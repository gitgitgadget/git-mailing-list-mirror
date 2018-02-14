Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061201F576
	for <e@80x24.org>; Wed, 14 Feb 2018 10:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967075AbeBNKK5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 05:10:57 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34761 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967046AbeBNKK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 05:10:56 -0500
Received: by mail-wr0-f182.google.com with SMTP id m5so9492543wrg.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=zAFeDIvZr+SkjbCuuRRQ39YGqRuC26tHbTP4kxGNoE4=;
        b=NCs7e0580upq4u+PyPJVev/4EAogxtj92RnPevl1STvV8Voonsr31cwvu02ca7OLsq
         H21ZK78qcKo/q/0z6vjiDEs4eGXLeXJQtEsKEi6Fz9Ghl0inNsqmhm3XMWkiX2Z+BhaY
         7fmRr3/I5tP85sK9lAZca28us7bnY3upTUJr6CHiVv60CPiLt5khkhxWJtYG6mB38ZPu
         rPgaNODzsE8m/Idq+Zu4qC8/VXp9MOEpb8krsyUrA6ew9vCVEvcjK7C/ZYKqSEuqcAEe
         UB7KJZxm1YuTQLfnClP0HKHOGGOoX3nk4pYRk3ApI/Jl5JhFzFEQtA+VZCxPNV/XFvQu
         Ipww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=zAFeDIvZr+SkjbCuuRRQ39YGqRuC26tHbTP4kxGNoE4=;
        b=mLv0Vk1Ak+7860TaNN/IIgzDMUIPyxEYyLycanbe6+vOyQqi0+ryH/lRn4r0CQEw82
         ydxKVLZFT9vMKlmRDbzjEDK/PWHC7JTcp1asuBlwk+8ThsmpaHSgAXEE/Pwxb8UKqveL
         XGPuAQ6g5LQVIpw7oYsSk7m0Mp/LlK/6qOv1p5yIRCm4fnYbZ00fPcq3/Som4wkk797g
         /2shU3XTs9wXe04QZsyRNT3FQn2bpjOLx/N1z0C7Cb2BsYWaRUdeZGNce1x1OTMKcX9U
         MYL47ilUUkTcCh5U+p3b8aR7Q2bt2THd1JNwxzMGV8+XuAIsrirvhPVS0BL2OeqQf+oM
         bU7A==
X-Gm-Message-State: APf1xPBGLVThjiw+4ASS94OHLSf2GpXYA22pmk+8qju81Yxy+mS5xE8A
        2uUmQmJATW163g8Wj6fXRbBKh9o+
X-Google-Smtp-Source: AH8x226tOdCcHzfCs9nvKBgAVW3yZ6RDP+banaJGfqaa5hIA71XGzzHsto0q/TWQzz4x4+OWFFl16Q==
X-Received: by 10.223.208.141 with SMTP id y13mr3666456wrh.13.1518603055478;
        Wed, 14 Feb 2018 02:10:55 -0800 (PST)
Received: from localhost (bzq-109-65-157-28.red.bezeqint.net. [109.65.157.28])
        by smtp.gmail.com with ESMTPSA id c18sm7161002wmd.18.2018.02.14.02.10.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 02:10:54 -0800 (PST)
Date:   Wed, 14 Feb 2018 12:10:19 +0200
From:   Doron Behar <doron.behar@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] git init doesn't respect `--template` like configuration
 variable init.templateDir and $GIT_TEMPLATE_DIR
Message-ID: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rprondd7snfpffeu"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rprondd7snfpffeu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The title says it all.

If I run `git init --template=~/path/to/my/template` I get the following
message:

	warning: templates not found ~/path/to/my/template

But, if I run:

	$ env GIT_TEMPLATE_DIR=~/path/to/my/template git init

I don't get a warning and the template is used just fine.

If I configure the configuration variable `init.templateDir` to
`~/path/to/my/template` and run `git init` I don't get a warning and the
template is used just fine.



--rprondd7snfpffeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQHKBAEBCAA0FiEEl8KuRJYyNM8farE0MRjsiMS8FJQFAlqECwgWHGRvcm9uLmJl
aGFyQGdtYWlsLmNvbQAKCRAxGOyIxLwUlFD3C/4pXMwJLewz1hd6KKXQytUOPWlW
TX7JEPVb90X7BxlRWG899jkNtMqDPTcdEc4/jZBdh9WNdgKRVvm5vs+CR9BYlBol
TOoRQ2tH9iHvJjZEkj2VmlzrJ4RTIpiWPNuU03ukoaoDpi+bgQdZX9AW5Z7SiOEL
IT7cdosRoUF2fstOXuJZPbgd/ozWU389x2OHCNrdOOZJL9JTMt6rTLCvR2jaB8HF
dYcbF2e2HWI6c6O5zfKeIUfmBthMV0qEJ7V7QX00aG+d1q2BuXPPX5wiITfOAsj8
lCDAxb8WZ3svNciwoFimge2/PMoKcDtOZmyVPoOAuQKutWl41dT5YewNClFnj/p5
8GrepsPKtN6xoxjyOSfl/KORP87JuZhMh2EKygmmAAbXrN1Etwv0Cio9HHYFHGgI
GWZJQvTF+Us0/+k4Gl654dHBwX6thv6acnZz3pCtV3jDzlrB0GcB3kIkZqDdNND5
BmsXsbY1kF24H+C/QQR7e4CaAnoZUwkG23kaPH4=
=LFy3
-----END PGP SIGNATURE-----

--rprondd7snfpffeu--
