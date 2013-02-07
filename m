From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Thu, 07 Feb 2013 13:12:59 +0900
Message-ID: <876224sqwk.fsf@catnip.gol.com>
References: <cover.1359901732.git.john@keeping.me.uk>
	<6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
	<7vwqup890o.fsf@alter.siamese.dyndns.org>
	<20130203203150.GU1342@serenity.lan>
	<7v8v7585sr.fsf@alter.siamese.dyndns.org>
	<20130203231549.GV1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 07 05:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Ire-0003Ep-V9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 05:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab3BGENM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 23:13:12 -0500
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:38551 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab3BGENL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 23:13:11 -0500
Received: from 218.231.148.126.eo.eaccess.ne.jp ([218.231.148.126] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1U3Ir6-0006Eo-Cb; Thu, 07 Feb 2013 13:13:00 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 5C217DFC1; Thu,  7 Feb 2013 13:12:59 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20130203231549.GV1342@serenity.lan> (John Keeping's message of
	"Sun, 3 Feb 2013 23:15:49 +0000")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215671>

John Keeping <john@keeping.me.uk> writes:
> I generally like to get rid of the pointless warnings so that the use=
ful
> ones can't hide in the noise.  Perhaps "CFLAGS +=3D -Wno-string-plus-=
int"
> would be better for this particular warning, but when there's only on=
e
> bit of code that triggers it, tweaking that seemed simpler.

An even better approach would be to file a bug against clang ... it
really is a very ill-considered warning -- PTR + OFFS is not just
valid C, it's _idiomatic_ in C for getting interior pointers into
arrays -- and such a warning should never be enabled by default, or by
any standard warning options.

-miles=20

--=20
=E6=B0=B8=E6=97=A5=E3=81=AE=E3=80=80=E6=BE=84=E3=82=93=E3=81=A0=E7=B4=BA=
=E3=81=8B=E3=82=89=E3=80=80=E6=B0=B8=E9=81=A0=E3=81=B8
