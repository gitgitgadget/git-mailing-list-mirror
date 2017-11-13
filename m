Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3DD2021B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbdKMXFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:05:02 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:54455 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdKMXFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:05:01 -0500
Received: by mail-wr0-f169.google.com with SMTP id l22so15861226wrc.11
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJWDNZzgLtJhQyZ/abd/hQXsu8WQtl6AYUPmS3XEMhU=;
        b=uUiUfL/x9oS1/VjrbVfX1GjTdw0HuW5HSigUE/9gO2jk+2wslo9FEdQryKaHBgksz2
         DwjwK1DQteeG3QKDWZlEg2QHHaxwcfBC2t7gzlqINVFih4uJor5KHn925bx8sJoFUJOY
         FJHnlLoNieBsOfdWJPSmLP54XUKacBOAWSOA8fIPpnmKc7msnRSFj6ymQx/UQSiVTHXa
         wmOS9dcwoVy6tzdvT+SAAIdP0hsixW5lF1n2T2b/zAoOoLBLgYw/YlLUV+QXVvKjlqaV
         qB+Q79a2NJAOXvxjVhfWIREhrEpim4tETcZAZWPKkfNJR70dbQu3CV3RLJZALSRaQuMG
         TLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJWDNZzgLtJhQyZ/abd/hQXsu8WQtl6AYUPmS3XEMhU=;
        b=HvUEX9bOEKMqyVcik++5GSJ8ioXYzdS239hP0odTP+mM3JHIFBrw6S+wIee+9J8Xo9
         CK7dDNGqlWmycTR08/5cVkn4uC6dd8FbEi29HVpizVZ/qTI0RQlzO4ZUgkjGiX4LWMOL
         aJcfNFMsuX28qzWoc3grBGjyfYYyzbpeHGPczdSaNRSASJIhU5bWDgl+85L4PmtnTFu+
         Siy7M3uUq0UKtdAfxUqL3j977AxRd3/1QCoc6VprnImLYccmeJn4D2uXjxpWVb1sE206
         gSBtFyD7j1yPRUbrCqHzk1ZtSqnw/KDCjf1p9bFWjEvR4JY+iOx6O2AutHkTeLaNSiYe
         d9Tg==
X-Gm-Message-State: AJaThX78V1qdSx5mmlyh4pL56W9w9mMQQFIC1bTqU7SdkmIYU4p+xpgt
        iiWIdcQ7L3ryBLl3PJd3Pk7gow==
X-Google-Smtp-Source: AGs4zMaJgVl+QMab9kBOLi09kDBDIXDjrTFwQJN1spTYau1qxnhakt1SEf3qdO4o2sQUKM3i+bsfhg==
X-Received: by 10.223.164.22 with SMTP id d22mr9402617wra.232.1510614300143;
        Mon, 13 Nov 2017 15:05:00 -0800 (PST)
Received: from LykOS.localdomain (cpe-67-245-44-149.nyc.res.rr.com. [67.245.44.149])
        by smtp.gmail.com with ESMTPSA id 195sm31316562wmj.3.2017.11.13.15.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Nov 2017 15:04:59 -0800 (PST)
Date:   Mon, 13 Nov 2017 18:06:13 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171113230612.nyygui2ahuqzrjsr@LykOS.localdomain>
References: <20171113210745.24638-1-tmz@pobox.com>
 <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
 <20171113224323.GR5144@zaya.teonanacatl.net>
 <20171113230201.3gyqh2oknic2o6mg@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5p7tpbgq3bsqnalu"
Content-Disposition: inline
In-Reply-To: <20171113230201.3gyqh2oknic2o6mg@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5p7tpbgq3bsqnalu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quick followup.

The version that triggers this is at least 2.1.21[1]. I recall there was so=
me
wiggle room on minor versions before it.

Thanks!
-Santiago.

[1] https://dev.gnupg.org/T3218

On Mon, Nov 13, 2017 at 06:02:02PM -0500, Santiago Torres wrote:
> =20
> > Were the ENOENT errors you encountered in running the tests multiple ti=
mes
> > easy to reproduce?=20
>=20
> If you had the right gpg2, it should be easy to repro with just re-runnin=
g.
>=20
> > If so, I can certainly try to reproduce them and then
> > run the tests with --reload in place of --kill to gpgconf.  If that wor=
ked
> > across the various gnupg 2.x releases, it would be a simple enough chan=
ge to
> > make as a follow-up.
>=20
> Let me dig up the exact versions. IIRC it was somewhere between 2.1.0 and=
 2.2.x
> or so. I think somewhere within the patch re-rolls I had the exact versio=
ns.
>=20
> Cheers!
> -Santiago.



--5p7tpbgq3bsqnalu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloKJWQACgkQRo8SLOgW
IpXNJhAAm7ByBjbCD4KnGhzLFZdhdNWoNjKROJzfGlJQg07OgBYpmb5go8N7BG4J
UwyHAHW8WA666oKVt6wcWlNthNe2WmwoU7Gc8nEPg4B08IcaUwI9Q7qboxZCcDy5
Z1bqrYGW1li9hq71vWovMKyxqGqNV2gtUBBXd/kcx4bB/8V0t7AXT6rucwt+isxT
YRRarQcSlJ0XOF8lcdnD+NWcfzfQw71rDoxYmoamqcJjIzOLSYU0CTBNhlguf2z/
DG9ZaFidWGrylBCN7UGUd54TbdCwZCgmsZulFh9YDGsp2No+OAAtyuGC7ZZAyaAQ
NQO26mRxAgBPT3GSmuJ/0lxz42Q5izSgGGTWgueSjm1rQd6l1w9KALxkEKHPMt3v
5RKYJqhPmP9fOH6o8pU32pUefM2Hfgm8o+47i6dFcLzbCD1jk9fmGxwFIdQq5+v8
1NvH/eBsbmRXB9e5FZYKTDukGv0JfghbYjaXW+ADhlVjXuSfcqAK3StauRh/bs1a
X+77kdytklJKAwbk9WTPAximIgMTzB35azCQRphUiTu9geDDkKxMbDMlknKl5W4q
Az/D1V5/vJdeIo3AshD7QTm48NBhkzwSBr0nkIQNPNFBrne7YbugI7Nt4x8z1w5f
up7C3xPhcRwrFC2RVInrolco9hSOe1xgmjbVCDEiZcRr52NZrNY=
=bNZ4
-----END PGP SIGNATURE-----

--5p7tpbgq3bsqnalu--
