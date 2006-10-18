From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 09:22:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180918160.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<1161147348.3423.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610180820210.3962@g5.osdl.org>
	<200610181750.32888.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Robert Collins <robertc@robertcollins.net>
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 18:23:57 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaECR-00047W-1u
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 18:23:25 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaECB-0000fi-SC; Wed, 18 Oct 2006 17:23:07 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GaEC6-0000fL-Dk
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 17:23:02 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IGMxaX031043
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 09:23:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IGMwPc008036;
	Wed, 18 Oct 2006 09:22:58 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610181750.32888.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29244>



On Wed, 18 Oct 2006, Jakub Narebski wrote:
> > 
> > Normally, you'd just use the branch-name. Nobody ever uses the SHA1's 
> > directly.
> 
> With the exception of having sometimes commit-ids in the commit messages,
> for example "Fixes bug introduced by aabbcc00" (although usually you just
> write "Fixes bug in some_function in some_file"), and automatically
> generated 
>   This reverts d119e3de13ea1493107bd57381d0ce9c9dd90976 commit.

Yes. But in both cases, that's usually because you literally ended up 
having the commit name because somebody else (which _can_ be you) searched 
for it (with something like "bisect") and gave it to you.

So even that case is really about communicating a stable name from one 
place (the "find the bug") to another (the "revert the buggy commit").

So yes, _communication_ should always happen by full SHA1's, because those 
are the only thing that always remain stable.

(The fact that "gitk" and I think "gitweb" can then turn them into 
hyperlinks in the commit message is obviously one reason we then tend to 
give them such prominent visibility - they actually end up being very 
useful later on).

In bzr, either you don't get the hyperlinks, or you need to use the 
non-simple name in the commit messages, since the simple names don't 
actually work. Either way, it's an inferior setup.

			Linus
