From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: [PATCH] stash: don't leak underlying error messages
Date: Fri, 13 Apr 2012 05:59:54 +0200
Message-ID: <4F87A4BA.50009@gmail.com>
References: <1334169379-20827-1-git-send-email-rosslagerwall@gmail.com> <7vaa2g694j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigBC826401DD93555446014537"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIXh1-0002Lh-GH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 06:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794Ab2DMEA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 00:00:28 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46074 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2DMEA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 00:00:26 -0400
Received: by wibhj6 with SMTP id hj6so6088785wib.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=5wr+vVWRTP7o/O9UyIQo5IT73L4xX7XeoC1AHNd9Wrc=;
        b=zYmEVFy7j7H5mrEOFfXI5hlZ42oa62cfru1Qvx0YzjRAu6TCS0SsTBIVwDS35hKf92
         tltXn/JSMv4TZCiv3/WMhiZi6OPFLzhvm8fKQ4sYieV4t/zhRbobzgB0MJA+I0VzBDsD
         PqC9pNNNUPIMIAwCy5V7m6nIXz9Gv5ANKyQstSWuJ5FOynCsI8eHBZdtBnRamwrgrDuI
         OXFfpeZzHb2L/S4yIYY0Izi8+FSC4gUm70XOmNeQGzeBZnaXHhRm+pafBJmOFIKpjX6y
         fLB+EG4n6cZX1+JV9NFfKYrzkAX88u/xrQxr8SevSEIX7CgcWLhYaqqDHP+anNISZKjO
         3O8Q==
Received: by 10.180.104.65 with SMTP id gc1mr362611wib.13.1334289623994;
        Thu, 12 Apr 2012 21:00:23 -0700 (PDT)
Received: from [192.168.1.90] (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id gd4sm3294514wib.6.2012.04.12.21.00.21
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 21:00:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7vaa2g694j.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195398>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC826401DD93555446014537
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/12/2012 09:30 PM, Junio C Hamano wrote:
> Sign-off?

Oops, I'm not really used to the whole sign-off thing.

> Is create_stash (hence save_stash) the only operation that do not make
> sense when HEAD is not born yet?  I am wondering if it makes more sense=
 to
> either:
>=20
>  (1) catch the case where HEAD is not born yet a lot earlier and do not=

>      let the control even reach these functions (i.e. die inside the
>      case/esac statement at the end of the script); or
>=20
>  (2) pretend as if HEAD is a commit that records an empty tree, and not=

>      error out to begin with.
>=20
> If either one of the above turns out to make sense, then the issue this=

> patch addresses becomes irrelevant, so...

I think it would be more consistent if stash worked without any commits
having taken place so I'll look at (2).
--=20
Ross Lagerwall


--------------enigBC826401DD93555446014537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREIAAYFAk+HpMAACgkQMRWWudUHn2SR5wD/VYizc5V+q9dJ4uCoVElOMNfs
EFpgR/ASgV1O+QV7RssBANCm4zgtifO9rcScrg28orj04u1tqbR5inahPUEEC8Hh
=4epT
-----END PGP SIGNATURE-----

--------------enigBC826401DD93555446014537--
