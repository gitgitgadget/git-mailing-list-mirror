X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multi-project repos
Date: Fri, 17 Nov 2006 01:29:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611170048270.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz6r3tat.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 00:29:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz6r3tat.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31644>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkrbc-0000Me-E6 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424808AbWKQA3R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424812AbWKQA3R
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:29:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:19075 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1424808AbWKQA3Q (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:29:16 -0500
Received: (qmail invoked by alias); 17 Nov 2006 00:29:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp035) with SMTP; 17 Nov 2006 01:29:14 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Junio C Hamano wrote:

> I think the earlier write-up by Linus on magic HEADs would help 
> documenting FETCH_HEAD better.

I am not sure that documenting FETCH_HEAD better would help. As Han-Wen 
pointed out (and some colleagues of mine who would never subscribe to a 
mailing list), people do not read the manual, but rather try to wrap their 
heads around the inner workings from the interface. And FETCH_HEAD just 
does not meet _any_ expectation a sane (read: untainted) user might have.

While I'm at it: the problem I pointed out with -pull may annoy just me.

But there is another problem with "git fetch": a common work flow is 
tracking other peoples branches. And since git makes it so easy to 
have multiple branches, chances are that you track more than one 
branch per remote repository.

Now, an old gripe of mine was the lack of "git fetch --all". I wrote a 
script for that (Linus would be proud of me!), which just does "git 
ls-remote" and constructs a command line for "git fetch" from that.

But even if you agree with the common story that you should specify the 
branches you want to track: it is hard!

If I were new to git, after reading some tutorials I would _expect_ "git 
fetch" to be the tool to track branches. (I posted a patch to at least be 
able to store the current "git fetch" command line under a nick IIRC). But 
it does not.

(Of course, after reading several documentation, as a new user I would 
eventually find that I should edit .git/remotes/<nick>, or even 
edit/-repo-config the remotes information in the config, but I would fully 
expect a new user to give up before reaching that stage.)

But maybe I got it all wrong and this is not the common expectation...

Ciao,
Dscho
