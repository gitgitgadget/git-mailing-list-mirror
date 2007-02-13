From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not run git-pack-refs by default for now from git-gc
Date: Tue, 13 Feb 2007 11:03:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131101400.1300@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuVp-0005qr-1v
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbXBMKDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbXBMKDi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:03:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:57032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751234AbXBMKDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:03:38 -0500
Received: (qmail invoked by alias); 13 Feb 2007 10:03:36 -0000
X-Provags-ID: V01U2FsdGVkX1/KMMovN/PKvIKoA8ms79vi3BG+038lyyh/pCCx6G
	nojg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39507>

Hi,

On Tue, 13 Feb 2007, Junio C Hamano wrote:

> Just to be on the safe side, let's not run pack-refs from git-gc
> without an explicit "[gc] packrefs = true" configuration.

It seems to me that the reason are dumb transports, which are very likely 
to run only from bare repositories. How about checking for a bare 
repository explicitely, and only if it _is_ bare, check for gc.packrefs, 
too?

Packed refs _do_ have a tremendous advantage (when you have a lot of tags, 
like many CVS switchers).

Ciao,
Dscho
