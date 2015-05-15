From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 2/2] http-backend: spool ref negotiation requests to buffer
Date: Fri, 15 May 2015 14:28:37 -0400
Organization: Linux Foundation
Message-ID: <55563AD5.4090105@linuxfoundation.org>
References: <20150515062901.GA30768@peff.net>	<20150515063339.GB30890@peff.net> <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OJTV3tNpFSlebXUJDcTqsk6nwDtUOA9Jx"
Cc: git@vger.kernel.org
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri May 15 20:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKLo-0007pM-QE
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbbEOS2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 14:28:44 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35990 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbEOS2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:28:43 -0400
Received: by iepk2 with SMTP id k2so123471932iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type;
        bh=qVyQ+6AU6SstQLvCxvYZLaLnJ/YRVBWx+8GLmxrTPZs=;
        b=M0RMaG4QV4AIAv/k0t+FQvyJcSIInyn6Qw3n1+cbM/4Fu4aONmRrg1R+xV/K0tsBKl
         1DSh8/TXOg+gCyYN1pBOJu302csSzyfJ6rmuw1XyNiHAUdaK3Ivn/1YFyyukgvuuBrCw
         +Nn0e0NGgEdCAzGFn2yg9ODWT2qW/bQlA9G8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=qVyQ+6AU6SstQLvCxvYZLaLnJ/YRVBWx+8GLmxrTPZs=;
        b=aHqKmDIJWv2g9LdzFFzd82DclMNAkNT3dthckiEx331AGGHj302sfKy8SQCAzGquyX
         2j+ntt2zftFVkQAE6Y0xSXDmc9DcCjixVkMBvv9CZXYDKVJLGUsBBFv0BSKgICC4G+lf
         QTOEmiQJCZgz87QclpW9ZTodENy1akxu86VqV0qQMcPLN6Cime4GDPmWnLNYXyqa8z5L
         8ywZO81wxXDZusLLpubmPxN4EFbysIGeVeTXsJARkKADUoW3/DmH+NIyerPXh2G0yd+g
         Gc3hzqe0AD0JFH5bf+uDD6LoD3dYrPOK1HZdi1eRiAz0FduveVu7xB8eyU0gttxdB7mx
         zkXA==
X-Gm-Message-State: ALoCoQk28zaVsnP454X2DNMlVNGKf3yictnuEUowrWKg9+JB/IxQ+hEtKe9MxfsvIo7oaSObQYUg
X-Received: by 10.107.137.143 with SMTP id t15mr14952992ioi.16.1431714523136;
        Fri, 15 May 2015 11:28:43 -0700 (PDT)
Received: from ada.mricon.com (198-84-251-213.cpe.teksavvy.com. [198.84.251.213])
        by mx.google.com with ESMTPSA id kl1sm1924357igb.15.2015.05.15.11.28.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 11:28:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269166>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OJTV3tNpFSlebXUJDcTqsk6nwDtUOA9Jx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/05/15 02:22 PM, Junio C Hamano wrote:
> Also, is it worth allocating small and then growing up to the maximum?
> I think this only relays one request at a time anyway, and I suspect
> that a single 1MB allocation at the first call kept getting reused
> may be sufficient (and much simpler).

Does it make sense to make that configurable via an env variable at all?
I suspect the vast majority of people would not hit this bug unless they
are dealing with repositories polluted with hundreds of refs created by
automation (like the codeaurora chromium repo).

E.g. can be set via an Apache directive like

SetEnv FOO_MAX_SIZE 2048

The backend can then be configured to emit an error message when the
spool size is exhausted saying "foo exhausted, increase FOO_MAX_SIZE to
allow for moar foo."

-K


--OJTV3tNpFSlebXUJDcTqsk6nwDtUOA9Jx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVVjrVAAoJEDZgaZyZ4FVXAVIH/j5y3K2g8PJ6oHQQZQ4NGUo3
NawB2eRJJ1zqzN2x2NF4lp+mTG0lK9T5bW6TGl033djUqfbzeN+qlHBlTICssKxE
5g/pNI83oBbwfsYP7qV+YCEDQ+fIcQOKyHiGLK/7QCMl7QwbkDimOfMLBwfKWTi1
nkW8DZOLMQzB5uHseH0lqlTSvNIyCQq18nwENArXJpr53M4gI0XDTS9XFDpD3w+C
jy0wwjX0PpSbW+rpfmphR0zxgeDV3fCr8Eu9baZewQ8C/6jOlO7ziyyjaOR5Anlw
EWljVMNSQ5qflndaaD1T4lXZ9ggBvjfduftuHQQvpNS7PMYeN+O3HfJ+VPJ37XU=
=HYWV
-----END PGP SIGNATURE-----

--OJTV3tNpFSlebXUJDcTqsk6nwDtUOA9Jx--
