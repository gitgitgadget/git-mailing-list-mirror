From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 12:47:48 -0800
Message-ID: <7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:48:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Ihl-0001Ra-KC
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWBIUrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWBIUrv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:47:51 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9609 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750775AbWBIUru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 15:47:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209204623.CXQA6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 15:46:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602091235210.2458@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Feb 2006 12:37:09 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15826>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 9 Feb 2006, Linus Torvalds wrote:
>> 
>> Here's a test-case, in case you care. Do "git-diff-tree --cc HEAD" in the 
>> merge-test directory.
>
> Btw, that test-case is also designed to show the different M/A/D cases for 
> the merge result. The merge diff obviously doesn't do rename/copy 
> detection (I don't think it's necessarily even a well-defined op, or if 
> it is, it's damn complicated).

Although I've never seriously tried it, I think "diff-tree --cc"
with -M or -C should do a decent job.  The initial phase to feed
combine-diff runs with the supplied rename/copy options if I am
not mistaken, and from the result it grabs one->{sha1,mode} (for
parent) and two->{sha1,mode} (obviously for merge result) to
feed combine-diff logic, while discarding one->path information.

So obviously it would show the final paths and would not talk
about which different path from each parent contributed to the
result, but otherwise it should not be broken too much.  At
least that was the way I intended..
