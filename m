From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] fetch doc: update introductory part for clarity
Date: Fri, 30 May 2014 10:52:32 -0700
Message-ID: <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
	<1401403350-7122-2-git-send-email-gitster@pobox.com>
	<5388972C.5020307@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 30 19:52:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQyw-0004R4-H3
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbaE3Rwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:52:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52240 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbaE3Rwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:52:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA852198C1;
	Fri, 30 May 2014 13:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtnZp5mIYvLZwJZ1aQ7at+QnBmo=; b=HFfTpJ
	/s3ooDTFGnlNwkU3lQCA0GPOWcNnwN9He7mNMqXel/X30+itbb4ytlnflsFHMGH4
	zkhu+jjmsb9Pm6PnGK2zYtQxQ3JNue1YntziKyAAN5DvfvjQVfNZXTS6wyJGS9VD
	Yesq/GWNwDVH7z3tl0PjNh3YgM4XH8W5PIiJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZSyK3PJlJLuYKrTyNaFk0zgeXKKGoe4b
	+uYBzKRib8ZL7RVxnR/hCNuSHt0IYXgNsbrZMRcg3a1u1HxYb99Ex1K/HZOowv7B
	uooUzFBrFpDw5lwZiPME1nKEWaJQ0zXF6QG91RncFYQwB6gREgTz+JXkaCG85vAA
	Cfe9jWkNDH8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AED86198C0;
	Fri, 30 May 2014 13:52:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D803198BE;
	Fri, 30 May 2014 13:52:34 -0400 (EDT)
In-Reply-To: <5388972C.5020307@xiplink.com> (Marc Branchaud's message of "Fri,
	30 May 2014 10:35:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DE33172-E823-11E3-B843-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250455>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 14-05-29 06:42 PM, Junio C Hamano wrote:
>>  - "Branches" is a more common way to say "heads" in these days.
>> 
>>  - Remote-tracking branches are used a lot more these days and it is
>>    worth mentioning that it is one of the primary side effects of
>>    the command to update them.
>> 
>>  - Avoid "X. That means Y."  If Y is easier to understand to
>>    readers, just say that upfront.
>> 
>>  - Use of explicit refspec to fetch tags does not have much to do
>>    with turning "auto following" on or off.  It is a way to fetch
>>    tags that otherwise would not be fetched by auto-following.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/git-fetch.txt | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>> 
>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
>> index 5809aa4..d5f5b54 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -17,20 +17,23 @@ SYNOPSIS
>>  
>>  DESCRIPTION
>>  -----------
>> -Fetches named heads or tags from one or more other repositories,
>> -along with the objects necessary to complete them.
>> -
>> -The ref names and their object names of fetched refs are stored
>> -in `.git/FETCH_HEAD`.  This information is left for a later merge
>> -operation done by 'git merge'.
>> -
>> -By default, tags are auto-followed.  This means that when fetching
>> -from a remote, any tags on the remote that point to objects that exist
>> -in the local repository are fetched.  The effect is to fetch tags that
>> +Fetch branches and/or tags (collectively, "refs") from one or more
>> +other repositories, along with the objects necessary to complete the
>> +histories of them.
>
> Phrasing: s/the histories of them/their histories/

Yeah, thanks.

>> +
>> +The names of refs that are fetched, together with the object names
>> +they point at, are written to `.git/FETCH_HEAD`.  This information
>> +is used by a later merge operation done by 'git merge'.  In addition,
>
> Isn't this merge stuff about pull, not fetch?

It is true that "git pull" uses "git fetch" and .git/FETCH_HEAD is a
documented mechanism between the two to communicate what commits the
latter downloaded are to be merged by the former, and that is one of
the reasons why we had the description here in the original before
this patch.  A user can also do this to refer to the tip of the
single branch she fetched:

	git fetch origin master
        git log -p ..FETCH_HEAD
        git merge FETCH_HEAD

Perhaps "is used ... by 'git merge'" can be rephrased somehow, like
"can be used to refer to what was fetched"?  Or we could go in the
opposite direction and be more explicit, i.e.

	"git pull" calls "git fetch" internally, and this
	information is used by the former to learn what commits were
	fetched by the latter.

I dunno.

>> +the remote-tracking branches may be updated (see description on
>> +<refspec> below for details).
>
> I realize that "may be updated" is strictly correct, in that if the remote's
> branches have not changed since the last fetch then the local tracking
> branches won't change.
>
> But it took me a second or two to think of that.  The "may" kindof tripped me
> up.  The fact is that the local tracking branches are always updated to match
> the remote's branches, it's just that sometimes the remote's branches don't
> change.  So I think it would be clearer to say
>
> 	the remote-tracking branches are updated
>
> because this makes it clear that the command always makes your local tracking
> branches match the remote's.

The primary reason behind my "may be" was not "they may not have
done anything in the meantime", but was "we may not have configured
to track at all", but in that case by definition we don't have "the
remote-tracking branches", so now I realize that it is pointless to
say "may be updated".
