From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Document --ignore-if-in-upstream in git-format-patch
Date: Thu, 18 Jan 2007 15:13:46 +0100
Message-ID: <87wt3ke82t.fsf@morpheus.local>
References: <8764b4fuc8.fsf@morpheus.local> <Pine.LNX.4.63.0701181437200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 18 15:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Y1w-00083H-6i
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXAROOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 Jan 2007 09:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXAROOL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:14:11 -0500
Received: from main.gmane.org ([80.91.229.2]:49461 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbXAROOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:14:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7Y1b-0002P4-Ph
	for git@vger.kernel.org; Thu, 18 Jan 2007 15:13:56 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 15:13:55 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 15:13:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:8EHoI+OVl5lChvSSifhS23PSalE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37093>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 18 Jan 2007, David K=C3=A5gedal wrote:
>
>> Someone who knows how it *actually* works is encouraged to send a
>> better explanation.
>
> Nice try... Unfortunately, I don't have time to do it.
>
>> +--ignore-if-in-upstream::
>> +	Do not include the same patch twice.  If there are two commits
>> +	that would produce identical patches, the second one is
>> +	excluded from the output.
>
> This is not what it does, though. (If in doubt, use the source, Luke)=
=2E

I did.  But I haven't learnt to navigate it yet.  I get confused by
the global state in the code, which makes it hard to know when I
function call returns interesting information or changes some global
table.

> Given a range upstream..localbranch, --ignore-if-in-upstream looks at=
 all=20
> diffs associated with commits in localbranch..upstream (i.e. all comm=
its=20
> upstream has, but not localbranch), and when traversing=20
> upstream..localbranch to output the commits with diffs, drops those a=
t the=20
> floor which were already seen in localbranch..upstream.

Ah, now I see.  How about this, then:

+--ignore-if-in-upstream::
+       Do not include a patch that matches a commit in
+       <until>..<since>.  This will examine all patches reachable
+       from <since> but not from <until> and compare them with the
+       patches being generated, and any patch that matches is
+       ignored.

It's hard to get something readable without writing lots about what
<since>..<until> actually means.  Which might actually be a good idea
to do. But I don't have time to do that :-)

--=20
David K=C3=A5gedal
