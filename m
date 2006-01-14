From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 14 Jan 2006 11:17:23 -0800
Message-ID: <7v1wzaliv0.fsf@assigned-by-dhcp.cox.net>
References: <dp3qpb$7uk$1@sea.gmane.org>
	<7voe2prniw.fsf@assigned-by-dhcp.cox.net>
	<43C91B25.9030707@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 20:17:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exqu1-0006CC-As
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 20:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWANTR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 14:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWANTR0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 14:17:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60803 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750828AbWANTRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 14:17:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114191608.CCLD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 14:16:08 -0500
To: John Ellson <ellson@research.att.com>
In-Reply-To: <43C91B25.9030707@research.att.com> (John Ellson's message of
	"Sat, 14 Jan 2006 10:39:17 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14673>

John Ellson <ellson@research.att.com> writes:

>> ...  In that
>> sense, maybe leaving the interim version unbuildable for binary
>> packaging might be considered a feature.
>
> What happened to this?

I consider leaving the interim version unbuildable for binary packaging
consider a feature.

If you want to build your own version, I think you could locally
tag that head and build, like:

	$ git tag -a "John's GIT 1.1.2+frotz patch" v1.1.2.John0114
	$ make rpmbuild

Of course you can keep a patch with the sed -e 's/-/_/' in
GIT-VERSION-GEN as Linus suggested in your development branch.
I am not yet convinced being able to build a random
unidentifiable binary package is a good thing, and "the number
of minutes/seconds monotonicity" would not work in multiple
branches case (i.e. still leaves the result unordered).
