From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from stdin
Date: Mon, 26 Feb 2007 11:21:59 -0800
Message-ID: <7vk5y4n2qw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702261827510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702261003480.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlQE-0006c7-57
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbXBZTWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbXBZTWB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:22:01 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60589 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030474AbXBZTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:22:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226192200.DUCF3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 14:22:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UKMz1W00f1kojtg0000000; Mon, 26 Feb 2007 14:22:00 -0500
In-Reply-To: <Pine.LNX.4.64.0702261003480.12485@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 26 Feb 2007 10:05:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40645>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 26 Feb 2007, Johannes Schindelin wrote:
>
>> Hi,
>> 
>> On Mon, 26 Feb 2007, Linus Torvalds wrote:
>> 
>> > I suspect you only tested with small input to stdin.
>> 
>> Addendum: yes, I only tested with a reflist which was smaller than one 
>> megabyte ;-)
>
> Well, that CHUNK_SIZE is just silly. I don't see why you'd have a 
> chunk-size of a megabyte to begin with,...

Me neither (not my code) ;-).  I agree with you that using
smaller limit than what will be deployed often helps
testability.
