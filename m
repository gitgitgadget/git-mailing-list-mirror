Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2271F42D
	for <e@80x24.org>; Sat, 26 May 2018 19:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032331AbeEZTjo (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 15:39:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44881 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032304AbeEZTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 15:39:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so3635966pgd.11
        for <git@vger.kernel.org>; Sat, 26 May 2018 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:references:in-reply-to:date
         :mime-version;
        bh=O+/vYy6A08pe+ypSofzMdf2zTI5RhdbsJFDIbf/J/+E=;
        b=qvYHe3Hv8kL5zP6xf/dmD3Erao3FSoUEm/aagtGYU0aLR2Q4USYo76jeU4kSUtiptE
         G5EDFwV4vJ8TYYgT59SEKBlrFLFLJj10dG2CWzLXwFL1ZqbV6sk9+u7e62/zZdQOsbqy
         NqBY4wjphjYcNF/dcE7iysTMFYemU9CwD19DDFG7uKq4d66+kq4T/nb6O5kTjUcfpBQe
         nHEJJz8/PRrZaFuc04DwaqBE74yLD0+Mv0DgFzETXEx+5ek1cYIaRhokiWpdtMjapOpg
         59rpJiky5HX0QLA2bnawMq7eK/NlhHq7wRNj0TkB67vt/I3ikCLm2lJK7PCRU8RVjhJD
         EiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:references
         :in-reply-to:date:mime-version;
        bh=O+/vYy6A08pe+ypSofzMdf2zTI5RhdbsJFDIbf/J/+E=;
        b=aXZbkhr6f1hlpdCStjMnO/zv95GnXhJXXIPTtZXuKSquo6Ju/bOVKBx8GU6Kc6Ui93
         Gzl4BF+mozem1W80h95IyjJtUPg7xmlcRL9BAib5vymlBtCHJHV1fB6wM7APFg7jVpFz
         x9iWcmFy56PLIfqYS/gCgFk0QKf2DluxBBtiKG8cRR9MkBx+28w1QgFU1HehqtYv3fFP
         zUZbav+lpot2P6/wrmV4hPXNoVRl/nJFRq7YHdCyOol4dRswK1YbQWAvEOxDjIxhG5gC
         qbE6R4o+BN9cQyBKgwSXLW3h7ldmFuTdHWtGCoQC5gmriT7awArUAvpn6iQUgJqF8aif
         dIvQ==
X-Gm-Message-State: ALKqPwe3JQDJhXsnT8PkMkOR0FAV03agDYgH+JiAoJ5+G4ycI5i6ivg3
        DhNDZuz8xzESU6AZEer4Avk=
X-Google-Smtp-Source: AB8JxZqGtXE7yVZqP3P5DNWyZdHfVAR99wzhXLmkhWxt6Tkl6jlnNEyAfqXxi1r7Y0g6M+hX1g1bYA==
X-Received: by 2002:a65:5883:: with SMTP id d3-v6mr5882121pgu.131.1527363582621;
        Sat, 26 May 2018 12:39:42 -0700 (PDT)
Received: from unique-pc ([106.203.45.218])
        by smtp.gmail.com with ESMTPSA id f21-v6sm49427411pfa.106.2018.05.26.12.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 12:39:41 -0700 (PDT)
Message-ID: <1527363575.10290.3.camel@gmail.com>
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager
 starts
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
         <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
         <87fu2qbojy.fsf@evledraar.gmail.com>
         <20180517133601.GC17548@sigill.intra.peff.net>
         <1527174618.10589.4.camel@gmail.com>
         <20180524192214.GA21535@sigill.intra.peff.net>
         <20180524193105.GB21535@sigill.intra.peff.net>
         <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
         <20180525024002.GA1998@sigill.intra.peff.net>
In-Reply-To: <20180525024002.GA1998@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hj+mi10EAyIut6OSVTun"
Date:   Sun, 27 May 2018 01:09:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-hj+mi10EAyIut6OSVTun
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Friday 25 May 2018 08:10 AM, Jeff King wrote:
> Subject: [PATCH] branch: customize "-l" warning in list mode
>=20
> People mistakenly use "git branch -l", thinking that it
> triggers list mode. It doesn't, but the lack of non-option
> arguments in that command does (and the "-l" becomes a
> silent noop).
> > Since afc968e579 (branch: deprecate "-l" option, 2018-03-26)
>=20
> we've warned that "-l" is going away. But the warning text
> is primarily aimed at people who _meant_ to use "-l", as in
> "git branch -l foo". People who mistakenly said "git branch
> -l" may be left puzzled.
>=20

So, this patch is to improve the user experience of people who use "git
branch -l" for listing and not for the people who forget to give a new
branch name argument for "-l". In that case, this makes sense.

BTW, I hope people don't start wondering why "git branch -d" doesn't
trigger list mode ;-)


> +			warning("the '-l' option is an alias for '--create-reflog' and");
> +			warning("has no effect in list mode. This option will soon be");
> +			warning("removed and you should omit it (or use '--list' instead).");

I suppose s/alias/deprecated alias/ makes the point that '-l' will be
removed more stronger.


--=20
Sivaraam
--=-hj+mi10EAyIut6OSVTun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsJt/cbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpjQMP/3ufClUXXkAww19cZNwe
otGeRY1hTD1P745+3NhbfqkxLK0G/52PiQuiBAbePCIefSyceg1t/4WM6FA9hy2k
REIal4TFGYgEFKV+CLA2ik3TV7DqXFCJfiMgrsOg0o0hUvua1INxaTe38TiLXwxC
YpSUI9bldlq0pAkVnslEy2Rbwbawc88EDpY1Sy4NUkagsxkgD0XNL3eU8ueSobaF
y7MC/EPjnhj6EGDb0DnPKmQ/xdyXNnFyFC91qA5mrK8FAIyWnTkPxMjsSLgf97n6
gnA32GU2KJknvsqUo/sspfw/qvhs06RuhtmUvqBuoPMtpZSjXigTYrq9dXCMy5Pm
5pms2Yw2u9SB5Wz2xyr+RLNlR6xYvZ3WnR5M3DplwQW5JksCqEkuLi4XyPl1cqdA
rCPYRDntxMVzd+W5Dq19YHbiiBlPfags4EjCh325Prf0swX1ObNvthOEaMtIFeB1
63KegiwJB8oAZDWmfv4dJNMK4KgS4tUJJCv2JOj0S7zObBVj+iteIiJLP/1qi5Ay
e4TeIePl+xoDZ49/2ou53GosfUNe3x0o7ODm2uv9s/vYOLofG1JUtY6D2TaELcFg
/SlRp0h+9wqKyoBp9oXwlt3rusPy0/HugrjMMGYrbVEEqianNiGPGyuzsyHMoKJN
Pw4QRO/GQttHJOnglaoDs6Yy
=HsFV
-----END PGP SIGNATURE-----

--=-hj+mi10EAyIut6OSVTun--

