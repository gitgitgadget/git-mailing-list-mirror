From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Thu, 20 Oct 2005 06:08:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 06:09:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESRjt-0006tu-Ac
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVJTEIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVJTEIu
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:08:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3264 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751054AbVJTEIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:08:49 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BE8F513F098; Thu, 20 Oct 2005 06:08:48 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9AFC7B4DFE; Thu, 20 Oct 2005 06:08:48 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7739AB1072; Thu, 20 Oct 2005 06:08:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B3B113F098; Thu, 20 Oct 2005 06:08:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10340>

Hi,

> > +		    ((o = parse_object(remote)) != NULL) &&
> > +		    (o->flags & COMPLETE) &&

I just realized that parse_object() always reads the file, then does a 
lookup (which makes the above code work), and then parses the file. It 
always does all of these steps, even if the object was already parsed. Any 
reason for this?

Ciao,
Dscho
