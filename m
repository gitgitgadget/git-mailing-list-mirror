From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: mutt aliases file not working
Date: Fri, 29 Oct 2010 12:51:33 +0200
Message-ID: <4CCAA735.1030805@drmicha.warpmail.net>
References: <4CC89BC4.8080009@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 12:51:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBmYI-0005li-SH
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 12:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0J2KvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 06:51:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51049 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753029Ab0J2KvL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 06:51:11 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3BD3C6EB;
	Fri, 29 Oct 2010 06:51:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 29 Oct 2010 06:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=E9oQ+a8NlhWcYAvVqXhR5Fwv8Kc=; b=Q5L7tVQRmgG9smsDTueqeh6XACBbuWiXEM101pgof9PT8RH3J6Q2EDfGSS5j+o/ccV9L/L7UNKMjpc83JAGmIN+bUIE84Y7lRGh6l2cNp6RHqdWcs+lLydEkU7q3khOoNB6eodTPJ9Fk8Fh2KokK1JT9avJ1qL23xeS74genyr0=
X-Sasl-enc: S6DsJaFcKGcmD+N833tJmcOYgNiUuxS8tEN1IMIFKXuL 1288349469
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B7DF75E2BE9;
	Fri, 29 Oct 2010 06:51:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <4CC89BC4.8080009@linux.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160326>

Darren Hart venit, vidit, dixit 27.10.2010 23:38:
> For whatever reason, which I'm sure is user error, I haven't been
> able to get mutt aliases to work, while mailrc works fine:
> 
> $ mkdir aliases.git
> $ cd !$
> $ git init
> Initialized empty Git repository in /home/dvhart/aliases.git/.git/
> $ echo "joe Joe Blow joe@foobar.com" > muttaliases

How about:

echo 'alias joe Joe Blow <joe@foobar.com>' > muttaliases

> $ git add muttaliases
> $ git commit -m "aliases file"
> [master (root-commit) b71ae4a] aliases file
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 muttaliases
> $ git config sendemail.aliasesfile `pwd`/muttaliases
> $ git config sendemail.aliasfiletype mutt
> $ cat .git/config
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [sendemail]
> 	aliasesfile = /home/dvhart/aliases.git/muttaliases
> 	aliasfiletype = mutt
> $ git send-email --to joe -1 
> /tmp/l0xCEC7o3d/0001-aliases-file.patch
> Who should the emails appear to be from? [Darren Hart <darren@dvhart.com>] 
> Emails will be sent from: Darren Hart <darren@dvhart.com>
> Message-ID to be used as In-Reply-To for the first email? 
> (mbox) Adding cc: Darren Hart <darren@dvhart.com> from line 'From: Darren Hart <darren@dvhart.com>'
> 
> From: Darren Hart <darren@dvhart.com>
> To: joe
> 
>     ^ when using a mailrc fail this expands to joe@foobar.com
> 
> Cc: Darren Hart <darren@dvhart.com>
> Subject: [PATCH] aliases file
> Date: Wed, 27 Oct 2010 14:29:10 -0700
> Message-Id: <1288214950-13695-1-git-send-email-darren@dvhart.com>
> X-Mailer: git-send-email 1.7.1
> 
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): ^C
> 
> $ stty: standard input: Input/output error
> ^C
> 
> Am I doing something obviously wrong?
> 
