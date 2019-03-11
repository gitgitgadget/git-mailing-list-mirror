Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B28E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfCKQpP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:45:15 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33882 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:45:15 -0400
Received: by mail-oi1-f169.google.com with SMTP id g16so4193525oib.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0tHVHoW0IydrXXKPi3bTTTFAOQE7hJBpdu+X6wNv2k4=;
        b=GrBjagmnCVQcH1TrpQ2O22aN/GF0R93S0toevtngmxpRPjB7iDCQ3oKfspHqkXcsNz
         3U1WfwSlDNPSL1KIq0DCG0KyE0YkUfooEedXTWFMLMydJ9gwz6Bl88QptXQU2gylRk/6
         +Cr21NNvfMdvpJzsyXA4cCeSO5WmilnBRVw0ktuCtcf+6TXwm0g/+XfNesFC4ejAePAR
         dnsL4ZLaZnuJmATgiAp6S2p4Y1sTzJCe3FttSfVoqA9g1L8Y/90TfOztq24JiEqTpSMv
         lKsh/k8oMfOAEA6dDLkBpZ++hdTf/sACbGmT6aVam0mP5TR5apAE/1aCu0pkuZCqA1CL
         Jj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0tHVHoW0IydrXXKPi3bTTTFAOQE7hJBpdu+X6wNv2k4=;
        b=POZ7rnE/4x/YNmWTcxC66HG9aTY8VNpEGiDOdzq4q2qQf9XxgkbPTBA12doc1vvTh0
         3KKRdy9Wv9qpmsRAlTKYF/x/afahx0j8Qn3I4guwArOW3QwSuPerFlJCCLGquGxbPKzi
         J8dBvdEr9Z1Vow8L4g9XWDyc6ayk4U2/rooqqfIfiiEyPii8AdgcRJP/ry0HeI3jSg6M
         LBrw8nm5DRxuhwssfrnazmt6fUDmRvTrFVDikdndgTx2oqoEMfT/xyVv9Ox0Nj/Yvfgk
         dVbKi8fZPWWcoWhXuW27uUmyJL82SHD6TI6dhWR1iAYIPPsg4Ap2dqOEp12BjZ0BJtkJ
         BN9Q==
X-Gm-Message-State: APjAAAUkcoSnZNnAE9KZCzoJfe+6oS9kg5IQ16ZCkBV0mLXACKU1/wzt
        DViMK8E7ym6IlzgPy37/lQsM1YV2pR78Oz0QSH8fTkQr
X-Google-Smtp-Source: APXvYqw71tuPckHxi4+GR3sj5SVFVwaaC41Ey/1AirbIWRjOoZcf9UWH0H68s0ghVbdHjbemKntyphs6+BM9jzocQm0=
X-Received: by 2002:aca:cf93:: with SMTP id f141mr403139oig.130.1552322713927;
 Mon, 11 Mar 2019 09:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190309154555.33407-1-ttjtftx@gmail.com> <CAP8UFD26Zxt1FvwAajV48eBbhPv_q5oSLTekWxApcNpg=xRn3Q@mail.gmail.com>
 <CAOAu_Y+GeHHsxVmqLajtM41H67L83Rxxkp3SqJ-G4GBv=uTDYg@mail.gmail.com>
 <CAP8UFD274-iDkqPm8-WGXbUmcVqjDE7bSg2bwA-17TWJivn0jA@mail.gmail.com> <CAOAu_YL8heWLSznRV8pjLkRZBOEth_7CSmftupx+4+SSx5yztw@mail.gmail.com>
In-Reply-To: <CAOAu_YL8heWLSznRV8pjLkRZBOEth_7CSmftupx+4+SSx5yztw@mail.gmail.com>
From:   jonathan chang <ttjtftx@gmail.com>
Date:   Tue, 12 Mar 2019 00:45:03 +0800
Message-ID: <CAOAu_YK6G8apWPoFJPCCNizr_O-puHUwtU4CE-0_UgCnTSWkgQ@mail.gmail.com>
Subject: Fwd: [GSoC][PATCH] tests: avoid using pipes
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I forgot to Cc, again.

---------- Forwarded message ---------
From: ttjtftx <ttjtftx@gmail.com>
Date: Tue, Mar 12, 2019 at 12:32 AM
Subject: Re: [GSoC][PATCH] tests: avoid using pipes
To: Christian Couder <christian.couder@gmail.com>


On Sun, Mar 10, 2019 at 11:05 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Mar 10, 2019 at 9:28 AM ttjtftx <ttjtftx@gmail.com> wrote:
> >
> > On Sun, Mar 10, 2019 at 2:06 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >
> > > If you take a look at c6f44e1da5 ("t9813: avoid using pipes",
> > > 2017-01-04) you can see the following:
> > >
> > >     - it changes only one test file: t9813-git-p4-preserve-users.sh
> > >     - its title starts with "t9813: "
> > I adapted this format in my second version[1].
> >
> > [1]: https://public-inbox.org/git/20190310080739.63984-1-ttjtftx@gmail.com
>
> It's better because each patch changes only one file, but I also
> wanted to say that for a microproject you only need to focus on only
> one file. So I would you suggest you keep only the patches that are
> about "t0000-basic.sh" and drop the patches about
> "t0003-attributes.sh" and "t0022-crlf-rename.sh".

I will do that as I have made too many mistakes. I decided to do more
than one file because
I thought it might be too small even for a microproject and that there
would be more chances
for feedback if I include more files, since the same file tend to have
similar conversions needed.

> It's also a small nit but your patches start with "t0000-basic: " not
> just "t0000: " though the latter format is more frequent in existing
> commits than the former.

Got it.
