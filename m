Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7753D1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBSOPO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:15:14 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:52727 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfBSOPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:15:14 -0500
Received: by mail-it1-f170.google.com with SMTP id r11so6305047itc.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=80lvLCprjTcgPr6B0Xclv7nTFdmGbOOCqxTbHi7KWlk=;
        b=Ww6IPgoSx5MDYLPOoYIQ8D4ZRB36uRdlnpEwDM9wPJvwCvA3YeToy3sfHAr2UQxMEu
         vNQBa5Mg7S0LtcUCfrnXWsXtYuBMn6Gwv1BJlHnvEKzactsGcR8pdmsHGyIieZLgH98Q
         tPDNY6P/D+npKF+5NwOvDBWF23734pqiOM53VDDtLYxyHjbFhnfAPyKQAwAb37C6lD5j
         +i94cljBDpWJubvJAQOkLDsukiulv7soY0vjm/9KtPXHJQaqyvPwgQAxsgtcjUW0hQxF
         GJNkLzy1FpxGxmpYpwoHBdkgwlsZDIHlUfhtSZmfg36MIZ+PlCLzfYmf0q0if62LJN4X
         nfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=80lvLCprjTcgPr6B0Xclv7nTFdmGbOOCqxTbHi7KWlk=;
        b=jCPO/2bBCbWG2hoyBqiK8Nk4hHtizncoLGb1rIkcYSZ42FvHeafIM/Fbqe7ey31FG+
         ktbMDaiuzHgYzT+hVsXAq4Lntgz+2j8fEfRnQxcVsQigRYMfA/MfpNXq2e3SsxHlvVaP
         JU9ZNhBlZDzK0drRofZfThNsO0mJeWdGkjKYBrp+/V5VkQB6ouUHug8jAZ8ikJdTEZ3O
         N0fvhlJ5Kk0Fz+ojKrQlF4ydtg53mImFOt1ILZjtO/4yQ994Lg3cuXctb+42jqrbw2Z0
         KLrlUTCRTNXgcGS/sejyIO6GYYimdBRRT4gGXdCU+QslfY4j96kLXaQod9K5BtzweDoD
         z3VQ==
X-Gm-Message-State: AHQUAubL2XthdHIaDBhLANedE+yU61adHvXzDI4dO0cjkCH/tidENaUD
        IOMmEKhyr+fjZ7uZnwHOB7QgrAO1gQWLjBR+aoE=
X-Google-Smtp-Source: AHgI3IYyxltu3HLh4Um7iIsSfcJO/kx7gtA3t33ct3Sc+f3OUce0ML93hBaSzG8vhKTvKQOv6nPcquEzQcyr6dhIwWQ=
X-Received: by 2002:a02:9c21:: with SMTP id q30mr14467693jak.30.1550585713335;
 Tue, 19 Feb 2019 06:15:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
 <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net> <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
In-Reply-To: <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Feb 2019 21:14:46 +0700
Message-ID: <CACsJy8Crn3mnXkwj_CQ1capeAXT=Jvn5S-HdnKsTLJZvdH=ObQ@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 9:04 PM Sebasti=C3=A1n Mancilla <smancill.m@gmail.c=
om> wrote:
> And the content of .git/rebase-merge/author-script is always the same:
>
>         GIT_AUTHOR_NAME=3D'Sebasti=C3=A1n Mancilla'
>         GIT_AUTHOR_EMAIL=3D'smancill@jlab.org'
>         GIT_AUTHOR_DATE=3D'@1550530007 -0300
>

Just to be clear, the lack of closing quote on the last line is not a
typo right?
--=20
Duy
