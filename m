X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 12:41:33 +0000
Message-ID: <20061219124133.GB16429@localhost>
References: <20061218224327.GG16029@localhost> <200612191214.58474.jnareb@gmail.com> <20061219120854.GA16429@localhost> <200612191328.08928.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 12:42:08 +0000 (UTC)
Cc: Robert Fitzsimons <robfitz@273k.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612191328.08928.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34829>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GweI0-0004gm-S2 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 13:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932818AbWLSMlq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 07:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWLSMlq
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 07:41:46 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:43093 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932817AbWLSMlp (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 07:41:45 -0500
Received: from [212.2.165.238] (helo=localhost) by igraine.blacknight.ie with
 esmtp (Exim 4.60) (envelope-from <robfitz@273k.net>) id 1GweHP-0006at-AY;
 Tue, 19 Dec 2006 12:41:11 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

> Junio usually puts such comments in brackets (I don't know if it is
> always used, i.e. if it is some 'convention'), e.g.:
> 
>   Also perform the same "..." link logic to the forks list.
> 
>   [rf: Modified patch from Jakub to to apply cleanly to master]
> 
> or something like that. Just a nitpick.

No problem, I tried to find the approreati convention.

> > -	my @taglist  = git_get_tags_list(15);
> > -	my @headlist = git_get_heads_list(15);
> > +	# we need to request one more than 16 (0..15) to check if those 16 are all
> > +	my @taglist  = git_get_tags_list(16);
> > +	my @headlist = git_get_heads_list(16);
> 
> It needs to be 17, not 16, otherwise we never would get "...". By default
> we show _16_ items, from 0 to 15 inclusive, so we must get _17_ items
> to check if there are more than 16.

That was a copy error on my part.  Though looking at the code
git_get_tags_list and git_get_heads_list already adds one to the limit
value, so if you pass in 17 they will return 18 items.

Robert
