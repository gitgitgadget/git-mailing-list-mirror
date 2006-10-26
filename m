X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Check git base URLs before generating URL from it
Date: Thu, 26 Oct 2006 10:21:53 -0700
Message-ID: <7vr6wvkn66.fsf@assigned-by-dhcp.cox.net>
References: <200610261226.44960.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 17:22:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30245>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8vZ-00030M-Bi for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423625AbWJZRVz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423627AbWJZRVz
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:21:55 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12184 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1423625AbWJZRVz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:21:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026172154.GCMS22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 13:21:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id f5Mc1V00d1kojtg0000000 Thu, 26 Oct 2006
 13:21:37 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Wouldn't this be simpler and more to the point, I wonder?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5a81b8f..aceaeb7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -80,7 +80,7 @@ our $strict_export = "++GITWEB_STRICT_EX
 
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
-our @git_base_url_list = ("++GITWEB_BASE_URL++");
+our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
