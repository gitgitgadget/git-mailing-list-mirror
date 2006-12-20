X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit
 hook
Date: Wed, 20 Dec 2006 13:35:34 +0100
Message-ID: <45892E16.2040301@op5.se>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com> <A76C0FA3-1649-409B-B0D4-C22865622C1F@silverinsanity.com> <emb8h2$io4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 12:35:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <emb8h2$io4$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34923>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx0fb-0006K9-Lk for gcvg-git@gmane.org; Wed, 20 Dec
 2006 13:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754806AbWLTMfg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 07:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbWLTMfg
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 07:35:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60737 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1754806AbWLTMff (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 07:35:35 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 96E446BCD8; Wed, 20 Dec 2006 13:35:34 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Brian Gernhardt wrote:
> 
>> On Dec 20, 2006, at 5:08 AM, Andy Parkins wrote:
>>
>>> Hello,
>>>
>>> Help...
>>>
>>>> +if [ -f .gitmodules ]; then
>>> This doesn't work because git-commit is not necessarily in the root  
>>> of the
>>> working tree.  How do I safely get that root?  While ${GIT_DIR}/..  
>>> would work
>>> it is not guaranteed.
>> The way to do that seems to be "git rev-parse --git-dir".  I'm not  
>> sure why it's not just "git --git-dir" or similar (probably just  
>> historical reasons), but there you go.
> 
> Because it is "git --git-dir=<PATH>" to set it (probably).
> Although it is not insurmountable difficulity...

AFAIR, the discussions long ago went along the lines of "if no argument 
is passed to any of the --*-dir options, print out the current value". 
If "git --git-dir" doesn't print the directory name of the .git 
directory inside the repo you're currently in, I'd consider it a bug.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
