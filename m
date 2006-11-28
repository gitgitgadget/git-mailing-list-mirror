X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_object_info(): be consistent with read_sha1_file()
Date: Mon, 27 Nov 2006 17:05:58 -0800
Message-ID: <7vslg4crd5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0611280016150.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 01:06:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611280016150.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 28 Nov 2006 00:18:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32475>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GorQD-00030O-At for gcvg-git@gmane.org; Tue, 28 Nov
 2006 02:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935014AbWK1BGA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 20:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935007AbWK1BGA
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 20:06:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8690 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S935005AbWK1BF7
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 20:05:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128010558.OQMJ18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 20:05:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s15S1V00a1kojtg0000000; Mon, 27 Nov 2006
 20:05:27 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We used to try loose objects first with sha1_object_info(), but packed
> objects first with read_sha1_file(). Now, prefer packed objects over loose
> ones with sha1_object_info(), too.

Well caught.  It appears this inconsistent order was from the
day one when we started using the packed git, and I forgot to
swap them when I did ab90ea5 to swap the reading side.

Thanks.


