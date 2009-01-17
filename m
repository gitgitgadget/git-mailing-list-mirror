From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v3 1/6] reflog: refactor parsing and checking
Date: Sat, 17 Jan 2009 06:35:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170632210.3586@pacific.mpi-cbg.de>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 06:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO3qY-0002rt-2a
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 06:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZAQFeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 00:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbZAQFeN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 00:34:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:47277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751450AbZAQFeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 00:34:13 -0500
Received: (qmail invoked by alias); 17 Jan 2009 05:34:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 17 Jan 2009 06:34:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/k5EMPDsLkAAUA7WUPeKczFaN5RSCD0HiK1w/URL
	YTjPngFD5O/p37
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106027>

Hi,

On Sat, 17 Jan 2009, Thomas Rast wrote:

> Note that this switches for_each_reflog_ent() from silently ignoring 
> errors to die().

I am not convinced this is necessary, and neither that it is good.

You could return int from parse_reflog_line() just like the other 
non-dying functions.

And keep in mind that reflogs could be corrupted for all kinds of reasons; 
with your patch, reflog handling would fail gracelessly, even if a 
lot could still be salvaged (by ignoring the error with a warning).

Ciao,
Dscho
