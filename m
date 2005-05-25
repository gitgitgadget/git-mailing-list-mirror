From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-update-cache: allow dot-files
Date: Tue, 24 May 2005 17:52:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241748520.2307@ppc970.osdl.org>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org> <7v8y24taai.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:50:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dak5J-0005Zt-UM
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVEYAuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVEYAuk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:50:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:47541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262212AbVEYAuX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 20:50:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P0oIjA006989
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 17:50:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P0oHsh028015;
	Tue, 24 May 2005 17:50:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y24taai.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> I considered it, but it's so much easier to allow things
> LT> later than deny them, that I preferred being anal about it.
> 
> That is not the point.  GIT_DIR set to "GIT" would happily suck
> index file in.  You are not being anal enough.

Heh. There's a difference between being anal, and allowing people to shoot 
themselves in the foot.

I'll happily allow people who _try_ to do stupid things to do them ;)

It's the

	find . -type f | cut -d/ -f2- | xargs git-update-cache --add --

kinds of "unintentionally stupid" scripts I want to avoid (and the reason
I do that is because that's basically _exactly_ the script I used when
testing something ;)

		Linus
