From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 10:38:17 -0700
Message-ID: <7vodjbx2t2.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
	<Pine.LNX.4.64.0706191037590.4059@racer.site>
	<Pine.LNX.4.64.0706191239260.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 19:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0her-00084Q-DN
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 19:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbXFSRiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758080AbXFSRiT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 13:38:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57922 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757993AbXFSRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 13:38:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070619173817.HXUZ4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 19 Jun 2007 13:38:17 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DVeH1X00Q1kojtg0000000; Tue, 19 Jun 2007 13:38:18 -0400
In-Reply-To: <Pine.LNX.4.64.0706191239260.4740@iabervon.org> (Daniel
	Barkalow's message of "Tue, 19 Jun 2007 12:49:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50499>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> >  * when a branch config file section refers to a branches/* remote, the 
>> >    merge setting is used (if one is given), even though this isn't useful 
>> >    either way.
>> 
>> Maybe this is the right time to cut off branches/* and remotes/*?
>
> It's not actually too difficult to support them, except for some weird 
> combination cases that nobody would do anyway. I just made the remote.c 
> config file parser generate the corresponding configurations from them, 
> and the rest of the code doesn't have to care. The only oddity is that I 
> had to support having a remote always auto-follow tags, even without 
> tracking branches, because that's what branches/* did. But this is 
> probably a reasonable thing to support as an option anyway.

We should support repositories with older layouts for an
eternity in git timescale (that is usually 6mo to a year) after
announcing that they are deprecated (which hasn't happened yet,
but I think everybody agrees that deprecating branches/ and
remotes/ is a sane thing to do in 1.6.0 or so).  Even if we give
clear migration path and script, having to convert them all at
once is a nuisance for the users.
