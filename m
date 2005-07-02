From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Sat, 02 Jul 2005 12:31:31 -0600
Message-ID: <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com>
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
	<m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
	<42C5DA77.4030107@zytor.com>
	<m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com>
	<42C6D318.8050108@zytor.com>
	<m1k6k9drfk.fsf@ebiederm.dsl.xmission.com>
	<42C6D5AD.9070304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 20:32:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Domn6-0006I0-DD
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 20:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVGBSc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 14:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGBSc3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 14:32:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50614 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261250AbVGBScV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 14:32:21 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j62IVW49016412;
	Sat, 2 Jul 2005 12:31:32 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j62IVV5e016411;
	Sat, 2 Jul 2005 12:31:31 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C6D5AD.9070304@zytor.com> (H. Peter Anvin's message of "Sat,
 02 Jul 2005 10:58:05 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> ?? Isn't that what ssh is?
>> To some extent a lot depends on how active you expect people to
>> try and forge things.  If there is an expectation of honesty
>> you are fine.
>
> I can't afford to have that.

So you are now your requirements are more stringent then sourceforge?
Sourcefore limited things by reducing the scope of commits per
project.  But once you had commit access to a project you could do
just about anything.

>> If you want to build one mondo repository with thousands of developers
>> having write access you need to be more careful.  But as far as I know
>> none of that is specific to tags.
>
> Well, you're wrong.  Tags is the only part of git which cannot be protected by
> git's own self-validation system.

Which is why I suggested having tags in sync with the committer
information, that way you are as valid as the commit record
in git.  Although I suspect the multiple head solution is
probably better, and simply limiting the people who can commit
to an individual head will achieve what is necessary.  One user
per head?

One thing arch has shown is that you can sucessfully move
authentication/permission checking to the underlying environment
if you structure things carefully.

I guess the problem is really we want to structure things so that
a user who has downloaded the code can verify they have the
release/tag is what they are looking for.  You can detect
a spoofed file in objects by simply verifying the sha1 of the file.

For a file that you can't internally verify that way the traditional
way to handle that is to create a file with a gpg signature.  So
is there anything wrong with adding .git/refs/tags/tag-name.sign
that is a traditional signature file?   That will at least give
you an end to end consistency check.  (Hmm.  Why didn't I suggest
this before?)

If you don't want to mirror and propagate data you need to do
consistency checks earlier in the process, and I have probably had
some poor suggestions on how to implement those.  But if everything
is setup so we can verify things once we have the code downloaded,
where you perform the checks is simply a matter of optimization.

Eric
