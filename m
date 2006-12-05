X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 11:42:47 +0100
Message-ID: <45754D27.9070701@op5.se>
References: <20061130170625.GH18810@admingilde.org>	 <4570AF8F.1000801@stephan-feder.de>	 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>	 <4570BFA4.8070903@stephan-feder.de>	 <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>	 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>	 <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>	 <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>	 <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com>	 <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org> <e7bda7770612041336s73e677ebh758b030f9f75c1d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:42:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf-gmane@stephan-feder.de,
	sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <e7bda7770612041336s73e677ebh758b030f9f75c1d8@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33336>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrXlE-00028k-GL for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937498AbWLEKmu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937499AbWLEKmu
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:42:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57057 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937498AbWLEKmt (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 05:42:49 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CC7E06BCBE; Tue,  5 Dec 2006 11:42:47 +0100 (CET)
To: Torgil Svensson <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org

Torgil Svensson wrote:
> On 12/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> So yeah, it's a bit hacky, but for the reasons I've tried to outline, I
>> actually think that users _want_ hacky. Exactly because "deep 
>> integration"
>> ends up having so many _bad_ features, so it's better to have a thin and
>> simple layer that you can actually see past if you want to.
> 
> Thin and simple sounds very good. Let's try it with an example. Lets
> say we have one apllication App1 and three librarys (Lib1, Lib2, Lib3)
> with the following dependency-graph:
> 
>        App1
>          /\
>         /  \
>   Lib1   Lib2
>       \     /
>        \   /
>        Lib3 (don't really needed for this example but looks nice)
> 
> All components can be used individually and have their own upstream,
> maintainer etc.
> 
> To compile App1 however, I need some files from both Lib1 and Lib2
> specifying it's API. To satisfy these dependencies, It sounds
> reasonable to link Lib2 and Lib3 submodules from App1. In your
> concept, can I construct a modules file to fetch the API files and
> their history without checking out the whole Lib1 and Lib2 source?

I think not. Then it wouldn't be a submodule anymore, but just some 
random sources from an upstream project. Not that it's an uncommon 
workflow or anything, but it's sort of akin to just importing the SHA1 
implementation (a few source-files with no real interest in the history 
of those source-files) from openssl into a different project rather than 
actually using the entire openssl lib (which would be nice to have as a 
submodule).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
