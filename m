X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Wed, 08 Nov 2006 01:52:56 +0100
Organization: At home
Message-ID: <eir9nq$cm8$1@sea.gmane.org>
References: <878ximbwm3.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 8 Nov 2006 00:52:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31105>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhbgP-0004yC-1R for gcvg-git@gmane.org; Wed, 08 Nov
 2006 01:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753196AbWKHAwq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 19:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKHAwq
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 19:52:46 -0500
Received: from main.gmane.org ([80.91.229.2]:27066 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753196AbWKHAwp (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 19:52:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ghbg3-0004tb-3F for git@vger.kernel.org; Wed, 08 Nov 2006 01:52:29 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 01:52:27 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 08 Nov 2006
 01:52:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nix wrote:

> After all that setup, my question's simple. Does a `parent' in git
> terminology simply mean `this commit was derived in some way from the
> commit listed here'? If so, I suppose I can list heads/some-change-foo
> as one parent on these merge commits, even though the `merging'
> mechanism is so odd that I expect to be pelted with rotten vegetables as
> soon as I post this.

Yes, being parent means that this commit was derived in some way from the
commit listed here. It needs not to be this commit is the result of merge
of commits listed here... there was a discussion some time ago to use one
of parents (first for example) instead of special header for "prev" link to
previous value of the ref (which discussion was obsoleted by reflog).

It provies two things you have to think about if to use 'parenthood' for
something a bit unexpected. First, parents are connectivity, so even if you
delete trunks/some-name and then prune, averything that was merged in some
branch or tag which lives still wouldn't get pruned. Second, the
information about merges is used in merge strategies: consider if having
this information would help your strange merge strategy.

And of course there is a question if the graph as visualized by for example
gitk would have more sense or not with the "strange merges" marked as
merges. 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

