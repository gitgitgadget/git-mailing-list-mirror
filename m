From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 08:42:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
 <20090102105856.GB14691@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 02 17:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIn8G-0007yv-Em
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 17:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZABQm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 11:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbZABQm6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 11:42:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53377 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756667AbZABQm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 11:42:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02Gg6Sc020218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Jan 2009 08:42:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02Gg4tc003498;
	Fri, 2 Jan 2009 08:42:04 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090102105856.GB14691@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104386>



On Fri, 2 Jan 2009, Clemens Buchacher wrote:
>
> Only two choices, and I still get it wrong. The diffs should be labeled the
> other way around, of course.

Yes, this one is a real patience diff change, but it's also the same one 
that I've seen in the google fanboi findings. What google did _not_ show 
was any real-life examples, or anybody doing any critical analysis.

So I was hoping for something else than a single "in this case patience 
diff works really well". I was hoping to see what it does in real life. 
But when I tried it on the kernel archive, I get a core dump.

For example, in real life, files are bigger, and unique lines are not 
necessarily always common (generated files, whatever). Depending on unique 
line ordering may work fine in 95% of all cases, but do you know that it 
works fine in general? Does it work when 50% of lines are unique? I 
believe it does. Does ti work when just 1% of lines are unique? I just 
don't know.

And I haven't seen _any_ real critical analysis of it. Anywhere.

			Linus
