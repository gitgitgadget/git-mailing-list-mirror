From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Re-fix get_pathspec()
Date: Fri, 7 Mar 2008 12:53:02 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071252240.19395@racer.site>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXb8v-0006VL-2o
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbYCGLxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758520AbYCGLxB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:53:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:55815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752472AbYCGLxB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:53:01 -0500
Received: (qmail invoked by alias); 07 Mar 2008 11:52:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 07 Mar 2008 12:52:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZSpYodoVZUiHiu1Gx+pXf7vnjZQU22GRY65Wsvb
	hqXDrNZa1cv/3M
X-X-Sender: gene099@racer.site
In-Reply-To: <1204879119-7528-1-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76480>

Hi,

On Fri, 7 Mar 2008, Junio C Hamano wrote:

> After 1.5.4, we improved get_pathspec() to allow absolute paths, because
> people wanted to cut&paste from file managers and such, so that you can
> feed absolute paths to "git add" and friends.
> 
> However, the paths still must be inside work tree, so there must be a 
> way to ensure that.  d089eba (setup: sanitize absolute and funny paths 
> in get_pathspec()) botched the interface, by making the check the 
> responsibility of the callers, while keeping the interface to the 
> function intact, which meant that the callers needed to count returned 
> pathspecs and compared it with the number of paths fed to the function.
> 
> This miniseries cleans up the interface by making get_pathspec() to die
> again.

We have a few places where you have to pass a "die_on_error" flag.  Why 
not imitate that?

Ciao,
Dscho

