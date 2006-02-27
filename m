From: Andreas Ericsson <ae@op5.se>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 16:28:04 +0100
Message-ID: <44031A84.1080704@op5.se>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 16:31:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkID-0008H5-L0
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 16:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWB0P2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 10:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWB0P2G
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 10:28:06 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:18354 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751450AbWB0P2F
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 10:28:05 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5BEFE6BD10; Mon, 27 Feb 2006 16:28:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16853>

Aubrey wrote:
> Hi all,
> 
> I'm a newbie of git. I have a question about how to generate a patch by git.
> I want to make a patch againt git repository HEAD. So in my local
> tree, I do the command:
> 
> git diff -p > my.patch
> 
> The file my.patch is generated. But the unchanged files information is
> also included in the patch file. It should be quiet.
> Was I wrong to use git by this way?
> 
> Thanks for your hints.
> 

The current best practice involves these steps:
1. Create a topic branch (git checkout -b feature-name)
2. Apply your changes and commit them, preferrably in small and isolated 
steps, making sure it compiles after each change.
3. Run "git format-patch origin".

This will result in one or more commit-patches, which contains your 
author info, the commit-messages you wrote, the commit-time and all 
other such info and ofcourse the diff in unified git format. You can 
send those patches on using "git send-email" or apply them using "git am 
-k 00*.txt".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
