From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Thu, 2 Feb 2006 00:02:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:02:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4ZQ5-0002gk-7D
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423366AbWBBICR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423368AbWBBICR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:02:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423366AbWBBICQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 03:02:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k12826DZ024091
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 00:02:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k12824de009045;
	Thu, 2 Feb 2006 00:02:05 -0800
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15493>



On Thu, 2 Feb 2006, Marco Costalba wrote:
> 
> Currently the public git repo version of qgit uses "git-diff-tree -c"
> for merges, It's not a problem to change qgit to use --cc option
> instead. But I would like to use just one kind of option to filter
> merges files.

I think using "-c" rather than "--cc" is fine, and if it makes parsing 
easier..

The "--cc" option should show less "noise", an dI'm actually arguing that 
it should show even less than it does now (for when the branches agreed 
with each other, and there was no actual conflict, which is what I think 
is more useful), but I don't think "-c" is _wrong_ either.

Using "-c" is a strange kind of "show all differences in a file that had 
file-level merges" while at least to me "--cc" is meant to be more of a 
"show all actual file-level CONFLICTS where the merge actually did 
something different"

		Linus
