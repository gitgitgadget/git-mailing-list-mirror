X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Fri, 03 Nov 2006 03:58:17 -0800
Message-ID: <7vodro91ye.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610301958.23334.jnareb@gmail.com>
	<7vlkmtgd3o.fsf@assigned-by-dhcp.cox.net>
	<200611031159.02065.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 11:58:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031159.02065.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 3 Nov 2006 11:59:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30832>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxgk-0006GE-LA for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751151AbWKCL6T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWKCL6T
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:58:19 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37327 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1751151AbWKCL6S
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:58:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103115818.YUFC18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 06:58:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iByN1V00N1kojtg0000000 Fri, 03 Nov 2006
 06:58:23 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps it should be "LF ('\n') and TAB ('\t')".

Official terminology seems to call \t "HT", but my feeling is
that we would not need that comment there.

> Or
> 	return $es{$seq} if exists $es{$seq};

Although gitweb is full of that syntax, I personally do not like
it very much.  It is really hard to read when you are trying to
skim through the code quickly.  You would have to say "why
return it?  ah -- only when it exists, then it makes sense",
which is a hiccup that disrupts the thought process.
