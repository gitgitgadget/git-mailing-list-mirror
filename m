From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Wed, 07 Oct 2015 18:00:20 +0200
Message-ID: <56154194.9050607@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>	 <1443477738-32023-39-git-send-email-dturner@twopensource.com>	 <56123CE3.9070909@alum.mit.edu> <1444181145.7739.70.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 18:07:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjrFb-0003OI-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbbJGQH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 12:07:28 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49203 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852AbbJGQH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 12:07:27 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2015 12:07:26 EDT
X-AuditID: 1207440e-f79516d0000012b3-55-561541964726
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 55.12.04787.69145165; Wed,  7 Oct 2015 12:00:23 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9720C.dip0.t-ipconnect.de [79.201.114.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t97G0KoD006280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 7 Oct 2015 12:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444181145.7739.70.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqDvdUTTM4NF3Rov5m04wWnRd6Way
	aOi9wuzA7HHxkrLHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M5YMOcBa0GDSsWlRfYNjE9l
	uhg5OCQETCRmLPfvYuQEMsUkLtxbz9bFyMUhJHCZUeL59kuMEM45Jomdv/qYQKp4BbQlDvfP
	YgOxWQRUJbat6mYEsdkEdCUW9TSD1YgKBEmsWP6CEaJeUOLkzCcsILYIUO/sIz2sIDazgLXE
	7j6IuLCAj0TXqjfsEMuuMErs2/wYrJlTwELi470pjBAN6hJ/5l1ihrDlJZq3zmaewCgwC8mO
	WUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJHT5djC2r5c5
	xCjAwajEw/vDWCRMiDWxrLgy9xCjJAeTkijvPQvRMCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vMcdgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQne9yCNgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdo7wSwvcUFiblAUYjWU4yKUkBb
	QRICIImM0jy4sbCE9IpRHOhLYV4zkCoeYDKD634FNJgJaHC/vBDI4JJEhJRUAyOLxokDC99e
	zWdZYnvq/q3Fp4PZ+iaLZP9sSjlcvkRmg/1zhkCJJ+utGHzlBNhSNgv1h9qnmV1NXNI0zdiy
	aSX7sk/8blsYZ8hEp+sanPc4a7FW8s7+I1/D/jKHPXbKrz5Wsfyh4naOnwd6lnwy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279180>

On 10/07/2015 03:25 AM, David Turner wrote:
> On Mon, 2015-10-05 at 11:03 +0200, Michael Haggerty wrote:
>> On 09/29/2015 12:02 AM, David Turner wrote:
>>> Because HEAD and stash are per-worktree, other backends need to
>>> go through the files backend to manage these refs and their reflogs.
>>>
>>> To enable this, we make some files backend functions public.
>>
>> I have a bad feeling about this change.
>>
>> Naively I would expect a reference backend that cannot handle its own
>> (e.g.) stash to instantiate internally a files backend object and to
>> delegate stash-related calls to that object. That way neither class's
>> interface has to be changed.
>>
>> Here you are adding a separate interface to the files backend. That
>> seems like a more complicated and less flexible design. But I'm open to
>> be persuaded otherwise...
> 
> After some thought, here's a summary of the problem:
> 
> Some writes are cross-backend writes.  For example, if HEAD is symref to
> refs/head/master, a commit is a cross-backend write (HEAD itself is not
> updated, but its reflog is).  Ronnie's design of the ref backend
> structure did not account for cross-backend writes, because we didn't
> have per-worktree refs at the time (there was only HEAD, and there was
> only one copy of it).
> 
> Cross-backend writes are complicated because there is no way to tell a
> backend to do only part of a ref update -- for instance, to tell the
> files backend to update HEAD and HEAD's reflog but not
> refs/heads/master.  Maybe we could set a flag that would do this, but
> the synchronization would be fairly complicated.  For instance, an
> update to HEAD might need to confirm the old sha for HEAD, meaning that
> we couldn't do the db write first.  But if we move the db write second,
> then when the db code goes to do its check of the HEAD sha, it might see
> a new value.  Perhaps there's a way to make it work, but it seems
> fragile/complex.
> 
> Right now, for cross-backend reads/writes, the lmdb code cheats. It
> simply does the write directly and immediately.  This means that these
> portions of transactions cannot be rolled back.  That's clearly bad. 

That's a really good point.

I hate to break it to you, but the handling of symrefs in Git is already
a mess. HEAD is the only symref that I would really trust to work
correctly all the time. So I think that changes needn't be judged on
whether they handle symrefs perfectly. They should just not break them
in any dramatic new ways.

So, you pointed out the problem that HEAD (a per-worktree reference) can
be a symref that points at a shared reference. In fact, I think when
HEAD is symbolic it is only allowed to point at a branch under
refs/heads, so this particular problem is pretty well-constrained.

Are there other cases of cross-backend writes? I suppose there could be
a symref elsewhere among the per-worktree references that points at a
shared reference. But I can't think of any cases where this is done by
standard Git. Not that it is forbidden; I just don't think it is done by
any of the standard tools.

Or there could be a symref among the shared references that points at a
per-worktree reference. But AFAIK the only other symrefs that are in
common use are the refs/remotes/*/HEAD symrefs, and they always point at
references within the same (shared) namespace.

If everything that I've said is correct, then my opinion is that it
would be perfectly adequate if your code would handle the specific case
of HEAD (by hook or by crook), and if there are any other cross-backend
symrefs, just die with a message stating that such usage is unsupported.
Junio, do you think that would be acceptable?

> The simplest solution would be for the lmdb code to simply acquire
> locks, and write to lock files, and then commit those lock files just
> before the db transaction commits. Then the lmdb code would handle all
> of the orchestration without the files backend having to be rewritten to
> handle this case.

Wouldn't that essentially be re-implementing the files backend? I must
be missing something.

> [...]

BTW I just realized that if one backend should delegate to another, then
the primary backend should be the per-worktree backend and it should
delegate to the common backend. I think I described things the other way
around in my earlier message. This makes more sense because it is
acceptable for per-worktree references to refer to common references but
not vice versa.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
