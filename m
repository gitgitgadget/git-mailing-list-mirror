From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: git smudge filter fails
Date: Tue, 15 Mar 2016 12:17:16 -0400
Message-ID: <CAH8BJxHvg1cnzdsnVsHLYm2BAoqNxp8-mNyVxRy4CHqv0rgN6g@mail.gmail.com>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
	<20160310015939.GA12709@sigill.intra.peff.net>
	<CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
	<20160310210544.GB30595@sigill.intra.peff.net>
	<xmqqtwkec7lk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:17:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afres-00044s-QT
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934053AbcCOQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:17:19 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33653 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcCOQRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:17:18 -0400
Received: by mail-wm0-f50.google.com with SMTP id l68so152331545wml.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KR7NpkBXofeslJdJj3YJYRSDFoDT25ccI00AAvw8rtc=;
        b=ZJvuC82M2HVn21WbF7Jq3Iyx5fBpd/ZulSLbChH9GGLTmVOK13oklpLFAQcbGh2VCx
         teTWYKpRn80zsMrGTEBl4nUsjmz27b8MVo53W5Fg/nrmxGl5UXJeIfZOTvVUSSx2H+7D
         fXNH8O+vkZR+pz3NYA16AG0JJGrMbHY9UGj9M2SU141S2wjXI0qLaeiadwnyrav47MZb
         XGKxznccbYPGXJEAp2tYDbCs6HJ9v+rf1CtSpTeYl2oTsnjoA+VECjWfwdDexcZNeG0A
         NnLzKDnbwY9ia+gC6jJ7E0Bfc+hZI6xI0bg/Qx97HccjVnRaxIQ0Rb4lKjDt458qpVz8
         /5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KR7NpkBXofeslJdJj3YJYRSDFoDT25ccI00AAvw8rtc=;
        b=XImNw0zsj5hBTKRrmeZraFRGAAZaXw/rRclC+Vxp1xm72Oxi+fykAkkZH5m/Zi0sLM
         q3ztbmZG1uh5OlAb7sfT6Z59ePndqmANpIm+YFzDy6ewt0YyOcK0Tpu+L5cX6rgTQANr
         F5MQfh527HwfPYsPX6WjRdSzXS/1TvB0pQGO4Idf568GyYFTlgVKHNnEDXP0swQyUyVP
         kxPUOp/3aTAPQVNG8djj6tZ5RacN4aJa3V5P5mhQI0uKWIcvJSisA4jEsURjYsspvUmt
         WPUSzMqDfI1JMjQT8i18Ztq/R7SeufEBnvWoXlSAejLYgfbs7mo5pgVQwa/o3EYBi50w
         hH7A==
X-Gm-Message-State: AD7BkJJKb1S6xeSrxRImFZYHk+JBADRRB8zhKmNTzSZyIIFFb4A1ueuULxwHCAHkB4qqJzSBS2JQnwxdWkkQHw==
X-Received: by 10.28.18.85 with SMTP id 82mr26116727wms.5.1458058636780; Tue,
 15 Mar 2016 09:17:16 -0700 (PDT)
Received: by 10.194.63.82 with HTTP; Tue, 15 Mar 2016 09:17:16 -0700 (PDT)
In-Reply-To: <xmqqtwkec7lk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288858>

On Thu, Mar 10, 2016 at 5:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Mar 10, 2016 at 09:45:19AM -0500, Stephen Morton wrote:
>>
>>> I am a bit confused because this is basically the example used in
>>> ProGit [1] and it is fundamentally broken. In fact, if I understand
>>> correctly, this means that smudge filters cannot be relied upon to
>>> provide any 'keyword expansion' type tasks because they will all by
>>> nature have to query the file with 'git log'.
>>
>> Interesting. Perhaps I am missing something (I am far from an expert in
>> clean/smudge filters, which I do not generally use myself), but the
>> example in ProGit looks kind of bogus to me. I don't think it ever would
>> have worked reliably, under any version of git.
>>
>>> (Note that although in my example I used 'git checkout', with an only
>>> slightly more complicated example I can make it fail on 'git pull'
>>> which is perhaps a much more realistic use case. That was probably
>>> implied in your answer, I just wanted to mention it.)
>>
>> Yeah, I think the issue is basically the same for several commands which
>> update the worktree and the HEAD. Most of them are going to do the
>> worktree first.
>
> You can have a pair of branches A and B that have forked long time
> ago, and have a path F that has been changed identically since they
> forked, perhaps by cherry-picking the same change.  This happens all
> the time.
>
> If there were some mechanism that modifies the checked out version
> of F with information that depends on the history that leads to A
> (e.g. "which commit that is an ancestor of A last modified F?")
> when you check out branch A, it will become invalid when you do "git
> checkout B", because the path F will not change because they are the
> same between the branches.  In short, CVS $Id$-style substitutions
> that depend on the history fundamentally does not work, unless you
> are willing to always rewrite the whole working tree every time you
> switch branches.
>
> The smudge and clean filters are given _only_ the blob contents and
> nothing else, not "which commit (or tree) the blob is taken from",
> not "which path this blob sits in that tree-ish", not "what branch
> am I on" and this is a very much deliberate design decision made in
> order to avoid leading people to a misguided attempt to mimick CVS
> $Id$-style substitutions.
>


I will raise an Issue with ProGit.

It's perhaps beyond the scope of my original question, but for
situations where I need a "last change date" embedded in a file (e.g.
because a protocol standard requires it), is there any recommended way
to do so? We've the hard way that hardcoding makes
merging/cherry-picking a bit of a nightmare and should be avoided. Is
a post-checkout hook the way to go? I've actually found the smudge
filter to be very slow for this application as each file is processed
in series; a post-commit hook that could operate on files in parallel
would likely be substantially faster.

Stephen

(Sorry about the earlier top-posting. I didn't realize what gmail was
doing until after it had happened.)
