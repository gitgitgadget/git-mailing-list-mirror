X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-for-each-refs broken for tags
Date: Fri, 17 Nov 2006 20:45:11 -0800
Message-ID: <7v4psxfjmw.fsf@assigned-by-dhcp.cox.net>
References: <20061118025652.2970.10571.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 04:45:28 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118025652.2970.10571.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 18 Nov 2006 03:56:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31753>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlI4s-0003UH-CZ for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755975AbWKREpO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755983AbWKREpO
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:45:14 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38852 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1755975AbWKREpM
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 23:45:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118044512.FEYV27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 23:45:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o4lJ1V00h1kojtg0000000; Fri, 17 Nov 2006
 23:45:19 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Thanks for noticing.

This is not like rev-list where we walk all over the map of
ancestry graph, so it might be a simpler and better to keep
the buffer than to keep duplicate copies of pieces.


