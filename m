From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 06 Mar 2007 15:02:56 -0800
Message-ID: <7vejo2nffj.fsf@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com>
	<Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com>
	<Pine.LNX.4.63.0703061518250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOihQ-0003hf-OZ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbXCFXDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbXCFXDE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:03:04 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33100 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030651AbXCFXC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:02:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306230257.CRBO2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 18:02:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xb2w1W00U1kojtg0000000; Tue, 06 Mar 2007 18:02:57 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41610>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 6 Mar 2007, Alex Riesen wrote:
> ...
>> ... I was suggesting to output something like this:
>> 
>> $ make
>> ...
>>     CC builtin-grep.o
>> builtin-grep.c:187: warning: 'external_grep' defined but not used
>> 
>> Notice "builtin-grep.o" (the ".o", not _.c_). IOW, we already
>> see builtin-grep.c when we need it (in the error/warning message),
>> BUT the builtin-grep.o is missing (and is useful for mouse-copy-paste).
>
> Ah! That explains it why I did not understand.

But doesn't "CC foo.o" look just simply WRONG?  We compile foo.c
to produce foo.o.  An alternative that I could slightly more
sympathize with would be something like this:

	CC builtin-grep.c => builtin-grep.o
