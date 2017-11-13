Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8201F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbdKMXAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:00:51 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:56565 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbdKMXAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:00:50 -0500
Received: by mail-wm0-f42.google.com with SMTP id z3so18443130wme.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rgDxS/tDguqtHa29ymyhCTOh8Fa2AMH8F4a1AcFwI04=;
        b=ESXdkjOOGteuVMhT2ZSCv3Kwdtr12qY4UkCQ9OOdcAAYo1W9P7S8rAyGsd+3VzpW42
         jpyRTbiGOIO9hkM/ITH7d1KF4ikDOxOXscQobfD5HU4wyVkrwlTionXJE8GFTkH/8MLX
         Uy8tC7Zo5Ky9EfUq8gwHugwv5wFDRW08p+mBQtWocdDPssNJKqrNXjCfIZT5nnppMdXP
         DTylBCYWUSkDaHL3E7Y4MmmCG5x8E/QwHSsTxyX0iBJA+whqEs7/0oPSLXFqqV8eqy1Z
         lGE5+eGPyrw0Kq62y9rxyUmTASoJzFovKozUnT/sctchufCAbzGM0TEZEIVrIBiH/IK7
         XhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgDxS/tDguqtHa29ymyhCTOh8Fa2AMH8F4a1AcFwI04=;
        b=U7PMx5EHt9EOBUNlhkXc01zoaFwAByIYlynoUC++mzrwOEAeeTx7gAC8ha0i22P0tu
         QVGblR9bUvXY9upPTiOrBeBnB8WfO50YUVxkkZyiwBJRR7sowDzmUbWOa3blaAJVNi4S
         j2HZKHU0OIQx+G/gu5mgrY2q9Ty/5oNFfOWUzlFxDA+HDMnumb9MC7d5ELWy3QCu2uZD
         WOEwzcU6rXQ/Lb+MWpuwcycVFSJJWSdcV6fPrFGkFQpyGtsNUAVvaXAeDOR5jo0e6xZl
         kCuiiRtF15P8J7CC/L889I3EmUvcmZVwGmXxWB1WSfnky0SC63AY2FFyqG7UFEH5shkL
         M5pw==
X-Gm-Message-State: AJaThX4XOCTjGeuKFTw7UiD++DOsOB/6Zogs8mRNtgZLHOwdAh+HcjDN
        b5pXwgNfvT4AzwMjAgXNVGdhtw==
X-Google-Smtp-Source: AGs4zMbyfPTy9J3MHIRosGG0euC41im7eAmfaICXv5E/ZZlt1JJ2v0tcDqyNNEhrUk+U1zjVKHklng==
X-Received: by 10.28.56.198 with SMTP id f189mr8095027wma.16.1510614048909;
        Mon, 13 Nov 2017 15:00:48 -0800 (PST)
Received: from LykOS.localdomain (cpe-67-245-44-149.nyc.res.rr.com. [67.245.44.149])
        by smtp.gmail.com with ESMTPSA id t135sm4319827wmt.24.2017.11.13.15.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Nov 2017 15:00:48 -0800 (PST)
Date:   Mon, 13 Nov 2017 18:02:02 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171113230201.3gyqh2oknic2o6mg@LykOS.localdomain>
References: <20171113210745.24638-1-tmz@pobox.com>
 <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
 <20171113224323.GR5144@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5ynz3zyftqshzhg"
Content-Disposition: inline
In-Reply-To: <20171113224323.GR5144@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a5ynz3zyftqshzhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
> Were the ENOENT errors you encountered in running the tests multiple times
> easy to reproduce?=20

If you had the right gpg2, it should be easy to repro with just re-running.

> If so, I can certainly try to reproduce them and then
> run the tests with --reload in place of --kill to gpgconf.  If that worked
> across the various gnupg 2.x releases, it would be a simple enough change=
 to
> make as a follow-up.

Let me dig up the exact versions. IIRC it was somewhere between 2.1.0 and 2=
=2E2.x
or so. I think somewhere within the patch re-rolls I had the exact versions.

Cheers!
-Santiago.

--a5ynz3zyftqshzhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloKJGQACgkQRo8SLOgW
IpVglg/+Ng89dRA76ftgv+kBByM3L6UIHOo5eBE+atUtAfs+K4obPSiJjcSkYV/0
y0EXnKiJ9U8uh9GRA0eZpaAnzQ0hdL9AZHvwrV2EM24l9Qr+Dkj4zAC8uqBx297W
70L2AwBELYbcHmngPJUI/2Ucu3jKh7zes6hgPjw1HIfY0wZ0QcoN8ap1/9hru4PR
jJ4poqsMzEX0ZrBgqrtqr2Il45SXi2kWxFPZnMHIjgQaTMlN64/faoFUw+aPmMo+
MuIc5SUeg6nHN9HimeK5v4jccbSty/XM1NdVeMxrVBBKplGEPYlNq8rZIj2dvriX
JFrq6x7m2mTaR3/co+RNYjrXUN4dDqeFNl1cN4dcUrdFTNKCLjn41LMsskKo9ZlL
bEDRFn3mVClvHn/GAynL8lm746dgl9yosiHbBWXkLzSmPEBZX0KdTQKYDkmknH6N
fOKSy3x74JP/dkkgZPNBhMiLodJQTdGxTJIKKy6sCPSdJX3cyCKCN4+zIOib+zX1
1lN25QhKeKFtUA+RetosaOXH/dx1JyNz5PikEYhIO7bYjIkVSBUmr99aNQ/2/CPe
dPL3eZ2PTyeZjAx2knACVHMcjmqzEhWpCPmOxMctK7kkRfKixoc2PVXoLWJm0nB0
sVGX9a1nBd4wsLZo5vYZk7x4O7xSQeoejF1tN9O++dEBRMmziAs=
=dSWi
-----END PGP SIGNATURE-----

--a5ynz3zyftqshzhg--
