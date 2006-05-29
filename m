From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Mon, 29 May 2006 15:10:15 -0700
Message-ID: <7vzmh07a9k.fsf@assigned-by-dhcp.cox.net>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
	<7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
	<17531.28529.215905.856397@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpwM-0005sW-Ue
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWE2WKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE2WKS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:10:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12454 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751421AbWE2WKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 18:10:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529221016.KUES18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 18:10:16 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17531.28529.215905.856397@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 30 May 2006 08:02:25 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20984>

Paul Mackerras <paulus@samba.org> writes:

>> Wouldn't this help?
>> 
>> 	$ git-diff-tree --stdin --always
>
> On the git.git tree:
>
> $ cat revs
> 65aadb92a1ce9605fa2f412b51de91781a3ef3d6
> cc189c2ca2c725c430f100f61e7c4a6849f93163
> $ git diff-tree -r -s --stdin -- apply.c <revs
> 65aadb92a1ce9605fa2f412b51de91781a3ef3d6
> $ git diff-tree -r -s --stdin --always -- apply.c <revs
> 65aadb92a1ce9605fa2f412b51de91781a3ef3d6
> cc189c2ca2c725c430f100f61e7c4a6849f93163
> $
>
> With --always, how do I tell that 65aadb affects apply.c and cc189c
> doesn't?

I am not quite sure exactly what you are trying to achieve, but
one trivial way is not giving -s perhaps?
