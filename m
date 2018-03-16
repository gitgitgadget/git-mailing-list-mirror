Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE97D1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeCPSMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:12:51 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:45610 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCPSMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:12:50 -0400
Received: by mail-pl0-f42.google.com with SMTP id v9-v6so6380499plp.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ARLhj03NbZ9jo8lmTXZwFqggEUE5QLa2axNMG5DSSEw=;
        b=VonQDN4RRpFQkOapkgNLk7YYtaSBjIC+Lhrx7vrx6tup1TMj72vzw7VqhAtlp1dBPO
         sA17vwx7J+S3409DF8SHV3WzvEOoZBtZFwd1/NXG3UvzJyxcLdhwuYGj4CQVBQNtEYFK
         6iCa++i8BOkpmE70SbGtZ06vtPHz/WHbQRssHCGNDHj0LMf2WeUgfxLAVND8mMnanhKy
         zMaWW0vcippqwpcPJifk6HOqi4ooSuomxQQEPExHWOxECUPzKIm6tn14gbHW//8KHw+j
         KzQIJEdjlYK9ghSuvGD/R+0OFpMGr9id3NZVKuaEKyqqASYSlbU58k0E5Tf3laQ6eI+1
         tHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ARLhj03NbZ9jo8lmTXZwFqggEUE5QLa2axNMG5DSSEw=;
        b=Zt+xK4N/4glP6OjWww0Qq6QX6vM94HBrx+34/mirv/5BzGOOZIdWvVRCp2AKJ454Dj
         6e8qJv9C3EMqOlHoZwMJUVoeoIjuRdUZHq9oq2eqzd2D5pOO82zaHLRTmGgcEiZQN5uv
         LA8eM0P7me68kHrNxpsorW+jhnoaw1vxRSof3R/zQ8+r36aLp68sCXo+ULoQkY7ihfLr
         Z1HvDoLNA3cQG8iShD6ksxD388FF0ikASGBYaXtU7WumJX553MOG3++DemOVs+p1AaEJ
         QglbU0x+vDrLhHLOYdEWc1pxjpfDiSj+roPmpBraLjgoxVW31VTP4917YdXdvX83QiSH
         OEkA==
X-Gm-Message-State: AElRT7FLtmNhdtMHMz2O5rvpuxVCg4xBSOEvqhhVAKTMeS2QoxKq8nbX
        7ogih6fa++Gtq2t5lRhUVJQ=
X-Google-Smtp-Source: AG47ELuLedQyc1i6El5ieV+aE4AF5OIgTmYhRrrXA/rcNOtZ+5R0bQeSx55TegM4mq1G0LnWqQIOrA==
X-Received: by 2002:a17:902:20c2:: with SMTP id v2-v6mr3220122plg.82.1521223970039;
        Fri, 16 Mar 2018 11:12:50 -0700 (PDT)
Received: from [192.168.206.100] ([117.246.118.180])
        by smtp.gmail.com with ESMTPSA id f86sm17726069pfk.111.2018.03.16.11.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:12:48 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] branch: introduce dont_fail parameter for
 branchname validation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-2-kaartic.sivaraam@gmail.com>
 <xmqqpo453x0k.fsf@gitster-ct.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <fa87ddd0-f034-498e-c112-4393bfa0d96d@gmail.com>
Date:   Fri, 16 Mar 2018 23:42:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo453x0k.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TUpDPwi2ZbBP511GtDpFS4maEi03c5Cl6"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TUpDPwi2ZbBP511GtDpFS4maEi03c5Cl6
Content-Type: multipart/mixed; boundary="1cTek2qlwwr0qMqODnzoOhDZxrjPaD43b";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <fa87ddd0-f034-498e-c112-4393bfa0d96d@gmail.com>
Subject: Re: [PATCH v4 1/3] branch: introduce dont_fail parameter for
 branchname validation
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-2-kaartic.sivaraam@gmail.com>
 <xmqqpo453x0k.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpo453x0k.fsf@gitster-ct.c.googlers.com>

--1cTek2qlwwr0qMqODnzoOhDZxrjPaD43b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Friday 16 March 2018 01:57 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>=20
> So... I am not finding dont_fail that was mentioned on the title
> anywhere else in the patch.  Such lack of attention to detail is
> a bit off-putting.
>=20

I'm absolutely sorry x-<

I should have forgotten to update the commit subject during one of the
old rebases in which I renamed the parameter from 'dont_fail' to 'gently'=
=2E

I shouldn't have assumed that the commit messages of the old series held
in the reboot too. I should have re-read them "completely" and double
checked it. :-(


>> +enum branch_validation_result {
>> +	/* Flags that convey there are fatal errors */
>> +	VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE =3D -3,
>> +	VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
>> +	VALIDATION_FATAL_INVALID_BRANCH_NAME,
>> +	/* Flags that convey there are no fatal errors */
>> +	VALIDATION_PASS_BRANCH_DOESNT_EXIST =3D 0,
>> +	VALIDATION_PASS_BRANCH_EXISTS =3D 1,
>> +	VALIDATION_WARN_BRANCH_EXISTS =3D 2
>> +};
>=20
> where adding new error types will force us to touch _two_ lines
> (i.e. either you add a new error before NO_FORCE with value -4 and
> then remove the "=3D -3" from NO_FORCE, or you add a new error after
> INVALID, and update NO_FORCE to -4), which can easily be screwed up
> by a careless developer.  The current code is not wrong per-se, but
> I wonder if it can be made less error prone.
>=20

At the top of my head I could think of 2 ways to get around this,

	- Assigning the actual value to every single entry in the enum.

	  This should solve the issue as a any new entry that would be
	  added is expected to go "with a value". The compiler would
	  warn you in the case of duplicate values. The drawback is: it
	  might be a little restrictive and a little ugly. It would also
	  likely cause maintenance issues if the number of values in the
	  enum get bigger.

	  (Of course this doesn't hold if, the careless programmer
	   shatters "consistency" and adds an entry without a value to
	   the enum and that change gets merged into the codebase ;-) )

	- Using non-negative values for both errors and non-errors.

	  This might make it hard to distinguish errors from non-errors
	  but this would avoid errors completely without much issues,
	  otherwise.

I might prefer the former as I find the possibility of the requirement
to distinguish the errors from non-errors to be high when compared with
the possibility of the requirement to add more new entries to the enum.

Any other ideas/suggestions ?

--=20

Kaartic

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


--1cTek2qlwwr0qMqODnzoOhDZxrjPaD43b--

--TUpDPwi2ZbBP511GtDpFS4maEi03c5Cl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlqsCRwbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlp/o8P/1xyp630PLvSl3bKT01R
NLgiIBlUnyyWTOjNHxBa5EUm+zUXS0uRjiW5ye2kXA8GxRDYlMyYrGofVnTBh2OU
hUdVgO1QkJZoN9I/dSiRsnI2aj/RuG6py791X7J2GdWMQwgdPvqeYtqMXYFnKTsY
vFlR7U+zkvKLPsGM13J5tKW21qzgbZsZl5l0BgzVipSY8GgHhpWseZRyYUsOLiLg
QChkNOO/m8AX+dX426iR499xbpBa2erZlTxb7Q/k85c6QljawyowUa9X9Wnt6VJi
SQsfCWlcfTEjFpBOL6XWrte2/kZ6nqw4EJPCUSIlPSg8tJ1Hg9pUxVD2DcXHtMh7
GgXa/jrjPKcw2uqcveikvPmQ2ErHOJ9s5MzeQnzNwHMnKh8RPM8Vzlxd54BBhJ8+
sX3ph4gwgFhvlUHLt2BAaFe3opEY9oxeR9d4Yoa8rq/7KgyKA6YMgBNE1Lsw95zi
yOgMKn7ANp9icKO/EpdYbCJm3iEM0E82muQcy+vdZ9YQeL1tl8aoI5MtCW/ZG6kx
1aZd6zqdZkJiYFeA0iaBLGeZAQFrg49RWzcmlZUd3rNPngNIsigrC1NvSViHaWWU
8xFI2H8rp8uG2l+r4+7TGDBV56xP0EwHrvMc0H4pAWlJBTZDbKVpNu4XFB34H/Pz
+YCmZyf5fpf7WiedqnoVzZDc
=e0/y
-----END PGP SIGNATURE-----

--TUpDPwi2ZbBP511GtDpFS4maEi03c5Cl6--
