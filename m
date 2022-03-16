Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BBC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbiCPUnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiCPUnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:43:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98DE6E787
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:42:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l20so5680425lfg.12
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LcGKStxoasgxL35WIEzYIGTtUK7HPS+Xbi04By/H13M=;
        b=iCsl6PNPT3KVeBdm1UAGXv4EW66AFEm+s8hglrd3pryNTtyEI2iGNk/fTXY3jZde/D
         Zg3v9IO4sZuxWE7TsOKLuTLq7pypXLjWNN6PahxfyMfFTai2Mh+bf4dCo/nLB9zrcn24
         YZXLbw92Xpj5kzgjpSExE0B0soyhSC+Xq4CgMTlz7D7ICRpZMyYmeTsf2g6DOp0r5EIU
         u8BEZRJG2FtJOc0fvXxxrpOxRL8Kmjs4wiqObO9N/uyLKDGw1OiLVGUCldWtGfLTWKBB
         KSRSA8sGCUrl1baVDuOJq0aoSH+9zj5fWuTnFdt+uwVYVUt+uelkYnXDpJv51LbNfPAe
         +RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LcGKStxoasgxL35WIEzYIGTtUK7HPS+Xbi04By/H13M=;
        b=2HV27KesWPGRu6qCyPA3/SpEpEFp08pRDYiMOV2Y4DUr3jRzWnF3TJzLNVwAMtVKf1
         HT8MNcq5N3H7MjvA/c304hxzq5B4sp+OELXGs4tqkTP93eEr3NPLR64fGLBV0Bbx6eWm
         jd48UolEMmddRcN/pYkbtJqt1pXaY05RYe3YhXei2BK8VpbQk9+Ql6WsJpkxYSIwaGMQ
         KXVt4MgrRSlXRMB7sKmW1eOky/01/OmRTj73T33gBgQGraiOwfmg8VSgc28quF4GVIkd
         3bCcIXidnIBPT4EE5dVZZSYGTfZLvKsPHjDs+lAu1rx6LhmKUBPx4hl/qXxNBu/usHUy
         YR3g==
X-Gm-Message-State: AOAM533ltC8aj+fW8+pz+IOITCvNLaPm5NZWSdQv4zZAsobpGsDnmPUo
        l9+53n1yu7mzhDkZXrVS1EmncQncuDTBZMFD//1VTQ==
X-Google-Smtp-Source: ABdhPJxkM5GjBV0jdKwHj0kTNzsMMGKOxXlthHUf8I+BMYR8yHc5vjxFtP3nk6l6TP7SKH50DgeJgY+WR+VKEO91cbE=
X-Received: by 2002:a19:7612:0:b0:448:307a:4bca with SMTP id
 c18-20020a197612000000b00448307a4bcamr820552lff.361.1647463330959; Wed, 16
 Mar 2022 13:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <20220316201058.GI163591@kunlun.suse.cz>
In-Reply-To: <20220316201058.GI163591@kunlun.suse.cz>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 16 Mar 2022 13:41:59 -0700
Message-ID: <CAJoAoZnKebM4m3AXW6+RBY7dBsQhAcReqd61VtXHNjcnPBeemQ@mail.gmail.com>
Subject: Re: Let's have a user experience workshop
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Alice Merrick <amerrick@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 1:11 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:

> > * Reply directly to this email if you are interested in organizing the
> > event to discuss git UX (scheduling the event, sending invites,
> > communicating with invitees)
>
> Can you, please, use a sane mailing list for the discussion?
>
> The user experience of Google Groups really bad.
>
> Also it seems it is accessible only to people with a google account.
>
> Could you use a more inclusive technology?

Git already uses Google Groups for the security list (e.g. for fixing
pre-disclosure security issues) and for the mentoring list, and it's
fine to subscribe to one with a non-Google account; it acts just as a
normal mailing list in your inbox. Anyway, as I mentioned in
https://lore.kernel.org/git/CAJoAoZn91dyFEdMKUj_XU8CjUbh5EtdqjTR3CaAe%3DBhi=
i7dt3Q%40mail.gmail.com,
the list mostly serves as a roster, not as a place for discussion.

 - Emily
