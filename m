From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][GSoC] Calling for comments regarding rough draft of proposal
Date: Wed, 19 Mar 2014 14:30:59 -0700
Message-ID: <xmqqtxat27vw.fsf@gitster.dls.corp.google.com>
References: <CAEc54XAvdOFQLFE_odEKDGjrqNo+vtYfHafUvKS0OazUQ1r-Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tanay abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQO4x-0007gk-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbaCSVbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:31:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395AbaCSVbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:31:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0112074816;
	Wed, 19 Mar 2014 17:31:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+We11H0lkXOw0/QB2KYqrqrkJnU=; b=NQkEQP
	wXWPm1aEqzZ+D4eqcDJFxzNNsL1pB+hQuPvZb0yWcZ6AMNGXPBLkAZPV1495FYrY
	9oVP2ErumN/bJOBWrB/lquiGMuBQwhGFTJ8aTi3wBXiQvC1rqsrKKRcJRZGWBQ19
	P3ioZTdYBx/fDVRRR8qpM0Myx0eDTrRAoj+bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZhSSE9L5UfqZjskjwfeFLao6+Y/Cs37
	TUZcyfomg0JnNLxHCxiSqLSx7Fa23fs+rjV282P7jFYe8rjdPtumxRi8LC/Dlvz8
	S/FAqtzZrl+EXVpJnTQ3A0kD8x3BdA5inGWDY9AinJg6yt+S7qPRzI6ga2z7OHgA
	nojFP45pkMc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD4074815;
	Wed, 19 Mar 2014 17:31:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A3EC74813;
	Wed, 19 Mar 2014 17:31:01 -0400 (EDT)
In-Reply-To: <CAEc54XAvdOFQLFE_odEKDGjrqNo+vtYfHafUvKS0OazUQ1r-Ag@mail.gmail.com>
	(tanay abhra's message of "Thu, 20 Mar 2014 01:22:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C47AAB64-AFAD-11E3-A3B6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244497>

tanay abhra <tanayabh@gmail.com> writes:

> 2.Other things I should add to the proposal that I have left off?I am
> getting confused what extra details I should add to the proposal. I
> will add
> the informal parts(my background, schedule for summer etc) of the
> proposal later.

I would not label the schedule and success criteria "informal";
without them how would one judge if the proposal has merits?

Other things like your background and previous achievements would
become relevant, after it is decided that the proposed project has
merits, to see if you are a good fit to work on that project, so I
agree with your message that it is sensible to defer them before the
other parts of the proposal is ironed out.

> #Proposed Improvements
>
> * Fix "git config --unset" to clean up detritus from sections that are
> left empty.
>
> * Read the configuration from files once and cache the results in an
> appropriate data structure in memory.
>
> * Change `git_config()` to iterate through the pre-read values in
> memory rather than re-reading the configuration
>   files.
>
> * Add new API calls that allow the cache to be inquired easily and
> efficiently.  Rewrite other functions like
>  `git_config_int()` to be cache-aware.

I think we already had a discussion to point out git_config_int() is
not a good example for this bullet point (check the list archive).
The approach seciton seems to use a more sensible example (point 2).

> * Rewrite callers to use the new API wherever possible.
>
> * How to invalidate the cache correctly in the case that the
> configuration is changed while `git` is executing.

I wouldn't list this as an item of "list of improvements".

It is merely a point you have to be careful about because you are
doing other "improvements" based on "read all into memory first and
do not re-read files" approach, no?  In the current code, when
somebody does git_config_set() and then later uses git_config() to
grab the value of the variable set with the first call, we will read
the value written to the file with the first call.  With the
proposed change, if you parse from the file upfront, callers to
git_config_set() will need to somehow invalidate that stale copy in
memory, either updating only the changed part (harder) or just
discarding the cache (easy).

> ##Changing the git_config api to retrieve values from memory
>
> Approach:-
>
> We parse the config file once, storing the raw values to records in
> memory. After the whole config has been read, iterate through the records,
> feeding the surviving values into the callback in the order they were
> originally read
> (minus deletions).
>
> Path to follow for the api conversion,
>
> 1. Convert the parser to read into an in-memory representation, but
>    leave git_config() as a wrapper which iterates over it.
>
> 2. Add query functions like config_string_get() which will inquire
> cache for values efficiently.
>
> 3. Convert callbacks to query functions one by one.
>
> I propose two approaches for the format of the internal cache,
>
> 1.Using a hashmap to map keys to their values.This would bring as an
>  advantage, constant time lookups for the values.The implementation
>  will be similar to "dict" data structure in python,
>
>  for example, section.subsection --mapped-to--> multi_value_string

I have no idea what you wanted to illustrate with that "example" at
all.

>  This approach loses the relative order of different config keys.

As long as it keeps the order of multi-value elements, it should
not be a problem.

> 2.Another approach would be to actually represent the syntax tree of the
>   config file in memory. That would make lookups of individual keys more
>   expensive, but would enable other manipulation. E.g., if the syntax
>   tree included nodes for comments and other non-semantic constructs, then
>   we can use it for a complete rewrite.

"for a complete rewrite" of what?

>  And "git config" becomes:
>
>   1. Read the tree.
>
>   2. Perform operations on the tree (add nodes, delete nodes, etc).
>
>   3. Write out the tree.
>
> and things like "remove the section header when the last item in the
> section is removed" become trivial during step 2.

Are you saying you will try both approaches during the summer?

You should be able to look-up quickly *and* to preserve order at the
same time within one approach, by either annotating the tree with a
hash, or the other way around to annotate the hash with each node
remembering where in the original file it came from (which you will
need to keep in order to report errors anyway).

> ----------------------------------------------------------------------
> ##Tidy configuration files
>
> When a configuration file is repeatedly modified, often garbage is
> left behind.  For example, after
>
>     git config pull.rebase true
>     git config --unset pull.rebase
>     git config pull.rebase true
>     git config --unset pull.rebase
>
> the bottom of the configuration file is left with the useless lines
>
>     [pull]
>     [pull]
>
> Also,setting a config value, appends the key-value pair at the end of
> file without checking for empty main keys
> even if the main key(like [my]) is already present and empty.It works
> fine if the main key with an already present
> sub-key.
>
> for example:-
>     git config pull.rebase true
>     git config --unset pull.rebase
>     git config pull.rebase true
>     git config pull.option true
> gives
>     [pull]
>     [pull]
>         rebase = true
>         option = true
>
> Also, a possible detriment is presence of comments,
> For Example:-
>     [my]
>             # This section is for my own private settings

Another example you need to consider is

	# Comment regarding the entire [my] section
        [my]
        	# Comment on the item foo
                foo = true
		# Comment on the item bar
                bar = false


What should "git config --unset my.foo && git config -unset my.bar" do?
What if these are done in a different order?

>
> Expected output:
>
>   1. When we delete the last key in a section, we should be
>      able to delete the section header.
>
>   2. When we add a key into a section, we should be able to
>      reuse the same section header, even if that section did
>      not have any keys in it already.
>
> Possible approaches:-
>
> 1.Leave the empty section header as it was and when a new value is set,
>   reuse the header instead of appending at the end of the config file.
>   I am going through the code to find find other solution for this problem.
>
> links:-
> [1]http://thread.gmane.org/gmane.comp.version-control.git/219505
> [2]http://thread.gmane.org/gmane.comp.version-control.git/208113
>
> -----------------------------------------------------------------------
>
> Thanks,
> Tanay Abhra.
