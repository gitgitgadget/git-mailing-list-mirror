From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 7 Jan 2009 08:08:59 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901070808000.3057@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit>
 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKbI7-0005A6-2y
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 17:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbZAGQ2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbZAGQ2f
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 11:28:35 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54834 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599AbZAGQ2e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 11:28:34 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07G8xjP007976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 08:09:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07G8xkN008405;
	Wed, 7 Jan 2009 08:08:59 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104810>



On Wed, 7 Jan 2009, Linus Torvalds wrote:
> 
> And dobody else saw it than this one person, and it was a total mystery to 
> everybody until we realized that he used this one feature that nobody else 
> was using. So as you're on OS X, I assume you don't have CRLF conversion, 
> but maybe you use some other feature that we support but nobody really 
> actually uses. Like keyword expansion or something?
> 
> Oh - that would also explain why you got all those entries in "git status" 
> that went away when you did a "git reset --hard": if you had some keyword 
> expansion (or CRLF) enabled in the original users "~/.gitconfig", that 
> checkout would have had expansion/CRLF/whatever conversion, but then when 
> you tarred/untarred it on another setup, the expansion would be seen as a 
> difference because it wasn't enabled.

Btw, if you untar it again, and just do a "git diff", that should show any 
such effects. Rather than showing just that something changed, it should 
show _how_ it changed.

		Linus
