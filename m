From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 15:23:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051519400.7631@beast.quantumfyre.co.uk>
References: <854pjfin68.fsf@lola.goethe.zz> <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHh0o-0007Td-OT
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbXHEOXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbXHEOXP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:23:15 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:56716 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255AbXHEOXO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 10:23:14 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 8C6D1B8D7E
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 15:23:12 +0100 (BST)
Received: (qmail 24092 invoked by uid 103); 5 Aug 2007 15:23:12 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3855. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031356 secs); 05 Aug 2007 14:23:12 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 5 Aug 2007 15:23:12 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55024>

On Sun, 5 Aug 2007, Junio C Hamano wrote:

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
> - local branches -- we know what they are.
>
> - remote tracking branches -- refs that appear in refs/remotes/
>   in the current world order; they are updated only by copying
>   the corresponding local branches at the remote site, and are
>   meant to "keep track of what _they_ are doing".  In olden
>   days before 1.5.0 with non separate remote layout,
>   'refs/heads/origin' branch, and all the non default branches,
>   were treated this way as well.  You were not supposed to make
>   commit on them (because of the above "keep track of" reason),
>   and having them under refs/heads were too confusing, which
>   was the reason the separate remote layout was invented.
>
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

Following was mentioned earlier in this thread ... could we use that?

tracking branch:
   ref always points at a commit from the remote repo branch

following branch:
   ref either points at a commit from the remote repo branch, or a
   local commit with a commit from the remote repo branch in the history

perhaps?

-- 
Julian

  ---
An optimist is a man who looks forward to marriage.
A pessimist is a married optimist.
