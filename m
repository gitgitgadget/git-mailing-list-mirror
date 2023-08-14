Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6AC04A94
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHNW24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjHNW21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:28:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D9171A
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:28:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589b0bbc290so59995537b3.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052105; x=1692656905;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9n34be/297fdC9tbAwTrTTokwh6GgeCCJhRWcCLZ9k=;
        b=JTQMvjl+Y4gtaKkzUONFtUS/IlKtSv4dxh8gFdXFLswITNq4AK5O0pWDSS+NS2QpyU
         9StKDLYI0k0aHlqTKTYuB9G8KxiGXA3xbARHEveT3HcTDCm5dZnEPhThUh/XKCvp8brJ
         W0qk6Zy630zJvbJL+Z5MKtiRCOIwwMw3k3s6dkza+WOzugzey2Mm5W8je8Mbux0cbf5O
         w4YozESpmMOflQUtvpk0CeUCSlmrpQ3/m0wuwTLGsxlAlLqQXqAHoyiyTNxyywYMpngB
         pkRJ/vKGNfZyD0QnGDrbj+RvfFndHD6LM0FqPzg+Av/Pq3ZGYkn4DMigHp1U9K7gboiX
         Kjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052105; x=1692656905;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9n34be/297fdC9tbAwTrTTokwh6GgeCCJhRWcCLZ9k=;
        b=em8YVcd5xjdIFmgTmSJDZUXUtC+XOjdHAe8HbOHJGCCm3buWcvMzscI7KHYWFEr3Jv
         EDIqjcsjOR5zf7l2VqjDAtRhOvu0Q5ckJuw3MSTL13fkNtF0NfospMv/kzdg5nyGq7zc
         U/RSlgj9cDhTmuqNzsrR1uFh+8H5fA8z305m5Vidc55GiY/str8v7QWUkUwqHQHFXsXF
         OmzRVt5jaSVTDzIDYNi43ORIpho25FvT8StSX7uN3kJB8kZ0+2nA9DTfaFNTOmX/zeda
         ZqQ+zBplIyT16qFWLbUPflPj5D8ezwOys1oSbBQbSS4W2aN3epMKLKzJ4cN+bxpwjOOT
         hQBQ==
X-Gm-Message-State: AOJu0Yxe/XiK29kTQEjWutuVHZx+weu75wX6z+C/V3CCDXh5rXT9v7Z0
        RDo433k2Ty+t/qWI5CD/iToh8M4LXqkf1tsq4Myr
X-Google-Smtp-Source: AGHT+IE1B1HS5tizTTRJtGtmhNthz57WX7SsNvmjNynXvF8yu90HnWwsaeCjWvuGQ8jDRGyy1wzMreOKbLktHTWgCGHN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51f6:bcfb:aa2f:af1f])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4413:0:b0:583:5039:d4a0 with
 SMTP id r19-20020a814413000000b005835039d4a0mr8339ywa.0.1692052105699; Mon,
 14 Aug 2023 15:28:25 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:28:23 -0700
In-Reply-To: <20230810163654.275023-7-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814222823.65107-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 7/7] git-std-lib: add test file to call
 git-std-lib.a functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, chooglen@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Add test file that directly or indirectly calls all functions defined in
> git-std-lib.a object files to showcase that they do not reference
> missing objects and that git-std-lib.a can stand on its own.
> 
> Certain functions that cause the program to exit or are already called
> by other functions are commented out.
> 
> TODO: replace with unit tests
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Thanks for this patch - it's useful for reviewers to see what this
patch set accomplishes (a way to compile a subset of files in Git that
can provide library functionality). I don't think we should merge it
as-is but should wait until we have a unit test that also exercises
functions, and then merge that instead (I think your TODO expresses the
same sentiment).
 
