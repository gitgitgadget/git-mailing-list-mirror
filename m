From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 14:27:20 +0200
Message-ID: <51582BA8.90500@physik.tu-berlin.de>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de> <51562E79.7000202@physik.tu-berlin.de> <87obe0x94e.fsf@linux-k42r.v.cablecom.net> <51581617.1030107@physik.tu-berlin.de> <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com> <515824C2.1020004@physik.tu-berlin.de> <e92b404b-d5e7-489a-90d0-190d1f15177f@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 14:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMHMy-0002Mx-28
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 14:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab3CaM1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 08:27:42 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:57308 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab3CaM1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 08:27:41 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UMHMG-0002qP-Ie; Sun, 31 Mar 2013 14:27:40 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 0A66811402;
	Sun, 31 Mar 2013 14:27:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <e92b404b-d5e7-489a-90d0-190d1f15177f@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219619>

On 03/31/2013 02:16 PM, Thomas Rast wrote:
> "Sebastian G=C3=B6tte" <jaseg@physik.tu-berlin.de> wrote:
>=20
>> expecting success:=20
>> test_must_fail git merge --ff-only --verify-signatures side-untruste=
d
>> 2>mergeerror &&
>>        test_i18ngrep "has a good, untrusted GPG signature" mergeerro=
r
>>
>> =3D=3D1430=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
>> =3D=3D1430=3D=3D    at 0x4C26B5C: strchrnul (mc_replace_strmem.c:711=
)
>> =3D=3D1430=3D=3D    by 0x47B90B: check_commit_signature (commit.c:10=
57)
>> =3D=3D1430=3D=3D    by 0x444212: cmd_merge (merge.c:1245)
>> =3D=3D1430=3D=3D    by 0x4050E6: handle_internal_command (git.c:281)
>> =3D=3D1430=3D=3D    by 0x40530C: main (git.c:489)
>>
>> Though I also can't see the problem. strchrnul gets passed a char* t=
hat
>> is just fine.
>=20
> Usually that means that the string *contents* are uninitialized, usua=
lly because you scanned past the end of the string...
I checked for that, everything looks fine to me. The pointer should poi=
nt to a valid, 0-terminated string.
