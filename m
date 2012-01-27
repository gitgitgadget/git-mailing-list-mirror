From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: git rebase likes to fail miserably on Mac OS X Lion
Date: Fri, 27 Jan 2012 08:59:28 +0100
Message-ID: <1keiu28.11ei9311hu0d3gM%lists@haller-berlin.de>
References: <4F223543.3080903@workspacewhiz.com>
To: jjensen@workspacewhiz.com (Joshua Jensen),
	git@vger.kernel.org (git@vger.kernel.org)
X-From: git-owner@vger.kernel.org Fri Jan 27 08:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqgiy-00033i-BI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 08:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab2A0H7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 02:59:31 -0500
Received: from server90.greatnet.de ([83.133.96.186]:40986 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab2A0H7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 02:59:31 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 317FC2A01D1;
	Fri, 27 Jan 2012 08:57:31 +0100 (CET)
In-Reply-To: <4F223543.3080903@workspacewhiz.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189203>

Joshua Jensen <jjensen@workspacewhiz.com> wrote:

> On 4 different Mac OS X Lion machines, rebasing my commits (I currently
> have 14 of them) yields either of the following _consistently_ across
> varied repositories:

As far as I can tell, these are two completely unrelated problems.

>      fatal: Unable to create 
> '/Users/joshua/src/project/.git/index.lock': File exists.

In my experience, this is caused by Xcode 4's builtin git support. It
happens when you have your project open in Xcode 4 while you try to
rebase it.  It doesn't seem to be possible to turn off Xcode's git
support (I never use it), so the only workaround seems to be to close
the Xcode project before you rebase.

>      error: Your local changes to the following files would be 
> overwritten by merge:

As a workaround for this one, try

  git config --global core.trustctime false

This helps for me, but I have no idea what the implications are or why
it would be necessary.


(Out of town until Feb 5; don't expect timely replies.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
