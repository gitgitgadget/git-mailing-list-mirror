From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 14:16:26 +0200
Message-ID: <e92b404b-d5e7-489a-90d0-190d1f15177f@email.android.com>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de> <51562E79.7000202@physik.tu-berlin.de> <87obe0x94e.fsf@linux-k42r.v.cablecom.net> <51581617.1030107@physik.tu-berlin.de> <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com> <515824C2.1020004@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 14:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMHDH-0007BS-OP
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 14:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab3CaMRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 08:17:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:21580 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270Ab3CaMRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 08:17:41 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 14:17:37 +0200
Received: from [10.151.234.36] (213.55.184.251) by mail.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 14:17:34 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <515824C2.1020004@physik.tu-berlin.de>
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219618>

"Sebastian G=C3=B6tte" <jaseg@physik.tu-berlin.de> wrote:

>expecting success:=20
>test_must_fail git merge --ff-only --verify-signatures side-untrusted
>2>mergeerror &&
>        test_i18ngrep "has a good, untrusted GPG signature" mergeerror
>
>=3D=3D1430=3D=3D Conditional jump or move depends on uninitialised val=
ue(s)
>=3D=3D1430=3D=3D    at 0x4C26B5C: strchrnul (mc_replace_strmem.c:711)
>=3D=3D1430=3D=3D    by 0x47B90B: check_commit_signature (commit.c:1057=
)
>=3D=3D1430=3D=3D    by 0x444212: cmd_merge (merge.c:1245)
>=3D=3D1430=3D=3D    by 0x4050E6: handle_internal_command (git.c:281)
>=3D=3D1430=3D=3D    by 0x40530C: main (git.c:489)
>
>Though I also can't see the problem. strchrnul gets passed a char* tha=
t
>is just fine.

Usually that means that the string *contents* are uninitialized, usuall=
y because you scanned past the end of the string...
--=20
http://code.google.com/p/k9mail
