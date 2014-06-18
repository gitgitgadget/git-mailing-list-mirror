From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Wed, 18 Jun 2014 08:03:36 -0700
Message-ID: <CAL=YDW=vfkxdv1viRdvUmWatMftN3yRq7OgyW-2cC9ftA0_G4g@mail.gmail.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
	<xmqqfvj81oym.fsf@gitster.dls.corp.google.com>
	<53A1791B.5010301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxHOq-0005SB-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 17:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaFRPDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 11:03:39 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:39679 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaFRPDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 11:03:37 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz11so944048veb.31
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xMGGMBJ3lwFUYPq4+U1e88LxaKr09EtImv0Ckw9Xze8=;
        b=VXNEHcgmlVTaws1+fA4W6nuxLxGziTYSGWC5JKael2nkzrdItsCHWS7gtCyTL/04L9
         ro0xaSHWTEtmlAIjRo8qGpDFw6N/bK4TbiDvsK4e2/1YjdjWQHRDy8D/WbRznr3WDI5E
         9yZ0jrhR9aZqboe3tnAtDJIrf/NC2TKuKe7V2TFoiTRWeCOeBntVjkpatIKAXU3ZK6HC
         4AIyQJcOlRYHqnYFn1UFxChxFnRKq1jE34bjpUCBTKCATk1a7+hi2M4BQC5fsDpibcTj
         KzGidZJ9/+Aa5XQTTf5uzX6T55lWVIP/8foDwTRwhIdZwmquk+BUUcDMxjNIcxbjL9lU
         biew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xMGGMBJ3lwFUYPq4+U1e88LxaKr09EtImv0Ckw9Xze8=;
        b=gIRpfgi/DWgUqNwrqk12MG6UIaUfns7Z0bx88ETHhtmdgnj+925HUKI1EeE64QlA+l
         I3RvFj38OirHoocJ8bb8hPxw7jD6FAIU8HrVO44vyMlVnxYZ/9vCDAxhwR0hPQGQv8XM
         bGN7IRHLum1ZhH7Sdtq8DAu7AqXrwR/0J1YCFB9yCp1VhUNp2AgcQa7SzMtz0bghAJCZ
         ca0xMgtZSWpKx+pDxuDfz7iU/iZ1jprTfqJOSI74vzMqhz1aQIgUxrAaG3icOgzBF6sV
         du/+fJ9mMYus8ysrxWQMSx3q4B4wSHAt5qZCcjQC478GteZbFPvCVsv40J9jw4IkHs5i
         zF2w==
X-Gm-Message-State: ALoCoQnPmvpWYkfb7e2TB+cHzjXgNgXA/HARgMoLKHmRn+XeFG15iUrNB9LXse5mxfR6TdzyOOMd
X-Received: by 10.52.120.83 with SMTP id la19mr703076vdb.68.1403103816727;
 Wed, 18 Jun 2014 08:03:36 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 18 Jun 2014 08:03:36 -0700 (PDT)
In-Reply-To: <53A1791B.5010301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251985>

On Wed, Jun 18, 2014 at 4:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/13/2014 11:25 PM, Junio C Hamano wrote:
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> It gets even more hairy :
>>> If the server has A/a and a/b and you clone it it becomes A/a and A/b
>>> locally. Then you push back to the server and you end up with three
>>> refs on the server:  A/a A/b and a/b.
>>
>> That is part of the transition in deployment.  David who wants to
>> forbid A/a and a/b mixed in his project will surely correct the
>> situation at the server end so "somebody fetches A/a and a/b and
>> ends up with A/a and A/b" will not happen.  They will fetch A/a and
>> A/b.
>>
>> If a user is with an older Git and he has his own a/c, fetching A/a
>> and A/b from a corrected central repository will still give the user
>> a/a and a/b, but then pushing it back will be forbidden.  The user's
>> repository needs to be fixed and installation of Git needs to be
>> updated to the version with an equivalent of David's "optionally
>> deny" feature implemented for the fetching side, so that the user
>> notices the local a/c is bad and not allowed within the context of
>> his project, deletes it and recreates it as A/c before he can fetch
>> A/a and A/b from the central repository.
>>
>> I agree that the transition may be painful, but as long as the
>> desired semantics is "If you have A/a, you are not allowed to have
>> a/a or a/b", it cannot be avoided---in that sense, I view it as a
>> lower priority issue.
>>
>> Having said that, it may indicate that the desired semantics above
>> may not be the optimal one.  Perhaps the flag might want to be "on
>> this platform, we cannot do case sensitive refs, so pretend as if
>> all refs are lowercase" instead.  I suspect that such a flag may
>> allow smoother transition than what has been proposed.
>>
>> Underlying refs "A/a" and "a/b" can stay as they are in David's
>> central repository, but ref enumeration with the flag enabled will
>> return a/a and a/b, and these are the names that will be fetched by
>> the users.  If the user had an existing A/c, then fetching these
>> will still create A/a and A/b locally, but pushing them back will,
>> under that flag enabled, be turned into updates to a/a, a/b, and a/c
>> on the central server side with updated Git.
>
> The discussion here has made it pretty clear that, given our current
> loose reference and reflog storage schemes, it is not possible to
> implement case-sensitive references or even case-insensitive but
> case-preserving references correctly on a non-case-sensitive filesystem.
>  We would always have spooky non-local conflicts like A/a vs. a/b.
>
> I think we *could* correctly implement
>
> * case-folded reference names (e.g., all lower-case; I wonder if
>   that would also apply to HEAD etc.?)
>
> * case-folded reference names except for the last component, which
>   could be case-insensitive but case-preserving:
>   refs/heads/MyCrazyBranch.  I suppose that many mixed-OS projects
>   effectively use this policy nowadays and that is why we don't hear
>   more complaints about this Git deficiency.
>
> If we had an option to use only packed references in a repository, I
> think we could also implement case-insensitive but case-preserving
> references on a non-case-preserving filesystem.  The packed-refs file
> would be authoritative WRT case, and the case of the reflog directories
> and files would be ignored.  But I would be nervous about promoting this
> style, because it will likely cause performance problems for repos that
> have a lot of refs.
>
> To support arbitrary refname policies on arbitrary filesystems, we of
> course need a different way of storing references and reflogs.
>

Agree.
I think the transaction work can help here for both the cases of refs
(which might be solved by a pacxked-refs only setting) and reflogs.

My next two (small) series for transactions :
https://github.com/rsahlberg/git/tree/ref-transactions-reflog
https://github.com/rsahlberg/git/tree/ref-transactions-rename

reworks the handling of reflogs and all reflog API callers.
With these two series we get to a stage where the reflog API and
implementation both shrinks and becomes more well defined.
We essentially end up with only these functions for touching reflogs:

check if a reflog exists:
extern int reflog_exists(const char *refname);

create/initialize an empty reflog:
extern int create_reflog(const char *refname);

delete a reflog:
extern int delete_reflog(const char *refname);

these two functions iterate/read over all entries for a particular reflog:
int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
void *cb_data);
int for_each_reflog_ent_reverse(const char *refname,
each_reflog_ent_fn fn, void *cb_data);

iterate over all reflogs:
extern int for_each_reflog(each_ref_fn, void *);

write/append an entry to a reflog:
int transaction_update_reflog(struct ref_transaction *transaction,


When we get to that point it will become much easier if we want to
change how reflogs are stored.
If for example we want to default to something else than " a shadow
directory structure under logs/".
So I would like to see those two series as both refactoring the
existing code as well as defining the API for reflogs and in its
extension make it easier to do changes.

For my plan with pluggable refs backends I plan to put the reflogs
inside a TDB database, but if someone wants to, this would also
provide the framework for someone to add a
"core.store_reflog_in_xyz = True" which do something to address the
problems with case insensitive filesystems.



Following those series, I have another small series that has not been
out for review yet:
https://github.com/rsahlberg/git/tree/ref-transactions-req-packed-refs

This particular patch series starts using packed refs as part of a
multi ref transaction.
The main purpose of this is to make transaction_commit() become more
atomic, it particular for better rollbackability but also in order to
make the transaction commit become more atomic for an external
observer as well.
In doing so, for any transactions that affects 2 or more refs it will
start reading and writing to the packed refs file instead of loose
refs.

For example a transaction that will rename a ref, i.e. deleting the
old ref and creating a new ref with the same sha1, it will do
1, copy the old ref to the packed refs file and repack the packed refs.
2, delete the old loose ref
3, delete the old ref from the packed refs file and add the new ref
and then commit this change to the packed refs file.

Or if you are deleting multiple refs :
1, copy all refs to the packed refs file and commit the packed refs
2, delete the loose refs
3, remove the refs from the packed refs file and commit it.

etc.

The patch series as it is today only do this for multi ref
transactions. That is for performance reasons since repacking a huge
packed refs file would be heaps slower than just creating/updating a
single loose ref for the common case of "git commit, and update a
single ref".
We could see this series as also lay the groundwork for an option :
"core.packed_refs_only = True"
which would change transaction_commit() to only operate on packed refs
also for the single ref case, and then you would basically have a
"refs only exist as packed refs mode"
in which case you would have a solution to the case insensitive
filesystem as well.

So we could see this as, once the series is ready for review and/or
use, this would provide almost a solution for a "packed refs only"
mode.



What I am trying to say is that I think we will get multiple ways to
solve the case insensitive filesystem problem as a sideeffect of
finishing the ref transaction work.
Perhaps not full solutions out of the box but at least we should have
ended up with a framework to make it a lot easier to solve these
problems than they are today.




regards
ronnie sahlberg





> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
