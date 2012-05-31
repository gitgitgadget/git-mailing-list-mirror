From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 08:36:16 -0500
Message-ID: <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_11E4F298-9736-4F50-A6CC-8A865628F4FE"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:36:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5YA-0004Li-5o
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093Ab2EaNgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 09:36:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52060 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949Ab2EaNgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:36:21 -0400
Received: by yenm10 with SMTP id m10so778936yen.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=PncUTwAJZHRnytKLohlj/or3LCqkX9wp9ciYcnPYBqc=;
        b=l46q2qkSo3zJYREQq+RBnaM3dV1+DnqCEKbLFjme23P3Ls3ijIQTiOcjJY+TqS4pOD
         cSWYC578+ECxL/WRMlQBGRdw2GNO/GK0khTAukIp2x5kC905UXzqaowh4iWpt7e1bnVD
         ArabkzCNiCgiQCVPBbu+nEWMM/HdHP4nqONew/spbWmfVAPjMxBST3zl9BcqXJFu6GVy
         DsOaRmLh6kl/X9T70j/PC04zHHUj8onD7ku2FXRP6swOrMSxGT6w9mRP9SIAxItbD9Vb
         zf4G0lLC0bYIwuEfUOO3D9PQ6/OxDaravRtlGDlY820BYuP1MDjnAa1FUI9p4CteSKbY
         sbFQ==
Received: by 10.60.30.194 with SMTP id u2mr19035919oeh.5.1338471380434;
        Thu, 31 May 2012 06:36:20 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id x10sm1926958oeb.8.2012.05.31.06.36.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:36:19 -0700 (PDT)
In-Reply-To: <7v62bc97w1.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkB/iDxqSBhrcvb7azY6g/+r9UGC5kHMA30KmTzbVq5n9uoKxydPPmIlEnhiVTPHzSJJT8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198896>


--Apple-Mail=_11E4F298-9736-4F50-A6CC-8A865628F4FE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Bingo.

  lanny;~> echo "R=E9mi Leblond" | LANG=3DC LC_ALL=3DC /usr/bin/sed -ne =
's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
  GIT_AUTHOR_NAME=3D'R=E9mi Leblond'

Just occurred to me that I'm using fink and that git-am doesn't use =
/usr/bin/sed but just sed.  My suggestion is to be explicit on the path =
in git-am.

So it now stands at two bug-reports and one pebkac.

  Thanks!,
  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On May 31, 2012, at 1:33 AM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
>> On Wed, May 30, 2012 at 04:45:33PM -0700, Junio C Hamano wrote:
>> ...
>>> So in C locale where each byte is supposed to be a single character,
>>> that implementation of "sed" refuses to match a byte with high-bit
>>> set when given a pattern '.'?
>>>=20
>>> That is a surprising breakage, I would have to say.
>>=20
>> It should not be too surprising, since we discussed it a few months =
ago:
>>=20
>>  http://thread.gmane.org/gmane.comp.version-control.git/192218
>=20
> Heh, no wonder I do not recall that one, as everything happened and
> conclusions reached while I was sleeping ;-)
>=20
> If it is not a bug in platform-sanctioned sed, but a buggy
> third-party build, then I wouldn't worry about it for this cycle,
> but pre-release freeze might be a good time to start sketching
> Thomas's --format=3D"%'%an <%ae>%'" approach, perhaps?


--Apple-Mail=_11E4F298-9736-4F50-A6CC-8A865628F4FE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/Hc9EACgkQ+owW65SoXfi4WAD/XRTLvQO6CgpPaQ0LE2NK9nYh
dWR8pA/9COxfUa2wCJEA/0HKHd9xRghEXzbZdf6HRy5G1Ox5+XxyveBaQhdoWrUs
=KbUI
-----END PGP SIGNATURE-----

--Apple-Mail=_11E4F298-9736-4F50-A6CC-8A865628F4FE--
