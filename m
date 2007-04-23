From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 12:51:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231247480.8822@racer.site>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com> 
 <Pine.LNX.4.64.0704231215370.8822@racer.site>
 <f36b08ee0704230330if89d417udefb8e50062d5a05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: no To-header on input <""@pop.gmx.net>,
	Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 12:52:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfw9T-0000HX-AI
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbXDWKwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbXDWKwE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:52:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:51022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161339AbXDWKwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:52:00 -0400
Received: (qmail invoked by alias); 23 Apr 2007 10:51:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 23 Apr 2007 12:51:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180jkZeOtk0tvoleDYOKGy8/0udTCZB6Xui//0nFe
	OxOUyc1dKA8y38
X-X-Sender: gene099@racer.site
In-Reply-To: <f36b08ee0704230330if89d417udefb8e50062d5a05@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45315>

Hi,

On Mon, 23 Apr 2007, Yakov Lerner wrote:

> CVS did not accept absolute pathnames, and SVN does. It is really convenient.

I do not feel very comfortable with the thought. If you have symbolic 
links somewhere along the path, it is easy to get wrong.

This line of thought got me confused: would

$ ln -s /tmp x
$ touch x/y
$ git add x/y

work?

*clicketyclick*

Yes, it does. It ignores the fact that x is not a directory, but a 
symbolic link. Lots of opportunities to shoot yourself in the foot.

Think about the consequences of doing something like this in one 
repository, where "x" points into another one...

Ciao,
Dscho
