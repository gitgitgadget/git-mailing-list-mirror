From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 19:01:44 -0800
Message-ID: <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
	<7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 04:01:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOmPZ-0004V5-4r
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 04:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbXCGDBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 22:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161355AbXCGDBq
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 22:01:46 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52249 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161331AbXCGDBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 22:01:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307030146.NRGB1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 22:01:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xf1k1W00w1kojtg0000000; Tue, 06 Mar 2007 22:01:45 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41645>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> The handcrafted built-in rev-list lookalike forgot to mark the trees
>> and blobs contained in the boundary commits uninteresting, resulting
>> in unnecessary objects in the pack.
>>
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>>
> This works for things like  master~1..master, but fails on git bundle
> create t.bdl  master --since=1.day.ago.
> Apparently the boundary commits marked with a date are not being
> honored in creating a pack.

That one is caused by the broken revision traversal in 'master'
and being worked on in 'next'.  Care to try the one from 'next'
instead?
