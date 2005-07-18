From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 23:40:28 -0600
Message-ID: <m164v8oenn.fsf@ebiederm.dsl.xmission.com>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
	<7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
	<m1hdetnfjq.fsf@ebiederm.dsl.xmission.com>
	<7v64v8j4qn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 07:41:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuONA-0002JM-04
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 07:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGRFku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGRFku
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 01:40:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31105 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261519AbVGRFks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 01:40:48 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6I5eSZq007050;
	Sun, 17 Jul 2005 23:40:28 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6I5eSRB007049;
	Sun, 17 Jul 2005 23:40:28 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64v8j4qn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 17 Jul 2005 18:13:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Actually looking a little deeper unless I have misread
>> the code git-fetch-pack at least will only ask for commit
>> objects so git fetch will never return a tag object.
>
> I thought so but then I tried it and actually it does seem to
> work as expected (well, it is Linus code so it has to be perfect
> ;-).  

Yep.  I confused the want and have cases when I was reading
the code. 

A generalization of git-fetch-pack that can handle multiple
heads looks like it would handle the transfer part of the
problem with tags.  git-clone-pack already does.  Then
all that is needed is a sane way to list the heads that
are read back and some post processing to install everything.

The big question is in what format should we return the heads?
Just a space separated list of sha1's or a directory hierarchy
like git-clone-pack uses.

Eric
