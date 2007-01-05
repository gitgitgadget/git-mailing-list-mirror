From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 5 Jan 2007 15:15:18 -0800 (PST)
Message-ID: <826.67287.qm@web31809.mail.mud.yahoo.com>
References: <7vtzz9usyp.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Jan 06 00:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yHU-0004Dk-6J
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXAEXPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbXAEXPV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:15:21 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:30103 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750850AbXAEXPU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 18:15:20 -0500
Received: (qmail 68372 invoked by uid 60001); 5 Jan 2007 23:15:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=u4oEA28sqSp31ythoLVMJoM7cu6mWWFRAoiiBoMfs6lh8XQu8pxm7273DDhab46kWXiq28I06U7jSpqzYS5qyBDLRmWEPLH7PtKiEDeI2uRTd2PEKupg8qRGdtLBVcHGmNVPuxOeiPVYGOelAyuiUk5M0NCYJtabKLswD9EdVKY=;
X-YMail-OSG: 0v_eec8VM1mRLQZXKANr.a9AbltrBkn2yC1reQ0l2njefITxpzn6LYxVa79sElNDndinCgJK7vYAYrkHQI11zbDk6_ru4Se_LwkiLpi1JcO72N_9Ly0crHFDHJXm4yh7d5wBSykZ_P4v93XajnM96bL1tXTqejIIXaVYHjMe_SRE2.ty8HpqKuR6
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 15:15:18 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzz9usyp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36043>

--- Junio C Hamano <junkio@cox.net> wrote:
> 
> Because [remote] is NOT about mapping.  It asks the fetch
> mechanism to fetch from that remote, so the primary thing you
> should look at is .url, not RHS of colon on .fetch lines.  Use
> of tracking branches is strictly optional.

Remote
------

Please help me understand.  Here is a sample remote from
an actual repo (actual names changed):

[remote "origin"]
        url = http://blah/bleah.git
        fetch = +refs/heads/*:refs/remotes/origin/*

This basically says: "Get it" from such and such url, where
on the repo at that url, i.e. the remote side, you will
find stuff in "refs/heads/", and when you get it here, locally,
put it in refs/remotes/origin/.

Now if this isn't a mapping, then please can someone
explain to me what a "mapping" is?

The "fetch = <remote>:<local>" is inherently a mapping,
its syntax dictates it, as does the actual actions
it performs: "fetch" from "remote" and "put in local <local>".

Branch
------

Here is an actual example:

[branch "branchA"]
        remote = origin
        merge = refs/heads/branchA

Yeah, but by default "refs/heads/branchA" doesn't exist (see
my previous email).  It doesn't have to, since it specifies
the "remote part", but that has already been handled by
"[remote]".

Unless of course "[branch "..."]" specifies the _remote_ branch
being tracked in refs/remotes/origin.  Is this the case.

Does "[branch]" apply to local branches too?  If so,
then what happens when refs/heads/branchA does exist and is
the same as the one it describes -- i.e. completely old behavior.

Thanks,
    Luben
