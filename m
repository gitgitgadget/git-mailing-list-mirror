Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563CE1FBB0
	for <e@80x24.org>; Sun, 27 Nov 2016 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbcK0LVA (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 06:21:00 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33977 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbcK0LU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 06:20:59 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so10614449wjc.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2016 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWluGkCI2tPqyqY2Efe2YDBcYWt5QxMr82rZwjdK46Y=;
        b=hg5Wf63auNDcVJeIiq/wa1GvSJmPY9febuq8TYLNqQVfxNq3wQ0gVi4WDllONxUTJP
         S+kyS9f2b73R+mn8Vr4Gsiov0sSUgwHynKHRYZAU/caIxUIFhysEkYkdFxyitMLYbklc
         l1SAT1gyYRHWgfOaAnSJdxoBtVsuM9IHQEAaN3p8nu3XyY1CeKu5CFtaq4cOVRG5LQAF
         EKnlsM5HtKJ82/IF09KbZtZ/V4Rgsi+fRugBAgDKJRhwdlhEA53nV4XdfZhihc0z606q
         UjDBF16dKNG+W5lZR8axs5hFlm5kgZ6x6CGwlvoDFJ4irx2yFSaMMHDqPO2GzHFi8f7y
         LZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWluGkCI2tPqyqY2Efe2YDBcYWt5QxMr82rZwjdK46Y=;
        b=R3neJYJBV0rFLmDOjul0fzZo0AI7hVxpOHCOQUZs7d2kVEXpcAQ6IqlDdWSpSkzxhU
         7uop9gpKkvGwMJPofN5uyXx/wpiAPsVy2IdQkFHDJSuycxIzofHqySLZIGhIwBih3TYk
         FF2VkwAQtWDLkl4yDoEa8CmSWcq2WsPiRAPuHM1LH3jJeXTNzJAOsxolmZOie/kPPCjz
         y/ZfOArR2RJkBn55gAwEXoy2l8c8ZuD0r8N1gXENmLSM9dVvClIU9Emk15+YDmRKq9Lm
         Jd6i7pJ1tTtgrjKsV22pSB9cM21ef0T3qq2L6NFBtfXzt199ZXtlZukQFoz0Vwn1jI29
         LiQw==
X-Gm-Message-State: AKaTC0003T86EiNPeACMykVc93iP8YxGBa+AM/TFJX0VlkF7uTljntZXw/aMjCSFyNx0SbYFkSw7DFTwj+Rvog==
X-Received: by 10.194.141.141 with SMTP id ro13mr14427978wjb.76.1480245658014;
 Sun, 27 Nov 2016 03:20:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.145.151 with HTTP; Sun, 27 Nov 2016 03:20:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1611261407520.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
 <cover.1480019834.git.johannes.schindelin@gmx.de> <ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de>
 <2994b0d6-4b6c-84e7-d0d5-257bcae3be98@gmail.com> <alpine.DEB.2.20.1611261407520.117539@virtualbox>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Sun, 27 Nov 2016 12:20:17 +0100
Message-ID: <CANQwDwcbsCTWsS8oFJaC8+dsLpqjivfxJt741G3QpCvir-_WAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] difftool: implement the functionality in the builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

On 27 November 2016 at 12:10, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 25 Nov 2016, Jakub Nar=C4=99bski wrote:
> > W dniu 24.11.2016 o 21:55, Johannes Schindelin pisze:

[...]
> > > +static int difftool_config(const char *var, const char *value, void =
*cb)
> > > +{
> > > +   if (!strcmp(var, "diff.guitool")) {
> >
> > Shouldn't you also read other configuration variables, like "diff.tool"=
,
> > and it's mergetool fallbacks ("merge.guitool", "merge.tool")?
>
> No, as those configuration variables are not used by the builtin difftool
> directly but read by subsequently spawned commands separately. There woul=
d
> be no use reading them here, for now.

Ah, all right then.

Though NEEDSWORK comment would be nice to have here (for when
we don't spawn commands).

[...]
> I read the rest of your review, but it appears that it is more about
> style than about substance, while I am only willing to address the latter
> issues at the moment. You see, I want to focus on getting difftool correc=
t
> first before attempting to make it pretty.
>
> Ciao,
> Dscho

Well, excet for the submodule-relates stuff, which I have skipped,
it looks good to me.
--=20
Jakub Nar=C4=99bski
