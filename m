From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 11:45:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021141350.4716@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
 <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com>
 <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com>
 <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com>
 <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com>
 <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com>
 <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com>
 <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 20:48:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Don21-0007cw-1D
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 20:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVGBSrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 14:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVGBSrm
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 14:47:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbVGBSr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 14:47:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j62IhpjA015234
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 11:43:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j62Ihj1q005569;
	Sat, 2 Jul 2005 11:43:47 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C6D5AD.9070304@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 2 Jul 2005, H. Peter Anvin wrote:
> 
> Well, you're wrong.  Tags is the only part of git which cannot be 
> protected by git's own self-validation system.

Well, you _can_ use the tag objects. That's what I do. The namespace isn't
the tag name you use ("v2.6.12"), it's the name of the tag itself (in this
case "26791a8bcf0e6d33f43aef7682bdb555236d56de"), and then it does
actually distribute fine. The symbolic name is encoded within the tag, but 
isn't guaranteed to be unique in any way.

So no, it doesn't protect the tag _name_ per se. Anybody can create a tag
called "v2.6.12", and I don't think there's any way to handle clashes
sanely. But you can find the tag objects in a pack, and you could index 
them separately. Then you'd need to let the users decide which ones they 
trust or want to use.

		Linus
