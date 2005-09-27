From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 10:07:38 -0700
Message-ID: <7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com>
	<20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 19:09:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKIvg-00042G-0k
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVI0RHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVI0RHl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:07:41 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56991 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965010AbVI0RHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 13:07:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927170737.LLZE776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 13:07:37 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050927094029.GA30889@pasky.or.cz> (Petr Baudis's message of
	"Tue, 27 Sep 2005 11:40:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9406>

Petr Baudis <pasky@suse.cz> writes:

> Yes, that's perhaps a fine solution for the core GIT plumbing, but in
> Cogito, I _really_ want to have this working automagically.

I agree that would be nice.  If you are only interested in tags
that refer to commits that anchor points in published branches,
maybe we should have something along the lines of info/refs to
help the downloaders?  Perhaps info/refs showing the SHA1 id of
the non-tag object each tag dereferences to in addition to the
current output?

This is a bit hard and needs some thinking to do cleanly,
because what is in info/refs is what is sent from the publisher
side over git-native protocol at the beginning of the handshake,
and it is not easy to add that to git-native protocol cleanly
and backward-compatibly (I think I know how without breaking
existing clients, but it is not clean).
