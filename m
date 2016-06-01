From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git gc and worktrees
Date: Wed, 1 Jun 2016 18:12:51 +0200
Message-ID: <574F0983.5030108@alum.mit.edu>
References: <574D382A.8030809@kdbg.org>
 <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
 <20160531221415.GA3824@sigill.intra.peff.net> <574EA364.60408@alum.mit.edu>
 <xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:13:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88lY-0000Lt-70
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbcFAQND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:13:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61153 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753240AbcFAQNB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 12:13:01 -0400
X-AuditID: 12074413-473ff700000008c7-a2-574f0986e639
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 61.92.02247.6890F475; Wed,  1 Jun 2016 12:12:54 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFA.dip0.t-ipconnect.de [80.142.175.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u51GCpSD003448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Jun 2016 12:12:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqNvG6R9ucPwuv8X8TScYLbqudDNZ
	NPReYbZ4Mvcus0X3lLeMFj9aepgd2Dx2zrrL7vHwVRe7x7PePYweFy8peyx4fp/d4/MmuQC2
	KG6bpMSSsuDM9Dx9uwTujOlXnrEW/Bep2PCugbmBsVGwi5GDQ0LAROJHR3kXIxeHkMBWRomH
	LX+ZIZzzTBId+xuAHE4OYQFFiWlLL7GC2CICahIT2w6xQBS9ZZR4vmMVK4jDLLCPUaLpcA8T
	SBWbgK7Eop5mMJtXQFvi/olH7CA2i4CKxIsPz8CmigqESJxft5UVokZQ4uTMJywgNqeAtcT2
	o91gcWYBPYkd139B2fIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5yc
	mJeXWqRrrpebWaKXmlK6iRES4sI7GHedlDvEKMDBqMTDW3HZN1yINbGsuDL3EKMkB5OSKG8O
	i3+4EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFeR5Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpi
	SWp2ampBahFMVoaDQ0mCdzcHUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KCrj
	i4FxCZLiAdrrCtLOW1yQmAsUhWg9xajLcWT/vbVMQix5+XmpUuK8F0CKBECKMkrz4FbAEtor
	RnGgj4V5RYDpTYgHmAzhJr0CWsIEtCQ+wwdkSUkiQkqqgTG7/rn6FKZZxbO4N+d+O/m0dKed
	v4iejpXTCuHJHjOi6hcV1+gpvl9u/f9mdNqMC1o3fuxX2G1wIfiTa0XSr988Rvxs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296096>

On 06/01/2016 05:15 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I think reference stores are going to need two distinct types of
>> reference iteration: one to iterate over the *logical* reference space
>> of a single repo or worktree, and one to find all *local* references
>> and/or reachability roots (e.g., when run within a linked repo).
> 
> This is hard reason about without defining *logical* and *local*.

By "logical" I mean the references that appear to be available in the
specified repository. Roughly, "what reference names can I pass to `git
rev-parse`?" If you are in a linked repo, your "logical" references are
most of those in the main repo plus the "HEAD" and "refs/bisect/*" and
probably a couple other pseudo-refs that are stored in your worktree.

"Local" is probably a bad name. What I mean is that we have multiple
physical places to store references. In particular, in the case of
linked repos we have the main repo's references plus we have the
worktree's local references.

Most Git commands care only about the "logical" references in the repo.
But some commands (mostly having to do with reachability) need to know
about all roots, and therefore have to know about the union of all of
the references stored in each of the linked repositories.

Note that in the second case it is a little silly even talking about
"references", because references in different linked repos might have
the same names. We're really talking about reachability roots that might
have a little metadata connected with them, like "this SHA-1 came from
reference 'HEAD' in the 'test' worktree" or "this SHA-1 came from the
reflog of 'refs/heads/master' in the main repo".

I argue that the fundamental concept in terms of the implementation
should be the individual physical reference stores, and these should be
compounded together to form the logical reference collections and the
sets of reachability roots that are interesting at the UI level.

> For protecting necessary objects from pruning by anchoring them as
> "reachable", and for avoiding unnecessary object transfer by showing
> things via ".have" lines, we're better consider references and
> reflogs that do not appear in the namespace visible from the current
> worktree.  I wanted to come up with an example of wanting to iterate
> over refs of the current worktree, but other than "what are my
> branches including HEAD?" I didn't think of anything interesting.

It doesn't show up much at the UI level, but there are some examples, like

* git log --decorate
* git for-each-ref --contains
* gitk --all

> [...]

Michael
