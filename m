X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 19:06:17 +0100
Message-ID: <45706F19.6090609@op5.se>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se> <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org> <457061A7.2000102@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 18:06:57 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <457061A7.2000102@b-i-t.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32952>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqCmE-0004oG-T7 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 19:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759315AbWLASGU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 13:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759319AbWLASGU
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 13:06:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:34208 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1759315AbWLASGT (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 13:06:19 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 76D0B6BCC5; Fri,  1 Dec 2006 19:06:18 +0100 (CET)
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org

sf wrote:
> 
> That is one of the points Martin Waitz and I are discussing.
> 
> If I understand you correctly you cannot make any changes to the 
> submodules code _in the supermodule's repository_, no bugfixes, no 
> extensions, no adaptions, nothing. Do you mean that?
> 
> That would be a third alternative. In my opinion the usefulness of 
> submodules would be unnecessarily restricted if it comes to the choice 
> of either using the code from upstream as is or do not use submodules at 
> all. What is the point of the restriction?
> 

That depends on your definition of submodule. In my eyes, a submodule is 
a separate repo that can be committed to separately (and generally also 
built separately), although it's usually built into something else. I'm 
imagining most submodules will contain only library code and its testing 
routines.

Insofar as I've envisioned submodules, it's a separate git repo where 
you simply record a certain snapshot of the sub-repo with a commit in 
the super-module, like so:

$ git commit ssl-functions/*.[ch] openssl -m "Upgraded openssl with 
necessary changes to core code"

(yes, I know it's horrid to use -m to commit, and I daily advocate 
against it where I work, but you get the idea, I'm sure)

Isn't this how it's supposed to work? Enlighten me, and please remember 
that I'm drunk atm, so make it obvious ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
