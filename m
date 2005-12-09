From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 02:19:38 +0100
Message-ID: <200512090219.38297.Josef.Weidendorfer@gmx.de>
References: <20051208063409.31967.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 02:20:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkWvN-0007Ap-1t
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 02:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLIBTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLIBTl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 20:19:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:36830 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750728AbVLIBTl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 20:19:41 -0500
Received: (qmail invoked by alias); 09 Dec 2005 01:19:39 -0000
Received: from p5496AA54.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.170.84]
  by mail.gmx.net (mp031) with SMTP; 09 Dec 2005 02:19:39 +0100
X-Authenticated: #352111
To: linux@horizon.com
User-Agent: KMail/1.9
In-Reply-To: <20051208063409.31967.qmail@science.horizon.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13409>

On Thursday 08 December 2005 07:34, you wrote:
> As I mentioned with all my questions, I was writing up the answers
> I got.  Here's the current status.  If anyone would like to comment on
> its accuracy or usefulness, feedback is appreciated.
> ...

> + Oddballs
> git-mv.perl
> 	I have to admit, I'm not quite sure what advantages this is
> 	supposed to have over plain "mv" followed by "git-update-index",
> 	or why it's complex enough to need perl.
> 
> 	Basically, this renames a file, deleting its old name and adding
> 	its new name to the index.  Otherwise, it's a two-step process
> 	to rename a file:
> 	- Rename the file
> 	- git-add the new name
> 	Followed by which you must commit both the old and new names

The nice thing about it is that you can move huge directories around,
or multiple files/dirs at once, and it will do the right thing. E.g.
	git-mv -k foo* bar/
will only move files which are version controlled.

It is actually a 3-step process: rename, delete old, add new.
Perhaps it should be noted that this has nothing to do with any
explicit renaming feature like in other SCMs.

Josef
