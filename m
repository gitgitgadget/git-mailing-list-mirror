X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: globs in partial checkout?
Date: Sun, 10 Dec 2006 12:13:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101209370.12500@woody.osdl.org>
References: <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
 <20061210200029.GF1708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 20:14:11 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061210200029.GF1708@mellanox.co.il>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33921>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtV3o-00060d-OM for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762471AbWLJUOF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762476AbWLJUOF
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:14:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57828 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762471AbWLJUOD
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 15:14:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAKDhID018842
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 12:13:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAKDg7V001958; Sun, 10 Dec
 2006 12:13:43 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Michael S. Tsirkin wrote:
>
> I'm trying to checkout some files after doing "clone -n".
> Should using globs there work? It doesn't:

Not historically at all. "git checkout" needed exact filenames in older 
versions.

However, since about 1.4.4.1 or so, it now does the same filename 
expansion as "git add" etc does, which means that you can give it a 
directory name and it will check out everything under that directory, or 
you can give it a pattern, and it should glob it. But it sounds like you 
may have a slightly older version of git (the pathname matching really is 
fairly recent).

