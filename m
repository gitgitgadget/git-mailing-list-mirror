From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Fri, 24 Feb 2006 14:44:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602241440330.9461@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
 <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <20060224120225.GE12309@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Sam Vilain <sam@vilain.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 14:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCdF0-0007MP-72
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 14:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWBXNoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWBXNoL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 08:44:11 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:65191 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751017AbWBXNoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 08:44:10 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 2B18515E2;
	Fri, 24 Feb 2006 14:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1E4CD1170;
	Fri, 24 Feb 2006 14:44:09 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C9791116C;
	Fri, 24 Feb 2006 14:44:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060224120225.GE12309@localdomain>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16703>

Hi,

On Fri, 24 Feb 2006, Eric Wong wrote:

> Writing and reading from a tempfile are very fast for me in Linux, and 
> probably not much slower than pipes.

Sorry, but no. Really no. Pipes have several advantages over temporary 
files:

- The second program can already work on the data before the first 
  finishes.
- Most simple temp file handling has security issues.
- You need write access.

Hth,
Dscho
