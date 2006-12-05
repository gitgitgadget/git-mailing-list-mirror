X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 23:07:35 +0100
Message-ID: <4575EDA7.2090705@stephan-feder.de>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>  <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>  <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>  <4570BFA4.8070903@stephan-feder.de> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com> <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org> <Pine.LNX.4.64.0612042053080.20138@iabervon.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 22:08:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 37
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157024137.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0612042053080.20138@iabervon.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33376>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GriSi-00043K-A4 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759310AbWLEWIL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760217AbWLEWIL
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:08:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35671 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760218AbWLEWIJ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 17:08:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GriSC-0007iL-Ua for git@vger.kernel.org; Tue, 05 Dec 2006 23:07:56 +0100
Received: from ip-213157024137.dialin.heagmedianet.de ([213.157.24.137]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 23:07:56 +0100
Received: from sf-gmane by ip-213157024137.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05
 Dec 2006 23:07:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Daniel Barkalow wrote:
> On Sat, 2 Dec 2006, Linus Torvalds wrote:
> 
>> So that's where I come from. And maybe I'm totally wrong. I'd like to hear 
>> what people who actually _use_ submodules think.
> 
> I think you'd rather hear from people who _would_ use submodules; I've 
> worked on a number of projects that would have benefitted from that 
> general functionality, but nobody trusted the implementation enough to 
> actually use it.
> 
> At my work, we're doing a bunch of stuff with microcontrollers. We've got 
> about a dozen different boards with microcontrollers, and each of them has 
> different firmware. We also have a bunch of code that can go on any of the 
> boards.
> 
> The way things are organized currently is that each board has its own 
> project, and there's a "common-micro" project with the common code. This 
> sort of works, but it means that when you change things in common-micro, 
> you never know what effect this will have on boards other than the one 
> you're actually working on. What I'd like to have is that each project has 
> a "common-micro" subdirectory, and changes to each of these can be merged 
> into each other, but that doesn't happen automaticly, and each board's 
> revisions include the common-micro revision they were created with.

Our setup and requirements at work are exactly the same: We have a few
main projects that are developed independently and we have one "helper"
project for code that is general enough to be reused. So work on the
helper project is only done while working on one of the main projects.
When we switch to another main project we integrate the changes to the
"helper" project.

That's the theory, at least.

Regards

Stephan
