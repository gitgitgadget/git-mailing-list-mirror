From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 19:05:15 +0200
Message-ID: <20080811170515.GD10151@machine.or.cz>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com> <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de> <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com> <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com> <20080811164945.GI32184@machine.or.cz> <48A0705B.3030107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?iso-8859-2?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 11 19:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSaqc-0001Pw-Ih
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 19:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYHKRFU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 13:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbYHKRFT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 13:05:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40479 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbYHKRFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 13:05:18 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CCF1C393B31E; Mon, 11 Aug 2008 19:05:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A0705B.3030107@lsrfire.ath.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91964>

On Mon, Aug 11, 2008 at 07:01:15PM +0200, Ren=E9 Scharfe wrote:
> Petr Baudis schrieb:
> > On Mon, Aug 11, 2008 at 04:59:32PM +0100, Reece Dunn wrote:
> >>>> On Mon, 11 Aug 2008, Francis Moreau wrote:
> >>>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
> >> does not work as expected. Replacing this with
> >>
> >>                case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 =
;; esac
> >>
> >> would work as intended, as Mikael has pointed out.
> >=20
> >   Wouldn't it be more elegant to
> >=20
> > 	case "$(head -n 1)" in [Nn]*) exit 1 ;; esac
>=20
> Only if head is a built-in, otherwise you fork needlessly.  Not that
> this is a performance critical part, but I wouldn't call it "elegant"=
=2E

Ok, exec head -n 1. ;) And yes, I know... I guess I've just spent too
much time perl-golfing lately.

> What's wrong with the following variant, already used a few lines up =
in
> the file?
>=20
> 	read yesno
> 	case "$yesno" in [Nn]*) exit 1 ;; esac

Nothing wrong with this one, of course.

--=20
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
