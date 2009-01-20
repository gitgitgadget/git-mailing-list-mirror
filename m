From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: valgrind patches, was Re: What's cooking in git.git (Jan 2009, #04;
 Mon, 19)
Date: Tue, 20 Jan 2009 14:51:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 14:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPH2o-0008EC-2R
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 14:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbZATNwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 08:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756283AbZATNwD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 08:52:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:54063 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755594AbZATNwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 08:52:01 -0500
Received: (qmail invoked by alias); 20 Jan 2009 13:51:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 20 Jan 2009 14:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19C8l8ZCzhCGvTZSbqVqAbuMxrMY8FS2GeHOfget/
	k4B3SGEVV5JSVj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090120044447.GF30714@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106473>

Hi,

On Mon, 19 Jan 2009, Jeff King wrote:

> One of the things I didn't like about it was that the valgrind wrapper 
> directory was created in the Makefile.

I agree.

> I think creating it inside the trash directory for each test run that 
> wants to use valgrind makes more sense (probably as .git/valgrind, which 
> is unlikely to hurt anything but will stay out of the way of most of the 
> tests).

Here I disagree.  But I think that test-lib.sh should create it on-demand, 
and it should traverse all executables in all paths listed in $PATH, 
replacing the ones that start with "git-" ("git" itself should be the 
first one) that are no scripts by symlinks to the valgrind script (which 
should therefore live in t/), and those that _are_ scripts by symlinks to 
$GIT_ROOT/$NAME.

I'll work on it.

Ciao,
Dscho
