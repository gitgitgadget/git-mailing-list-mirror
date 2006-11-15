X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:59:54 +0100
Organization: At home
Message-ID: <ejeocl$vrj$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home> <200611150917.23756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 15 Nov 2006 09:59:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31427>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkHY2-0004Yo-W5 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 10:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966728AbWKOJ7L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 04:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966729AbWKOJ7L
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 04:59:11 -0500
Received: from main.gmane.org ([80.91.229.2]:29408 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966728AbWKOJ7K (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 04:59:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkHXk-0004U3-4M for git@vger.kernel.org; Wed, 15 Nov 2006 10:58:56 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 10:58:56 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 10:58:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

>  * Don't use the name "origin" twice.  In fact, don't use it at all.  In a 
> distributed system there is no such thing as a true origin.

The remote 'origin' is true origin of the repository: it is repository
we cloned this repository from.

I agree that having branch 'origin', at least in most common multi-branch
(multi-head) repository, is just confusing.

>  * Ensuring we have /all/ upstream branches at a later date is hard, and not 
> automatic.  Here is the .git/remotes/default file that should be possible:
>     URL: git://host/project.git
>     Pull: refs/heads/*:refs/remotes/default/*
>    Now, every git-pull would check for new upstream branch refs and sync them 
> into the local remotes list.  These are read-only so it'd be perfectly safe 
> to delete any locally that no longer exist upstream.

Very nice idea.
 
>  * git-clone should really just be a small wrapper around
>     - git-init-db
>     - create .git/remotes/default
>     - maybe create specific .git/config

I'm not sure about "create .git/remotes/default" part. Isn't git moving from
remotes file to having information about remotes (and branches) in config?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

