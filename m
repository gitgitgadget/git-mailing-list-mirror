X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 21:04:54 +0100
Organization: At home
Message-ID: <eln1sr$1rm$1@sea.gmane.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org> <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612121352520.18171@xanadu.home> <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612121420580.18171@xanadu.home> <Pine.LNX.4.63.0612122031450.2807@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612121144220.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 20:03:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 39
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34141>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDqI-0007F8-Cl for gcvg-git@gmane.org; Tue, 12 Dec
 2006 21:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932421AbWLLUCz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWLLUCy
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 15:02:54 -0500
Received: from main.gmane.org ([80.91.229.2]:57196 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932421AbWLLUCy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 15:02:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuDpt-0007jg-9x for git@vger.kernel.org; Tue, 12 Dec 2006 21:02:45 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 21:02:45 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 21:02:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> 
> 
> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
>> On Tue, 12 Dec 2006, Nicolas Pitre wrote:
>> 
>>> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
>>> 
>>>> But it would become a non-problem when the HTTP transport would learn 
>>>> to read and interpret the .idx files, basically constructing thin 
>>>> packs from parts of the .pack files ("Content-Range:" comes to 
>>>> mind)...
>>> 
>>> Woooh.
>> 
>> Does that mean "Yes, I'll do it"? ;-)
> 
> Umm. I hope it means "Woooh, that's crazy talk".
> 
> You do realize that then you need to teach the http-walker about walking 
> the delta chain all the way up? For big pulls, you're going to be a lot 
> _slower_ than just downloading the whole dang thing, because the delta 
> objects are often just ~40 bytes, and you've now added a ping-pong latency 
> for each such small transfer.
> 
> You don't need to download many such small ranges, and suddenly the few 
> hundred ping-pongs that got you a few tens of kB of data took longer than 
> just downloading a big stream efficiently that got you everything.

While I think the problem is much better solved by having "archive" pack(s)
and "current" pack, perhaps with always sownloading the whole delta it
would be feasible?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

