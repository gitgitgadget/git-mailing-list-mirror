X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 03:30:03 +0100
Message-ID: <455BCD2B.6060603@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl> <7vhcx0gnbq.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 02:30:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vhcx0gnbq.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31544>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkX13-0001Yl-SO for gcvg-git@gmane.org; Thu, 16 Nov
 2006 03:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162223AbWKPCaI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 21:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162218AbWKPCaI
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 21:30:08 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:36614 "EHLO
 smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP id S1162223AbWKPCaG
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 21:30:06 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAG2U1fB056996; Thu, 16 Nov 2006 03:30:01 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
>> FWIW, I regularly mess up with the differences between fetching,
>> pulling and merging.  In particular, having to do a two step process
>> to get remote changes in,
>>
>>   git pull url-to-server master:master
>>      ..error message about not being a fast-forward..
>>
>>   git pull --update-head-ok url-to-server master:master
>>      ..still an error message about update not being a fast-forward..
>>
>>       (sigh)
> 
> Sigh indeed.
> 
> Why don't you do the simple and obvious
> 
> 	git pull url master

It is not all evident from the git-pull man-page that this is the 
obvious and most common usage.

> or "git pull url" if you already know the master is the branch
> you are interested in.

Because I usually replace verbose commands with shortcuts only when I 
understand exactly what the shortcut is.

To me it's very unlogical that

   master:current-branch

doesn't work, but

   master:

does work, and does what I'd expect

   master:current-branch

to do. Interestingly, doing

   pull ..url.. master:HEAD

also doesn't merge into the current branch, but rather creates a bogus 
refs/heads/HEAD

I use the remote:local syntax, because I started using GIT in scripted 
compiles from copied branches of remote repositories. There the explicit 
remote:local statements are necessary because there is no default branch.

-- 
