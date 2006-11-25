X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Calling all bash completion experts..
Date: Sat, 25 Nov 2006 11:08:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611251106250.6991@woody.osdl.org>
References: <Pine.LNX.4.64.0611230935520.27596@woody.osdl.org>
 <20061125071351.GE4528@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 19:09:14 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061125071351.GE4528@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32300>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go2tf-0002ge-SV for gcvg-git@gmane.org; Sat, 25 Nov
 2006 20:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966365AbWKYTJE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966431AbWKYTJE
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 14:09:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:18897 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966365AbWKYTJD (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 14:09:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAPJ8Tix029465
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 25
 Nov 2006 11:08:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAPJ8SLI009920; Sat, 25 Nov
 2006 11:08:28 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Sat, 25 Nov 2006, Shawn Pearce wrote:
> 
> I added the nospace option because of the completion for fetch/push,
> cat-file, diff-tree and ls-tree.
> 
> The problem is the file completion for e.g. cat-file.  We don't
> want a space added after we complete a directory name, so you can
> complete further, e.g.:
> 
>   git cat-file -p ma<tab>con<tab>comp<tab>git-com<tab>

But that's how directory completion _always_ works. Completion doesn't add 
spaces to directories anyway, it adds a "/".

The branch-name thing is well-taken: you don't want to add a space after a 
branch-name, although neither do you want to add a ":" by default.

So "nospace" after a branch (or tag) name sounds sane, but nowhere else 
that I can see.

