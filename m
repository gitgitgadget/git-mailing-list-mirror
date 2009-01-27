From: Hannu Koivisto <azure@iki.fi>
Subject: git gui blame tooltip problem in Cygwin with multiple displays
Date: Wed, 28 Jan 2009 00:52:05 +0200
Organization: NOYB
Message-ID: <83hc3ke50q.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 23:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwoQ-0000ms-Oa
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbZA0WwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbZA0WwR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:52:17 -0500
Received: from main.gmane.org ([80.91.229.2]:42235 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbZA0WwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:52:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LRwn1-00056n-4Z
	for git@vger.kernel.org; Tue, 27 Jan 2009 22:52:15 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 22:52:15 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 22:52:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:2QjfrLCUcC0D3cSf03+SYFKukbo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107414>

Hi,

I have two displays in my Windows XP SP3 machine, display 1 on the
left 1050x1680 (rotated 90deg) and display 2 (primary display) on
the right 1920x1080.  Display coordinates ((top left
corner)-(bottom right corner)) are (-1050,-600)-(0,1080) and
(0,0)-(1920,1080), respectively.  That is, all visible x
coordinates on display 1 are negative and y coordinates are partly
negative.

git gui blame works fine when its window is on the primary display
but if I move it to the other display, the tooltips it opens are
still opened on the primary display, far from the cursor's current
position.  I wonder if the tooltip position calculations cannot
handle those negative coordinates?  I found the code in question
but I can't really read tcl/tk nor have I any idea how to
instrument it to log position calculations, for example.

I realize this may be a quite rare setup and I would like to help
narrow this down but I need a debug version of the code or
something, unless of course the problem is obvious to the author or
someome who is proficient with tcl.

Tested with git 1.6.1.265.g9a013 (and some slightly older version
as well).

PS. I tried to send this, twice, directly to the list (instead of
via Gmane) and Cc the author of the code, Shawn O. Pearce, but for
some reason those mails never showed up, even though at the same
time I was able to send other mails to the list just fine.  Weird.

-- 
Hannu
