From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 16:57:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191655490.4059@racer.site>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
 <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
 <20070619021252.GE19725@planck.djpig.de> <Pine.LNX.4.64.0706191208300.4059@racer.site>
 <20070619152139.GF19725@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 17:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0g5E-00015h-O5
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 17:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbXFSP5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 11:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbXFSP5b
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 11:57:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:57061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752960AbXFSP5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 11:57:30 -0400
Received: (qmail invoked by alias); 19 Jun 2007 15:57:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 19 Jun 2007 17:57:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aobpVnBRalffpt0F1F/wTmam1vLVFvy5W1o77Lv
	O/N6qtPACVr7RQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070619152139.GF19725@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50491>

Hi,

On Tue, 19 Jun 2007, Frank Lichtenheld wrote:

> On Tue, Jun 19, 2007 at 12:09:18PM +0100, Johannes Schindelin wrote:
> > Okay, good point. But of course, you have to use a delimiter for the key 
> > name that cannot be part of the keyname. You picked '\n'. The original was 
> > '='. Both work.
> 
> No, they actually don't.

Right, I completely forgot that we actually allow all kinds of special 
characters, in order to be able to say "branch.<branchname>.merge" for all 
kinds of branchnames.

Incidentally, I think I found a bug:

[foo "bar\nbaz"]
	key = value

gives

foo.barbaz.key=value

Ciao,
Dscho
