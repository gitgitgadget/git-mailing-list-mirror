X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on rerere
Date: Tue, 19 Dec 2006 16:41:33 -0800
Message-ID: <7vk60no0ua.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612200045490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 00:41:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612200045490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Dec 2006 00:53:38 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34875>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpWd-0003xX-HW for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932701AbWLTAlg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWLTAlg
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:41:36 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38521 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932701AbWLTAlg (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:41:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220004135.TGSQ97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 19:41:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0ogt1W0031kojtg0000000; Tue, 19 Dec 2006
 19:40:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> IIUC then each conflict hunk is handled _separately_ like this: the 
> lexicographically smaller between the two file sections is displayed 
> first, regardless if a previous hunk had a different order. Not that it 
> matters most of the time, but isn't this dangerous?

You are probably right.  Probably the right thing would be to
use the first hunk to determine the flipping order and stick to
that for the rest.

Not that I've seen problems with the current behaviour, though.
