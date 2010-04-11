From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Sun, 11 Apr 2010 14:32:49 -0700 (PDT)
Message-ID: <m3tyrhfzg8.fsf@localhost.localdomain>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>,
	mercurial list <mercurial-devel@selenic.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 23:33:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O14m5-0004po-0t
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 23:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab0DKVcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 17:32:55 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:32834 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0DKVcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 17:32:54 -0400
Received: by bwz19 with SMTP id 19so24838bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MAcukdjfs61AVe+5mHzTvIlJROS1i1P9jkpce0byxAc=;
        b=PWI+chVKGTCvylYq6sOUCiJWb2Wo4eo7JaCxd4FwIf0uazUP9ZrecNNrKR5Fn0MLpc
         q7eLZmMYGcjR4o+ELAqe7WdDSDgIZYNR7QnDTkffjzf4+3PYyog2XrUSAOebBAbl5kPa
         URiAZviFtbKQNXllWrQN+1t8BAr3zptkv8dL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RrbjxlVo0kHemjtoIDHDcueJUhSci6fEYNQbM3sv+wOuPfmd4hBguXtcQvdNxi2mx0
         V+bEBsOumIbVUHUhNZnK8Z1lZT4cA4dDKzXY5rbaE4iyOPuyv20MZPW+dtstta9KYoSx
         SwhKXIxDrcJWXKruWSGqx0jF7ZAAn6NrZq/+k=
Received: by 10.102.174.35 with SMTP id w35mr1477958mue.51.1271021570283;
        Sun, 11 Apr 2010 14:32:50 -0700 (PDT)
Received: from localhost.localdomain (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id e9sm14200475muf.10.2010.04.11.14.32.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 14:32:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3BLWDns013823;
	Sun, 11 Apr 2010 23:32:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3BLVqol013818;
	Sun, 11 Apr 2010 23:31:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144687>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 9 Apr 2010, Aghiles wrote:
> > 
> > Oh, I should have read the documentation. I was certain that ".." stands
> > for a range but it is a ... complement.
> 
> Well, technically ".." means two different things
> 
>  - for "set operations" (ie "git log" and friends) it's the "relative 
>    complement" of two sets (or "'reachable from A' \ 'reachable from B'").
> 
>  - for "edge operations" (ie "git diff" and friends) it's just two 
>    end-points (aka "range"). A diff doesn't work on sets, it only works on 
>    the two endpoints.

[...]
> Most SCM's really talk about "ranges". Once you think in those terms, 
> complex history doesn't work. Git very fundamentally is much about set 
> theory, and "ranges" is a bad word to use.

For example from I have got from asking on #mercurial IRC channel on
FreeNode (a bit of self promotion: I have done this research to write
an answer to "Git and Mercurial - Compare and Contrast" question on
StackOverflow[1]), Mercurial implements its ".." equivalent in the
term of _numeric range_, even for "hg log" (sic!).  It turns revision
identifiers used in range (-r <rev1>:<rev2>) to LOCAL number of
revision, and generates range based on numeric range, IIRC inclusive
on both sides (in Git range is exclusive from bottom, inclusive from
top).

Which is plain useless for anything but linear subsets of history
(compare e.g. "master..next", which in Git shows everything in "next"
that is not in "master"; "master" and "next" are not direct
descendants of one oanother, at least not usually).

[1] http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-contrast/1599930#1599930

P.S. I wonder if Mercurial development list is subscribe-only...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
