From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Thu, 10 Jul 2008 15:28:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807101526380.18205@racer>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>  <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>  <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>  <7vprpnlglh.fsf@gitster.siamese.dyndns.org> 
 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com> <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu Jul 10 16:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGx9J-0002WF-Re
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbYGJO2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbYGJO2f
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:28:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:56654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751168AbYGJO2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:28:34 -0400
Received: (qmail invoked by alias); 10 Jul 2008 14:28:33 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp010) with SMTP; 10 Jul 2008 16:28:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N/kwCZNZNEv0q5uzjcL2zP7P8c7yf4/a4HwYzWp
	4y6BzGHFw92SaB
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87975>

Hi,

On Thu, 10 Jul 2008, Geoffrey Irving wrote:

> On Wed, Jul 9, 2008 at 8:34 PM, Geoffrey Irving <irving@naml.us> wrote:
>
> > Note: there are at least two "holes" in this code.  First, it is 
> > impossible to verify the validity of the entries (this is impossible 
> > to fix).  Second, it is possible to write a malicious patch-id-cache 
> > file that causes git-cherry to go into an infinite loop.  Fixing the 
> > loop requires either traversing every entry on load (bad) or adding a 
> > second loop termination condition to find_helper.  Since looping 
> > forever is better than returning incorrect results, I figured fixing 
> > the weaker hole would just result in a false sense of security.
> 
> Oops: avoiding the infinite loop only requires reading expected O(1) 
> entries on load, so I can fix that if you like.  It would only be all of 
> them if it actually did detect the infinite loop.

I have to admit that you lost me there.  AFAIR the patch-id cache is a 
simple commit->patch_id store, right?  Then there should be no way to get 
an infinite loop.

Besides, this is a purely local cache, no?  Never to be transmitted...  So 
not much chance of a malicious attack, except if you allow write access to 
your local repository, in which case you are endangered no matter what.

Ciao,
Dscho
