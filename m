X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 06:49:04 -0500
Message-ID: <A76C0FA3-1649-409B-B0D4-C22865622C1F@silverinsanity.com>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 11:49:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612201008.49045.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34918>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwzwc-0006lK-8V for gcvg-git@gmane.org; Wed, 20 Dec
 2006 12:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754434AbWLTLtH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 06:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbWLTLtH
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 06:49:07 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45218 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1754434AbWLTLtG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 06:49:06 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 178971FFC02B; Wed, 20 Dec 2006
 11:49:05 +0000 (UTC)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


On Dec 20, 2006, at 5:08 AM, Andy Parkins wrote:

> Hello,
>
> Help...
>
>> +if [ -f .gitmodules ]; then
>
> This doesn't work because git-commit is not necessarily in the root  
> of the
> working tree.  How do I safely get that root?  While ${GIT_DIR}/..  
> would work
> it is not guaranteed.

The way to do that seems to be "git rev-parse --git-dir".  I'm not  
sure why it's not just "git --git-dir" or similar (probably just  
historical reasons), but there you go.

