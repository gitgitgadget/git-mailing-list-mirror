From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 15:09:29 -0700
Message-ID: <CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:09:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajZvD-0003RY-5E
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbcCYWJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:09:31 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33815 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbcCYWJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:09:30 -0400
Received: by mail-io0-f179.google.com with SMTP id e3so11920418ioa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0aDQQqN6MbgT9Rrm/G6VQJ9Ey32pCLRuqyAQaYmQD0U=;
        b=nVDhbvQPUvB0PjOG1YdaTdEXAy0o7ePMTs6gTNp/UtAB7mYkZlP5PQsxI0ptn5Ve5S
         uySDTOBaEHkMkw4EWO76pvhXJaGl4ek5Ba1K9xWNs1mXbKkcKBNoEKR3l/azF7mtqWTC
         1dRu1kgcSRmIzgyEj0N8pL1TEs5PFZG7K1wmTwBehWd3GRz8lzgisLY9QN5KLQ9h8mK6
         uBtmhcP5DmMLxi1iV0l/nNATbqpLiqVexk9TXQlAgo4cfs/U4QdoKgx5lVH3PSjaxX8U
         FZwVYHxGnrMUDJS0LrCtGknNpZam+BCnCtQk3bhX5GsqF19atGmBvk9NDvD170u844Xf
         USCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0aDQQqN6MbgT9Rrm/G6VQJ9Ey32pCLRuqyAQaYmQD0U=;
        b=FiSaXuP0cZ95z6JVHM4X5ig8HFpuODpXfg00PxJrTSW0OjN1e4ihkq0MGHg9GYMI6d
         IsGBkSrfisJIl4ZfyuHpDRkggl7/04Y69S91dl01h/Jr3ijt9XNOaSZuwfbmFsxDgqd3
         sOWN0VCfIG7ldalDUOGZn7j9zUv6wOsF0SmIoATo4agiybXbXXTzpIEQlsi2U+bm/c8J
         aEjb6KWOvLSJAVPtWF3FOfdeitZMGxS1N0Sj4JDeA24jrTGdaEZ9d6apilw+qO8QyoZT
         46SFGqozG8a10XfMeDJfPECUdOOus3nz/E4OK8nnB72qNpwJbIuuJTJP+Clhgi9Qhi4s
         3vUA==
X-Gm-Message-State: AD7BkJL5xDHM6Fbmm5/64g2+4Y/Sj3HDtLDVJIJsSMHR5qrp+EBYk4jnS9PI0ntn48W8s9WSo77tJHLAeEd51BSP
X-Received: by 10.107.135.96 with SMTP id j93mr16082527iod.96.1458943769329;
 Fri, 25 Mar 2016 15:09:29 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 15:09:29 -0700 (PDT)
In-Reply-To: <xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289956>

On Fri, Mar 25, 2016 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> This helper is called from the root level of the superproject's
>> working tree (after cd_to_toplevel is done), and has options like
>> --url.  If the user named --url with a relative pathname to a local
>> repository directory (or a bundle file), shouldn't it be adjusted,
>> and wouldn't prefix the only clue what that given path is relative
>> to?  Same for --reference repository's path.
>>
>> I am not sure removing "--prefix=$wt_prefix" without doing "git -C
>> $wt_prefix" on the calling side is the right thing to do.  Even
>> though the options list used by this function does not seem to use
>> OPTION_FILENAME, parse-options API takes prefix exactly because
>> relative pathnames need to be adjusted, and it smells like that the
>> breakage brought in by this change is merely hidden by existing bugs
>> in the code that does not use prefix to adjust relative paths.
>
> As you may be able to guess from the above, I do not fundamentally
> oppose to using "-C $wt_prefix" in place of "--prefix $wt_prefix".
>
> These two should be equivalent, from the callers' point of view.
>
> If you use the "--prefix $wt_prefix" thing, then the called program,
> which starts at the root level of the working tree, just overrides
> the prefix that it would get from the caller, as "prefix" its own
> startup sequence computes when it is invoked by its caller is not
> useful for adjusting the things that are relative to the directory
> the caller originally was invoked at.
>
> The resulting behaviour should be as if the called program were
> originally started inside $wt_prefix directory, the start-up
> sequence crawled up the directory hierarchy to find the root level
> of the working tree and derived $wt_prefix as the prefix that is
> given as the third parameter of any builtin cmd_foo().
>
> And that is what would happen if you used "git -C $wt_prefix" to run
> the program.  So "git -C $wt_prefix" should be functionally
> equivalent to "--prefix $wt_prefix", even though the former is less
> efficient by having to do the discovery and series of chdir(2) only
> to discover the prefix the caller already has.

And the chdir is the only difference.
So you may easily be tempted to think "git -C $wt_prefix" is the
same as  "--prefix $wt_prefix", like I did in the very first attempt
of this series.

The replacement works fine in all tests except for the recursive
tests as then the chdir is an important detail. In the submodule
there is no $wt_prefix (as it is the parents' wt_prefix we passed in),

So here is the example from before:
        repo/ # a superproject repository
        repo/untracked/ # an untracked dir in repo/
        repo/sub/ # a submodule
        repo/sub/subsub # a submodule of a submodule

When calling "git submodule <cmd> --recursive" from within
repo/untracked/, the recursed instance will end up in
repo/sub/ with the parents prefix ("untracked/")

In case of git -C $wt_prefix we would try to chdir into
repo/sub/untracked/ which doesn't exist and our journey ends here.

In case of "--prefix $wt_prefix" we do not chdir in there, but execute
the command in the root of the submodule i.e. "submodule--helper
list" in repo/sub/. As we do not path any path into the listing
in the recursed submodule, there will be no error reporting from
inside of  "submodule--helper list". All output is done in shell
where we have the parents "wt_prefix" and "prefix" from those two
we can derive the "displaypath" which is $(relative_path "$prefix$sm_path"
which relates to "wt_prefix".

So conclusion at this point is: wt_prefix and prefix must stay in sync.

"wt_prefix" is the relative path inside the repository from where the original
command started, and "prefix" is building up when recursing. So once
we recursed into repo/sub/subsub  we would have "prefix" = sub/subsub
and wt_prefix=untracked/, such that we can compute the displaypath to
be "../sub/subsub".

Observation:
If we had wt_prefix=(null) and prefix= "../sub/subsub", the computed
display path would be the same.

So what needs to happen to make git -C $wt_prefix behave the same as
"--prefix $wt_prefix"?

1) in recursing instances we have to have wt_prefix=(null), so that the
  execution is the same as in "--prefix $wt_prefix". This is the same, as
  we don't try to chdir into non existent directories then.
2) Because we have to keep "wt_prefix" and "prefix" in sync, we need to
  subtract the "wt_prefix" from the prefix, such that we end up with
  passing (wt_prefix=(null), prefix= "../sub/subsub") instead of
  (wt_prefix=untracked/, prefix=sub/subsub")
  I wrote subtract, because wt_prefix is always a "positive" path going
  deeper into a path of the superproject. So we can count the number of
  directories and append so many ../ to prefix, which is roughly what happens
  in relative_path.

>
> What bugs me the most is that, even though they should be
> equivalent, you need 1/5 (or 1&2 in the old series) only when you
> use "git -C $wt_prefix" but not "--prefix $wt_prefix".  That means
> that they are not equivalent.  And it is not clear why, i.e. where
> they differ.

As explained above, the chdir is the difference.
Note that I rewrote the commit message in 1/5, to explain that. Maybe
I need to be even more explicit there. The paragraph which I thought would
convey the message:

   When in repo/untracked/ and invoking "git submodule status --recursive",
   the recursed instance of the latter version for listing submodules would
   try to change into the directory repo/sub/untracked, which is a bug.
   This happens as we cd into the submodule in git-submodule.sh without
   clearing wt_prefix, which is the assumed relative path inside the working
   directory.

>
> It could be that the way "--prefix $wt_prefix" work is insufficient
> and "git -C $wt_prefix" does more complete job, and the codepath
> that implements "--prefix $wt_prefix" needs to do more to become
> truly equivalent.  If that is a case, it means that there is a bug
> in "--prefix $wt_prefix" codepath and the callers of the program may
> be compensating for the bug by doing wrong things in order to work
> around the bug.  When switching to "git -C $wt_prefix", you may be
> seeing the effect of these wrong things the callers do, exposed as
> bugs that need to be fixed with 1/5 (or 1&2 in the old series).
>
> And I'd want to see the log message explain how the two ways are not
> equivalent and what "--prefix $wt_prefix" and the current callers
> that use that mechanism get wrong.
>
