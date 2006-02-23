From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Thu, 23 Feb 2006 20:41:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
 <86hd6qgit5.fsf@blue.stonehenge.com> <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
 <863bi9hq6u.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 20:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMLO-000050-K6
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWBWTlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWBWTlj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:41:39 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:33179 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751653AbWBWTlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 14:41:39 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 249F81BB0;
	Thu, 23 Feb 2006 20:41:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 18C521155;
	Thu, 23 Feb 2006 20:41:38 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 04DEF12DA;
	Thu, 23 Feb 2006 20:41:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <863bi9hq6u.fsf@blue.stonehenge.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16660>

Hi,

On Thu, 23 Feb 2006, Randal L. Schwartz wrote:

> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> The version of Perl Alex has to use claims to be 5.8, but does
> Junio> not understand open($kid, '-|'), and he is trying to come up
> Junio> with a workaround.
> 
> Ahh, the problem is activestate then.  If that's the case, then amend 
> the code with a check for $^O (operating system) that falls back to a qx 
> if on activestate, and hope that filenames aren't a problem.  
> Unfortunately, I don't know enough about that to fix it.

Now that our local Perl guru joined the discussion, may I ask what is, and 
what is not quoted when put inside qx{}? I had the impression that all 
arguments are quoted, except that variables are resolved first. Was that 
wrong? IOW does

	qx{bash $variable}

quote the value of $variable, or not?

Ciao,
Dscho
