X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Use git-for-each-ref to generate list of heads and/or tags
Date: Thu, 02 Nov 2006 18:40:34 -0800
Message-ID: <7vhcxhl0bh.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
	<7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
	<200611022017.31351.jnareb@gmail.com>
	<200611022023.12246.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 03:04:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30778>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp4U-0003wO-Pf for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752975AbWKCCkj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbWKCCkj
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:39 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37551 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1752975AbWKCCkf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024035.WDEU6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gD1V00R1kojtg0000000 Thu, 02 Nov 2006
 21:40:14 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> From 4d86b34d49dd1f18da465952be8306348fef5150 Mon Sep 17 00:00:00 2001
> From: Jakub Narebski <jnareb@gmail.com>
> Date: Thu, 2 Nov 2006 20:14:15 +0100
> Subject: [PATCH 2/2] gitweb: Use git-for-each-ref to generate list of heads and/or tags

The first line should not be in the body of the message.

> CHANGES IN OUTPUT: Before, if ref in refs/tags was tag pointing to
> commit we used committer epoch as epoch for ref, and used tagger epoch
> as epoch only for tag pointing to object of other type. If ref in
> refs/tags was commit, we used committer epoch as epoch for ref (see
> parse_ref; we sorted in gitweb by 'epoch' field).

I think that behaviour was inconsistent and just silly.  Using
creatordate consistently is better so if the code generates what
the commit log claims to, I think that is fine (I haven't looked
at it deeply yet).

Thanks.  Will apply.

