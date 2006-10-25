X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: updating only changed files source directory?
Date: Wed, 25 Oct 2006 13:58:50 +0200
Message-ID: <453F517A.7060000@xs4all.nl>
References: <ehjqgf$ggb$1@sea.gmane.org> <Pine.LNX.4.64.0610241435420.9789@iabervon.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 11:58:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0610241435420.9789@iabervon.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30053>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GchP9-0005el-H9 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 13:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423327AbWJYL6k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 07:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423331AbWJYL6k
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 07:58:40 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:65030 "EHLO
 smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP id S1423327AbWJYL6j
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 07:58:39 -0400
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 k9PBwZXX066867; Wed, 25 Oct 2006 13:58:36 +0200 (CEST) (envelope-from
 hanwen@xs4all.nl)
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

Daniel Barkalow escreveu:
>> I'm just starting out with GIT.  Initially, I want to use experiment with
>> integrating it into our binary builder structure for LilyPond.
>>
>> The binary builder roughly does this:
>>
>>  1. get source code updates from a server to a single, local
>>     repository. This is currently a git repository that is that
>>     tracks our CVS server.
>>
>>  2. copy latest commit from a branch to separate source directory.
>>     This copy should only update files that changed.
>>
>>  3. Incrementally compile from that source directory
> 
> The terminology in the git world is, I think, a little different from what 
> you expect. We call the thing that contains all of the tracked information 
> (what you're calling the repository) the "object database"; what we call 

yes, you hit the nail on the head.

> referencing an external one. So you need a repository for each source 
> directory (because it keeps track of what commit is currently in the 
> source directory), but it doesn't need to have its own complete object 
> database, which is what you're trying to share between all of them.

OK. This makes sense; thanks for this pointer.

How can I set the object database?  I found GIT_OBJECT_DIRECTORY, but 
can I write a config file entry for that?

> built it in that directory. You fetch into the single bare repository 
> from upstream, and then pull into each source directory from the bare 
> repository; this will do the minimal update to the contents of the source 
> directory automatically.

yes, this works. Thanks!

-- 
