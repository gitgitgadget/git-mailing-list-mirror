X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: git fetch slow as molasses due to tag downloading
Date: Thu, 14 Dec 2006 16:40:14 +0100
Message-ID: <elrr8j$a02$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:41:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34352>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusi1-0007Sa-QC for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932810AbWLNPkp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWLNPkp
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:40:45 -0500
Received: from main.gmane.org ([80.91.229.2]:48106 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932810AbWLNPkl
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 10:40:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gush1-0002rm-5k for git@vger.kernel.org; Thu, 14 Dec 2006 16:40:19 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 16:40:19 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006 16:40:19
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hello,

just upgraded our autobuilder from 1.4.3 to 1.4.4.2.

Now, our standard download command comes to a complete halt.  Judging
from the "ps -ef" apparently, it does 

   git-show-ref --verify --quiet -- [TAG]

This is done for every one of the 1500 tags that are in my repository. 
At approx 20 tags per second this takes an awful lot of time. 

1. Is this necessary? 

2. Is this efficient?  Wouldn't doing all tags in a single git-show-ref
invocation be potentially quicker?


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
