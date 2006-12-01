X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 00:49:56 +0100
Message-ID: <4570BFA4.8070903@stephan-feder.de>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:50:16 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32992>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqI8q-0000O3-Uf for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161748AbWLAXuA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967715AbWLAXuA
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:50:00 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:56794 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S967711AbWLAXt7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:49:59 -0500
Received: (qmail 31685 invoked by uid 1011); 1 Dec 2006 23:49:58 -0000
Received: from sf-gmane@stephan-feder.de by mail1 by uid 1003 with
 qmail-scanner-1.22  (ExcuBAtor: 1.0.2. 
 Clear:RC:1(213.157.24.137):SA:0(0.0/5.0):.  Processed in 0.28325 secs); 01
 Dec 2006 23:49:58 -0000
Received: from unknown (HELO mx.stephan-feder.de) (213.157.24.137) by
 mail.medianet-world.de with SMTP; 1 Dec 2006 23:49:58 -0000
Received: from [192.168.3.69] (unknown [192.168.0.2]) by mx.stephan-feder.de
 (Postfix) with ESMTP id 2593688B01; Sat,  2 Dec 2006 00:49:57 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 1 Dec 2006, sf wrote:
>> Linus Torvalds wrote:
>> ...
>>> In contrast, a submodule that we don't fetch is an all-or-nothing 
>>> situation: we simply don't have the data at all, and it's really a matter 
>>> of simply not recursing into that submodule at all - much more like not 
>>> checking out a particular part of the tree.
>> If you do not want to fetch all of the supermodule then do not fetch the
>> supermodule.
> 
> So why do you want to limit it? There's absolutely no cost to saying "I 
> want to see all the common shared infrastructure, but I'm actually only 
> interested in this one submodule that I work with".

If you need a common infrastructure to be able to work with the
submodule, then the submodule is not independent of of the supermodule.
I see a contradiction in your requirements.

> Also, anybody who works on just the build infrastructure simply may not 
> care about all the submodules. The submodules may add up to hundreds of 
> gigs of stuff. Not everybody wants them. But you may still want to get the 
> common build infrastructure.

See above.

> In other words, your "all or nothing" approach is
>  (a) not friendly
> and
>  (b) has no real advantages anyway, since modules have to be independent 
>      enough that you _can_ split them off for other reasons anyway.
> 
> So forcing that "you have to take everything" mentality onyl has 
> negatives, and no positives. Why do it?

(There have been lots of use cases for shallow clones but for a long
time git did not support them).

If you can extend this partial fetch feature to the non-subproject case
I would agree with your reasoning. What makes the subprojects so special
in this regard. Do I have to turn a plain tree into a subproject to be
able to ignore it? Once you can restrict fetches to parts of the
contents you get the ability to restrict fetches to the "common
infrastructure" and selected submodules for free.

Regards

Stephan
