From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Mon, 8 Feb 2016 10:27:41 -0800
Message-ID: <CAGZ79kYT8EWv6T=3bW_fH+_Q8p74p=JyzbErB+TOPO2VtVQHgQ@mail.gmail.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
	<xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
	<FA2DA97F-D944-4784-8297-E2885F197AC0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 19:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSqXL-0003pH-81
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 19:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbcBHS1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 13:27:43 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37748 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbcBHS1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 13:27:42 -0500
Received: by mail-ig0-f181.google.com with SMTP id 5so64477811igt.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bjH+dyoVlvU/T3J4aTbX8+/BlrRl1DvZzEiX2I167dM=;
        b=HgcLbqy9wdUJEmWb7hiUvIwFlh6OTtMoXeUh7CjB3nIxVDhue/o3giWqfuqq3g/DHT
         O9ZWUGZq1qwvzk3iBXF0YOrbN155wul+rDF0mSkQ3tQ4xcJgHH7QdAqZQiVlLXt+yNbp
         cckoC/UBXnPMgR2rf5+YBiPv9HfOeZZJ3SyxJ8GSN1+VnwiSIvyEjfiHbHtIOp5kZyLE
         Upn2i8soqLnMh0g7chaUzBz647xahOLHKIxe/7hk0VMoLe49eKyoVJRacuZVGXMsSqcJ
         f5iJ6I5Sr8NeQXtAIdYkDABFy/01JboFj2CFX0dxjV0GrbWBTpA8gPfcF1LUVDh+T26u
         GqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bjH+dyoVlvU/T3J4aTbX8+/BlrRl1DvZzEiX2I167dM=;
        b=FQz03l33Jg/PIQUWyo3zBWQ2bIT/oqVLCD8Fmh0qWNxeBvH8B+Em4at575VQypqnBr
         LlWD6MCwiEq1fsLxu6JexztEzh6uzcIOHksCTdNS/uumWA2aCKiSLWlqULtYm/FYlSZj
         TRJXYWt3jv8dfbvBupmL1unC1yw39SR6/x2UogW9jrWJ3XMaFJyRh1Cq4+xNNjyhRHcY
         lrLsn0MPTDzge8lBqlCF9fOcZsX2t9mq31Vi7HdDv7iyK6pPnbzqStwFF3Vg0n/0w7EV
         hYv4/OYuVoVz0W5d+JgPedis/LwG0+qelWUSPLSjECW5ESt1D3KE9v64xaVbSkNtZqdD
         cyTA==
X-Gm-Message-State: AG10YORehTnWsFbeaFcCqWrKLMzUUFeXn6N+lYAfDNNlhOvH76RlBbXArgAZNAItjNo0ow+2/1k4WfLUxPwKCqLF
X-Received: by 10.50.88.74 with SMTP id be10mr205078igb.93.1454956061834; Mon,
 08 Feb 2016 10:27:41 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Mon, 8 Feb 2016 10:27:41 -0800 (PST)
In-Reply-To: <FA2DA97F-D944-4784-8297-E2885F197AC0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285788>

On Sun, Feb 7, 2016 at 5:32 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
>
> On 06 Feb 2016, at 01:05, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Currently when cloning a project, including submodules, the --depth argument
>>> is passed on recursively, i.e. when cloning with "--depth 2", both the
>>> superproject as well as the submodule will have a depth of 2.  It is not
>>> garantueed that the commits as specified by the superproject are included
>>> in these 2 commits of the submodule.
>>>
>>> Illustration:
>>> (superproject with depth 2, so A would have more parents, not shown)
>>>
>>> superproject/master: A <- B
>>>                    /      \
>>> submodule/master:  C <- D <- E <- F <- G
>>>
>>> (Current behavior is to fetch G and F)
>>
>> I think the issue is deeper than merely "--depth 2", and you would
>> be better off stepping back and think about various use cases to
>> make sure that we know what kind of behaviour we want to support
>> before delving into one particular corner case.  We currently pass
>> the depth recursively, and I do not think it makes much sense, but I
>> view it as a secondary question "among the behaviours we want to
>> support, which one should be the default?"  It may turn out that not
>> passing it recursively at all, or even passing a different depth, is
>> a better default, but we wouldn't know until we know what are the
>> desirable behaviour in various workflows.
>>
>> If you are actively working on the superproject plus some submodules
>> but you are merely using the submodule you depicted above, not
>> working on changing it, even when you want the full history of the
>> superproject (i.e. no "--depth 2"), you may not want history of the
>> submodule.  Even though we have a way to say "I am not interested in
>> this submodule AT ALL" by not doing "submodule init", not having
>> anything at all at the path submodule/ may not allow you to build
>> the whole thing, and we currently lack a way to express "I am not
>> interested in the history of this thing, but I need at least the
>> tree that matches the commit referred to by the superproject".
>>
>> If you are working on a single submodule, trying to fix a bug in the
>> context of the whole project, you might want to have a single-depth
>> clone of the superproject and all other submodules, plus the whole
>> history of the single submodule.
>>
>> In either of these examples, the top-level "--depth" does not have
>> much to do with what depth the user wants to use when cloning or
>> fetching the submodule repositories.
>>
>> I have a feeling (but I would not be surprised if somebody who uses
>> submodules heavily has a counter-example from real life) that
>> regardless of "--depth" or full clone, fetching the tip of matching
>> branch is not a good default behaviour.  In your picture, even when
>> depth is not given at all, there isn't much point fetching F or G.
>
> I really wonder in what cases people use the "--depth" option, too.
> For instance I have never used it in either one of the two cases you
> described above. I don't worry about a long running "clone" as it
> usually is a one-time operation.

I think there are 3 use cases.

1) You work on the superproject and don't care about the submodules.
In this case you want the superproject non-shallow and the submodules
may be just fine with depth 1. (Think of libraries pulled in via Git instead
of via the build system)

2) The superproject is a collection of submodules, i.e. not much content
in the superproject except for the submodules. You want to work
in the submodules, i.e. you want the suberproject shallow, and all
submodules deep.

3) same as 2, but you're interested in only one (or a few) submodules,
which means you want superproject and most of the other submodules
shallow, but one submodule needs to be deep.

So covering 1 and 2 is easy, 3 is complicated.
For 1) we can make it so, that the depth argument is not passed on,
but only covers the referenced submodule commits, and then we
introduce another switch "--submodule-depth" to cover 2).

For 3 we don't know which submodules the user is interested in,
so the user needs to unshallow the interesting submodules themselves
after doing a "--depth 1 --submodule--depth 1" clone. "--depth 1" sort of
implies "--submodule--depth 1", though.

>
> However, in case of a continuous integration system that starts with
> a clean state in the beginning of every run (e.g. Travis CI) a
> "clone" operation is no one-time operation anymore. In this case the
> "--depth 1" option makes very much sense to me. This was the situation
> where I realized the problem that Stefan wants to tackle here and I
> tried to make it tangible with a test case [1].

Thanks for the test! The problem to make it work is in making it working
in a backwards compatible way. Instead of the branch, you can just pass
a sha1 to git fetch and it sometimes works (if the server permits fetching
arbitrary or hidden sha1s. Though Jonathan noted this check may be in
the client only and the server trusts the client on not wanting arbitrary
sha1s?)

So for fetching I think we need to have a "--try-to-get-commit <sha1>"
argument for fetch, which depending on the server capabilities and
the history obtained otherwise may try again to fetch the exact sha1.


>
> On top of that I think Git's error message is really confusing if
> you clone a repo with "--depth" that has submodules and Git is not
> fetching the necessary submodule commits:
>
> Unable to checkout '$SHA' in submodule path 'path/to/submodule'
>
> I tried to tackle that with [2] which would detect this case and
> print the following error instead (slightly changed from the patch):
>
> Unable to checkout '$SHA' in submodule path '/path/to/commit'.
> Try to remove the '--depth' argument on clone!
>
> [1] https://www.mail-archive.com/git%40vger.kernel.org/msg82614.html
> [2] https://www.mail-archive.com/git%40vger.kernel.org/msg82613.html
>
>
>>
>>> So to fetch the correct submodule commits, we need to
>>> * traverse the superproject and list all submodule commits.
>>> * fetch these submodule commits (C and E) by sha1
>>
>> I do not think requiring that C to be fetched when the superproject
>> is cloned with --depth=2 (hence A and B are present in the result)
>> is a good definition of "correct submodule commits".  The initial
>> clone could be "superproject follows --depth, all submodules are
>> cloned with --depth=1 at the commits referenced by the superproject
>> tree"--by that definition, you need E but you do not want C.
>>
>> As a specification of the behaviour, the above two might work, but I
>> do not think that should be the implementation.  In other words,
>> "The implementation should behave as if it did the above two" is OK,
>> and it is also OK to qualify with further conditions to help the
>> implementation.  For example, the current structure assumes that E
>> and C are reachable from "some" ref in submodule, so that at least a
>> whole clone of the submodule would give them to you--otherwise you
>> would not be able to even build the superproject at A or B.  Perhaps
>> it is OK to further require that, when you are working in a single
>> branch mode and working on 'master', you are required to have
>> commits C and E reachable on the 'master' branch in the submodule,
>> and that may lets you limit the need for such scanning of the
>> history?
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
