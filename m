X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sat, 2 Dec 2006 13:33:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021330070.3476@woody.osdl.org>
References: <200612022059.kB2Kx565009646@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 21:34:26 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612022059.kB2Kx565009646@laptop13.inf.utfsm.cl>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33058>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcUu-0000PV-RR for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162505AbWLBVeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162506AbWLBVeJ
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:34:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39866 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162505AbWLBVeG (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:34:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2LXvjQ025768
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 13:33:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2LXuM6029622; Sat, 2 Dec
 2006 13:33:56 -0800
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Horst H. von Brand wrote:
> 
> The command should never even see the '*' here. Globbing is handled
> (uniformly) by the shell. Don't loose that.

Git supprts an extra level of globbing.

In the kernel tree, try the difference between these two command lines:

	git ls-files fs/*.c
	
	git ls-files 'fs/*.c'

and enjoy.

It's _very_ useful for a number of programs (including "git add") but I 
find it _especially_ useful for something like

	git grep jiffies -- '*.h'

where the git-level globbign is important.

Not all git programs do that globbing, but many do.

