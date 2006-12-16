X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 11:23:52 -0800
Message-ID: <7vmz5nejav.fsf@assigned-by-dhcp.cox.net>
References: <458437E0.1050501@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 19:24:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <458437E0.1050501@midwinter.com> (Steven Grimm's message of "Sat,
	16 Dec 2006 10:16:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34635>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvf8k-0004Vr-Qg for gcvg-git@gmane.org; Sat, 16 Dec
 2006 20:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161406AbWLPTXy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 14:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbWLPTXy
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 14:23:54 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:46773 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161406AbWLPTXx (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 14:23:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216192352.YMQK20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 14:23:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zXQ41V00a1kojtg0000000; Sat, 16 Dec 2006
 14:24:05 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> $ mkdir dir
> $ echo foo > dir/file
> $ git add .
> ...
> Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
> create mode 100644 dir/file
> $ mv dir dir.real
> $ ln -s dir.real dir
> $ git add .
> fatal: unable to add dir to index

You didn't tell the index to remove dir/file.  You cannot have
dir and dir/file at the same time.
