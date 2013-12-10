From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Additional git-archive tests
Date: Tue, 10 Dec 2013 10:48:47 -0800
Message-ID: <xmqq8uvsv8xc.fsf@gitster.dls.corp.google.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
	<CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
	<xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
	<CA9E9538-E39B-41CA-BB82-BDD8CF7A2E3F@mac.com>
	<xmqqwqjj3wit.fsf@gitster.dls.corp.google.com>
	<3943DF12-8FE8-4664-8901-C243D588BE82@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSMq-0001JM-RU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3LJStF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 13:49:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab3LJSs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 13:48:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E89D596BC;
	Tue, 10 Dec 2013 13:48:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccBbjSxGteY8CARXDtr+u7rqhzE=; b=RPfrcQ
	zbSP/g1fe8YZ9plWMViq++5ZoTsFGx6jCo9vw6q/jV98XlQgZgvhZwED2vqvep/C
	VatowWXa9Rr+cn7Mf0u/vS4kJZN8ZfGNppkql5fG8jm4WboZbVF2aCfZiStn0URW
	KO9/5au5Vv0NlWIV3bjA7sKAGEayktWiKrki4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MV9q4MfR98dfxYdRUxb7uhVfRZzQp/AH
	9U0g0KB9T3HPCtZWf9+59OSvqoPenyU123iMDT5OYaRIA1/klYmOHLEtQwxTAglt
	da7c3wYQ6pMQ4pdQvyxhrx4F25VTHXxVYg/FyggwzejuyIVyM2BSt1IRpljWGGyW
	kkMEpOv9suI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16003596BA;
	Tue, 10 Dec 2013 13:48:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF8E596B3;
	Tue, 10 Dec 2013 13:48:51 -0500 (EST)
In-Reply-To: <3943DF12-8FE8-4664-8901-C243D588BE82@mac.com> (Nick Townsend's
	message of "Mon, 09 Dec 2013 21:26:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B66AB8FA-61CB-11E3-878D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239146>

Nick Townsend <nick.townsend@mac.com> writes:

>> In other words, are all these new tests expected to pass?
>
> Sorry about that - the first four tests do pass with 1.8.5, the last
> three tests do not currently pass.

OK.

>> So I do not think it is expected to accept tree object names with
>> the HEAD:<path> style syntax, if the user expects a predictable and
>> consistent result.  The third step above attempts to make sure that
>> you name a tree-ish that corresponds to the top-level of the
>> project, i.e. with no <path>.
>> 
> That’s not quite right - paths do work from the root directory - see tests.

I know that they work from the very top, but they _only_ happens to
work from the very top.  As I do not see the code is designed to
compare the prefix (i.e. the subdirectory you are in) and the path
that is tucked after the name of the top-level tree object with a
colon (e.g. path in "HEAD:path") and adjust these two accordingly, I
do not think it was designed to deal with that at all.  The code
just assumes that the tree object corresponds to the top-level, and
the adjustment is done solely by adding the prefix when limiting the
output by paths.

This observation *is* very right. Not designing to deal with that
case may or may not be right, but that is a different issue.

> It was this very useful capability that I sought to add and generalized
> the code to do. 
>> What seems to be supported are:
>> 
>>    cd a && git archive HEAD ;# archives HEAD:a tree
>>    cd a && git archive HEAD -- b ;# archives a/b/ part of HEAD:a as b/
>> 
>> Specifically, it appears that HEAD:./b, HEAD:b etc. are not designed
>> to work, at least to me.
>> ...
>> I am not saying that these should _not_ work, but it is unclear what
>> it means to "work".  For example, what should this do?
>> 
>>    cd a && git archive HEAD:./b $pathspec
>> 
> I think we can clear this up by documenting the cases and choosing
> sensible behaviour _for git-archive_ ie. what people might expect.

I am afraid that this topic is not limited to "git-archive";
"sensible behaviour _for git-archive_" will end up being far from
sufficient.  I would not be surprised if "ls-tree" shares the same
issue, for example.  If you had "subdir/subsubdir/path" (and other
paths) tracked in your project,

    cd subdir
    git ls-tree HEAD:./subsubdir path

is likely to have the same issue as

    cd subdir
    git archive HEAD:./subsubdir path

I would think.

> Here is a suggestion:
>
> a. The pathspec is used as a selector to include things in the archive.
> it is applied after the cwd and treeish selection.

That would mean that doing this in the top-level:

        git archive HEAD:subdir/subsubdir path<TAB>

will not auto-complete the pathname.  In all other Git commands,
vanilla pathspecs (at least the ones that do not use the magic
escape hatch ":/path", etc.) are relative to your current directory,
and I do not think we want a single command to work in an
inconsistent way with respect to that.

> b. The current working directory (if present) prefixes a path in the object
> if one is present.

That is already done at a lower-level get_sha1_with_context(), I
think.

	cd subdir
	git archive HEAD:./subsubdir

will try to use tree subdir/subsubdir in the HEAD commit (but due to
the prefix logic that is not preprared to use such a tree object,
you will get "current working directory is untracked" error).

> c. The path in the object (if present) is prefixed by the cwd (if present) and
> used to select items for archiving. However the composite path so created
> *is not present* in the archive - ie. the leading components are stripped.
> (This is very useful behaviour for creating archives without leading paths)
>
> d. As currently the ―prefix option (not the prefix from setup_git_directory)
>  is prepended to all entries in the archive.
>
> These correspond to the use cases that I have for git archive - extracting all
> or part of a multiple submodule tree into a tgz file, with or without leading
> directories.
>
>> The extended SHA-1 expression HEAD:./b in the subdirectory a/ is
>> interpreted by get_sha1_with_context_1() to be the name of the tree
>> object at path "a/b" in the commit HEAD.  Further, you are giving a
>> pathspec while in a subdirectory a/ to the command.  What should
>> that pathspec be relative to?
>> 
>> In a normal Git command, the pathspec always is relative to the
>> current subdirectory, so, the way to learn about the tree object
>> a/b/c in the HEAD while in subdirectory a/ would be:
>> 
>>    cd a && git ls-tree HEAD b/c
>> 
>> But what should the command line for archive to grab HEAD:a/b/c be?
>> It feels wrong to say:
>> 
>>    cd a && git archive HEAD:./b b/c
> It’s clear to me that if you are in a subdirectory, that is an implicit prefix on the 
> ./b so you retrieve HEAD:a/b  which then archives everything in b without the
> leading a/b. The pathspec is wrong (including the b) and this archive is empty. 
>> 
>> and it also feels wrong to say
>> 
>>    cd a && git archive HEAD:./b c
>> 
> That looks fine to me given the rules suggested above.
>
> Also git-parse manages
> to return the correct thing in this case, so I’d expect this to work.
>
>> No matter what we would do, we should behave consistently with this
>> case:
>> 
>>    treeish=$(git rev-parse HEAD:a/b) &&
>>    cd a &&
>>    git archive $treeish -- $pathspec
>> 
> Well this will fail both in the existing case (‘fatal: current
> working directory is untracked’) and with the scheme proposed
> above (‘fatal: invalid object name $treeish:a/‘)

The thing is the "current working directory is untracked" is a
fallout from the current archive code not expecting to see a
tree-ish specifed in HEAD:<path> style to interact with $cwd (aka
prefix).  Go back to the description in how parse_treeish_arg()
works in the message you are responding to (or to archive.c).  It
says "if we have prefix, grab the tree object that corresponds to
the prefix in the given tree-ish".  When "subdir" is your current
directory, if you give HEAD as the tree-ish, this logic will give
you the subtree HEAD:subdir; if you give anything else that does not
correspond to the top-level of the project, it will not be able to
find such a subtree (by definition, any tree-ish that does not
correspond to the top-level cannot contain "subdir" tree object that
corresponds to "subdir" directory of the top-level; it may contain a
random directory that happens to be named "subdir", but that will be
a different directory from the "subdir" you see at the top-level).

I do not think a workable compromise exists, but one that is closest
to be workable, even though I do not think it is such a great idea,
would be to apply the add "prefix" logic _only_ when the given
tree-ish is known to be at the top-level (e.g. when it was
originally given as a commit).
