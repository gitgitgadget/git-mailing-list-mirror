From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 20:38:07 -0600
Message-ID: <m164vg7nqo.fsf@ebiederm.dsl.xmission.com>
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
	<m13bqk26pp.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111810380.17536@g5.osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 04:43:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsAjr-0007i5-PZ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 04:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVGLCmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 22:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGLCjn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 22:39:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31890 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261840AbVGLCiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 22:38:22 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C2c8XJ021661;
	Mon, 11 Jul 2005 20:38:08 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C2c7mC021660;
	Mon, 11 Jul 2005 20:38:07 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111810380.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 18:14:46 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>> > So if you only get one branch, it will leave the objects that are specific 
>> > to other branches alone.
>> 
>> Hmm.  As I recall reading the code it grabs everything that is
>> in .git/refs/*.
>
> Only by default.
>
> If you specify a branch (or five) git-clone-pack will grab only that
> branch.
>
> However, I don't think "git clone" (the script) even exposes that, so
> right now you'd not even see it - "git clone" only exposes the "get all
> the branches by default" behaviour.

Yep.

The question:
Does git-upload-pack which gets it's list of objects
with "git-rev-list --objects needed1 needed2 needed3 ^has1 ^has2 ^has3"
get any history beyond the top of tree of each branch.  

As I read the code it does not.  

If the code does not get the history I see some problems.
In particular merging with a branch is hard because we
may not pull the common history point.

Eric
