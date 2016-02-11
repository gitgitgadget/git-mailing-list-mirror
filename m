From: Stefan Beller <sbeller@google.com>
Subject: Re: Gated Merge?
Date: Thu, 11 Feb 2016 15:53:49 -0800
Message-ID: <CAGZ79kY5MT_HZQHwh2EaoN01hEDLcA-=dCTxuejF7yiYwpPRoQ@mail.gmail.com>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
	<CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:53:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU13c-0008Ni-2m
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 00:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbcBKXxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 18:53:53 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36863 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcBKXxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 18:53:50 -0500
Received: by mail-io0-f172.google.com with SMTP id l127so74980402iof.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 15:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=idslWakBFfIQTM82x7K0vXhOQKZdplThZr9mSg/D9J8=;
        b=W37LHzMFVBNjapVAzqeoOzqvpi5nUgpotNZE9TyAVlNZSKoa2Zm7OYUZF/P5LEGzqr
         28zcVxdy/U3ZJ+MA0z/i39ZkaCuYl1gVcXYgq2F6jMN7p2Jcix+MdXhLPGvSxjWh+kj3
         KatfdrqxcsZtySnIaJvJC5MCrZZWlRNDAFCjNO/jP0nR15hwRMuTMVlU0qjavxlmKkag
         Uia8hTKLs8wX1fTX/Ebf2f72iC63xa0YmNmi5vKorBVcnExrYOYg3zkv9ePvs8v8SySp
         P17O8NNuknhDNUrBYEbb9wn8SK5bcNmDb+YiBLfYNPpEWB7Thy9ZcxJUD7bq32hn0GA6
         EIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=idslWakBFfIQTM82x7K0vXhOQKZdplThZr9mSg/D9J8=;
        b=W1Ta9xkHy9KAI2f7NZSSF3rXMHLyMJccGpdLeLhbxMURbrQazPz7xXYkr0oQb5uy3u
         IuBK/uuv9qDP/mhA+U9gHTvV2z56tXqKcJXnYyC8LwQBqoF7v1pcDYgL9rHKE2mqXw+v
         jM/kf6W6TcuAHJHH99gHpQYzL4eezVvONbWtnbwydqEA0vheylB1KnG4vsUoOhoxZtKq
         NFHFNU7eEO4syhpIVKztDI+KMpSeW3t7AaqRQXIv49UB4z7n+caQPbWpwdsr7hY8UJOH
         SQi5oGbAAyp6dzS4lKnUc50ru2WAUWrCsAP38/jdboi1030PZc5VbtfWK0eU4W7Jwe2i
         Qshw==
X-Gm-Message-State: AG10YOSp097xNUIR+YY5z8Sb7mOkOyFbrcLf1ZjdQLVtcu+EZgPo1qfi36JCDY4UT68HsF/toqBGhUwtb7pLkEhd
X-Received: by 10.107.158.81 with SMTP id h78mr26266620ioe.174.1455234829886;
 Thu, 11 Feb 2016 15:53:49 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 11 Feb 2016 15:53:49 -0800 (PST)
In-Reply-To: <CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286019>

On Thu, Feb 11, 2016 at 2:42 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 12 February 2016 at 09:06, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> To realize this, there are low-hanging-fruit building blocks that
>> are trivial:
>>
>>  - Such an annotation can be made as a note attached to the commit
>>    in question;
>>
>>  - Such a check can be done in pre-commit hook;
>>
>>  - Such a pre-commit hook can iterate over this set of commits
>>
>>     DIFF=$(git rev-list --left-right HEAD...MERGE_HEAD)
>>
>>    collect these Merge Gate annotations from the commit appears on
>>    the left hand side (e.g. only exists on the trunk that a side
>>    branch is about to be merged in), and run them.
>>
>> But the last one feels very costly, and I suspect that there must be
>> a better way to do this.  I do not think we want the "what to do"
>> part (i.e. checking new lines for __attribute__ in the first
>> example, or rewriting new lines that has __attribute_ in the second
>> example) to be in git-core; that clearly is outside the scope of the
>> plumbing.  But the part that finds these "annotations", especially
>> if we can come up with a fast implementation that may be hard to
>> script, may be a good addition to the plumbing command set.
>>
>> Thoughts?
>
> What is the benefit in doing this in notes vs having the tests in the
> working tree?
>
> Pros:
>
>  - merge-gates can be added after the commit, but will stick with the
> commit if it moves around (as opposed to creating a second commit to
> add the merge-gate to the working tree)
>
>  - cross repository standards can be established that allow
> merge-gates to be detected and run automatically (arguably could be
> done with a standardised folder structure too, but that is more
> disruptive)
>
>  - can view the relevant merge-gates in git log against each commit
> that they are protecting
>
> Cons:
>
>  - difficult to see the current complete set of merge-gates
>
>  - difficult to make changes to a number of merge-gates at the same time
>
>  - poorly defined behaviour when multiple merge-gates overlap in
> functionality. Which gates execute first? What if I reorder the
> commits?

The way I could imagine "merge gates" currently:

 * they are some kind of invariant to be checked, or an action
performed, an event
 * they can be introduced by a commit X.
 * they can be turned off by a commit Y
 * an offspring commit inherits all "merge gates" from its parents (in
order of the parents

So the event for one merge gate is in effect iff you merge one commit from X..Y

Now we want to know for a given commit C, which merge gates are there?
To find all events we would need to walk the whole history of C and record
all found events, which are not turned off.

So I'd think that could be accelerated with event bitmaps (which work
similar to the
reachability bitmaps, but having a different goal and record which
events are alive
for certain commits, such that you only need to walk a bounded set of commits to
find out.


When first reading this email I thought this is a typical maintainers problem,
so it should happen all the time in larger projects, such as linux, how do they
handle system wide refactorings?

>
>
> My practical knowledge of notes is severely lacking so excuse me if I
> missed anything obvious.
>
> Regards,
>
> Andrew Ardill
>
> (sorry for the double post Junio, gmail ate my plain text encoding at
> some point...)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
