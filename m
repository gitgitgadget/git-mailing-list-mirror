X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 01:42:22 +0100
Organization: At home
Message-ID: <ejthuh$fn8$1@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 00:41:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 35
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31965>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmJhJ-0000hm-9U for gcvg-git@gmane.org; Tue, 21 Nov
 2006 01:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030579AbWKUAlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 19:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWKUAlJ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 19:41:09 -0500
Received: from main.gmane.org ([80.91.229.2]:36550 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030579AbWKUAlI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 19:41:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmJh8-0000f5-JT for git@vger.kernel.org; Tue, 21 Nov 2006 01:41:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 01:41:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 01:41:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> Now, to get everything to work seamlessly within such a commit thing 
>> might be a fair amount of work, but I'm not sure you even _need_ to. It 
>> might be ok to just say "subproject 'xyzzy' differs" in the diff, for 
>> example, and have some rudimentary support for "git status" etc talking 
>> about subprojects that need to be committed.
> 
> I agree with the static "diff" part, and probably "checkout" and
> "merge" are not all that difficult.
> 
> However, if I recall correctly, it was rather nightmarish to
> make this also work for reachability traversal necessary for
> pack generation.  It was painful enough even when the bind was
> at the commit level (which was way simpler to handle), but to do
> this the right way, the bind needs to be done at the tree level,
> and "rev-list --objects foo..bar" would need some way to limit
> the commit ancestry chain of subproject at the same time, by
> computing the commit ancestry of the embedded commits in the
> trees.

Perhaps it would be best to join those two subproject support
solutions together: "bind" tree/commit mount header in commit
object, and "commit" entry in a tree. But I agree that revision
walking needs to be rewamped... well, unless you always have
project and subproject in the same repository, and subprojects
are branches in the project too... 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

