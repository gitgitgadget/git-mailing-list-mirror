X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 14:40:31 -0800
Message-ID: <458475DF.6040809@midwinter.com>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com> <7vodq3cxl7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 22:40:37 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <7vodq3cxl7.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34649>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GviCm-0005Pj-TC for gcvg-git@gmane.org; Sat, 16 Dec
 2006 23:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422709AbWLPWkU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 17:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWLPWkU
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 17:40:20 -0500
Received: from tater.midwinter.com ([216.32.86.90]:38398 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1422709AbWLPWkT
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 17:40:19 -0500
Received: (qmail 7369 invoked from network); 16 Dec 2006 22:40:18 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 16 Dec 2006 22:40:18
 -0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Maybe "git add" should internally use ADD_CACHE_OK_TO_REPLACE
> (or error out and have an option to enable it)?
>   

That sounds right to me. Maybe there are cases where this isn't true, 
but -- especially given the recent move toward making "git add" the 
suggested porcelain command for updating the index -- I want "git add 
foo" to stick the current contents of "foo" into the index, regardless 
of what might have been there under that name previously. I'll grant 
that it's not a super-common use case to rename or delete a directory 
and put a file in its place, but it's IMO not an unreasonable thing to 
want git to track without undue hassle, given that it claims to support 
renames. I'm fine with having to supply an extra option to get that 
automatic behavior.

But barring that, the patch would at least have saved me a lot of 
head-scratching.

-Steve
