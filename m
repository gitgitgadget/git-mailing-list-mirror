From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 02:01:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 02:01:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFKi9-0008N5-O3
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 02:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVINABK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 20:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVINABK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 20:01:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62097 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964852AbVINABJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 20:01:09 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 644D313C400; Wed, 14 Sep 2005 02:01:06 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49680B3721; Wed, 14 Sep 2005 02:01:06 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1D61BB371A; Wed, 14 Sep 2005 02:01:06 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9538A13C400; Wed, 14 Sep 2005 02:01:05 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8505>

Hi,

On Tue, 13 Sep 2005, Linus Torvalds wrote:

> 
> 
> Also, I really do think that the dumb transports are oversold, and 
> git-daemon is undersold.

My tests confirm that a single git-pull via git-daemon brings a small 
machine to its knees. Which means that multiple git-pull's bring a nice 
big machine like kernel.org to its knees.

IMHO the culprit is git-rev-list, which takes ages and ages for big 
repositories (beware: this could be my Darwin client which might be 
incapable to stop the rev enumeration in time; but if that can be done 
unintentionally, this can be intentionally, too!).

Did anybody think about using the information which helps the dumb 
transports for intelligent transports, too? (A sort of cache for 
git-rev-list would do wonders...) This could at least help the CPU load on 
the server.

(In retrospect it might have been a mistake to make the call to 
git-update-server-info optional: maybe an environment variable should be 
set to _inhibit_ the behaviour for those which absolutely cannot live with 
the performance hit.)

Ciao,
Dscho
