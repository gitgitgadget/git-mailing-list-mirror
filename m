From: Petr Baudis <pasky@ucw.cz>
Subject: Re: commit-id fails after cg-init
Date: Tue, 3 May 2005 23:13:01 +0200
Message-ID: <20050503211301.GA15995@pasky.ji.cz>
References: <1115150585.28520.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:07:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4bV-0006Qu-5U
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVECVNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVECVNH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:13:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43979 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261708AbVECVND (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:13:03 -0400
Received: (qmail 637 invoked by uid 2001); 3 May 2005 21:13:01 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1115150585.28520.11.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 10:03:05PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> So, cg-init created an empty .git/refs/heads/master and made .git/HEAD a
> symlink to it.  Now, commit-id reads that file and gets confused.

my plan is to make cg-init:

(i) automatically add to cache any existing content in the current directory,
    if there is any
(ii) call cg-commit right away

This will make us free of this annoying special case and if you are
importing an existing tree, you want to do this anyway. The only case
when it is not 101% right is when starting a new project from fresh, but
some first "dummy" special commit shouldn't hurt there either (that will
require to modify write-tree to be willing to write an empty tree).

Patches welcome.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
