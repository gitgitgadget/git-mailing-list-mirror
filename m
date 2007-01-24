From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rm'ing all dead files
Date: Wed, 24 Jan 2007 17:57:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241756300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20070124T171435-429@post.gmane.org> 
 <Pine.LNX.4.63.0701241723560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e7ab7380701240851u1249b46ch36450fcf91bf7986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pazu <pazu@pazu.com.br>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lRR-0007KL-3R
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXAXQ5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXAXQ5g
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:57:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:38761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbXAXQ5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:57:35 -0500
Received: (qmail invoked by alias); 24 Jan 2007 16:57:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 24 Jan 2007 17:57:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <9e7ab7380701240851u1249b46ch36450fcf91bf7986@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37656>

Hi,

On Wed, 24 Jan 2007, Pazu wrote:

> 2007/1/24, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > How about
> > 
> >         git ls-files -z --deleted | git update-index -z --remove --stdin
> 
> Aha. I was trying
> 
>    git-ls-files -d | xargs git rm --cached
> 
> but most removed files contains spaces in their names, and that
> screwed git-rm up. I've even noticed the -z option on git-ls-files,
> but couldn't find one on git-rm, and I completely forgot about
> git-update-index.

You _can_ use

	git ls-files -z -d | xargs -0 git rm --cached

So, you did not find that option with git-rm, because it is an option to 
xargs...

Ciao,
Dscho
