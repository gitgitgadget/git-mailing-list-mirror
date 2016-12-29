Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD639200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 10:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbcL2KCN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 05:02:13 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34669 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbcL2KCM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 05:02:12 -0500
Received: by mail-wj0-f195.google.com with SMTP id qs7so19392759wjc.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c0PeH7hpotId2KHBFA3klXhcI+hjhf3ff6jJW245pOc=;
        b=cL3HHEy5ImjYJvpymTczh0GGJWhIvPc3FhpJMIEiRKrVkEYRyscXB8uTx9/X/IjLAM
         SCSADu9iBZJj9etzqhg/A824XY7MXItw0qT5MPQBjg46PJa5Y05RORU1tJbE02z4qovR
         kBD1ias5R0xr5LTeTtzUQYN9KWd633Xf98kOMf6+IlfU0wB9KD/NWWXjk9O8E6pkneWO
         IDbZNxfUlqOy4S+JFXLrhcSVnF39qpPlVcZ4AgqEGmP8P3KLf/jnHXiQNMjXSi01MYYC
         bLbKu2OhCGBpF72hoLgqBqcpNrz7DlyWhcZOR41eHuYiyJk8EcFOFmYlsWCulfr+DYp4
         xfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c0PeH7hpotId2KHBFA3klXhcI+hjhf3ff6jJW245pOc=;
        b=kF28VM7wvk/n9cQUgvfAYvhqEox1i57hefaSP4Ayr8WGYIH5EhxYqvUDJCEOJ/5rKT
         kD/sToCvYK88b11Y0ZJIMHOPVYkLIglFMblmGOyu7ZszldexTGD7MolDhpCATrzlphCg
         WAxjnO4omuEaYdGP+RuA+1WUn/6eBzSCT6KmJOC8uH/iOpkefBQZKrbuh4TNbowxfFWU
         rhLebSLZZbbxvUKXdxQmEF+yEq3cIUqSR2t1sT2XVwkwzgiT2lG6heP+50UksfFxo/fr
         ycNST4XweAMH9Za1Xp1Wso8i8vMZuYDGdvXQSzv54cIlp3HzWpTuMuzxiuBFf1kxQeX5
         qk6w==
X-Gm-Message-State: AIkVDXLUIHl3PgY6d024fFWancMhgrikAOl+oYXWzWPZLSqZgTd0n3d0aXSL5AOhWJlhhg==
X-Received: by 10.194.122.65 with SMTP id lq1mr36451495wjb.12.1483005731348;
        Thu, 29 Dec 2016 02:02:11 -0800 (PST)
Received: from [192.168.0.185] (HSI-KBW-085-216-063-243.hsi.kabelbw.de. [85.216.63.243])
        by smtp.gmail.com with ESMTPSA id u81sm64671949wmu.10.2016.12.29.02.02.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 02:02:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-p4: do not pass '-r 0' to p4 commands
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161229090533.4717-1-igorkuo@gmail.com>
Date:   Thu, 29 Dec 2016 11:02:12 +0100
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Ori Rawlings <orirawlings@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AA88917-5F94-498C-BB7A-60192127C36C@gmail.com>
References: <20161229090533.4717-1-igorkuo@gmail.com>
To:     Igor Kushnir <igorkuo@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Dec 2016, at 10:05, Igor Kushnir <igorkuo@gmail.com> wrote:
>=20
> git-p4 crashes when used with a very old p4 client version
> that does not support the '-r <number>' option in its commands.
>=20
> Allow making git-p4 work with old p4 clients by setting git-p4.retries =
to 0.
>=20
> Alternatively git-p4.retries could be made opt-in.
> But since only very old, barely maintained p4 versions don't support
> the '-r' option, the setting-retries-to-0 workaround would do.
>=20
> The "-r retries" option is present in Perforce 2012.2 Command =
Reference,
> but absent from Perforce 2012.1 Command Reference.

Thanks for this workaround!


> Signed-off-by: Igor Kushnir <igorkuo@gmail.com>
> ---
> Documentation/git-p4.txt | 1 +
> git-p4.py                | 4 +++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index bae862ddc..f4f1be5be 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -479,6 +479,7 @@ git-p4.client::
> git-p4.retries::
> 	Specifies the number of times to retry a p4 command (notably,
> 	'p4 sync') if the network times out. The default value is 3.
> +	'-r 0' is not passed to p4 commands if this option is set to 0.

At this point in the docs we have never talked about the "-r" flag and I
would argue it is an "implementation detail". Therefore, I would prefer
something like: "Set the value to 0 if want to disable retries or if=20
your p4 version does not support retries (pre 2012.2)."


>=20
> Clone and sync variables
> ~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/git-p4.py b/git-p4.py
> index 22e3f57e7..e5a9e1cce 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -83,7 +83,9 @@ def p4_build_cmd(cmd):
>     if retries is None:
>         # Perform 3 retries by default
>         retries =3D 3
> -    real_cmd +=3D ["-r", str(retries)]
> +    if retries !=3D 0:

How about "retries > 0"?


> +        # Provide a way to not pass this option by setting =
git-p4.retries to 0
> +        real_cmd +=3D ["-r", str(retries)]
>=20
>     if isinstance(cmd,basestring):
>         real_cmd =3D ' '.join(real_cmd) + ' ' + cmd
> --=20
> 2.11.0
>=20

