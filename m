From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/6] Expose in_merge_bases() via merge-base.
Date: Tue, 09 Jan 2007 02:41:25 -0800
Message-ID: <7v64bgpjmy.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<87fyalyqqz.wl%cworth@cworth.org>
	<7v7ivxt3ft.fsf@assigned-by-dhcp.cox.net>
	<87d55pyp82.wl%cworth@cworth.org> <20070109032640.GB1904@spearce.org>
	<7v3b6ksmo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQL-0003nM-9R
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbXAIKl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAIKl2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61249 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbXAIKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104126.SYON16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhh1W00P1kojtg0000000; Tue, 09 Jan 2007 05:41:42 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36345>

Junio C Hamano <junkio@cox.net> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> The common case is probably going to be where the argument to
>> `git checkout` is a fast-foward of the detached HEAD.  And that's
>> pretty cheap to check.  So we perform that check, and if we fail
>> that then we search through every ref to determine if the detached
>> HEAD is fully contained in any of those.  Currently that would be
>> pretty slow to do with the current tools, but a small modification
>> of say git-merge-base (or git-describe) might make it cheap enough
>> to run during this slightly less common case.
>
> The needed change to merge-base is quite minimum.  Let me come
> up with a patch...

[PATCH 1/6] Allow in_merge_bases() to take more than one reference commits.
[PATCH 2/6] merge_base(): move traversal into a separate function.
[PATCH 3/6] git-merge-base: --check-ancestry option
[PATCH 4/6] in_merge_bases(): optimization
[PATCH 5/6] Make merge-base a built-in.
[PATCH 6/6] Teach "git-merge-base --check-ancestry" about refs.
