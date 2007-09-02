From: Sean <seanlkml@sympatico.ca>
Subject: Re: git clone over http
Date: Sun, 2 Sep 2007 14:54:29 -0400
Message-ID: <20070902145429.8bf50059.seanlkml@sympatico.ca>
References: <200709021123.04218.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 20:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRuam-0007R5-He
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 20:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbXIBSyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXIBSyd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 14:54:33 -0400
Received: from bay0-omc3-s24.bay0.hotmail.com ([65.54.246.224]:8542 "EHLO
	bay0-omc3-s24.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094AbXIBSyc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 14:54:32 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.184]) by bay0-omc3-s24.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 2 Sep 2007 11:54:32 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp11.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 2 Sep 2007 11:55:48 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IRuac-0003BT-8M; Sun, 02 Sep 2007 14:54:30 -0400
In-Reply-To: <200709021123.04218.robin.rosenberg.lists@dewire.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.14; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Sep 2007 18:55:48.0687 (UTC) FILETIME=[E04365F0:01C7ED92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57378>

On Sun, 2 Sep 2007 11:23:03 +0200
Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:

Hi Robin,

> git clone (1.5.3) with http is somewhat unreliable. I've noticed if can actually give
> me different versions of a branch each time I run it, eventually yielding
> the one I'm expecting.  And now this:

Hmmm, that's very odd.  Tried it 3 times here and master was always at the
same commit (0421997bfd5).

> (Using master, just after rc7)
> $ git clone http://unix.schottelius.org/git/cLinux/cinit.git
[...]
> /usr/local/bin/git-clone: line 40: 14823 Segmenteringsfel        git-http-fetch $v -a -w "$tname" "$sha1" "$1"
> 
> It doesn't repeat itself, but I cannot clone because it always crashes.

Using 1.5.3 here and it works just fine.  Perhaps it has something to do with
your version of the Curl library?  This is what is in use here:

$ curl --version
curl 7.16.4 (i686-pc-linux-gnu) libcurl/7.16.4 OpenSSL/0.9.8e zlib/1.2.3
Protocols: tftp ftp telnet dict http file https ftps 
Features: Largefile NTLM SSL libz

Sean
