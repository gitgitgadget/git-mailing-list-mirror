From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 22:06:51 +0200
Message-ID: <486153DB.3070502@alum.mit.edu>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEoU-0007UA-JW
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbYFXUHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYFXUHG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:07:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53887 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbYFXUHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:07:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m5OK6pVT031138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Jun 2008 22:06:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080505 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <alpine.DEB.1.00.0806241808400.9925@racer>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86133>

Johannes Schindelin wrote:
> When you look for a fix instead of a regression, it can be quite hard
> to twist your brain into choosing the correct bisect command between
> 'git bisect bad' and 'git bisect good'.
> 
> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

It seems to me that your problem is that git-bisect requires the "good"
revision to be older than the "bad" one.  If this requirement were
removed, would there still be a need for "fixed" vs. "unfixed"?

A bisection search doesn't care what labels are applied to the two
endpoints, as it only looks for transitions between the labels.
Therefore it should be easy to teach git-bisect to locate either kind of
transition, "bad" -> "good" or "good" -> "bad", depending only on where
the user places the original "good" and "bad" tags.

Michael
