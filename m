X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Remove extra "/" in path names for git_get_project_list
Date: Thu, 02 Nov 2006 21:59:29 -0800
Message-ID: <7vslh1jcji.fsf@assigned-by-dhcp.cox.net>
References: <454ACF91.50601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 05:59:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454ACF91.50601@gmail.com> (Aneesh Kumar K. V.'s message of "Fri,
	03 Nov 2006 10:41:45 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30785>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfs5b-0004cC-3X for gcvg-git@gmane.org; Fri, 03 Nov
 2006 06:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753128AbWKCF7b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 00:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbWKCF7b
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 00:59:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6835 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753128AbWKCF7a
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 00:59:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103055929.UZXV18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 00:59:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i5za1V00A1kojtg0000000 Fri, 03 Nov 2006
 00:59:34 -0500
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> Without this change we get a wrong $pfxlen value and the check_export_ok()
> checks with with a wrong directory name. Without this patch the below
> $projects_list fails with gitweb
>
> $projects_list = "/tmp/a/b/";
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

Hmph.  Doesn't this break $projects_list = "/", I wonder?

> +		# remove the trailing "/"
> +		$dir =~ s!/+$!!;

