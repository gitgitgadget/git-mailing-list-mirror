X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 11:04:46 +0100
Organization: At home
Message-ID: <ejuit4$mg$1@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net> <ejthuh$fn8$1@sea.gmane.org> <20061121062158.GF20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 10:04:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 36
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31980>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmSUD-0005QT-Rj for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030803AbWKUKEF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 05:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030804AbWKUKEF
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:04:05 -0500
Received: from main.gmane.org ([80.91.229.2]:29089 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030803AbWKUKEC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 05:04:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmSTl-0005Jd-Md for git@vger.kernel.org; Tue, 21 Nov 2006 11:03:49 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 11:03:49 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 11:03:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:

> On Tue, Nov 21, 2006 at 01:42:22AM +0100, Jakub Narebski wrote:
>> Perhaps it would be best to join those two subproject support
>> solutions together: "bind" tree/commit mount header in commit
>> object, and "commit" entry in a tree.
> 
> But which is the autoritative source then?
> Does it give any more information?

Both should contain the same information, otherwise repository is corrupt
(is in inconsistent state).

"bind" header in commit objects is meant as a kind of shortcut, to ease
reachability checking (you don't need to recurse into directories).

> The advantage in your proposal would be that submodules would
> be visible immediately when looking at the commit,
> without having to traverse the entire tree.
> This may be worthwhile when showing the combined history of parent
> and submodules.

That was the idea.

> But still this looks like "caching submodule information in the
> commit object" and I do not know if we really want to do that.

Well, we would be repeating information, sure. But we can put additional
information in "bind" header except sha1 of commit and mount point...
although I cannot think what... :)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

