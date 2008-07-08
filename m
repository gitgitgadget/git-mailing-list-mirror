From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Tue, 8 Jul 2008 10:00:42 +0200
Message-ID: <20080708080042.GB3628@joyeux>
References: <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux> <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 10:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG88u-0001Cv-IX
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 10:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYGHIAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 04:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYGHIAr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 04:00:47 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:56509 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYGHIAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 04:00:46 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay02.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KG87w-000139-8q; Tue, 08 Jul 2008 10:00:44 +0200
Content-Disposition: inline
In-Reply-To: <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87730>

On Mon, Jul 07, 2008 at 11:20:08AM -0700, Junio C Hamano wrote:
> > Is it possible to make 'fetch' only .. well .. fetch objects, without
> > updating any refs?
> 
> By honestly saying "The superproject binds a commit you do not have
> locally at these paths", the user *can* choose *when* to go there and
> update, or have "git submodule update" command to that for him.
Agreed. The problem is that git submodule update does not only fetches
the new refs but *also* checks out the commit currently registered in
the superproject. Therefore git-submodule status *and* git-submodule
summary cannot tell you anything after a git-submodule update.

What I was missing is, given the current discussion, a git-submodule
fetch alike to what Avery was proposing, which fetches all submodules in
one command. Having to do the fetch/update manually for each submodule
is really cumbersome -- I have around 30 modules in the superproject.

Sylvain
