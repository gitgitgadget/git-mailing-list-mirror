From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: moving to a git-backed wiki
Date: Wed, 02 Feb 2011 18:24:23 -0800
Message-ID: <4D4A11D7.4040103@eaglescrag.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org> <20110131225529.GC14419@sigill.intra.peff.net> <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com> <20110201201144.GA16003@sigill.intra.peff.net> <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com> <4D488DCD.3080305@eaglescrag.net> <4D4929F4.3020805@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vincent Hanquez <tab@snarc.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 03:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkosG-0008MX-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 03:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab1BCCYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 21:24:39 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:48426 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab1BCCYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 21:24:38 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p132ON5E017102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 2 Feb 2011 18:24:24 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <4D4929F4.3020805@snarc.org>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 02 Feb 2011 18:24:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165947>

On 02/02/2011 01:55 AM, Vincent Hanquez wrote:
>  On 01/02/11 22:48, J.H. wrote:
>> The wiki will almost universally have a "central site" no matter what
>> the backend.  Personally I see little advantage to having a git backed
>> wiki myself.
> with git based wiki, you can clone the whole wiki on your local machine,
> and read/edit/commit on it locally using standard editor tool (i.e.
> $EDITOR). and the history/revision/diff is completely built-in.

That would be fine for things like source code or documentation, but you
end up with a single person who would need to merge / push things to a
central location, a-la git.wiki.kernel.org.  You are now taking
something, that is already editable by anyone, and making it only
editable by a single person.

You also have a scalability problem.  Git is *VERY* memory and i/o
intensive.  While you basically have a cache of data that is static (the
basic pages you are viewing) things like the history, edits, etc can be
quite expensive to generate.

Think about a site, we'll use git.wiki.kernel.org, where it's not
running on a single machine, but a cluster of machines (how many web
infrastructures, including git.wiki.kernel.org run) and now you have a
problem of an edit happens and commits on node3, a different conflicting
edit happens on node9 and when those try to merge - you get conflicts.

Let me be clear here, I think the idea is interesting, but I think in
trying to replace a full wiki it's a horrible idea, particularly since
you are pushing a lot of manual work - somewhere, and trying to use git
as a nosql database without some sort of locking system.

Just my $0.02 though.

- John 'Warthog9' Hawley
