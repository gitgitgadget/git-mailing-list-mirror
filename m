Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EDB1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBTTgo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:36:44 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45010 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeBTTgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:36:44 -0500
Received: by mail-pg0-f53.google.com with SMTP id l4so5347294pgp.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=YoDQubBfwvghJrh+/qjXwaz1Kov1t+Mg/lUDBwQ5TgE=;
        b=fm3w5/tbvlmndbHDkiCD75TYl6SZ9VJpl8fjqPTUPW7GJRCuIYvOre9fgk/eXbBNek
         sySoDIyVKhxziCkSM1mNSYMrl9Aw6xnOzqXqg27brExo7gAuw2i6NaBzSo6Qp87ZLqM6
         50OH5CruMtpBd4JTVrXIwH+vZ1Ees4yM0wxBQ+XL1nQFUzWAE6lf/GBAE1EK87XqkTpO
         PEn5eDAd3pyzBNtJ/2tfxG0AHgAX+wk1IP6hcFf8x1vKeSyNINmzO3bT/AG4FKCMCRsD
         /jlEFBDpjhYU1Jmf6H2AS5wgYzCeEF2GXQW551fbm90ahXcdULxrHsODED2dAI+WB458
         KhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=YoDQubBfwvghJrh+/qjXwaz1Kov1t+Mg/lUDBwQ5TgE=;
        b=sxFrIvNM1F93cB0IbMoKbGGIuMYwPEJBXOzZ9/fg4d8cnYFV6MjyCNIFyhboH/MTcI
         mF37otYvCXmnZGBcFkx6dSUrKYhAIwvGNfV5JJ0K5tTb/aHseqIwuQm2sORt75DMG1kp
         qdmKFYJT2gxG6qdR/mzMHomCzevHF6YfHFznEtws/8PXv2iVRI/S8dXPAsvvCHX3cOrW
         /m0MRNTBkBDjaKpjTIqbRxDKY9nt8C0tw0k+v1zlt6ffPpFLJdyPfpyrb5Sv1HQG5M67
         4QptUHbyF/VXGrVeNxMTSKqdUHkfGH+c5P6rQkwKa0YTby1Gjpk5n3jzvEJa4nHcM4Iq
         Y1FA==
X-Gm-Message-State: APf1xPCux1SDHEuc5fb00giaU7NoQmWyOxrbIkTxuZUZD1Wp5yjGjCex
        FvtrUyEPi3Ap9KVWzCQGcoL5YLmO
X-Google-Smtp-Source: AH8x226HLbx/EtaUKOB7eGHjDWyOtjvpEeeQCcm5QcQR0K0I6jogjlJgUKbRvJsRxA/8G5MpPAOpRg==
X-Received: by 10.99.121.5 with SMTP id u5mr560471pgc.444.1519155402958;
        Tue, 20 Feb 2018 11:36:42 -0800 (PST)
Received: from [192.168.42.146] ([106.203.65.211])
        by smtp.gmail.com with ESMTPSA id z6sm53150362pgu.49.2018.02.20.11.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 11:36:41 -0800 (PST)
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
To:     Stefan Beller <sbeller@google.com>,
        marmot1123 <marmot.motoki@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
 <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
 <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b4e6f89b-fc20-7244-ad23-548697f9764e@gmail.com>
Date:   Wed, 21 Feb 2018 01:06:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DTThfAcfvx3zB9UlS9WO6uShJMBgJCxPO"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DTThfAcfvx3zB9UlS9WO6uShJMBgJCxPO
Content-Type: multipart/mixed; boundary="IA7E1fQefcZZdz5VxKenO79y8oWrjokgO";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>, marmot1123 <marmot.motoki@gmail.com>
Cc: git <git@vger.kernel.org>
Message-ID: <b4e6f89b-fc20-7244-ad23-548697f9764e@gmail.com>
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
 <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
 <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com>
In-Reply-To: <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com>

--IA7E1fQefcZZdz5VxKenO79y8oWrjokgO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On Wednesday 21 February 2018 12:20 AM, Stefan Beller wrote:
> Kaartic was the last to touch that file,
> (as found via git log origin/master -- Documentation/gitsubmodules.txt)=
,
> sorry I did not find this in the review.
>=20

"Non-ASCII characters" made me dig into to this a little deeper as I
generally don't use them particularly for text files.

"git blame" points at d48034551 (submodules: overhaul documentation,
2017-06-22) as the offending comment.


> Thanks for the patch!

Yeah, nice catch!


--
Kaartic

QUOTE

=E2=80=9CIt is impossible to live without failing at something, unless yo=
u live
so cautiously that you might as well not have lived at all =E2=80=93 in w=
hich
case, you fail by default.=E2=80=9D

      - J. K. Rowling


--IA7E1fQefcZZdz5VxKenO79y8oWrjokgO--

--DTThfAcfvx3zB9UlS9WO6uShJMBgJCxPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlqMeMYbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpIw0QAIIzIlFNjGr+LautTDkl
cHAowK7+NcVXGrzEapTB50F8liAzBpIX27DMOJBBcNdv0D5s47A++oXM4+HUubwx
dS9Bg9C2JDRqOAqQYUqr0B64lKwyKAFYfqHJI3rwFtrjdmPfw2cY1ubDRJbvkqG7
neuAEPWV98T6OdywqfUZGHJNR0ShPCycHTI27ohqa5Q4ZYk9e2Eqbven2pXsV7Ff
j1VBZCnTPrkCPJSOYnriW6YxUCCXF1Fq83SUzWjjwAmz0xTV+lO7TMyNk7QKFS0c
NIjsfo/y+4qHbvmqiyIo07z61kD3ULA69aVR1adpMDCKQps3vlpG5cIsDfhaiaiC
JrTri1HOtxemsgMWAikHTUqB4aPZSNn3Vhzz045nZ1W7vc9LoYmkTi2yHAZUtX9+
8EfF7HWNQJ5Fg8kFlk1NOuejIV8Oky2AbU38acWGeDJo1zoecXwRONgr3M5W66xt
jF9plYi4GPaeXdVlGpc2gwTKHJsu3/YqyeEKU2SBRoE+5BXfBtG5lDhwWUBTRYNb
nlNel5wKXmkQ5LD021OJKbyzweev2xFdnkRmf3xvlm6Uuj9WClwNfWXtEbNYDyli
aGr1OHZ9yj3vMmaBfuPD+tFhwfdjXIjN0fCctFkmWyjsF2XdY4OUHYvdJcNuirk/
E12WZ7vycVNEyTjM3LwvcfKM
=B5a9
-----END PGP SIGNATURE-----

--DTThfAcfvx3zB9UlS9WO6uShJMBgJCxPO--
