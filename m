From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 13:38:34 +0200
Message-ID: <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de> <51562E79.7000202@physik.tu-berlin.de> <87obe0x94e.fsf@linux-k42r.v.cablecom.net> <51581617.1030107@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 13:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMGcm-00021i-9q
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab3CaLkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:40:05 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:3284 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3CaLkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:40:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 13:40:00 +0200
Received: from [10.151.234.36] (213.55.184.251) by mail.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 13:39:57 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <51581617.1030107@physik.tu-berlin.de>
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219616>

"Sebastian G=C3=B6tte" <jaseg@physik.tu-berlin.de> wrote:

>On 03/31/2013 10:32 AM, Thomas Rast wrote:
>>> +	test_must_fail git merge --ff-only --verify-signatures
>side-untrusted 2>mergeerror &&
>>> +	test_i18ngrep "from an untrusted key" mergeerror
>>> +'
>>=20
>> This test gives me the following:
>>=20
>> =3D=3D26527=3D=3D Conditional jump or move depends on uninitialised =
value(s)
>> =3D=3D26527=3D=3D    at 0x4C2D8BC: strchrnul (mc_replace_strmem.c:10=
84)
>> =3D=3D26527=3D=3D    by 0x4989CC: parse_signature_lines (commit.c:10=
74)
>> =3D=3D26527=3D=3D    by 0x498B33: check_commit_signature (commit.c:1=
100)
>> =3D=3D26527=3D=3D    by 0x453719: cmd_merge (merge.c:1246)
>> =3D=3D26527=3D=3D    by 0x4057B6: run_builtin (git.c:282)
>> =3D=3D26527=3D=3D    by 0x405949: handle_internal_command (git.c:444=
)
>> =3D=3D26527=3D=3D    by 0x405A63: run_argv (git.c:490)
>> =3D=3D26527=3D=3D    by 0x405BF2: main (git.c:565)
>>=20
>> though I currently cannot see what's wrong, probably because I don't
>> know the format that parse_signature_lines gives.  Can you look into
>it?
>Against what version/combination of the patches are you running the
>test?
>parse_signature_lines is called parse_gpg_output in v5.  Perhaps just
>try again
>with v6 of the patch, the difference between v5 and v6 is
>parse_gpg_output
>(Junio did not like the v5 variant).

Oh, my bad then. I used the version in pu. I just ran all tests under v=
algrind and this cropped up.

If you have valgrind installed locally, you can also test yourself ;-) =
just pass --valgrind to the test script.

--=20
http://code.google.com/p/k9mail
