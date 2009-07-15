From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Correct way of making existing remote repository "bare"
Date: Wed, 15 Jul 2009 16:08:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907151607050.4410@intel-tinevez-2-302>
References: <h3khis$3tq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5AN-000465-Tm
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbZGOOI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZGOOIz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:08:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:51828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752645AbZGOOIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:08:55 -0400
Received: (qmail invoked by alias); 15 Jul 2009 14:08:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 15 Jul 2009 16:08:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yv+85GIuyfwO1WZVGGSNsN2bFqypGpCi5EqKtX+
	a/7He6fUWk0efL
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <h3khis$3tq$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123310>

Hi,

On Wed, 15 Jul 2009, Graeme Geldenhuys wrote:

> Steps I done:
> 
> * ssh to remote server
> * git clone --bare -l <path_to_repos> <new_dir>
> * renamed old repository directory
> * renamed new repository dir to what old repository used to be.
> 
> Like I said, this did the tick, but is this the correct way of doing it?

That's the easiest.  However, I regularly avoid those steps by doing

	mv bla/.git bla.git
	git --git-dir=bla.git config core.bare true
	rm -rf bla

This requires a bit more familiarity with the Git internals than your 
solution, though (although it makes sure that the config is unchanged, as 
well as possibly installed hooks).

Ciao,
Dscho
