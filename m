X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:31:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151329420.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611152131.14883.Josef.Weidendorfer@gmx.de>
 <20061115203517.GN7201@pasky.or.cz> <200611152212.35978.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 21:32:17 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611152212.35978.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31503>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSMc-0005D4-Hz for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161729AbWKOVcH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161730AbWKOVcH
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:32:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39819 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161729AbWKOVcE (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:32:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFLVooZ031844
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 13:31:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFLVnD2030646; Wed, 15 Nov
 2006 13:31:49 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Josef Weidendorfer wrote:
> 
> I am not really opposed to pull doing a merge. It only should work in
> a useful way: ie. only do the merge of updated origin branch when
> current branch is master (given "Pull: master:origin").

I absolutely agree.

We should _only_ use the default head when pulling from the default head 
("master"). If we don't pull from within the default branch, we should 
either require an explicit head _or_ we should require that an explicit 
mapping has been set up in .git/config or in .git/remotes/..

So doing a "git pull" from any other branch than "master" should probably 
by default say "which branch do you want to pull from today"?

