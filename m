X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 26 Nov 2006 00:49:08 +0100
Message-ID: <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com> <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 23:50:32 +0000 (UTC)
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go7Ht-0000Xs-2g for gcvg-git@gmane.org; Sun, 26 Nov
 2006 00:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966877AbWKYXuV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935216AbWKYXuV
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 18:50:21 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:30919 "EHLO
 smtp6-g19.free.fr") by vger.kernel.org with ESMTP id S935217AbWKYXuU (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 18:50:20 -0500
Received: from gandelf.nowhere.earth (unknown [81.57.214.146]) by
 smtp6-g19.free.fr (Postfix) with ESMTP id D2B9F43545; Sun, 26 Nov 2006
 00:50:18 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 3E79F201C;
 Sun, 26 Nov 2006 00:49:08 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Sat, Nov 25, 2006 at 11:30:47AM -0800, Linus Torvalds wrote:
> The git trees are _independent_. That's important.

I'm not sure how independant you mean them to be.  The approach I've
tried to describe so far assumes that, although you can look at each
submodule independently from the supermodule or any other submodule, you
can still look at the supermodule as a single tree of it own.

Eg, so that if one part of an appliance/ modules ends up promoted to a
lib/ module, GIT can still show that as a move within the supermodule.
If we insist that the submodules get committed independently before we
make a supermodule commit tying those together, I fear it may make things
like such "move/copy detection" more tricky ?

Also, I'd rather expect "git-commit -a" outside of any submodule to
commit everything in the supermodule, triggering submodule commits as an
intermediate step when needed - just like "git-commit -a" does not
require to manually specify subdirectories to inclue in the commit.  I'd
rather expect a special flag to exclude submodules from a commit.

Best regards,
--
