From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git interactive rebase 'consume' command
Date: Mon, 21 Jan 2013 12:05:30 +0100
Message-ID: <50FD20FA.8060906@alum.mit.edu>
References: <kdgtir$apt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxFCQ-00050B-1s
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 12:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab3AULFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 06:05:36 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:61392 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab3AULFf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 06:05:35 -0500
X-AuditID: 1207440e-b7f116d0000008ae-77-50fd20fe41c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 15.E5.02222.EF02DF05; Mon, 21 Jan 2013 06:05:34 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0LB5Vkp004122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2013 06:05:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <kdgtir$apt$1@ger.gmane.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqPtP4W+AwaILJhZdV7qZLBp6rzBb
	/GjpYbaYvvcwiwOLx85Zd9k9nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujDcretkL
	zkpVLF75jrGB8Z9IFyMHh4SAiUTLMrcuRk4gU0ziwr31bF2MXBxCApcZJb5OPsAM4Rxnkujq
	fcQO0sAroC3x4Hk4SAOLgKrE6t7jLCA2m4CuxKKeZiYQW1QgTKL39TlGEJtXQFDi5MwnLCCt
	IgJqEoff6ICEmQXiJZa+fcIKYgsLmEq8//uADcQWEtCQmDjjB9gYTgFNib+f5zFD1OtIvOt7
	AGXLS2x/O4d5AqPALCQbZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwS
	vdSU0k2MkFDm28HYvl7mEKMAB6MSD29i358AIdbEsuLK3EOMkhxMSqK8L2X/BgjxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4f05A6icNyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgm
	K8PBoSTBGykPNFSwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKXxxcA4BUnxAO1d
	AdLOW1yQmAsUhWg9xajLsf13+3NGIZa8/LxUKXHerSBFAiBFGaV5cCtgiesVozjQx8K85SBV
	PMCkBzfpFdASJqAlvIt/gywpSURISTUwFi2wl2hV6dwtv9qZceclycSEq5eMGY/8U9E8tk5p
	/c7eqTLODDXSIq4i+96b/Yu2+6bosfeG6Dntnsxil5sxa3q3/Duv07X+YJ61mWz3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214109>

On 01/20/2013 03:05 PM, Stephen Kelly wrote:
> I find the fixup command during an interactive rebase useful.
> 
> Sometimes when cleaning up a branch, I end up in a situation like this:
> 
>  pick 07bc3c9 Good commit.
>  pick 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
> 
> 
> So, I have to reorder the commits, and change 1313a5e to 'f'. An alternative 
> would be to squash 's' c2f62a3 into 1313a5e and clean up the commit message. 
> The problem with that is it ends up with the wrong author time information.

I do "squash with successor then clean up commit message" all the time.
 I had never worried (or even thought much) about the author time of the
resulting commit.  I think I will continue not worrying about it :-)

I think it would be great to have a shorthand for this operation in "git
rebase --interactive" and I probably would have implemented it when I
added "fixup" if I had been able to think of a good name for it.  Even
though I do this sort of thing less frequently than "fixup", it still
comes up often enough that a special command for it would be useful.

> So, I usually reorder and then fixup, but that can also be problematic if I 
> get a conflict during the re-order (which is quite likely).

It is perverse to have to turn a well-defined and manifestly
conflict-free wish into one that has a good chance of conflicting, just
because of a limitation of the tool.

> I would prefer to be able to mark a commit as 'should be consumed', so that:
> 
>  pick 07bc3c9 Good commit.
>  consume 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
> 
> will result in 
> 
>  pick 07bc3c9 Good commit.
>  pick 62a3c2f Another commit.
> 
> directly.

Excellent.  But the name is not self-explanatory.  And there is
something different about your "consume" command:

Normally, "pick" means that the commit on that line is the start of a
new commit unrelated to its predecessors.  And in general, the command
on one line only affects the lines that come before it, not the lines
that come after it.  Under your proposal "consume" would change the
meaning of the following line, namely by changing what its "pick" means.
 It might be more consistent to require the following line to be changed
to "squash":

    pick 07bc3c9 Good commit.
    consume 1313a5e Commit to fixup into c2f62a3.
    squash c2f62a3 Another commit.

in which case the meaning of "consume" would be something like "pick
this commit but not its commit message.  There would have to be a
prohibition against generating commits with *no* commit messages, to
prevent series like [consume, pick] or [consume, fix, pick] while
allowing series like [consume, consume, squash, fix, fix].

If this is the interpretation, the name "quiet/q" might make things clearer.

Yet another approach would be to allow options on the commands.  For
example,

    pick 07bc3c9 Good commit.
    pick --quiet 1313a5e Commit to fixup into c2f62a3.
    squash c2f62a3 Another commit.

In fact if options were implemented, then "fixup" would mean the same as
"squash --quiet", "reword" could be written "pick --edit", and I'm sure
the new flexibility would make it easier to add other features (e.g.,
"pick --reset-author").

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
