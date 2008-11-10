From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Mon, 10 Nov 2008 22:31:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>  <20081106213711.GA4334@blimp.localdomain>  <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>  <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>  <20081107071231.GA4063@blimp.localdomain> 
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>  <20081109102528.GA5463@blimp.localdomain>  <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzeGA-0003ga-AM
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYKJVYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbYKJVYG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:24:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:52369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbYKJVYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:24:04 -0500
Received: (qmail invoked by alias); 10 Nov 2008 21:24:00 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 10 Nov 2008 22:24:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19c3FdNDxVctJpkjdrirPs9FKUEn9mscWL6oGRFRK
	xkKdt8eWo7PDHS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100576>

Hi,

On Mon, 10 Nov 2008, Alex Riesen wrote:

> 2008/11/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > On Sun, 9 Nov 2008, Alex Riesen wrote:
> >>
> >> Oh, I am. But it is just so convenient to have range support for
> >> commands which just show commits. Besides, git-show just errors out,
> >> instead of producing the commits like git-log does.
> >
> > Have fun implementing the support, and then explaining to users why this
> > shows only one commit:
> >
> >        git show HEAD^..HEAD HEAD~10
> >
> 
> for cs in HEAD^..HEAD HEAD~10; do
>   case "$cs"; in
>   *..*)
>      git format-patch --stdout "$cs"
>      ;;
>   *)
>      git show --pretty=email "$cs"
>      ;;
>   esac
> done
> 
> At least, this is what I have in mind and how I expect it to work.

That is not the way git-show is implemented (it uses setup_revisions() to 
check for validity and to parse the arguments), and I cannot think of any 
way to make this work without ugly workarounds.

Ciao,
Dscho
