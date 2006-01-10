From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 11:45:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
 <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 20:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPQz-0007lj-AP
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWAJTpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJTpa
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:45:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932495AbWAJTp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 14:45:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AJjRDZ029305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 11:45:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AJjNXp010974;
	Tue, 10 Jan 2006 11:45:25 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14441>



On Tue, 10 Jan 2006, Linus Torvalds wrote:
> 
> You can _undo_ the revert, so it's not permanent in that sense. Just do
> 
> 	git reset --hard origin
> 
> and your "master" branch will be forced back to the state that "origin" 
> was in.

Btw, you can try this (careful - it will also undo any dirty state you 
have in your working tree), and then do the "pull" again (which should now 
be a trivial fast-forward) and then just try to do the "git revert" on the 
new state.

An even better option is obviously to figure out _why_ that commit broke 
for you in the first place, and get it fixed up-stream, so that you don't 
even need to revert it any more, and the "pull" just fixes it for you ;)

			Linus
