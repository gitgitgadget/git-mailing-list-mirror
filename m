From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 10:32:17 +0200
Message-ID: <87obe0x94e.fsf@linux-k42r.v.cablecom.net>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
	<cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
	<51562E79.7000202@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDhU-0008Ko-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab3CaIcq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 04:32:46 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:58071 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab3CaIco convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Mar 2013 04:32:44 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:32:41 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.251) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sun, 31 Mar 2013 10:32:30 +0200
In-Reply-To: <51562E79.7000202@physik.tu-berlin.de> ("Sebastian
 \=\?utf-8\?Q\?G\=C3\=B6tte\=22's\?\=
	message of "Sat, 30 Mar 2013 01:14:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219607>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> When --verify-signatures is specified, abort the merge in case a good
> GPG signature from an untrusted key is encountered.
[...]
> +test_expect_success GPG 'merge  commit with untrusted signature with=
 verification' '
                                  ^
                                  `------------.
Nit: you have a pointless(?) double space here-=C2=B4

> +	test_must_fail git merge --ff-only --verify-signatures side-untrust=
ed 2>mergeerror &&
> +	test_i18ngrep "from an untrusted key" mergeerror
> +'

This test gives me the following:

=3D=3D26527=3D=3D Conditional jump or move depends on uninitialised val=
ue(s)
=3D=3D26527=3D=3D    at 0x4C2D8BC: strchrnul (mc_replace_strmem.c:1084)
=3D=3D26527=3D=3D    by 0x4989CC: parse_signature_lines (commit.c:1074)
=3D=3D26527=3D=3D    by 0x498B33: check_commit_signature (commit.c:1100=
)
=3D=3D26527=3D=3D    by 0x453719: cmd_merge (merge.c:1246)
=3D=3D26527=3D=3D    by 0x4057B6: run_builtin (git.c:282)
=3D=3D26527=3D=3D    by 0x405949: handle_internal_command (git.c:444)
=3D=3D26527=3D=3D    by 0x405A63: run_argv (git.c:490)
=3D=3D26527=3D=3D    by 0x405BF2: main (git.c:565)

though I currently cannot see what's wrong, probably because I don't
know the format that parse_signature_lines gives.  Can you look into it=
?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
