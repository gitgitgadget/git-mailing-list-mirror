From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Wed, 12 Oct 2005 11:10:11 -0700
Message-ID: <7v4q7mip30.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
	<7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net> <434D2D8F.2020407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:12:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPl3W-0007nw-FY
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 20:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVJLSKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVJLSKO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 14:10:14 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56824 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751463AbVJLSKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 14:10:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012180956.STBL29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 14:09:56 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434D2D8F.2020407@zytor.com> (H. Peter Anvin's message of "Wed,
	12 Oct 2005 08:36:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10042>

"H. Peter Anvin" <hpa@zytor.com> writes:

> We can disallow whitespace, and we *have* to disallow at least newline 
> due to the file format; I believe we should disallow all control 
> characters (0-31, 127-159.)

I agree.

Currently SP, TAB, and LF are all we care about, and nothing
else; NUL does not even count.  But if we are codifying a list
of disallowed byte values, excluding all control characters is
probably a sane thing to do, without introducing arbitrary and
unnecessary limitation too much.
