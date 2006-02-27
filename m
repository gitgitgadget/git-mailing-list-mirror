From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] gitweb: Enable tree (directory) history display
Date: Mon, 27 Feb 2006 11:56:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602271154400.22647@g5.osdl.org>
References: <20060227185554.75822.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 20:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDoTe-0002nh-5t
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 20:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWB0T4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWB0T4L
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 14:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWB0T4J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 14:56:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RJu8DZ005992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 11:56:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RJu76h006832;
	Mon, 27 Feb 2006 11:56:08 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060227185554.75822.qmail@web31810.mail.mud.yahoo.com>
X-Spam-Status: No, hits=-2.84 required=5 tests=HTML_MESSAGE,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16880>



On Mon, 27 Feb 2006, Luben Tuikov wrote:
> 
> This patch allows history display of whole trees/directories,
> a la "git-rev-list HEAD <dir or file>", but somewhat
> slower, since exported git repository doesn't have
> the files checked out so we have to use
> "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin \'$file_name\'"

No no. 

Just use 

	git-rev-list $hash -- $file_name

where the "--" is the important part.

As a usability-enhancer, you can leave out the "--" to separate filenames 
and other things, but when you leave out the "--", git requires that the 
filenames exist.

		Linus
