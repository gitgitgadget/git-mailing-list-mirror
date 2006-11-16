X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 01:23:17 +0100
Message-ID: <455BAF75.90506@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org>	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>	<7vu011qnl6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611151000460.2591@xanadu.home> <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 00:23:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31532>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkV2K-00009g-7J for gcvg-git@gmane.org; Thu, 16 Nov
 2006 01:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162104AbWKPAXV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 19:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162109AbWKPAXV
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 19:23:21 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:37386 "EHLO
 smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S1162104AbWKPAXU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 19:23:20 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAG0NF28037005; Thu, 16 Nov 2006 01:23:15 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> I still think in the long run you would be better off giving
> separate names to Porcelains because I am sure you are going to
> find the next command to "fix", you cannot suddenly change the

 > "ig pull", you can dismiss all the broken git-x Porcelain-ish by
 > saying "Oh, git-x user-level commands had inconsistent semantics
 > and broken UI so do not use them anymore -- they are still there
 > only to help old timers transition.  The user level commands are
 > now called ig-x and ig stands for improved git".


I think it would be good if there were different commands for 
porcelains. Not because fixing the current commands is too much work, 
but rather because it would clarify the structure of git.  GIT is a 
3-layer approach:

  - index+workdir+refs over
  - a DAG of commits over
  - a file based SHA1 database

at first sight it is difficult to tell for each command on which layer 
it operates. It would help understanding GIT a lot if each layer got 
it's own command, eg.

   git - sha1 content db
   gic - sequences of commits
   giu - UI

(Of course, these names are completely silly, but you get the idea)


> I think get/put is much better than suddenly changing what pull
> means and is shorter to type than x-load; I am Ok with them.
> Although I think these words are tainted by SCCS, I do not think
> anybody cares.

they're also tainted  by darcs, but that's a minor problem, I suppose.


-- 
