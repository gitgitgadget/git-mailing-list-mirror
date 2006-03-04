From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use core.sharedrepository consistently.
Date: Sat, 4 Mar 2006 15:16:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603041514050.22647@g5.osdl.org>
References: <20060304225125.GB8891@ferdyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 00:16:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFfzU-0002gQ-UG
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 00:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWCDXQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 18:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWCDXQo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 18:16:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751770AbWCDXQo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 18:16:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k24NGgDZ003150
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Mar 2006 15:16:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k24NGerP003535;
	Sat, 4 Mar 2006 15:16:41 -0800
To: "Fernando J. Pereda" <ferdy@gentoo.org>
In-Reply-To: <20060304225125.GB8891@ferdyx.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17198>



On Sat, 4 Mar 2006, Fernando J. Pereda wrote:
>
> 'git init-db --shared' sets 'core.sharedRepository' but in
> setup.c 'core.sharedrepository' is checked instead.

It really shouldn't matter.

Case in a git config option name is always converted to lower case when 
the config file is read, exactly so that you can use mixed case without 
the actual readers caring. Lots of people prefer mixed-case for 
human-readable info, ie

	[Core]
		Name=Linus Torvalds

will actually generate

	core.name=Linus Torvalds

as the config variable.

So the code should have worked fine.  Unless there is some bug somewhere.

		Linus
