From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Fri, 01 Jul 2005 16:38:02 -0600
Message-ID: <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
	<42C5714A.1020203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 00:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoU2r-0000bH-Mp
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 00:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVGAWjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVGAWjM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 18:39:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34217 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261369AbVGAWjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 18:39:08 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j61Mc6GD029721;
	Fri, 1 Jul 2005 16:38:06 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j61Mc20q029720;
	Fri, 1 Jul 2005 16:38:02 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C5714A.1020203@zytor.com> (H. Peter Anvin's message of "Fri,
 01 Jul 2005 09:37:30 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
> Unless you have an authentication mechanism and *enforce* it (you can do that
> with GPG signatures if *and only if* your disambiguation includes your GPG
> signature fingerprint) you still have a problem with someone introducing fake
> tags as a DoS attack.

There is a question of how bad is this.   For releases you certainly
need some kind of signature that people can verify and we
already have that but I think we can keep spoofing tags
down to the same level as spoofing patches.

Basically all this takes is to make your global namespace
the committer email address and you have the rule that
you can only tag your own commits.  Then when you merge
tags you never automatically add tags to your own tag namespace.

I think that is enough to make global tags usable in practice.

And for those who are typing challenged if all you ever
look at are your own tags the you should never need to
specify a fully qualified tag name as git should be able
to find the committer email address through other means.

Eric
