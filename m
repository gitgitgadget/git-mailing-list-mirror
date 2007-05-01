From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 01 May 2007 12:07:26 -0700
Message-ID: <7vlkg85pn5.fsf@assigned-by-dhcp.cox.net>
References: <463678B7.70409@gmail.com>
	<7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
	<200705010926.35265.andyparkins@gmail.com>
	<7virbc7vue.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705011044210.6574@xanadu.home>
	<7vps5k5uzt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705011939590.4010@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 01 21:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixhD-000881-ED
	for gcvg-git@gmane.org; Tue, 01 May 2007 21:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161770AbXEATH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161776AbXEATH2
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 15:07:28 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35390 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161770AbXEATH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 15:07:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501190727.RUSX24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 15:07:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tv7S1W0031kojtg0000000; Tue, 01 May 2007 15:07:26 -0400
In-Reply-To: <Pine.LNX.4.64.0705011939590.4010@racer.site> (Johannes
	Schindelin's message of "Tue, 1 May 2007 19:42:50 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45972>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 1 May 2007, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > On Tue, 1 May 2007, Junio C Hamano wrote:
>> >
>> >> I was not sure if that is even a good idea, and I am now
>> >> inclined to think that keeping the failed attempt history is
>> >> probably better than potentially causing confusion to people who
>> >> follow 'next'.  But it _is_ a possibility to reset 'next' to
>> >> 'master'.
>> >
>> > And what is the advantage of doing that, exactly?
>> 
>> Not much and that is why I am not sure if that is a good idea,
>> but one thing is:
>> 
>> 	$ git log master..next
>> 	$ git log --no-merges master..next
>> 
>> would start showing what are still pending in next without
>> noise.
>
> Of course, you could graft a fake relationship there. Something like
>
> echo $(git rev-parse master master^ next) >> .git/info/grafts
>
> should do. And you can do it _locally_, since all you care about is the 
> higher-level relationship that _you_ know about. And this is the way to 
> teach Git about it.

In case you did not get it, making the above usable is not about _me_.
