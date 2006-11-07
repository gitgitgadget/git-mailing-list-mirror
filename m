X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 11:53:32 +0100
Message-ID: <200611071153.32840.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <200611070225.24956.Josef.Weidendorfer@gmx.de> <20061107065400.GA25737@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 13:15:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <20061107065400.GA25737@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31069>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhQnX-0004a1-2D for gcvg-git@gmane.org; Tue, 07 Nov
 2006 14:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932502AbWKGNOn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 08:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWKGNOn
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 08:14:43 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:18055 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S932502AbWKGNOm (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 08:14:42 -0500
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de
 [131.159.35.44]) by mail.in.tum.de (Postfix) with ESMTP id 765C12800; Tue,  7
 Nov 2006 12:06:23 +0100 (MET)
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Tuesday 07 November 2006 07:54, you wrote:
> > IMHO this kind of aliasing is awkward. When you want to start
> > another topic branch on the remote branch, or want to reference the
> > remote branch for diffs, you have to explicitly specify
> > "remotes/origin/next", making for more typing.
> 
> Having more than one local branch for a remote branch is advanced
> enough that the user should know how to create branches with any name
> they choose.

But such an advanced szenario is exactly the reason to introduce
these long branch names like "origin/next", isn't it?
When a newbie probably never is confronted with this szenario, then
why give him longer branch names per default?
Do you see the contradiction in this argument?

IMHO it should be the other way around: when an advanced user
gets this conflict, he knows how to rename the branches by using
this more elaborated scheme.

I understand that these long branch names implicity give you information
about the upstream (by including the remote shortcut in front),
but this information (like all branch attributes) should also be
easy available with "git branch --info" or similar. Especially,
when we introduce shortcuts like "@up" (i.e. git-show-ref @up).
 
> But I do agree that calling it "origin/next" the first time you
> branch, and "remotes/origin/next" subsequent times, is nonintuitive.
> However, this could be solved by the following message being printed
> the first time:
> 
>   $ git checkout origin/next
>   No local branch "origin/next" exists. Creating new local branch
>   "origin/next" off of remote branch "remotes/origin/next".

My patch already does something like this.

