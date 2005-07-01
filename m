From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Fri, 01 Jul 2005 17:07:19 -0600
Message-ID: <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
	<42C5714A.1020203@zytor.com>
	<m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
	<42C5C75F.4040100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 01:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoUX0-0003jq-4X
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 01:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVGAXJC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 19:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVGAXJC
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 19:09:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58281 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261627AbVGAXIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 19:08:25 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j61N7KhB029994;
	Fri, 1 Jul 2005 17:07:20 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j61N7JZK029993;
	Fri, 1 Jul 2005 17:07:19 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C5C75F.4040100@zytor.com> (H. Peter Anvin's message of "Fri,
 01 Jul 2005 15:44:47 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> There is a question of how bad is this.   For releases you certainly
>> need some kind of signature that people can verify and we
>> already have that but I think we can keep spoofing tags
>> down to the same level as spoofing patches.
>> Basically all this takes is to make your global namespace
>> the committer email address and you have the rule that
>> you can only tag your own commits.  Then when you merge
>> tags you never automatically add tags to your own tag namespace.
>>
>
> Doesn't work.  You can trivially generate a key with someone else's address.  It
> would require a full PKI.

I'm not saying it's provable correct.  I'm simply saying it is as
correct as the rest of the git repository.

If I really care what developer xyz tagged I will pull from them,
or a mirror I trust.  And since developer xyz doesn't pull his
own global tags from other repositories that should be sufficient.

Plus if you pull from a spoofed tag somewhere further along
when you merge your code the merge will fail because what
you thought was a common ancestor isn't.  And you will
also likely get an error when you have the same tag
coming from 2 different sources with different values.

So all I am really arguing is that using the committer
email address is simply sufficient to prevent non-malicious
conflicts between developers, and it makes it enough
that to get a malicious conflict isn't completely trivial.
So I think it is good enough.

But for releases and things lots of people must trust yes you want
a full PKI infrastructure but I don't see a reason any of that
should be inherently tied to tags.

Eric
