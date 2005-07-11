From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 09:19:03 -0600
Message-ID: <m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
	<7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
	<m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 17:39:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds0N4-0003aF-FM
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 17:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGKPXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 11:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGKPV0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 11:21:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48011 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261975AbVGKPTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 11:19:35 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6BFJ9fW015163;
	Mon, 11 Jul 2005 09:19:09 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6BFJ3gT015162;
	Mon, 11 Jul 2005 09:19:03 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org> (Linus
 Torvalds's message of "Sun, 10 Jul 2005 15:36:01 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 9 Jul 2005, Eric W. Biederman wrote:
>> 
>> The current intelligent fetch currently has a problem that it cannot
>> be used to bootstrap a repository.  If you don't have an ancestor
>> of what you are fetching you can't fetch it.
>
> Sure you can.
>
> See the current "git clone". It's actually quite good, it's a pleasure to 
> use now that it gives updates on how much it has done.
>
> Just do
>
> 	git clone src dest

Sorry, somehow I just missed that, and then I noticed just a little
before you sent out your email.

I'm having the worst time putting together a mental model of how git
works, and the documentation is spotty enough that it hasn't been
helpful.  So I am wading through the code.  It seems every time I turn
a corner there is another rough spot.

I guess I was expecting to pull from one tree into another unrelated
tree.  Getting a tree with two heads and then be able to merge them
together.

A couple of questions.

1) Does git-clone-script when packed copy the entire repository
   or just take a couple of slices of the tree where you have
   references?

2) Is there a way for a pack to create deltas against objects
   that are not in the tree?  For a dumb repository making incremental
   changes this is ideal.

Eric
