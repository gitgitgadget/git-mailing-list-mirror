X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull and merging.
Date: Fri, 08 Dec 2006 12:48:08 +0100
Organization: At home
Message-ID: <elbj9g$og4$1@sea.gmane.org>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612061744.31213.Josef.Weidendorfer@gmx.de> <4577B8C0.3060200@gmail.com> <200612071227.46194.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 8 Dec 2006 11:46:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33689>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GseBC-0001Cz-HN for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425417AbWLHLqL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425416AbWLHLqL
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:46:11 -0500
Received: from main.gmane.org ([80.91.229.2]:40370 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S938051AbWLHLqJ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 06:46:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GseAw-0005Nq-68 for git@vger.kernel.org; Fri, 08 Dec 2006 12:45:58 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:45:58 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 12:45:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> Now looking at it, I think this semantic really is screwed and utterly confusing.
> Why decides branch.*.merge about actions done in fetch (I think even if you did
> "git fetch" alone)? OK, actually, that is an implementation detail and not
> really important.
> 
> More important: Because "branch.*.merge" specifies a _remote_ branch,
> the user has to understand that this info is already used in the fetch.
> The intuitive mental model of a user about how it works IMHO is that
> "branch.*.merge" is checked in the merge phase (as the name of the option suggests).
> But this way, how could the merge phase know about any remote branch at all,
> which does not need to be touched at all in the merge phase?
> 
> IMHO we should somehow change the semantic of branch.*.merge to specify the _local_
> refspec part, as this is the branch which actually gets merged.
> This is the only way that a user could grasp the meaning of it.
> Perhaps introduce "branch.*.defaultmerge", and obsoleting "branch.*.merge"?

The change of semantic would prohibit the "pull without tracking branch"
semantic (probably not used anymore, since git supports multiple heads
from long time).

I proposed in another thread to allow to either specify full refspec (in
addition to current specifying remote branch), or ':' and local branch.
Or perhaps add branch.*.localmerge configuration option?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

