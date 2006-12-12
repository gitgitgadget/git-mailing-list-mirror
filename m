X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 21:41:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612112135360.6452@woody.osdl.org>
References: <200612112210.08327.andyparkins@gmail.com>
 <BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE> <7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
 <BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
 <Pine.LNX.4.64.0612111936240.6452@woody.osdl.org> <7vejr5zoqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 05:42:12 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vejr5zoqe.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34063>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu0P2-0004rY-Qz for gcvg-git@gmane.org; Tue, 12 Dec
 2006 06:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932066AbWLLFmG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 00:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWLLFmF
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 00:42:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45760 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751182AbWLLFmD
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 00:42:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBC5fwID031144
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 21:41:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBC5fv7P022659; Mon, 11 Dec
 2006 21:41:57 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Junio C Hamano wrote:
> 
> 	[color]
>         	diff = auto
>                 branch = auto
>                 # it begs "* = auto" entry perhaps...
> 	[color.diff]
>         	old = red
>                 new = green
> 	[color.branch]
>         	remote = purple

I wish you'd learn to use the proper syntax ;)

It would be

	[color "diff"]
		old = red
		new = green

and what's nice about it is that you can also do

	[color "diff"]
		auto
		old = red
		new = green

and the config file rules for booleans are such that a config variable 
without the "= val" part parses the same as "= true", so you can now do

	git repo-config --bool color.diff.auto

and it will say "true".

Now, I just think that would be a nice syntax.

Of course, for legacy reasons, and for people who rather than keeping the 
_color_ information together want to keep the _diff_ information together, 
we can/probably-should support both color.diff.* and diff.color.* formats.

