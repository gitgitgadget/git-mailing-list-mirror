From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support \ in non-wildcard .gitignore entries
Date: Tue, 10 Feb 2009 13:56:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de>
References: <20090210121149.GA1226@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsB3-0001tF-EY
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZBJMzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZBJMzx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:55:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:55610 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753883AbZBJMzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:55:53 -0500
Received: (qmail invoked by alias); 10 Feb 2009 12:55:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 10 Feb 2009 13:55:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191TzpjYtZ1P56X8P3Xu1FDwJgta2nSz9Rq4USNeP
	HWUNXDP3ZFnAZy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210121149.GA1226@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109227>

Hi,

On Tue, 10 Feb 2009, Finn Arne Gangstad wrote:

> If you had an exclude-pattern with a backslash in it, e.g. "\#foo",
> this would not work, since git would do a strcmp of the exclude pattern
> and the filename. Only wildcard patterns were matched with fnmatch,
> which does the right thing with backslashes. We now also treat all patterns
> containing backslashes as wildcards.
> 
> De-escaping the pattern while reading the .gitignore file is error prone,
> since that would break patterns with both backslashes and wildcards.
> E.g. "\\*.c" would be translated to "\*.c" before fnmatch got it,
> and would change the meaning of the rule dramatically.

I am not sure I understand (maybe a test case would help, but that test 
case would have to be disabled on Windows, I guess):

You mean that '\#abc' would match '\#abc', but '\#abc*' would not?

Ciao,
Dscho
