Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981BF1E484
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470552; cv=none; b=T4td5/caUDNoReh4XK4rrfeNJmsuSufiGi8d6EdztsZ3gYg+byKl70ZzLNPhubk4B65h82E3dIr+/grtvO5Cv8suLNEN1vKWCiBxcx8fbwZMmql0ViBy5V/ciezwjkfij4FyxNNn/t1UrJlgoiRZuNrXujAVTLYBuAlDK2+kHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470552; c=relaxed/simple;
	bh=Q9oDDvYc/TAcsnaEWjTDlXvuxW9jcWOHI2bFlSANzMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvdVCWUQhyEoJJJj4CKThwR/A2Nh670+oFV8+cx91wzFvzHTEy8cmnNb1g/kyupD9f3HH4uOIcGYPANvCrmXPp1vUNfZgkDheb7viOIHqB0YxsHPXNz0+SKaQ1yGYd/5WVRK9sN/Lrp/3cJX7vfbA2/LRQMU+GfBXZ86dvaT6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFJZv9Sw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFJZv9Sw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DB3C1F0EC2;
	Tue, 26 Mar 2024 12:29:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q9oDDvYc/TAcsnaEWjTDlXvuxW9jcWOHI2bFlS
	ANzMk=; b=KFJZv9SwRI80SkWfvMRIWMZa5c/3mwaj1TE4dzwJ+TM/Avben/SWoN
	xu7UOpUqcyFcu6eUcVSNr3xYYf+FvImD+I0sJHcUdKij4tJeaNATJSvcSXXD3AiD
	acKIhB3i5yiWB0W4IUWuSnE0vBu66jwYC3FvLu61J5LYotevX0LdI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A7401F0EC1;
	Tue, 26 Mar 2024 12:29:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 191D21F0EBF;
	Tue, 26 Mar 2024 12:29:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Brian Lyles <brianmlyles@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
In-Reply-To: <dda1ba52-7b43-4017-96e7-10080618d4e7@gmail.com> (Phillip Wood's
	message of "Tue, 26 Mar 2024 14:18:10 +0000")
References: <xmqq8r26eyva.fsf@gitster.g>
	<dda1ba52-7b43-4017-96e7-10080618d4e7@gmail.com>
Date: Tue, 26 Mar 2024 09:28:59 -0700
Message-ID: <xmqq1q7xc5ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F3FC29D6-EB8D-11EE-9C92-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
>> +paragraph summary that appears in the "What's cooking" report when it
>> +is picked up to explain the topic.  If you choose to do so, please
>> +write 2-5 lines of a paragraph that will fit well in our release notes
>
> Maybe "please write a 2-5 line paragraph"?

Very true.

>> +(see Documentation/RelNotes/* directory for examples), and make it
>> +the first paragraph of the cover letter.  For a single-patch series,
>> +use the space between the three-dash line and the diffstat, as
>> +described earlier.
>
> I think this is a good idea - one question though, how do you want
> patch authors to indicate that the first paragraph should be used as
> the summary?

I want to start this as a light-weight process for contributors, and
leave the automation for later, because we do not know how this will
be useful in practice.  We may end up talking in inconsistent voices
if the author-supplied summary is used verbatim, so automation has
its limit---the result always need to be copy-edited.

In an case, taking an example from what eventually became 9187b276
(Merge branch 'pw/diff-no-index-from-named-pipes', 2023-07-17),
let's illustrate how the current process works and the proposed new
process would have worked.

The commit log message of the topic reads:

    Merge branch 'pw/diff-no-index-from-named-pipes'

    "git diff --no-index" learned to read from named pipes as if they
    were regular files, to allow "git diff <(process) <(substitution)"
    some shells support.

    * pw/diff-no-index-from-named-pipes:
      diff --no-index: support reading from named pipes
      t4054: test diff --no-index with stdin
      diff --no-index: die on error reading stdin
      diff --no-index: refuse to compare stdin to a directory

The three-line paragraph summary were written by me back then first
in the draft of "What's cooking" being prepared when the topic was
first merged to 'seen', and then the integration process [*1*]
copied the description to the merge commit message.  Such a merge
commit with the summary are made every time the integration cycle
runs, including the time the topic gets merged to 'next' and more
importantly to 'master', at which point, it also gets distributed
into sections of the draft version of RelNotes.

The topic is listed in the release notes for Git 2.42 as one of the
"UI, Workflows & Features":

    * "git diff --no-index" learned to read from named pipes as if they
      were regular files, to allow "git diff <(process) <(substitution)"
      some shells support.

Its cover letter <cover.1688586536.git.phillip.wood@dunelm.org.uk>
started like so:

    In some shells, such as bash and zsh, it's possible to use a command
    substitution to provide the output of a command as a file argument to
    another process, like so:

      diff -u <(printf "a\nb\n") <(printf "a\nc\n")

    However, ...

but you could have started it like so:

    * "git diff --no-index" learned to read from named pipes as if they
      were regular files, to allow "git diff <(process) <(substitution)"
      some shells support.

    In some shells, such as bash and zsh, it's possible to use a command
    substitution to provide the output of a command as a file argument to
    another process, like so:
    ...

and I suspect it would be sufficient to notice that the paragraph
wants to be the topic description.  We may even feed it to
automation if we decide to do so later [*2*].  Until then we

 - identify three-place indented first paragraph that is 2-5 lines
   long whose first line is indented with " * ";

 - somehow use it when adding the topic to "What's cooking" draft;

and then the integration process merges the topic to 'seen' and
uses it in the merge commit log message.  We *can* still copy-edit
what I keep in the draft of "What's cooking" which I send to the
list about twice a week.  When the topic eventually hits 'master',
the integration process would extract these merge log messages from
"git log --first-parent master" output for the batch, and I rearrange
them into sections of RelNotes, while doing the final proofreading.


[Footnotes]

 *1* The Reintegrate script and the other files from the 'todo'
     branch of my git repository are checked out in an untracked
     Meta subdirectory of my primary working area for Git
     development.  It knows how to take topic descriptions from the
     draft of "What's cooking" (also checked out in Meta/) among
     other tricks.

 *2* Teaching "am" to do something useful with the cover letters is
     something I have been wanting to do for quite some time.  Ideas
     other than the topic description we are disussing here include
     allowing the patch submitter to pick a branch name for the
     topic and creating an empty commit at the tip (not the bottom)
     of the topic branch that records the contents of the cover
     letter.
