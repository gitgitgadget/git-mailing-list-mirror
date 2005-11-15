From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add config variable core.symrefsonly
Date: Tue, 15 Nov 2005 10:39:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511151028540.3945@g5.osdl.org>
References: <Pine.LNX.4.63.0511151923120.1103@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-688111548-1132079462=:3945"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 19:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5jx-0000S3-Lu
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVKOSlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVKOSlF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:41:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964964AbVKOSlB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 13:41:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFIdpnO025530
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 10:39:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFIdoBJ013282;
	Tue, 15 Nov 2005 10:39:50 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511151923120.1103@wbgn013.biozentrum.uni-wuerzburg.de>
Content-ID: <Pine.LNX.4.64.0511151031160.3945@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11931>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-688111548-1132079462=:3945
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0511151031161.3945@g5.osdl.org>



On Tue, 15 Nov 2005, Johannes Schindelin wrote:
> 
> 	Linus, is there any reason you don´t allow spaces, underscores
> 	and dashes in the config variables?

I much preferred being anal and maybe relaxing the rules later than being 
permissive and accepting horrible crap.

Spaces are definitely out, since we are trying to igore whitespace 
everywhere, but underscores and dashes might be ok.

However, the traditional way to do these kinds of things in ini files is 
with PrettyCaps(tm), ie you'd do

	[core]
		SymRefsOnly = true

rather than the C way.

Let's face it, the C way is the only true way for a programming language, 
but having case matter in something unimportant and human-readable like a 
"ini" file is just bothersome, so PrettyCase(tm) actually makes sense 
there.

PrettyCase is for toys - unimportant things where it's more important to 
say "we don't care" over saying "we need to be precise". So Pascal is PC. 
It's a toy language. FAT is PC - it's a toy filesystem. And ini files are 
PC: it's more important that a config file is human-readable than it is 
that it's very precise and strict.

Put another way: real programmers want strict rules, because they know 
they'll be hurt without them. But _users_ need to be coddled. And ini 
files aren't for programmers, they are for users.

		Linus
--21872808-688111548-1132079462=:3945--
