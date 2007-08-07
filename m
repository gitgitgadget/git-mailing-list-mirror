From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Tue, 7 Aug 2007 15:08:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708071507410.14781@racer.site>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
 <11864401942772-git-send-email-mdl123@verizon.net> <Pine.LNX.4.64.0708062349460.14781@racer.site>
 <7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com>
 <7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net> <46B7D108.20606@gmail.com>
 <7vd4y09f07.fsf@assigned-by-dhcp.cox.net> <46B879DB.4090504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 07 16:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIPkk-0007ky-KC
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 16:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbXHGOJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbXHGOJi
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 10:09:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753888AbXHGOJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 10:09:37 -0400
Received: (qmail invoked by alias); 07 Aug 2007 14:09:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 07 Aug 2007 16:09:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196q2F6ymJ6uz0Sh4gUdJZve42ctq5ruckN4/lZIT
	JJZK93pbcoVmoT
X-X-Sender: gene099@racer.site
In-Reply-To: <46B879DB.4090504@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55259>

Hi,

On Tue, 7 Aug 2007, Ren? Scharfe wrote:

> Junio C Hamano schrieb:
> > Mark Levedahl <mlevedahl@gmail.com> writes:
> > 
> >> +    printf "$mandir/%s\n" $(git ls-tree -r --name-only $head) | xargs
> >> gzip -f
> > 
> > No risk that ls-tree output is too long to fit within the exec
> > args limit to run printf?
> 
> Perhaps this instead?
> 
>    git ls-tree -r --name-only $head | (cd "$mandir" && xargs gzip -f)

I would have done

	git ls-tree -r --name-only $head | sed "s|^|$mandir|" | xargs gzip -f

but I like your version better.

Thanks for teaching me,
Dscho
