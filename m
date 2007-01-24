From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Wed, 24 Jan 2007 10:53:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B6C1FB.7060005@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 10:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ep3-0004I1-4h
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 10:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbXAXJxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 04:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXAXJxT
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 04:53:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:57360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbXAXJxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 04:53:18 -0500
Received: (qmail invoked by alias); 24 Jan 2007 09:53:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 24 Jan 2007 10:53:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45B6C1FB.7060005@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37616>

Hi,

On Wed, 24 Jan 2007, SungHyun Nam wrote:

> First of all, this problem always existed to me. I was lazy to report. 
> Please check the failure logs and my GIT build script below. [...] the 
> first test failed at 't1000-read-tree-m-3way.sh' always. And in this 
> case, 2nd test always succeeded.
> 
> * FAIL 57: 5 - must match in !O && A && B && A==B case.
>         rm -f .git/index LL &&
>              cp .orig-A/LL LL &&
>              git-update-index --add LL &&
>              echo extra >>LL &&
>              git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
> 997bbc4a0a51e0574168a4f637739380edebe4d7
> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>              check_result

It is not directly apparent what is causing this error. Could you please 
change your script to use "-i -v" on the tests? I.e. instead of:
	
> 	    if ! make test

this:

	    if ! (cd t; GIT_TEST_OPTS="-i -v" make)

It should give us a better idea what happened, since we also see the 
error messages of the git commands.

If it is still not apparent what went wrong, there is unfortunately no way 
around doing that particular test case manually, as to find out what went 
wrong. Since you seem to be the only one who can reproduce this bug, it 
boils down to you having to do the leg work.

Please keep us posted!

Ciao,
Dscho
