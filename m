From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 18:44:50 -0600
Message-ID: <m13bqk26pp.fsf@ebiederm.dsl.xmission.com>
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
	<m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:54:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds92E-0006KH-I1
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGLAsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVGLAqc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:46:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57744 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261931AbVGLApH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 20:45:07 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C0ipL1020707;
	Mon, 11 Jul 2005 18:44:51 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C0io5m020706;
	Mon, 11 Jul 2005 18:44:50 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507110928070.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 09:38:49 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>> 
>> I guess I was expecting to pull from one tree into another unrelated
>> tree.  Getting a tree with two heads and then be able to merge them
>> together.
>
> You can do it, but you have to do it by hand. It's a valid operation, but 
> it's not an operation I want people to do by mistake, so it's not 
> something the trivial helper scripts help with.
>
> The way to do it by hand is to just use something stupid that doesn't
> understand what it's doing anyway, and just copy the files over. "cp -a" 
> or "rsync" works fine. Then just do "git resolve" by hand. It's not very 
> hard at all, but it's definitely something that should be a special case.

Ok.  Only the dumb methods are allowed.

>> A couple of questions.
>> 
>> 1) Does git-clone-script when packed copy the entire repository
>>    or just take a couple of slices of the tree where you have
>>    references?
>
> It only gets the objects needed for the references, nothing more.
>
> So if you only get one branch, it will leave the objects that are specific 
> to other branches alone.

Hmm.  As I recall reading the code it grabs everything that is
in .git/refs/*.  So I would actually expect it to grab all of the
branches.   My real question was different.  With a clone it
appears to just get the objects used to compose a tree object,
but none of the history available by looking at the commit
parents is obtained.  Not at all what I would expect for
an operation named clone.

Eric
