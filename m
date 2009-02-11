From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
  order
Date: Wed, 11 Feb 2009 11:59:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902111158500.10279@pacific.mpi-cbg.de>
References: <1234332233-10017-1-git-send-email-newren@gmail.com>  <1234332233-10017-2-git-send-email-newren@gmail.com>  <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de> <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCpP-0008A7-GB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbZBKK67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZBKK67
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:58:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:51450 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753143AbZBKK67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:58:59 -0500
Received: (qmail invoked by alias); 11 Feb 2009 10:58:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 11 Feb 2009 11:58:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++Svh0xC6+jh98qIpnslRvwl1FArpqRjqf3fnnBs
	TpDTmr+PgrU7he
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109405>

Hi,

On Wed, 11 Feb 2009, Mike Ralphson wrote:

> > On Tue, 10 Feb 2009, newren@gmail.com wrote:
> > fast-export will only list as parents those commits which have already
> > been traversed (making it appear as if merges have been squashed if not
> > all parents have been traversed).  To avoid this silent squashing of
> > merge commits, we request commits in topological order.
> 
> Any comparative timings? We don't need to rename this to 'git
> reasonably-speedy-export'? 8-)

What we _could_ do is add proper error handling: fast-export should 
recognize that it did not see the commit yet, and error out suggesting 
using --topo-order with fast-export.

Ciao,
Dscho
