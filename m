X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Better symbolic link support in "tree" view
Date: Mon, 04 Dec 2006 17:08:33 -0800
Message-ID: <7vr6vfkv3i.fsf@assigned-by-dhcp.cox.net>
References: <1165256780505-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:08:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33276>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOnX-00058l-96 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967946AbWLEBIg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967948AbWLEBIg
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:08:36 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35444 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967946AbWLEBIe (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:08:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205010834.WKLF5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:08:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id up8k1V0051kojtg0000000; Mon, 04 Dec 2006
 20:08:44 -0500
To: Jakub Narebsmi <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebsmi <jnareb@gmail.com> writes:

> In "tree" view (git_print_tree_entry subroutine), add for symbolic
> links after file name " -> link_target", a la "ls -l".  Use
> git_get_link_target_html to escape target name and make it into
> hyperlink if possible.

I think " -> link_target" is fine, but I do not know if it is
useful (while I do not think it is wrong) to make the value that
would have been returned from readlink() into an href, even when
it points at something inside the same revision.

