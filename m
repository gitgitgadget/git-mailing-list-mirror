From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 18:58:16 -0600
Message-ID: <m1u0j0zvpz.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 03:04:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9Bc-00079h-EV
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVGLA74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGLA7p
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:59:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2193 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261804AbVGLA6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 20:58:31 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C0wG5U020804;
	Mon, 11 Jul 2005 18:58:16 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C0wGe6020803;
	Mon, 11 Jul 2005 18:58:16 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 10:06:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>> 
>> A couple of pieces.  The dist target has assumes git-tar-tree is in the
>> path.  Making it so you have to have git installed to build the rpm.
>
> Yes. Maybe we could relax that requirement by using "./git-tar-tree" or 
> something? That still requires that you have _built_ git to do the rpm, 
> but at least you won't have had to install it.
>
> Does that fit the rpm build process? Or does an rpm build make something 
> like that really inconvenient? I don't know, patches welcome.

That would be sane.  The reason I worry about having it installed is
that if git-tar-tree changes without building first you will run
the old version instead of the new one.

>> The man pages are not built. The build dependencies do not call out
>> the tools necessary to build the man pages.
>
> Most people don't have asciidoc, and I'm not sure we want to require it. 
> Maybe we could have a separate "make man-rpm" target for that?

Or just have a make man target and only require the rpm to use it.
You certainly want to require making the man pages when building
the rpm.  Which means only those people who build rpms or build
man pages need asciidoc.  

>> And it does not pass my torture test of building rpm's on debian,
>> but that is not a huge problem.
>
> Ok, why is debian problematic? 

Mostly because debian is not rpm based.  If you are real careful
you can build rpm's on debian.   It is almost as bad as complaining
that git does not build on windows with Microsoft's compiler.  I was
getting a really generic error.  I need to look into it deeper to see
if is something that is avoidable.

> Is there some missing dependency or 
> something? I really haven't ever done an rpm, and the git rpm target was 
> all done by Chris Wright, so I don't have any clue at all. Again, patches 
> welcome.

Will do.

Eric
