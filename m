From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 10:03:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 19:04:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg2xK-0001Mw-Gh
	for gcvg-git@gmane.org; Tue, 16 May 2006 19:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWEPRDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWEPRDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 13:03:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbWEPRDZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 13:03:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GH3KtH006822
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 10:03:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GH3JGW013764;
	Tue, 16 May 2006 10:03:20 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20127>



On Tue, 16 May 2006, Eric W. Biederman wrote:
>
> If the --author flag was not given the the author is recorded as 
> unknown.

Please don't do this. Just error out. It would be horrible to have a quilt 
import "succeed", and then later notice that some of the patches had 
incorrect authorship attribution just because the import script didn't 
check it, but just made it "unknown".

An un-attributed patch is simply not acceptable in any serious project. 
It's much better to consider it an error than to say "ok".

		Linus
