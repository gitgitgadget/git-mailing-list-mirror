Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86EC2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694B020644
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2uNsWoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgDKM0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:26:04 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39836 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgDKM0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 08:26:04 -0400
Received: by mail-wr1-f45.google.com with SMTP id p10so5053871wrt.6
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:in-reply-to:date:message-id:mime-version;
        bh=bUVkwLyyTMmAt3/lUYbUKdWzXJGDumlFaXuCmkjORgY=;
        b=r2uNsWoQGmLHtCJA1rSLDQqPPkQ+ZXcu4DZzs4KEa0UvJ1gPF5U1B7pVnOXIhgSvPl
         +1huPtNWCqebqYMlY1qS05A5JN1hIPoD7byiEqNBP7JOY40B+F7RG0s9huLqj0KFDdfe
         I273UwF83lU1Yn99EX2rGf7BZ8HHrFFA4nvGAeguN3zFiplpxc2/z9eqoG4gQaqAhRJi
         2V3teHQeSV5KpbxwINgoz3Al9F7kZaoLZbad6xvLWLGKEG87S42+OwfMbaK5cheXuVNK
         Zw+JXarlRW2WxthswFkbaAFGKnpGxkNHTh/4ntafIlThes+hl/TIVgVxG/e15iaGcEvO
         kg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=bUVkwLyyTMmAt3/lUYbUKdWzXJGDumlFaXuCmkjORgY=;
        b=OvkKVJDh5yKDUlkN9ebgLYh671c06wp5B1C47E+fBB8DtQ2PLiVucBSkqAIh10uj53
         mI3m8+1EOFSu0TtrFMXm/3Ke5AcPVEYs8P8mdEuTIY4/1E+P0dEzZqtPrzpKK3KbLUS8
         o8AX+PrvmHP4Q5g/kgW1/vVKcdZ2n5ckNOKGoUpV1djogVK5W46RdoGZqnDbHrXcReYM
         fNCHF98BRl9EIQEyymLNChSS9Bo9tHFlOaI+IjIhrZFHkhfdNw3b+vXQJ/+3Zv/DlMzG
         fGBg4Z8HdCw38zyYNYtzyeen/UfKcaOxXPZlBx6ZklRWGnXd6pnUddh5UOVK3C2HX2lD
         7Xbg==
X-Gm-Message-State: AGi0PuanGpVOQfoCqxdnqrOqz9d255eTEiwdXX6chTJHq61uaHMd5ZoL
        z+HOYGjKmJnddRVeTw0N/v5UHSvz
X-Google-Smtp-Source: APiQypKgcp28a4U7V4LYz+Sw9VkzwraLViAO0XbOWC03n0PN8HuTruXJdCSNjLoxmz9UAzNJYgXgzQ==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr9439852wrg.70.1586607961581;
        Sat, 11 Apr 2020 05:26:01 -0700 (PDT)
Received: from delllaptop.lockywolf.net ([95.85.18.95])
        by smtp.gmail.com with ESMTPSA id t81sm7141108wmb.15.2020.04.11.05.26.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 05:26:01 -0700 (PDT)
From:   Vladimir Nikishkin <lockywolf@gmail.com>
To:     git@vger.kernel.org
Subject: When will this patch be merged?
In-Reply-To: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
Date:   Sat, 11 Apr 2020 20:08:21 +0800
Message-Id: <20200411120821.7675-1-lockywolf@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20200411120821.30phdpFjf3R9Litbu9Bwk6f4FDexlwXaXhA85WbMK04@z>

When will this patch be merged? It is 2020, and git submodule is
barely usable with my internet provider, since outbound connections
are randomly shaped to 10k/s. At the moment I set up updating
submodules for the night, hoping that it works. If this patch was
accepted I would just see at which attempt the stream is not shaped
and reissue the command if it is.

Sorry for double-posting, was trying to reply to this message:
https://lore.kernel.org/git/1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com/

-- 
--
Vladimir Nikishkin (MiEr, lockywolf)

