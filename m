From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 16:28:03 -0800
Message-ID: <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZuU-0005um-AQ
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992953AbXBRA2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992894AbXBRA2H
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:28:07 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50484 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965454AbXBRA2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:28:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218002805.MGYB1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 19:28:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QoU31W0061kojtg0000000; Sat, 17 Feb 2007 19:28:03 -0500
In-Reply-To: <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 01:08:03 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40038>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > If I read this correctly, running 'git apply' inside a git repository
>> > will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
>> > repository it will parse neither. It would make more sense to me to
>> > still parse $HOME/.gitconfig to pick up the user's global options.
>> 
>> I thought about that, but decided against it.  If you are truly
>> operating outside a git managed repository, it does not feel
>> right to apply configuration user has for git.
>
> That is a good point. But in the same vein, why not have a flag to 
> git-apply, and let it ignore the configuration altogether?

Do you mean --whitespace=strip option from the command line?

But I think Jeff is right.  It would make sense to let apply
and perhaps 'diff', if we can somehow merge 'diff2' into it,
still read from $HOME/.gitconfig if available.
