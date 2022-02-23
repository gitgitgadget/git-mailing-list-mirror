Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC96EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiBWMKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiBWMKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:10:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70198A94F2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:09:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm8so34233506edb.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=K1DEmdYnt1BcQqyQmO4Idsyffr+Bk3w4lVRPxeRTa0E=;
        b=dOLwokaaeucn/umqvSOe2kNxV2fk8LHn0v3vnKH5SdFAjTSpA+bXPKvxju7iB8lVaO
         Akkg7oE9rISnFIIzPS3V38wgocfHkRIZXXZTkGk9iTULpl8KRd/HKxso0S3gIXQ85daz
         1O/lxG9OvOAgB8mmohCQFlyF3mRb5uDVVmm2mH+JrFOfTTS/ywCe7EaNJS61zfKhi80G
         hPHA+V4rOI3M8hwtkkONi9mbssucFZq3NLb/lJQ4zXfAEUrZOrgo/xTm64hZhrWsfbYo
         qBj7e1BjHAGKsikbXQXy3ZRy4mAmuh/dG5tB8dexQHqD+43orlFvO1eWj8ePu/ZC+m3c
         AE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=K1DEmdYnt1BcQqyQmO4Idsyffr+Bk3w4lVRPxeRTa0E=;
        b=PVlQUcc9T0I/9rinUROHGwf3GrKvleT4HFsCrcMHZfBCOD2/1wbvGlZ4aVNWyEfct5
         c2tOmX+yUrbpM2GBd7Rc9uOw1okV1r7W55zUUqM/ovXj35o43wwIY9m1em09XLIpZkAm
         Q7UR2gXiOk5tmxyaeMsG5abnVGlUfHCN3rDMInhmLadP3M2B33Fg2zO6prb69jVpJ+bw
         jvqqlHvLBbauMPh83vVYRmwJ0y6f0eFqhVoTLvFokISIGwWqH77BYxTXLUrPxUPdZUvU
         Z1DjWr+IemFrlSt/fyHseYaTdaoIbrIux+R8IipEH2MZ64wFjkZT4zjpD2JakIU59gUH
         QgOQ==
X-Gm-Message-State: AOAM531vd0AUHGJVmHKD/80OJ37+t9Xw3B6JMwGDjKeUsijPc8glWSJn
        jD/VAPsaCINwejW+hkc6qkeLy3g9vQdkKWMVrg3EEkpFZW6r3u2Z
X-Google-Smtp-Source: ABdhPJz0MEpEQOtmEV1IX27ZPcXNPmOuYFOichkdfG79HMUF5aFdo3Cc7fl3TtBzDgMAeQZutPYBAAHLMKOg3TFmQpI=
X-Received: by 2002:a05:6402:254d:b0:40b:74a9:e096 with SMTP id
 l13-20020a056402254d00b0040b74a9e096mr31283589edb.129.1645618147611; Wed, 23
 Feb 2022 04:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com> <20220223115347.3083-1-shivam828787@gmail.com>
In-Reply-To: <20220223115347.3083-1-shivam828787@gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Wed, 23 Feb 2022 17:38:54 +0530
Message-ID: <CAC316V57tHux-+MWMJuP5wNtwYrc2AinZj+ffnoyy-aWQWDukg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] avoid pipes with Git on LHS
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I am using mails for code review for the first time, I have some
doubts, Can someone please clarify them? -
1. It looks like the cover letter (Including "Range-diff" section) is
only for context sharing with reviewers, nothing from it gets merged
to the "seek" or any other branch.
2. I wanted to know how the merging process takes place. Once the
patch is accepted, do we merge all previous versions of it one after
another or every patch is independent so we have to just merge the
last accepted patch?
3. How does a particular patch set is linked to its previous version?
I added the flag "--in-reply-to" while sending this mail but I can't
find any linking here on the mail. Not sure If I am missing something
here.
