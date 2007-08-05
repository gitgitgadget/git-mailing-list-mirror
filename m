From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 12:07:56 +0200
Message-ID: <2D72EA7C-C77E-4B67-A8FD-EE610F5DC161@zib.de>
References: <854pjfin68.fsf@lola.goethe.zz> <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHd1J-0002a3-U2
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXHEKHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXHEKHb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:07:31 -0400
Received: from mailer.zib.de ([130.73.108.11]:43088 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbXHEKHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:07:30 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75A75GF004857;
	Sun, 5 Aug 2007 12:07:05 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75A74jP008893
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 12:07:04 +0200 (MEST)
In-Reply-To: <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54983>


On Aug 5, 2007, at 9:31 AM, Junio C Hamano wrote:

> David Kastrup <dak@gnu.org> writes:
>
>> I am trying to dig through man-pages and user manual and trying to
>> match them with reality.  I seem to have a hard time.  My current
>> understanding (which definitely differs from the documented state) is
>> that there are two types of branches, local and remote branches, and
>> both types of branches can be remote-tracking (it may not be possible
>> to have a non-remote-tracking remote branch, though).
>
> I think we have a brief discussion on #git before you brought
> this up ;-)
>
>  - local branches -- we know what they are.
>
>  - remote tracking branches -- refs that appear in refs/remotes/
>    in the current world order; they are updated only by copying
>    the corresponding local branches at the remote site, and are
>    meant to "keep track of what _they_ are doing".  In olden
>    days before 1.5.0 with non separate remote layout,
>    'refs/heads/origin' branch, and all the non default branches,
>    were treated this way as well.  You were not supposed to make
>    commit on them (because of the above "keep track of" reason),
>    and having them under refs/heads were too confusing, which
>    was the reason the separate remote layout was invented.

The current user manual defines this case in the glossary as
'tracking branch' (without remote), but mostly uses
'remote-tracking branch' at other places. Tracking branch
and remote-tracking branch seem to be equivalent. And I think
we should leave it this way.


> You can have a local branch that is created by forking off of a
> remote tracking branch, with the intention to "build on top" of
> the corresponding remote tracking brach.  You can create such a
> branch and mark it as such with --track option introduced in
> v1.5.1 timeperiod.  This is a relatively new concept, but many
> people find it useful.  We do not have the official term to call
> this concept, and some people have misused the term "remote
> tracking branches" to describe this, which made things very
> confusing.
>
> We would need an official terminology for it.

Something like 'automerging branch', and replace options with
'--automerge/--no-automerge'?

I'm not fully convinced of this idea because it may be
technically correct but doesn't really reflect the intention of
'building on top' of the remote tracking branch.

	Steffen
