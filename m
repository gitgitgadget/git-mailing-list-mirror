From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Implement git clone -v
Date: Wed, 8 Oct 2008 08:25:29 +0200
Message-ID: <20081008062529.GA4028@blimp.localhost>
References: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com> <1223331590-22138-1-git-send-email-vmiklos@frugalware.org> <81b0412b0810062321h33abe076kd87b60bffdaf218b@mail.gmail.com> <20081007193956.GB536@genesis.frugalware.org> <20081008060257.GA15240@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 08:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knp79-00022Y-9r
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYJIGeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbYJIGeA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:34:00 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:26261 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYJIGd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:33:59 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CU8wrP4=
Received: from tigra.home (Fa831.f.strato-dslnet.de [195.4.168.49])
	by post.webmailer.de (mrclete mo15) (RZmta 17.10)
	with ESMTP id U03eeak994pRLN ; Thu, 9 Oct 2008 08:33:53 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8D319277AE;
	Thu,  9 Oct 2008 08:33:52 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 2430636D1E; Wed,  8 Oct 2008 08:25:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081008060257.GA15240@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97831>

Shawn O. Pearce, Wed, Oct 08, 2008 08:02:57 +0200:
> Miklos Vajna <vmiklos@frugalware.org> wrote:
> > On Tue, Oct 07, 2008 at 08:21:28AM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > Yes. Does it work? :)
> > 
> > Yes, it does. I'm not sure how to test it from the testsuite, maybe
> > redirect the output to a file and grep in it? It's ugly, that's why I
> > did not do so, but if you think a testcase is a musthave for this
> > feature then that's the way to go, I guess.
> 
> Actually its not a bad way to test the feature.  Normally we disable
> progress if stdout is not a tty.  If you redirect to a file then
> -v should be needed to get anything at all on stderr.
> 
> You may be able to just test the size of the file:
> 
> 	git fetch -v ... >out 2>err &&

git clone

> 	test -s err

Right, but I don't think you need tests for progress bar. As a typical
eye candy, it tends to change often enough to be too annoying to test.
