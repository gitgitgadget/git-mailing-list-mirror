From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Guided merge with override
Date: Wed, 18 Jun 2008 20:29:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806182027240.6439@racer>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org> <48563D6C.8060704@viscovery.net> <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com> <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181618070.6439@racer> <alpine.DEB.1.00.0806181627260.6439@racer> <7viqw6zovi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93Ob-0004sc-Fc
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYFRTbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbYFRTbT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:31:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:51290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751582AbYFRTbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:31:18 -0400
Received: (qmail invoked by alias); 18 Jun 2008 19:31:12 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp063) with SMTP; 18 Jun 2008 21:31:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MGysRX8wMiyBnoU2inxoOPEKyNYuAZzl3xGwRyN
	5xxCM6CeLI9waR
X-X-Sender: gene099@racer
In-Reply-To: <7viqw6zovi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85401>

Hi,

On Wed, 18 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Thinking about this again, there could be a problem: in case of complex 
> > merges, it is possible that the sides are switched around for an 
> > intermediate merge.  IOW you'd expect it to take "theirs", but it really 
> > takes "ours".
> 
> Are you thinking about using this in merge-recursive?

Indeed I was.

> I do not think there is any reason to use this during intermediate 
> merges done inside merge-recursive.

That is right, but for some stupid reason I did not realize that 
git-merge-file is not even called by merge-recursive.

So the accompanying patch for merge-recursive would use the --theirs or 
--ours logic only in the !index_only case, i.e. the final merge.

And I guess we'd have similar logic as for merge-subtree, introducing 
merge-recursive-ours and merge-recursive-theirs.

Very nice.

Ciao,
Dscho
