From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 12:56:18 -0800
Message-ID: <20060221205618.GA23920@localdomain>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBeYZ-0003dT-RR
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWBUU4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWBUU4U
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:56:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:12746 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932723AbWBUU4U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 15:56:20 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 29DD42DC01A;
	Tue, 21 Feb 2006 12:56:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 21 Feb 2006 12:56:18 -0800
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16550>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/20/06, Junio C Hamano <junkio@cox.net> wrote:
> >  * Eric, thanks for the hint.  I have this four-patch series.
> >    Could people with perl 5.6 please check them?
> 
> Does not work here (ActiveState Build 811, Perl 5.8.6):
> 
> $ perl -e 'open(F, "-|")'
> '-' is not recognized as an internal or external command,
> operable program or batch file.

Both "-|" and "|-" forms of open() use fork() internally.  Iirc, fork()
doesn't work too well on that platform.

-- 
Eric Wong
