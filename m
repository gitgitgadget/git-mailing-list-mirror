From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 19:03:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261901140.9686@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
 <86mzkwfh54.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
 <86irvkfg80.fsf@blue.stonehenge.com> <20051026161552.GA11483@delft.aura.cs.cmu.edu>
 <20051026165515.GA16616@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 19:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUogd-0000hH-N3
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 19:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJZRDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVJZRDf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 13:03:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18851 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964818AbVJZRDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 13:03:34 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 86E9713F368; Wed, 26 Oct 2005 19:03:33 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C0FAB3550; Wed, 26 Oct 2005 19:03:33 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F6B1B0D87; Wed, 26 Oct 2005 19:03:33 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EB26B13F368; Wed, 26 Oct 2005 19:03:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20051026165515.GA16616@delft.aura.cs.cmu.edu>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10681>

Hi,

On Wed, 26 Oct 2005, Jan Harkes wrote:

> -		if (ret == EXDEV && !rename(tmpfile, filename))
> +		if (ret && ret != EEXIST && !rename(tmpfile, filename))

We don't need to test for ret, as we're already in a "if (ret)" block.  
What would happen if ret==EEXIST, and we try to rename() nevertheless? It 
should fail, too, right?

Ciao,
Dscho
