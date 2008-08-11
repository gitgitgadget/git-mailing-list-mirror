From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 18:49:45 +0200
Message-ID: <20080811164945.GI32184@machine.or.cz>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com> <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de> <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com> <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSabd-0004Lk-6R
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbYHKQtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755207AbYHKQts
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:49:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47806 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160AbYHKQts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:49:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A64E1393B31F; Mon, 11 Aug 2008 18:49:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91962>

On Mon, Aug 11, 2008 at 04:59:32PM +0100, Reece Dunn wrote:
> >> On Mon, 11 Aug 2008, Francis Moreau wrote:
> >>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
> 
> does not work as expected. Replacing this with
> 
>                case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 ;; esac
> 
> would work as intended, as Mikael has pointed out.

  Wouldn't it be more elegant to

	case "$(head -n 1)" in [Nn]*) exit 1 ;; esac

				Petr "Pasky" Baudis
