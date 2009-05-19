From: Miles Bader <miles@gnu.org>
Subject: Re: git svn rebase problem
Date: Tue, 19 May 2009 09:56:08 +0900
Message-ID: <buobpppq5av.fsf@dhlpc061.dev.necel.com>
References: <4A0DDCC5.4010001@dlasys.net>
	<op.ut4aagco1e62zd@merlin.emma.line.org>
	<32541b130905181000v34d5fd6arcb662bff232cb81c@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Andree <matthias.andree@gmx.de>,
	"David H. Lynch J.r" <ml@dlasys.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 02:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6DdZ-00008b-3V
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 02:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbZESA4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 20:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbZESA4T
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 20:56:19 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45276 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZESA4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 20:56:18 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4J0u3xt005297;
	Tue, 19 May 2009 09:56:09 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Tue, 19 May 2009 09:56:09 +0900
Received: from dhlpc061 ([10.114.114.140] [10.114.114.140]) by relay11.aps.necel.com with ESMTP; Tue, 19 May 2009 09:56:08 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id C9DAF52E30E; Tue, 19 May 2009 09:56:08 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <32541b130905181000v34d5fd6arcb662bff232cb81c@mail.gmail.com>
	(Avery Pennarun's message of "Mon, 18 May 2009 13:00:25 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119483>

Avery Pennarun <apenwarr@gmail.com> writes:
>> Branches and git-svn don't mix.
>
> That's not exactly true: merging and git-svn don't mix.  But rebasing
> works fine.

I've given up on trying to maintain rigid consistency with svn --
git-svn's constant rebasing is just too painful -- and just cherry-pick
everything between my "svn" branch and master, and use master in
conjunction with better-behaved git-only branches.  I often end up with
the same commits in a different order on the two branches, but oh well,
not much to do about that I suppose.

This means I often end up cherry-picking long sequences of commits, and
need to deal with conflicts in these cp-sequences.  For this reason, I
often wish cherry-pick supported all the fancy features of rebase
(multiple commits, nice handling of conflicts, -i, etc) -- after all
rebasing is really just a special case of cherry-picking.

[I've tried on a shell-script implementation of such an extended
cherry-pick, but soooo many little corner cases to deal with... maybe
it'd be easier to try and generalize git-rebase...?]

-Miles

-- 
Conservative, n. A statesman enamored of existing evils, as opposed to a
Liberal, who wants to replace them with new ones.
