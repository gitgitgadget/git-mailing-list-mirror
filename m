From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Tue, 12 Oct 2010 23:26:58 +0200
Message-ID: <20101012212658.GF4536@neumann>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
	<20101010212646.GA6092@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 23:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5mOQ-0005q9-Ew
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 23:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab0JLV2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 17:28:10 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51663 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0JLV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 17:28:09 -0400
Received: from [127.0.1.1] (p5B130B90.dip0.t-ipconnect.de [91.19.11.144])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0M1CM0-1OqBMh1SxM-00tkM0; Tue, 12 Oct 2010 23:27:00 +0200
Content-Disposition: inline
In-Reply-To: <20101010212646.GA6092@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:ulwNVtv7cg38bSHHhiINp+K1EdJjHnyv7LbcQMGM8AK
 +ud7yFJtOp7Dc6RJgPNE+DLHhEyKi4ahMP8KpY2cdQ6DCz/qEv
 HfNtsv1WC+x1TI8aa5hHThm0Je52ChcWe5oVd7jGYvPOFzA9Au
 m9P6S0CSgH/LUB1eCt7/SxLantxqFadFlzvFocTGVCsgWy4y5q
 XrAxfrHGDm6L2QSlwYS7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158879>

Hi,


On Sun, Oct 10, 2010 at 11:26:46PM +0200, SZEDER G=E1bor wrote:
> On Wed, Sep 29, 2010 at 05:16:10PM -0700, Junio C Hamano wrote:
> > * ml/completion-zsh (2010-09-06) 1 commit
> >   (merged to 'next' on 2010-09-22 at d62d10e)
> >  + completion: make compatible with zsh
> >=20
> > Comments from bash users regarding regressions?
>=20
> No regressions so far here, but I don't use the "divergence from svn
> upstream" feature (although the two changes in that codepath seem to
> be fairly trivial).

There is one regression, though.

We made changes in the past to get the completion script working when
'set -u' is enabled, see commits 25a31f8 (bash-completion: Support
running when set -u is enabled, 2009-01-15) and 6c44b64
(bash-completion: Fix __git_ps1 to work with "set -u", 2010-06-17).
This patch causes an unbound variable error with 'set -u' when it
checks $ZSH_VERSION, which is, of course, undefined in bash.

=46ollowing up on 25a31f8, using ${ZSH_VERSION-} avoids such errors
under bash and 'set -u', and I think it should work with zsh, too.


Best,
G=E1bor
