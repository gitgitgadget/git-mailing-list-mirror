From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 12:40:14 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711151237550.4260@woody.linux-foundation.org>
References: <804pfobgkp.fsf@tiny.isode.net>            <20071114230258.GG3973@steel.home>            <807ikj3fge.fsf@tiny.isode.net>            <20071115192654.GA3552@steel.home> <80ejerdzjd.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 21:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IslVz-0005Yq-Ly
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 21:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXKOUk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 15:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbXKOUk1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 15:40:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52108 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751554AbXKOUk0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 15:40:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFKeFNf030097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 12:40:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFKeEFt014050;
	Thu, 15 Nov 2007 12:40:15 -0800
In-Reply-To: <80ejerdzjd.fsf@tiny.isode.net>
X-Spam-Status: No, hits=-1.808 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65157>



On Thu, 15 Nov 2007, Bruce Stephens wrote:
>
> They are in the index.  What I want is a list of files which are known
> to git, which are matched by the default rules (in particular the
> .gitignore files).

Ahh.

*All* the .gitignore rules are purely about files that git does not 
already know about. Once git tracks a pathname, the ignore rules simply 
do not matter.

Files that are in the index are simply never ignored. There's no way to 
ignore them, and in fact, the whole "git add -f" thing is a way to add 
files to the index and override the exclude rules - at which point git 
then tracks them regardless of any such exclude rules.

			Linus
