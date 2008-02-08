From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Adding gitweb.owner, last shot
Date: Fri, 8 Feb 2008 11:49:21 -0200
Message-ID: <20080208134921.GA30264@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <7v3as3lwxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 14:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTcZ-0001r5-Tg
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbYBHNtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbYBHNtx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:49:53 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:45850 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbYBHNtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:49:52 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 3D947700003D9;
	Fri,  8 Feb 2008 11:49:50 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <7v3as3lwxn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73088>

On Thu, Feb 07, 2008 at 11:38:44PM -0800, Junio C Hamano wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
> > ... there is no major performance downgrade
> > compared to $projects_list , as seen below:
> >
> > 8<-------
> > These times i got with a 1000projects running 2 dd to generate disk IO.
> > Here comes the resultm
> > NO projects_list  projects_list
> > 16m30s69          15m10s74       default gitweb, using FS's owner
> > 16m07s40          15m24s34       patched to get gitweb.owner
> > 16m37s76          15m59s32       same above, but without gitweb.owner
> >
> > Now results for a 1000projects on an idle machine.
> > NO projects_list  projects_list
> > 1m19s08           1m09s55       default gitweb, using FS's owner
> > 1m17s58           1m09s55       patched to get gitweb.owner
> > 1m18s49           1m08s96       same above, but without gitweb.owner
> > 8<-------
> 
> Large installations would maintain the project_list in the flat
> file format for performance reasons anyway.  Benchmarking under
> a condition that yields unreasonably long response time is
> somewhat meaningless, I am afraid.  Who sane would wait for 15
> minutes for project list to come up?

But it got 15minutes with project_list to! The real problem is geting last
change on repository under high IO.
> 
><snip>
> 
> As the act of signing off patches is a legal statement, I'd
> prefer real person's name, not "Git Managment for C3SL", in the
> messages to be applied.  The change that adds the feature, and
> the documentation update to describe that new feature, should be
> in the same single patch for a small change like this.

I'll resend it !! my mistake of names =(
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
