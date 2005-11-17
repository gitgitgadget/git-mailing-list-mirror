From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 12:15:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171213370.29989@wbgn013.biozentrum.uni-wuerzburg.de>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net>
 <437B8CEC.8040002@mc.com> <20051116203334.GA3968@reactrix.com>
 <Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051117004621.GB3968@reactrix.com> <7vd5l03whv.fsf@assigned-by-dhcp.cox.net>
 <20051117021014.GC3968@reactrix.com> <7voe4jy36p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:17:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EchjY-0005j2-MJ
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKQLPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKQLPG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:15:06 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4776 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750751AbVKQLPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:15:04 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CD70213F9CE; Thu, 17 Nov 2005 12:15:03 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AEA4B9F333; Thu, 17 Nov 2005 12:15:03 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 98FD998FA6; Thu, 17 Nov 2005 12:15:03 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FE1B13F8F5; Thu, 17 Nov 2005 12:15:03 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe4jy36p.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12100>

Hi,

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> Nick Hengeveld <nickh@reactrix.com> writes:
> 
> > Assuming --vernum does work, is there a reasonable/portable way to
> > compare two hex values like 070801?
> 
> I would assume that it is always 6 lowercase hexdigits %06x when
> supported, or showing nothing to stdout for ancient ones.
> 
> A horrible but probably portable way would be:
> 
> 	case `(echo 070801; curl-config --vernum) 2>/dev/null |
>         	sort -r | sed -ne 2p` in
> 	070801)
>         	echo Happy ;;
>         *)
>         	echo Sad ;;
> 	esac

Horrible to read, but actually portable (and can be produced by a small 
script):

case "$NUMBER" in
07080[1-9] | \
0708[1-9]? | \
0709?? | \
07[1-9]??? | \
0[8-9]???? | \
[1-9]?????) echo "Yes";;
*) echo "No";;
esac

Ciao,
Dscho
