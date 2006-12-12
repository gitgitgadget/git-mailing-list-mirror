X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow building GIT in a different directory from the source directory
Date: Tue, 12 Dec 2006 01:03:08 -0800
Message-ID: <7vbqm9xz8z.fsf@assigned-by-dhcp.cox.net>
References: <eljo2u$pnq$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 09:03:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eljo2u$pnq$2@sea.gmane.org> (Han-Wen Nienhuys's message of "Mon,
	11 Dec 2006 14:56:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34070>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu3Xj-0007yn-9f for gcvg-git@gmane.org; Tue, 12 Dec
 2006 10:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750994AbWLLJDL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 04:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWLLJDL
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 04:03:11 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52071 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750997AbWLLJDJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 04:03:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212090309.VVRB7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 04:03:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xl3L1V0091kojtg0000000; Tue, 12 Dec 2006
 04:03:20 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> GIT can now be built in a separate builddirectory. This is done as
> follows:
>
>   mkdir build
>   cd build
>   $my_git_dir/configure
>   make

Somehow making this depend on the use of configure feels wrong,
since we tried to keep that config.mak.gen built by configure
strictly optional.  In other words, I think the result of your
patch should be buildable with or without ./configure in a
separate directory if we are going to do this.

Care to explain why it is too cumbersome to handle without
./configure magic?
