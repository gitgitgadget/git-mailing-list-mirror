From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] xdiff: replace emit_func() with type-safe
Date: Fri, 18 May 2012 10:28:17 +0200
Message-ID: <87aa15hp0e.fsf@thomas.inf.ethz.ch>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 18 10:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVIYD-0004oY-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 10:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762546Ab2ERI2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 04:28:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:20986 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762220Ab2ERI2V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 04:28:21 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 18 May
 2012 10:28:20 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (217.235.93.211) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 18 May
 2012 10:28:20 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [217.235.93.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197941>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Commit ef2e62fe added the ability to bypass the creation of textual d=
iffs
> and to access diff data directly, through the added emit_func member =
of
> xdemitconf_t.  This function pointer has a type of "void (*)()", beca=
use
> "int (*)(xdfenv_t *, xdchange_t *, xdemitcb_t *, xdemitconf_t const *=
)"
> (its real type) would be difficult to export due to the many internal
> types in that signature.
>
> This feature is currently used twice in git blame, through the functi=
on
> xdi_diff_hunks().  Both cases only need to know which lines are affec=
ted
> by the different hunks of a diff, i.e. the numbers shown in hunk head=
ers
> of unified diffs.
>
> This patch series adds a simpler mechanism to accommodate these two
> callers, in a type-safe way, without exporting too many internal type=
s
> of libxdiff.  The last patch removes the old functions.

Cool, thanks a lot, this will come in handy when I finally get around t=
o
finishing log -L.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
