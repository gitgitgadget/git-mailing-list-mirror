Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A534920966
	for <e@80x24.org>; Fri, 31 Mar 2017 05:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbdCaFIU (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 01:08:20 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32797 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdCaFIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 01:08:19 -0400
Received: by mail-lf0-f52.google.com with SMTP id h125so37719081lfe.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vuJWGp34pG60rj1fLtI0MwKP/rVyTPJxuvHy5Cf4rlk=;
        b=VX6V2tBlJglB6EZCdwttWg3ys+i8cY8+T3gNmit9/33PCBwVm+waZTwMzmkLWE/+M6
         5fWQEeirhyWMtz4em12zxWWxL5cz7wHsh3izMRXzvaErrKhK20oP4vkHIp61Flsj38p0
         hsuoPqFj78Z05ZULie/hRs58JYl6Bu3Q19lIKL1Gu1SWvbzSu0D95TpnQvEeau+vPIzB
         C2yOKE3yFtKvxZdyEQNWQPVzJNWaPGsdqFTdeX+T9TPVFNCcdbn5MY/vP17R/jCDDAUb
         4GXVzDPhaDDfLvqo8n9rVEUwgRmGniCnXs8F/uGyjSV7Pba0fhhTxp/aQD7yqh2vuw8b
         xrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vuJWGp34pG60rj1fLtI0MwKP/rVyTPJxuvHy5Cf4rlk=;
        b=YA3cxHO/I9J86t73MDx6LajZNErt+8TolW7Ycr5Iwbq18bcLt0na+z7yAFnDinEPM5
         unZh+fOgJZbIXkxWfGcfyAWK+WQRDy2vC/l44tG3wrVmow8GCM7FW3RH8SwGq1GiQ0BT
         AwMuPai/dN/gQUygmYT/8PMWYHVwsj+/UHfokcmOqQAQk3LzbyRdr0n931ma1wa8EOWM
         RxaFU4KzOLwZMDXElPedkNC5PoCqIApllVcjWJ9eowS3gmVaxMTJupZwGGvZ+COXgdf+
         gkf+iS8dv9NL9OpsBvM+6CyYVRq1x2OUS9IyUzqz5hHTgoqvIY25MEzK53md4lh1enpK
         Ko+g==
X-Gm-Message-State: AFeK/H3DCtZwIv6NSEHa5JEFj0Ibk3f32J0uc9xlTFZSQlUyhbV6hSfqMMCaXAw5ok1dF4VNftWxCqXTTJyxiA==
X-Received: by 10.25.18.169 with SMTP id 41mr279218lfs.129.1490936896409; Thu,
 30 Mar 2017 22:08:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Thu, 30 Mar 2017 22:07:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1703300142230.4068@virtualbox>
References: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com>
 <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com> <alpine.DEB.2.20.1703300142230.4068@virtualbox>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Fri, 31 Mar 2017 02:07:46 -0300
Message-ID: <CAEA2_RLX+0Yz-wcdAaEj3Pp0qOKWdHu32T9Vvkk2KSFkzUx7Cw@mail.gmail.com>
Subject: Re: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan & Johannes,

Thank you for the precious feedback on the proposal. I don't see much
sense in sending a full "v2" of it and have you read it all over
again, so I'll just answer to your comments directly.

Also, although the GSoC website allows me to send a "proposal draft"
to you through the website, since I've already sent it here that
shouldn't be necessary, correct? I intend to use it just to send the
final thing.

On Wed, Mar 29, 2017 at 9:01 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 28 Mar 2017, Stefan Beller wrote:
>
>> On Sat, Mar 25, 2017 at 8:15 PM, Daniel Ferreira (theiostream)
>> <bnmvco@gmail.com> wrote:
>>
>> > SYNOPSIS
>> > There are many advantages to converting parts of git that are still
>> > scripts to C builtins, among which execution speed, improved
>> > compatibility and code deduplication.
>>
>> agreed.
>
> I would even add portability. But yeah, speed is a big thing. I am an
> extensive user of `git add -p` (which is backed by
> git-add--interactive.perl) and it is slow as molasses on Windows, just
> because it is a Perl script (and the Perl interpreter needs to emulate
> POSIX functionality that is frequently not even needed, such as: copying
> all memory and reopening all file descriptors in a fork() call only to
> exec() git.exe right away, tossing all of the diligently work into the
> dustbin).

Thanks for this example =E2=80=93 it hadn't come to my mind since I don't u=
se
Git on Windows. I'll be sure to complement the synopsis with it. :)

>
>> > FEASIBILITY
>> >
>> > There was only one discussion regarding the feasibility of its porting
>> > (https://public-inbox.org/git/CAP8UFD2PcBsU6=3DFK4OHVrB7E98ycohS_0pYcb=
CBar=3Dof1HLx+Q@mail.gmail.com/).
>> > It resulted in a consensus that doing it would be a task too large =E2=
=80=93
>> > although interesting =E2=80=93 for GSoC 2015 based on the amount of it=
s lines
>> > of code. It is, however, only a few lines larger than
>> > git-rebase--interactive, which has been considered an appropriate
>> > idea. As such, it looks like a possible project for three months of
>> > full-time work.
>>
>> ok, it sounds a challenging project. (currently counting 1750 lines of
>> code). Scrolling over the source code, there are quite a couple of
>> functions, where the direct equivalent in C springs to mind.
>>
>> run_cmd_pipe -> see run-command.h
>> unquote_path -> unquote_c_style ?
>> refresh -> update_index_if_able()
>> list_modified -> iterate over "const struct cache_entry *ce =3D active_c=
ache[i];"

Thank you for these functions. I don't think I will be able to specify
them in detail as part of the projected timeline (e.g. "June 1:
convert calls to refresh() to use update_index_if_able()") already
because there is not enough time prior to the proposal deadline to
study their behavior in detail, and I like to avoid talking about
things I don't fully understand. Although I think I can cite them as
examples for a thesis I had put elsewhere in the proposal that "Git
APIs in Perl already have functional equivalents in C".

Also, they will be great for my early investigation stage into
git-add--interactive. :) Once more, thanks for having listed them.

> Yes, I think it would be more important to acquaint oneself with the
> idiosynchracies of Git's internal "API" than to get familiar with Perl:
> interpreting what obscure Perl code does is something I would gladly do a=
s
> a mentor.

That's really nice! I usually don't get stuck when trying to
understand code in languages I'm not too well acquainted with, but I
figured getting more familiar with Perl would speed development up.
But it does make sense that this "prior to May 4" might be better
invested learning about git's internals than Perl.

Question: do you suggest any pending bugfix to git-add--interactive or
to something related that might give some useful knowledge in advance?
(for the pre-code period). My microproject involves playing with the
dir_iterator interface, which is a great exercise in code refactoring
but really does not teach me too much about Git's architecture.

Even if you do not have an answer to this, I'm pretty sure I'll keep
this commitment to submitting some patch series somehow related to
git-add before GSoC begins, especially after this comment from
Johannes.

>
>> > PROJECTED TIMELINE
>> > - Prior to May 4
>> > -- Refine my basic knowledge of Perl
>> > -- Craft one or two small patches to some of Git's Perl components
>> > (preferentially to git-add--interactive itself) to improve my
>> > understanding of the language and of how Git's Perl scripts actually
>> > work

So yeah, I think this could be rewritten as:

- Prior to May 4
-- Craft two or three small patch series to git-add--interactive or
related components to improve my understanding of Git's internal
architecture, especially that related to git-add.

>
>> > - May 4 - May 30
>> > -- Clarify implementation details with my mentor, and work on a more
>> > detailed roadmap for the project
>> > -- Investigate roughly how to replace command invocations from the
>> > script with actual builtin functions; which Git APIs in Perl already
>> > have functional equivalents in C; which parts will require a full
>> > rewrite.
>> There are different approaches for replacing functionality in another
>> language. Examples:
>> * Implement the functionality in C and then have a "flag-day" commit
>>   783d7e865e (builtin-am: remove redirection to git-am.sh, 2015-08-04)
>>   This only works when the whole functionality was replaced in prior com=
mits
>> * Implement partial functionality in C and call it via a helper function=
.
>>   3604242f08 (submodule: port init from shell to C, 2016-04-15)
>>   This works well for only partial conversions (the larger the thing to
>>   convert the more appealing this is, as it gets code shipped early.)
>>   When choosing this strategy, this part of the Project would be to
>>   identify parts that could be ported on its own without much
>>   additional glue-code.
>
> To offer my perspective: I strongly prefer the latter approach. Not only
> does it yield earlier results, it also makes it substantially easier to
> handle the project even if it should turn out to be a little larger than
> just 3 months.

I agree. I even think that the latter parts of this projected timeline
imply a choice for the second approach.

For now, Stefan's implementation in 3604242f08 (create a helper
builtin command, call it from a script, do it to other functions until
the whole script is replaced) seems the most natural way to do it. But
sadly, I still do not have enough knowledge about the project to be
able to specify in this proposal how (e.g. in what order) exactly I
intend to "divide" the code to do this. But I'm sure the answer to
this question will be clearer through contact with my mentor and with
growing experience in the project.

>
>> > - May 30 - June 30 (start of coding period)
>> > -- Define the architecture of the builtin within git (which
>> > functions/interfaces will it have? where will its code reside?).
>> > -- Implement a small subset of the builtin (to be defined with my
>> > mentor) and glue it into the existing Perl script. Present this as a
>> > first patch to get feedback early regarding the implementation and
>> > avoid piling up mistakes early.
>> > -- Do necessary changes based on this initial review.
>> > -- Have roughly 1/3 of the script's functionality ported to C.
>> >
>> > - June 30 - July 28
>> > -- Port the remainder of the script to a builtin.
>> > -- Have a weekly roadmap, sending a part of the patch every 15 days to
>> > the mailing list for review and to avoid massive commits by the end of
>> > GSoC.
>>
>> yeah; send early, send often. ;)
>
> Even better: push multiple times a day to a public repository, say, on
> GitHub. That allows for "Work In Progress" commits that not only serve as
> a backup but also as transparent report what was done.

Great idea. It can also be a good way to report my progress to my
mentor. (I'll do my best to avoid "[WIP]" commits with barely any
explanation).

As for the "timeline", I think it can be improved by some better
specification regarding the gradual process of the implementation
opposed to switching from the script to a builtin all at once.

>> > -- Apply suggestions from community reviews when possible; if not,
>> > save them for doing toward the end of GSoC (see below).
>>
>> Please do not underestimate the discussion by community, finding
>> consensus on list consumes a bit of time in some cases.
> I agree with this statement. Ideally, the first patch series would be
> ready to submit very soon into the project, something like 2 weeks (which
> is another point in favor of the helper approach outlined by Stefan).
> The smaller the patch series are, the more likely they will get in
> quickly. And the easier is it to address reviewers' comments, because you
> won't have to send out gazillion unchanged patches of a multi-dozen patch
> series just to address one typo in one patch.

Seems reasonable. I'll amend the proposal to commit to a first patch
series in 2 weeks and to sending a new one every week or less (to
avoid series getting massive). I'll also refrain from postponing
responding to feedback and, when necessary, work in parallel between
amending patches and working on new code. After all, I know how my
schedule will be during the whole GSoC period, but I don't know how
available those in the list will be to review it, so it's probably
best to respond early.

>> > (Note: due to a previous commitment, during a five-day period of July
>> > I will only be able to work part-time on GSoC. The actual week will be
>> > known over the next weeks.)
>>
>> Maybe you want to shift the schedule up to here by one week then?
>> (e.g. the first period would be April 27  - May 23)
>>

I cannot shift the schedule one week earlier during the pre-code
period because Google only releases mentor information on May 4, and
the things I'm planning for the second period depend on the mentor.
However, my classes only start in September 22, so I would have
absolutely no problem continuing to work full-time on Git after the
GSoC period is officially over to compensate for these five days.

>> >
>> > - July 28 - August 29
>> > -- By the start of this period, send a patch with the builtin fully
>> > implemented to the mailing list.
>>
>> /a patch/a patch series consisting of many patches/
>> Experience shows that smaller patches are easier to review as
>> it is more focused.

I will reword it.

>> Consider e.g. e86ab2c1cd (wt-status: convert to struct object_id,
>> 2017-02-21) and the parents leading up to this commit. They work on the
>> same big topic, but focus on very regional areas to ease review.
>>
>> > -- Fix bugs, test extensively, possibly extend test coverage for
>> > git-add--interactive.
>>
>> AFAICT ('$ git grep "git add -i"') there is only t3701 testing the
>> interactive add. Maybe we need to add tests first to document
>> current behavior, before attempting a conversion?
>
> That should indeed be the first step, before doing much else.
>
> However, it does look as if t3701's 40 test cases provide fairly thorough
> coverage.
>
>> This could go well into the period "May 4 - May 30", as writing
>> tests would count as "Clarify implementation details".
>
> I agree with that, too.

Seems reasonable. As I said above, working on patches (if possible)
related to git-add--interactive will probably lead me to discovering
coverage issues, which could then be dealt with in this pre-code
period already with some guidance from my mentor.

> Thanks for working on this!

Thank *you*, and Stefan, for the careful review of it. It means a lot.

-- Daniel.
