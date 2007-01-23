From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 12:32:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
 <200701222127.09601.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 12:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JtU-00071W-P4
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 12:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbXAWLcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbXAWLct
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 06:32:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:39084 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932958AbXAWLct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 06:32:49 -0500
Received: (qmail invoked by alias); 23 Jan 2007 11:32:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 23 Jan 2007 12:32:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Johannes Sixt <johannes.sixt@telecom.at>
In-Reply-To: <200701222127.09601.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37502>

Hi,

On Mon, 22 Jan 2007, Johannes Sixt wrote:

> OTOH, git log, git diff, etc, which run the pager by default, are 
> broken. It seems that the pipe is not correctly flushed by the writer, 
> which the MinGW port closes in an atexit() routine, so that the last 
> part of the piped data is missing. I have no clue how to fix this except 
> by disabling the pager.

Maybe we have to go the other way round, just as POSIX git does: instead 
of spawning the pager, we should _beginthread() the actual work, and 
execl() the pager.

On the third hand, I fully expect git on Windows to be used only by GUI 
wieners who cannot handle the command line, let alone a pager! ("WTF! How 
do I go back to that dollar thingie? You know, where I type git-blabla?")

Since Tcl/Tk is available for MinGW, git-gui seems to be a way to go 
there.

Or to continue on the TortoiseCVS lookalike...

Ciao,
Dscho
