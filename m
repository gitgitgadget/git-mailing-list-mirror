From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 03 May 2007 09:03:30 +0200
Message-ID: <87lkg61j99.fsf@mid.deneb.enyo.de>
References: <200705012346.14997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 09:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjVLl-0003Yp-94
	for gcvg-git@gmane.org; Thu, 03 May 2007 09:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbXECHDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 03:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXECHDe
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 03:03:34 -0400
Received: from mail.enyo.de ([212.9.189.167]:1762 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbXECHDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 03:03:33 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HjVLf-0006ir-ON
	for git@vger.kernel.org; Thu, 03 May 2007 09:03:31 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HjVLe-0001oG-GG
	for git@vger.kernel.org; Thu, 03 May 2007 09:03:30 +0200
In-Reply-To: <200705012346.14997.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 May 2007 23:46:14 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46073>

* Jakub Narebski:

> The problem is with 'Size of checkout': to start working in repository
> one needs 1.4G (sources) and 98M (third party) for CVS checkout (it is
> 1.5G for sources for Subversion checkout).

The text bases for Subversion really should take another 1.4 GiB.
As a result, Subversion should be closer to 3 GiB.

> What might help here is splitting repository into current (e.g. from
> OOo 2.0) and historical part, and / or using shallow clone.

You could also split along project boundaries, but this is probably
too political.

> What I'm really concerned about is branch switch and merging branches,
> when one of the branches is an old one (e.g. unxsplash branch), which 
> takes 3min (!) according to the benchmark. 13-25sec for commit is also 
> bit long, but BRANCH SWITCHING which takes 3 MINUTES!?

IIRC, GIT accesses every file in the tree, not just the ones that need
updating.  How many files were actually updated when you changed
branches in your experiment?
