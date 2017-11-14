Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D1B1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbdKNPeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:34:07 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52474 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbdKNPeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:34:05 -0500
Received: by mail-wm0-f42.google.com with SMTP id t139so22876717wmt.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8euCcCKsVdUER0tLJwFp+pH4+eo4hIHkr5XvaKXCHvY=;
        b=LxUQZvzgvpXVE9+nTu1KkQYP4i19j5EWKAzFHVKYQ6er0VzuGIv3GO3Uoaai3r035Z
         Y6m6AhdVyFXC4peic8TMKCH3ZsTPxiD2E35Y3Pws6UPzySsqqI+WRbFQEO4MR55BaaXb
         OYP0lnHa0FzPOOhC6s4GxMgmM1T3HghdHWisGvq59pkARxK48LvVPouxibGLJLeT5Yz2
         Y3QqnJtlKiU3o78yZUQQ929RtUSpLU3/Q7XH6BAbcUHnMpEisg0Tw49a80DylILlmOWD
         K2D0RGiGc1UDu67mdY5x3sb6RzJFriOCmCGSNMS2GwAGFIiwN6GTppkjhXkQVPbs1KY/
         bh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8euCcCKsVdUER0tLJwFp+pH4+eo4hIHkr5XvaKXCHvY=;
        b=GkmeKK9IsUytermD7VJTwZEKo70qACWaUNpF0qioI/5g4llQS8LWhELl9X8shizeUK
         ItSQ/oOwjpwbQGFnvvsEWPvGOBm63NJTU4ugN0INZMNoyR0jkllrDIdNTOthurftbvjw
         BsybwuE3RsJjNXiBD3AoH4rfXzqLjAjlviuCeuLufgN9YYDhxv4XaAcmH/3VJOvanW1R
         K+ICqHl2p4HZEQlMjwAjMsPlctNfnlbTiCe4Cm+Cr1+2eyW0GqaDe0W1QqpPh6tfF4Ab
         uRTEFr/5WKKckq/wFyU/xhmf8VzZ25NZSRq2BwsfcbCohER4TccOj/jagLJi8mZJXYXV
         xEjg==
X-Gm-Message-State: AJaThX6bLa6uPBs9YqO4pstPiOyDMfBwplI+/8r4jrajWII7//3YJFnS
        a5FsXNxr5MsIbJlBnis4wTJZ0awH
X-Google-Smtp-Source: AGs4zMZUS/kV+vbe4Bm1jB+VzISLKraUpfrr35yRtPDIW2mzkaL+uPNt3VtdOAZ6iZ2q6nzrgivqDg==
X-Received: by 10.28.113.84 with SMTP id m81mr10218668wmc.134.1510673644619;
        Tue, 14 Nov 2017 07:34:04 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-166.NATPOOL.NYU.EDU. [216.165.95.166])
        by smtp.gmail.com with ESMTPSA id h66sm8824651wmd.11.2017.11.14.07.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Nov 2017 07:34:03 -0800 (PST)
Date:   Tue, 14 Nov 2017 10:35:19 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171114153517.3z3ndsvqhekijuad@LykOS.localdomain>
References: <20171113210745.24638-1-tmz@pobox.com>
 <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
 <20171113224323.GR5144@zaya.teonanacatl.net>
 <20171113230201.3gyqh2oknic2o6mg@LykOS.localdomain>
 <20171113230612.nyygui2ahuqzrjsr@LykOS.localdomain>
 <20171114031026.GT5144@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="le7fycoo4celptwt"
Content-Disposition: inline
In-Reply-To: <20171114031026.GT5144@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--le7fycoo4celptwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If it's a small range of gnupg versions which fail badly when the GNUPGHO=
ME
> dir is removed, then there's far less reason for git to do much more than
> make an effort to kill the agent.
>=20

Yeah. FWIW, it may be reasonable to consider dropping the patch once we are
certain distros don't ship this range anymore.

> It seems like all the gnupg versions which may suffer from the bug also
> support gpgconf --kill, which would make any further change in the test to
> handle versions which lack the --kill option moot.
>=20

This is also true. We should definitely not litter the stdout with ENOENT-l=
ike
error messages though...

Thanks again for catching this!
-Santiago.

--le7fycoo4celptwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloLDTUACgkQRo8SLOgW
IpV0Dw/+MfxHbgEEaKli7RPaFH/n2zMZSq+UYg2xUFDwWNSxoxfQTXvr/jzp65mm
dbrWHOc4ViDcXf7Nq6Havbf/gx6h0cNgYOWqMo9kpuaw9p57VxcwdVPH+Joc77Br
BDjqm/YXAZ3kNwg6SseoB2FVtIa6YlIQHY6wCaAbpyYnFMkaxrZXCL7V6NhL/3kn
CJ1xY37h03TlrK9Nfii54+ie5qjaoZZ9/+lvjSKiFtXLQPnK+/Kxcxi8+NCKPcpw
2hOzOALc0E88JXGvU4TNvn6ETBHUEQlGBAWIs2pp910DpLsGOqd0dY81H8WCk1Pc
18wqmFSVxEz2iwIWYS2gHy9o5WbQyOKfs8kiKmk0wri75DOGsBhqiCOC54X7Wt28
aUqf+JpKffL7FMZL5lYfyaIEJw/73xANzOtYDXA4J8ULztoVMGqushPdypKwIHNv
IZjb5PCOJFOyknMvjU/DJYMunX6VDNfTxJehbf/0svDUuQMtdtaLVctiYzzZYSBK
xdNoSbAeP3xZZ8yOHYmKhYrKZuJ4MObc1JzTBykkkiLREeBffA+fDM2PYE4cpFZB
4NyRRsQ3ueLfzrO8Nh5c9EfSWV2Af7xGai5ytAqzaVuIeaDj871lqORs6fg/fA5i
6uinA67RlU5T2excZf0Bx7wded2u/HSCqvo0iWbLExlSl2vvSEg=
=Nb61
-----END PGP SIGNATURE-----

--le7fycoo4celptwt--
