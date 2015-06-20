From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 20 Jun 2015 23:49:01 +0200
Message-ID: <20150620214901.GA5520@leeloo.kyriasis.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
 <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
 <20150612223223.GA22677@leeloo.kyriasis.com>
 <xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
 <20150620142705.GA23163@leeloo.kyriasis.com>
 <xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
 <xmqqmvzujcvb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 23:49:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6QdT-0000wR-ER
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbbFTVtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 17:49:07 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:42074 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbbFTVtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 17:49:06 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 532b0003;
	for <git@vger.kernel.org>;
	Sat, 20 Jun 2015 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=WC4c5Bqc8AGYlc6rjhPgmpztK4E=; b=KkxKft
	Fn4AlO5z5RfuGMN0llfJ5i7rb+/gZz2PfL5AT1FmGdCLNnAJnpdPfxDjWicP2lHR
	1VEawCRpZ8uFAQcWOQC3hSX6c+hDVV4KS+CP+pYWyd1AziyDc02AA6X4IntOfLtp
	Ep2Q8tdWYvuFeIjNveirqIctWI5KaxduprosY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=ivjaqKAQR4MEUIINblZs6HSG5/8D9/EP
	0C+cUy9UOB3gTXIkJRSj+bHnWWlo/C5ygtnno1XvMP7gL3U/7PsVCaDWUhjbF7o4
	huB3JE0gWpVrT3Ia/dGS6KQexu2zOmGgTdEZE+SxSfoKKR6WvOLIsWmq+vO+dSle
	ONS/O+OV0+w=
Received: from leeloo.kyriasis.com (h45n5-tb-a13.ias.bredband.telia.com [81.234.145.45]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 39628d84;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sat, 20 Jun 2015 21:49:03 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqmvzujcvb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272241>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/06, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>Let me step back and try again, as I think I am missing some
>existing feature you are using, and that missing piece is preventing
>me from seeing why this is a good idea (by the way, I do not think
>we are doing this exchange in the right thread---the upload-pack
>patch is not about auto-vivifying a new namespace by creating HEAD).
>

Yeah, that's true.

>But if we made some change to the transfer to push-to-receive-pack
>so that this can also create HEAD that points at something, what
>would the user say, instead of that earlier
>
> $ git clone git://site.xz/r
>
>to access this new namespace?  Don't you have to be running another
>instance of a server with GIT_NAMESPACE set to 'b'?  How do you
>arrange that to automagically happen?
>
>Or do your users that clone/fetch do things differnetly from the
>above, and if so what do they do?
>
>How is your server configured to support the access the existing
>namespace 'a', and the new namespace 'b' that is automatically
>created by pointing /usr/share/git/r.git/refs/namespaces/b/HEAD
>to one ref inside that namespace?

If you want to hide the fact that you're using namespaces you'll=20
probably have to either run another daemon or use a wrapper script, yes,=20
but only if you want to hide it.

However, if you don't want to hide the namespace behind some script the=20
users just have to use --namespace or GIT_NAMESPACE, possibly having a=20
script that does some access-control magic so that you eg can only push=20
to specific namespaces.

Having it be created is especially important when someone might be=20
working on the same machine as the repo, where the push won't go through=20
eg SSH.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVhd/KAAoJEJAcHDIOsNRdmMcf/2qsB6Hy3bqoWZJM3KwqFNQt
QQT5B3lSyEhy4beKA/0uox4V9+qWfyqA1ETq/0eCmpaEx8+48OMZeNgBCb8VhIYI
TonFiPdEAFL/mZMFtIaUrgqDFwF3p+EVcZVdhrVX9o5vPKB9l5AOD2BJNqBP6wTe
+egEppqUlBttbu9/WMDePayc4UqPfwEhzMHqF4yvB5rso1l0Rz1VLfGnER9Hdn0s
PqLDp5jnmzNO0LAHkbb6/UM+sybe2bivjvmpA0Z4qPkdRPbRSJzA0nLdnzkrHdrB
jAux5iw0sFzsHK8lcEbUx9EdxPZb/knQ58wRGryL3KKwKLpeINM75hDj25WiQK0w
44Fki6jfxgj/pucvdsy8pHfl74B28XPWMP+OjZrpD7WiGa4l/SemXoQcSZGW1Wbu
Rwet8+9+LbTnDuD1yqgOSY0pbLf+ak7VRsfIUJe6bzFvb0xYdEZUswupPPto/VYa
h4P+tW8Feg5T3jpUFfl+RXBYkKUeyeVhVcIsRjSG3sy24FXu3s+RF7ddbO910KwD
VhSGM701XAFTHheKF0Bg17yIGu18d00XuCI+Erv5rr0yF3aL0NrujdCQImVKGYE1
lR6fisrhlJjDDYmPyIL3G63PSZ6cZPjDwi/ZtNQccHDyTOAWl19NpGz919smW78+
Znbhuu0CpwRI/vWw6gGGFUXkyGAo0N8toyBMeuW8VQXPn01Qph+qQAD0nxsGBoKw
l55E/wnJotjN0iyK6tt8S/IpwDcj33WLKlV/kTetx+u+Xklc83oaYfnZm06IlW8m
D53q/ow1oBrSHxl3mgAYaDXWjzUOvgtcDcpJQjNbcyfAnFMJQdsIQOb3wk6AlI5R
9ycnhnsTQDW+PMM25D9vHjBesuqBqDpNxXq9Ua5VUeu/DFuosYVsyC8Zt2zvb5N/
8fJ63NF6KERPO2ebpLIlQP1O/pDWQufUKMBFcimty5r9G4iXxQB5oRmW1UPGiAB9
RgdyAs7YfkRbuYYITKLFJqmvle6jvUHzoxls/nBDHRVTfdbADnrqPoS96UHrqxkC
oO2J96GL7SOhF069g8Dh+B6+nLuMC6wOA6HIDqeBmtrr/LDUc1nqj4YwmzxUSCJZ
ru+17exR/GncfpgPqS6r9G/49WmKUr/ZBdzSJ5CcwAzxxxew5FEaRn503apy9+Zg
DMM/kF58URMNM5VVrKoGZFV6yF6ty/69cBbFNObTi+Seiohb0vbqVfRpyj1uOb06
dK9/vZ1WQvI3Bhxb4TRTjSQsY3ZOel8pTnfNVsPf0Cbl5YjDFUdKhEtgmurAB5xh
XSmP6tIFlJQrJuE3y9IesKys7JzTK3wUAEyr4KMvx/vyInIEcjVrBeZ2SnXPRHg=
=LGG8
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
