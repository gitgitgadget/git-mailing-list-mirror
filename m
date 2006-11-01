X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 08:21:45 -0800
Message-ID: <7vk62f2l46.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
	<7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 16:23:01 +0000 (UTC)
Cc: Florent Thoumie <flz@xbsd.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 1 Nov 2006 12:12:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30647>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfIqd-0008Ip-H4 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 17:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946914AbWKAQVs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 11:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946926AbWKAQVs
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 11:21:48 -0500
Received: from fed1rmmtai02.cox.net ([68.230.241.57]:53647 "EHLO
 fed1rmmtai02.cox.net") by vger.kernel.org with ESMTP id S1946914AbWKAQVr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 11:21:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101162146.LOPQ22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 11:21:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hUMq1V00M1kojtg0000000 Wed, 01 Nov 2006
 11:21:51 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this instead:
>
> -		mkdir(filename, 0777);
> -		if (adjust_shared_perm(filename))
> +		if (!mkdir(filename, 0777) && adjust_shared_perm(filename)) {
> +			*dir = '/';
>  			return -2;
> +		}

Not really.  See the comment above the code you just touched.
