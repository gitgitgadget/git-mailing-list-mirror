X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 10:23:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121021270.3535@woody.osdl.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 18:23:57 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34119>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCIF-0008L4-5X for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932290AbWLLSXs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWLLSXs
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:23:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53560 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932290AbWLLSXr
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 13:23:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBCINeID008856
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 10:23:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBCINa3a010914; Tue, 12 Dec
 2006 10:23:38 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> > rsync generally _works_ apart from the slight race-condition issue, 
> 
> ... and git would probably change the pack structure (i.e. which objects 
> are in which packs, or even loose) which would be too bad for all those 
> HTTP leechers ...

Well, as it is, I end up repacking my git archives on kernel.org every two 
weeks or so anyway, so anybody who uses stupid protocols (rsync or http) 
will end up downloading everything anew anyway.

And kernel.org will probably start doing automatic repacking, since the 
current situation just means that some people don't repack on their own, 
and have tens of thousands of loose objects.

You really don't want to use the non-native protocols unless you have to, 
or for projects that don't change.

