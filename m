From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Implement git-quiltimport
Date: Wed, 17 May 2006 07:28:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170725070.10823@g5.osdl.org>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0605161001190.3866@g5.osdl.org> <m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
 <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net> <m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 16:28:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgN0Z-0006vE-Nc
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWEQO2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWEQO2N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932574AbWEQO2M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:28:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HES7tH023725
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:28:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HES67x014948;
	Wed, 17 May 2006 07:28:07 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20201>



On Tue, 16 May 2006, Eric W. Biederman wrote:
> 
> So what we need for this case really is a way to mark the
> commit objects in such a way that git-fetch or git-merge
> would choke on the commit objects and refuse to merge.
> That way the changes could not easily propagate in the wild.
> Every user would at least have to specify a non-default option,
> that Linus at least would never specify.

No.

What we need is for your git-quiltimport to not generate the bogus commits 
in the first place!

Make it a damn error already.

If you want to have some stupid default to a non-existing and 
non-supported user, then do

	git-quiltimport --author="Bad User <baduser@nosuchuser.com>"

and get over it. Don't make the quiltimport script _default_ to a totally 
idiotic model that will just screw people over.

Or keep it as your personal script. I'm just saying that it should sure as 
hell not be used by any sane person in the format it is in now. Because, 
_by_default_, it now does something insane, which is bad bad bad. Which 
means that it shouldn't be merged by Junio.

		Linus
