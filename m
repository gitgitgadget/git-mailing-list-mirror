X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 03 Nov 2006 13:44:29 -0800
Message-ID: <7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<7vzmbds4pw.fsf@assigned-by-dhcp.cox.net>
	<7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
	<200611031719.13073.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 21:45:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031719.13073.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 3 Nov 2006 17:19:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30888>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg6q4-00025i-1I for gcvg-git@gmane.org; Fri, 03 Nov
 2006 22:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753556AbWKCVob (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWKCVob
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 16:44:31 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20722 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1753556AbWKCVoa
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 16:44:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103214430.LARA22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 16:44:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iMk81V00E1kojtg0000000 Fri, 03 Nov 2006
 16:44:09 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> # quote unsafe characters and escape filename to HTML
> sub esc_path {
> 	my $str = shift;
> 	$str = esc_html($str);
> 	$str =~ s!([[:cntrl:]])!sprintf('<span class="cntrl">&#%04d;</span>', 9216+ord($1))!eg;
> 	return $str;
> }
>
> with perhaps the following CSS
>
> span.cntrl {
> 	border: dashed #aaaaaa;
> 	border-width: 1px;
> 	padding: 0px 2px 0px 2px;
> 	margin:  0px 2px 0px 2px;
> }
>
> What do you think of it?

Probably "# quote unsafe characters" is not what it does yet (it
just quotes controls currently and nothing else), but we have to
start somewhere and I think this is a good start.

