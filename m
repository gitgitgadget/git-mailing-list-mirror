X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to ignore merge conflicts?
Date: Mon, 30 Oct 2006 12:29:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610301223021.25218@g5.osdl.org>
References: <200610301448.38222.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 20:38:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610301448.38222.len.brown@intel.com>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30520>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gedlw-0002Nw-Eo for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751978AbWJ3UaL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWJ3UaL
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:30:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62882 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751978AbWJ3UaK (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:30:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9UKTcPo022451
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 30
 Oct 2006 12:29:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9UKTbrp001770; Mon, 30 Oct
 2006 12:29:37 -0800
To: Len Brown <lenb@kernel.org>
Sender: git-owner@vger.kernel.org



On Mon, 30 Oct 2006, Len Brown wrote:
>
> Sometimes when a multiple-file merge give conflicts, I don't want to edit
> one of the resulting <<<<<=====>>>>> files.
> Instead, I just want to choose the version of that particular file that
> existed in one of the two merged branches and commit that along with
> the rest of the merge.
> 
> How to do this?

Well, if you promise not to do what has happened several times before in 
people who maintained their own CVS trees, for example (which is to just 
ignore all merge problems, and force _their_ version, even though the 
reason for the merge problem was that somebody else had fixed a bug, that 
was now unfixed by the "merge"), here's the trivial way to do it:

	git checkout HEAD the/file/you/wanted.c

(or, if you want to take it from the source you are merging _from_, just 
use MERGE_HEAD instead of HEAD).

And you're done.

