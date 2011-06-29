From: David Caldwell <david@porkrind.org>
Subject: Re: [PATCH] stash: Add --include-untracked option to stash and
 remove all untracked files
Date: Wed, 29 Jun 2011 10:11:59 -0700
Message-ID: <BE416D9D73FF59D8584480F7@black.porkrind.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========AA2BA9933C82DEFB3DBD=========="
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 19:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbyJE-0002ye-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1F2RMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:12:10 -0400
Received: from kill.porkrind.org ([68.68.97.104]:42532 "EHLO
	david.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab1F2RMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:12:09 -0400
Received: from porkrind.org (cpe-98-151-185-99.socal.res.rr.com [98.151.185.99])
	by david.xen.prgmr.com (Postfix) with ESMTPS id 029B92BFB6;
	Wed, 29 Jun 2011 10:12:06 -0700 (PDT)
Authentication-Results: david.xen.prgmr.com; dkim=pass
	(1536-bit key; insecure key) header.i=@porkrind.org
	header.b=XdJ5nlqS; dkim-adsp=pass
Received-SPF: pass (porkrind.org: authenticated connection) receiver=porkrind.org; client-ip=127.0.0.1; helo=[10.0.0.50]; envelope-from=david@porkrind.org; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from [10.0.0.50] (localhost [127.0.0.1])
	(authenticated bits=0)
	by porkrind.org (8.14.4/8.14.4/Debian-2) with ESMTP id p5THC4ap023601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 29 Jun 2011 10:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=porkrind.org;
	s=apoptygma; t=1309367526;
	bh=NPjUXfaBnFP0Yu7H08DzZ1J/OnkGwTpNgRsOuDrDlk0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type;
	b=XdJ5nlqSDdODwUXoIzrg3Sslzm6fx/spae6TfV3XSk/lQLAp9c2IQyYku0rlUNZev
	 kAPD5dOhwcmC+naws5SlRatRcXzK12WXPKW59oOKf/3zOLHY8ANcqv87J9GGUCo1rG
	 S6RAxwb79RKqRZSuVPaDIBvAcZ1HpyGs1zRF978yVL7vxgVo6GmmwtLCp+bGEXGE5H
	 2OPg3DREOSlSbd2FHH5ml20OjG+WdU2az8fj7Jkw0CzAitn2JaRdHrANtdT
X-Mailer: Mulberry/4.0.9b1 (Mac OS X)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_QP_LONG_LINE,
	SPF_PASS,T_DKIM_INVALID,UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on kill.porkrind.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176449>

--==========AA2BA9933C82DEFB3DBD==========
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6/26/11 1:02 PM -0700 Junio C Hamano wrote:

> David Caldwell <david@porkrind.org> writes:
>
>>  create_stash () {
>>  	stash_msg=3D"$1"
>> +	untracked=3D"$2"
...
>> -	create_stash "$stash_msg"
>> +	create_stash "$stash_msg" $untracked
>
> Just a minor nit from internal API point of view, I would prefer to see
> something like
>
> 	create_stash --untracked=3Dall "message"
>
> or even
>
> 	create_stash --untracked=3Dall --message=3D"message"
>
> once you start enriching these functions with optional behaviour.

I could do that, but doesn't that mean create_stash() would have to have a=20
whole while loop and case statement just to parse the two options? Because=20
that seems a little overkill for something that is only called from 2=20
places. Is there some nice compact way of doing the parsing I'm missing?

I could also remove parameter passing part and just leave it as a global=20
like the --patch option does. ;-)

-David

--==========AA2BA9933C82DEFB3DBD==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)

iQCVAwUBTgtc46f81MBhyqGFAQjtLQP+PKEZgQ2lqpM+kUR4quwUqfeYHCZWKQPF
+TrIRCNuacCMTGt06RnJD0pS+TvTSBm9xHI8gc0px0FkKg1B3Z70ZVfEdFX4Cvr/
7Ap7YmEmfinT4TdCBEUDb66WnHckiOFaii2kgO41MB+9VXig6BDeSZG5cVLr1Wxi
fFxIZ4dx7hI=
=jDHn
-----END PGP SIGNATURE-----

--==========AA2BA9933C82DEFB3DBD==========--
