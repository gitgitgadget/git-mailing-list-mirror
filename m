X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Wed, 15 Nov 2006 10:29:02 -0800
Message-ID: <7vzmasmump.fsf@assigned-by-dhcp.cox.net>
References: <FE74AC4E0A23124DA52B99F17F44159701A11D6C@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 18:29:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701A11D6C@PA-EXCH03.vmware.com>
	(Bhavesh Davda's message of "Wed, 15 Nov 2006 10:08:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31462>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPW3-0005zY-2W for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030806AbWKOS3T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030817AbWKOS3T
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:29:19 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37023 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1030806AbWKOS3S
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:29:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115182918.QEGU4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 13:29:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n6VQ1V00B1kojtg0000000; Wed, 15 Nov 2006
 13:29:24 -0500
To: "Bhavesh Davda" <bhavesh@vmware.com>
Sender: git-owner@vger.kernel.org

"Bhavesh Davda" <bhavesh@vmware.com> writes:

> Attached is my attempt at the same command "make prefix=/var/tmp/ggg clean
> all install"
>
> make install failes for the templates directory, leading to the entire make
> install failing:
>
> make -C templates DESTDIR='' install
> make[1]: Entering directory `/VMware/kernel/git/git/templates'
> : no custom templates yet
> install -d -m755 '/var/tmp/ggg/share/git-core/templates/'
> (cd blt && tar cf - .) | \
> (cd '/var/tmp/ggg/share/git-core/templates/' && tar xf -)
> tar: This does not look like a tar archive
> tar: Skipping to next header
> tar: Archive contains obsolescent base-64 headers
> tar: Error exit delayed from previous errors

I have a feeling that you have CDPATH exported to the
environment, which is a braindamage.  It is a fine usability
helper for interactive shells so I do not have problem with
people setting that in shell as shell variables, though.

In other words, never do "export CDPATH=..." nor "export CDPATH".
