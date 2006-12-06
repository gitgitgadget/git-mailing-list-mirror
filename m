X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 6 Dec 2006 18:00:16 +0100
Message-ID: <200612061800.17087.Josef.Weidendorfer@gmx.de>
References: <200612061207.23437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 17:01:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612061207.23437.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33492>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs08h-0001mr-IG for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936877AbWLFRAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936866AbWLFRAY
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:00:24 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:52936 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S936595AbWLFRAV (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 12:00:21 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id B8F962852; Wed,  6
 Dec 2006 18:00:19 +0100 (MET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Wednesday 06 December 2006 13:07, Andy Parkins wrote:
> The [branch "master"] section is such that there is no change to the
> functionality of git-pull, but that functionality is now explicitly
> documented.

Nice.
However, changing "git-clone" for this is an adhoc solution and
looks wrong.

Branching off a local development branch for a tracking branch is
the job of git-branch. So first, git-branch should be called from
git-clone to do this setup.

And git-branch should be told to change the configuration of default
behavior of git-pull, whenever it sees that you are branching off
from a branch tracking a remote one. I even would go so far to setup
a default "git-pull" action even for branching off from local branches,
by setting "branch.<newbranch>.remote = ." to merge from local "upstream".

Similar, "git-checkout -b <newbranch>" should call "git-branch"
for branch creation, too.

