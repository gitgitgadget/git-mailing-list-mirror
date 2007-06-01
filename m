From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [mingw port] git plumbing piping with CR/NL
Date: Sat, 2 Jun 2007 01:18:16 +0200
Message-ID: <20070601231816.GC6360@steel.home>
References: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 01:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuGO3-0003jt-LD
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 01:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbXFAXSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 19:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbXFAXSU
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 19:18:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61948 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbXFAXST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 19:18:19 -0400
Received: from tigra.home (Fa970.f.strato-dslnet.de [195.4.169.112])
	by post.webmailer.de (mrclete mo18) (RZmta 6.8)
	with ESMTP id F0145bj51LVEPi ; Sat, 2 Jun 2007 01:18:17 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2D683277BD;
	Sat,  2 Jun 2007 01:18:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 97204BE86; Sat,  2 Jun 2007 01:18:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmRtBQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48898>

Nguyen Thai Ngoc Duy, Fri, Jun 01, 2007 20:23:24 +0200:
> Hi,
> 
> I haven't had time looking at the code yet. I report here so that I
> can free my memory for other things. I made a command like this:
> 
> $ git ls-tree -r HEAD|grep blah.cc|git update-index --index-info
> 
> and the output of git-status was:
> 
> $ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   path/to/blah.cc\r
> #
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #
> #	deleted:    path/to/blah.cc\r
> ...
> $ git version
> git version 1.5.2.651.g80e39-dirty (if the commit isn't in the master
> branch, it is based on master branch)
> 
> Apparently git should ignore \r at the end of the path. ...

Why should it? \r is a valid character in filenames almost everywhere
(except for the some proprietary OSes, as usual).

Why does your grep _alters_ the input, instead of filtering it, btw?
