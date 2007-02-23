From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Thu, 22 Feb 2007 22:21:50 -0800
Message-ID: <7vslcx9ywx.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
	<455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org>
	<4566E512.4010405@xs4all.nl>
	<Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 07:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKToa-0004Hy-7X
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 07:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXBWGVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 01:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbXBWGVw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 01:21:52 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38725 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbXBWGVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 01:21:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223062152.TLVC2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 01:21:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SuMq1W00X1kojtg0000000; Fri, 23 Feb 2007 01:21:51 -0500
In-Reply-To: <Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 01:35:03 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40419>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this patch,
>
> $ git show -s \
> 	--pretty=format:'  Ze komit %h woss%n  dunn buy ze great %an'
>
> shows something like
>
>   Ze komit 04c5c88 woss
>   dunn buy ze great Junio C Hamano

Does it say "This commit is by a fool whose name is blah"?

> The supported placeholders are:
>
> 	'%H': commit hash
>...
> 	'%b': body

Hmmm.  Would we want to make them somehow interoperable with
git-for-each-ref format atoms?

Also, it _might_ be worthwhile to do something like "%+4b"
which means "indent each line of this field with 4 spaces", for
a multi-line field like "%b".

> 	'%Cred': switch color to red
> 	'%Cgreen': switch color to green
> 	'%Cblue': switch color to blue
> 	'%Creset': reset color

Hmmm.  I strongly suspect that we would want to reuse code to
grok colors and attributes in color.c.

> 	>   --format 'committer %c\nauthor %a\n'
> 	>   
> 	> this catches all combinations, and is easier for scripting.

I do not have strong preference between "\n" and "%n".

> 	So, I overcame my laziness after 91 days...

Thanks.
