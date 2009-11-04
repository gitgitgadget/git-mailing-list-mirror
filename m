From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare
 repos
Date: Wed, 4 Nov 2009 14:25:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 14:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5frt-0005Bo-AN
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 14:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbZKDNZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbZKDNZd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 08:25:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:36377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754149AbZKDNZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 08:25:33 -0500
Received: (qmail invoked by alias); 04 Nov 2009 13:25:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 04 Nov 2009 14:25:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qpJoLpLdqZCEQJO2nsZZl7HseISyE67J4satY+F
	6B0yeu7NhzgOV4
X-X-Sender: johannes@felix-maschine
In-Reply-To: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132083>

Hi,

On Wed, 4 Nov 2009, Sitaram Chamarty wrote:

> It seems to me an accidental push -f would cause some trouble on a bare 
> repo, and would usually require a bit of grubbing around among the 
> unreachable commits looking for the right one.

In one usage of mine, we have set said config value for exactly that 
reason.

> What would be the downsides (other than some objects hanging
> around far longer, i.e., space issues) of setting the config
> variable core.logAllRefUpdates to be default true on bare
> repos.

I did not have time yet to investigate, but it seems that there are 
problems with the permissions of shared bare repositories when activating 
the reflogs.

With gitweb on a public site, there might be a problem when you pushed 
some blob containing trade secrets accidentally, and try to scrub the 
repository using "git gc" after a forced push.

That are the only downsides I can think of.

Ciao,
Dscho
