Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264CC1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 06:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeBMGnv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 01:43:51 -0500
Received: from mail.javad.com ([54.86.164.124]:38242 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933366AbeBMGnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 01:43:49 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id AC2F83E8B8;
        Tue, 13 Feb 2018 06:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504228;
        bh=hlIe4USYjMakc1bcuoy5W51in1IpxA3HJXXkpydsC3g=; l=12699;
        h=Received:From:To:Subject;
        b=eeirDPowMoAXH/kLkENDvgdcB/OGUSZ/ykq4nBFFo3k+S6jqWT8IOa/q7Sz3LF/rp
         VIOKsBo3Fc17ybSBY5oXLGF0eqbYl+a80WgyhvRmJdCgAQMXQG1ENtBf2prAZJ1Y1p
         r2ErlQb2g5bZ1E6kZC4KKw39TCS2iUqmfkZnomD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504228;
        bh=hlIe4USYjMakc1bcuoy5W51in1IpxA3HJXXkpydsC3g=; l=12699;
        h=Received:From:To:Subject;
        b=eeirDPowMoAXH/kLkENDvgdcB/OGUSZ/ykq4nBFFo3k+S6jqWT8IOa/q7Sz3LF/rp
         VIOKsBo3Fc17ybSBY5oXLGF0eqbYl+a80WgyhvRmJdCgAQMXQG1ENtBf2prAZJ1Y1p
         r2ErlQb2g5bZ1E6kZC4KKw39TCS2iUqmfkZnomD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504228;
        bh=hlIe4USYjMakc1bcuoy5W51in1IpxA3HJXXkpydsC3g=; l=12699;
        h=Received:From:To:Subject;
        b=eeirDPowMoAXH/kLkENDvgdcB/OGUSZ/ykq4nBFFo3k+S6jqWT8IOa/q7Sz3LF/rp
         VIOKsBo3Fc17ybSBY5oXLGF0eqbYl+a80WgyhvRmJdCgAQMXQG1ENtBf2prAZJ1Y1p
         r2ErlQb2g5bZ1E6kZC4KKw39TCS2iUqmfkZnomD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518504228;
        bh=hlIe4USYjMakc1bcuoy5W51in1IpxA3HJXXkpydsC3g=; l=12699;
        h=Received:From:To:Subject;
        b=eeirDPowMoAXH/kLkENDvgdcB/OGUSZ/ykq4nBFFo3k+S6jqWT8IOa/q7Sz3LF/rp
         VIOKsBo3Fc17ybSBY5oXLGF0eqbYl+a80WgyhvRmJdCgAQMXQG1ENtBf2prAZJ1Y1p
         r2ErlQb2g5bZ1E6kZC4KKw39TCS2iUqmfkZnomD8=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1elUJd-0001wC-Tp; Tue, 13 Feb 2018 09:43:45 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi4edbp3.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 13 Feb 2018 09:43:45 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 12 Feb 2018 21:39:15 +0100
        (STD)")
Message-ID: <87d1198k4e.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,
>
> On Mon, 12 Feb 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> > On Fri, 9 Feb 2018, Sergey Organov wrote:
>> >
>> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> >> 
>> >> [...]
>> >> 
>> >> > With this patch, the goodness of the Git garden shears comes to `git
>> >> > rebase -i` itself. Passing the `--recreate-merges` option will generate
>> >> > a todo list that can be understood readily, and where it is obvious
>> >> > how to reorder commits. New branches can be introduced by inserting
>> >> > `label` commands and calling `merge - <label> <oneline>`. And once this
>> >> > mode has become stable and universally accepted, we can deprecate the
>> >> > design mistake that was `--preserve-merges`.
>> >> 
>> >> This doesn't explain why you introduced this new --recreate-merges. Why
>> >> didn't you rather fix --preserve-merges to generate and use new todo
>> >> list format?
>> >
>> > Because that would of course break existing users of
>> > --preserve-merges.
>> 
>> How exactly?
>
> Power users of interactive rebase use scripting to augment Git's
> functionality. One particularly powerful trick is to override
> GIT_SEQUENCER_EDITOR with an invocation of such a script, to perform
> automated edits. Such a script breaks when we change the format of the
> content to edit. If we change the format of the todo list generated in
> --preserve-merges mode, that is exactly what happens. We break existing
> users.

I didn't say a word against "--preserve-merges mode", whatever it is,
only about re-using "--preserve-merges" command-line option to "git
rebase", the git user interface. I'm sure you see the difference? Unless
there are out-of-git scripts that do use "git rebase --preserve-merges"
and simultaneously do rely on the todo list format this exact command
generates, there should be no breakage of existing users caused by
changing todo list format generated by  "git rebase --preserve-merges".

Old broken "--preserve-merges mode" could be then kept in the
implementation for ages, unused by the new fixed "git rebase
--preserve-merge", for the sake of compatibility.

> BTW it seems that you did not really read my previous reply carefully
> because I referenced such a use case: the Git garden shears.

I thought I did. You confirm below that this script doesn't use "git
rebase --preserve-merges" in the first place, nor will it break if "git
rebase --preserve-merges" starts to generate new todo format, yet you
expected I'd readily see how it's relevant? No, I'm not that clever, nor
am I a mind-reader.

> They do override the sequencer editor, and while they do not exactly
> edit the todo list (they simply through the generated one away), they
> generate a new todo list and would break if that format changes. Of
> course, the shears do not use the --preserve-merges mode,
> but from just reading about the way how the Git garden shears work, it
> is quite obvious how similar users of --preserve-merges are likely to
> exist?

Maybe, I dunno. If even "garden shears" won't break, then what will? Do
you know an example?

Anyway, as it seems it's too late already for such a change, let me stop
this and assume there are indeed such scripts that will break and that
it's indeed a good idea to introduce new option. Case closed. The manual
should still be fixed though, I think.

>> Doesn't "--recreate-merges" produce the same result as
>> "--preserve-merges" if run non-interactively?
>
> The final result of a rebase where you do not edit the todo list? Should
> be identical, indeed.

That's good to hear.

> But that is the most boring, most uninteresting, and least important use
> case.

For you. Do you suddenly stop caring about compatibility?

> So we might just as well forget about it when we focus on keeping
> Git's usage stable.

Why? It's good it behaves the same, so --preserve-merges could indeed be
deprecated, as you apparently intend.

>> > So why not --preserve-merges=v2? Because that would force me to
>> > maintain --preserve-merges forever. And I don't want to.
>> >
>> >> It doesn't seem likely that todo list created by one Git version is
>> >> to be ever used by another, right?
>> >
>> > No. But by scripts based on `git rebase -p`.
>> >
>> >> Is there some hidden reason here? Some tools outside of Git that use
>> >> old todo list format, maybe?
>> >
>> > Exactly.
>> >
>> > I did mention such a tool: the Git garden shears:
>> >
>> > 	https://github.com/git-for-windows/build-extra/blob/master/shears.sh
>> >
>> > Have a look at it. It will inform the discussion.
>> 
>> I've searched for "-p" in the script, but didn't find positives for
>> either "-p" or "--preserve-merges". How it would break if it doesn't use
>> them? What am I missing?
>
> *This* particular script does not use -p.
>
> But it is not *this* particular script that I do not want to break!

I thought that was an example of a tool that would break. Well, it won't
break. Good.

> It is *all* scripts that use interactive rebase!

I'm really interested, and here I *do* ask for education. What are
those? As I now only ask this out of curiosity, and don't argue
--recreate-merges anymore, are you finally willing to reveal the
information?

> Don't you also care about not breaking existing users?

I do care. I just suspected they are very unlikely to exist, and I do
want to be educated in this matter indeed, as they could be rather
interesting.

[Please notice violation of your own standard of not using "Don't
you...", not that I care myself.]

>> >> Then, if new option indeed required, please look at the resulting manual:
>> >> 
>> >> --recreate-merges::
>> >> 	Recreate merge commits instead of flattening the history by replaying
>> >> 	merges. Merge conflict resolutions or manual amendments to merge
>> >> 	commits are not preserved.
>> >> 
>> >> -p::
>> >> --preserve-merges::
>> >> 	Recreate merge commits instead of flattening the history by replaying
>> >> 	commits a merge commit introduces. Merge conflict resolutions or manual
>> >> 	amendments to merge commits are not preserved.
>> >
>> > As I stated in the cover letter, there are more patches lined up after
>> > this patch series.
>> 
>> Good, but I thought this one should better be self-consistent anyway.
>> What if those that come later aren't included?
>
> Right, let's just rip apart the partial progress because the latter
> patches might not make it in?

No, let's fix it instead.

>
> I cannot work on that basis, and I also do not want to work on that basis.
>
> If you do not like how the documentation is worded, fine, suggest a better
> alternative.

I suggested to re-use --preserve-merges command-line option to "git
rebase", unless there are actual users that would break. But as you
believe that's wrong idea, then it could be something like this in the
manual:

--recreate-merges::
	Recreate merge commits instead of flattening the history. Merge
	conflict resolutions or manual amendments to merge commits are
	not preserved. 

-p::
--preserve-merges::
	This option is similar to --recreate-merges, but doesn't
        support interactive mode properly. This option is deprecated,
        use --recreate-merges instead.

>
>> > Have a look at https://github.com/git/git/pull/447, especially the
>> > latest commit in there which is an early version of the deprecation I
>> > intend to bring about.
>> 
>> You shouldn't want a deprecation at all should you have re-used
>> --preserve-merges in the first place, and I still don't see why you
>> haven't. 
>
> Keep repeating it, and it won't become truer.

It is just my point that I repeat, and you gave no evidence it is false,
so I assume it's true, unless proved otherwise.

[...]

> Or for that matter like the design you proposed, to use --first-parent for
> --recreate-merges. Or to use --first-parent for some --recreate-merges,
> surprising users in very bad ways when it is not used (or when it is
> used). I get the impression that you still think it would be a good idea,
> even if it should be obvious that it is not.

What you describe here is bad idea indeed, but it has little to do with
what I actually have in mind and what you apparently don't want to even
try to understand.

>> > Also, please refrain from saying things like... "Don't you think ..."
>> >
>> > If you don't like the wording, I wold much more appreciate it if a better
>> > alternative was suggested.
>> 
>> Sorry, but how can I suggest one if I don't understand what you are
>> doing here in the first place? That's why I ask you.
>
> There are ways to put the person you ask on trial. And there are ways to
> genuinely show interest and seek education.

I didn't seek education, nor did I intend any trial. I asked for
clarification of the patch to the manual page that you wrote in a way
that made resulting manual page confusing for me. Confusing manual is
often indication of some additional problem(s) elsewhere, that's what
I've learned for sure, from multiple occasions, so I did reveal my
doubts.

> I am a really poor example how to communicate properly, of course, so
> don't try to learn from me. I am trying myself to learn better ways to
> express what I mean clearly, and to express it in a direct yet kind
> manner.
>
>> >> Don't you think more explanations are needed there in the manual on
>> >> why do we have 2 separate options with almost the same yet subtly
>> >> different description? Is this subtle difference even important? How?
>> >> 
>> >> I also have trouble making sense of "Recreate merge commits instead of
>> >> flattening the history by replaying merges." Is it "<Recreate merge
>> >> commits by replaying merges> instead of <flattening the history>" or is it
>> >> rather "<Recreate merge commits> instead of <flattening the history by
>> >> replaying merges>?
>> >
>> > The documentation of the --recreate-merges option is not meant to explain
>> > the difference to --preserve-merges. It is meant to explain the difference
>> > to regular `git rebase -i`, which flattens the commit history into a
>> > single branch without merge commits (in fact, all merge commits are simply
>> > ignored).
>> 
>> Yeah, that's obvious, but the point is that resulting manual is ended
>> up being confusing.
>
> Again, just saying something is bad, is bad. Saying something leaves room
> for improvement and then suggesting how to improve it, is good.

Please see wording suggestion above.

>> > And I would rather not start to describe the difference between
>> > --recreate-merges and --preserve-merges because I want to deprecate the
>> > latter, and describing the difference as I get the sense is your wish
>> > would simply mean more work because it would have to be added and then
>> > removed again.
>> 
>> I suspect you actually didn't need those new option in the first place,
>> and that's the core reason of these troubles.
>
> Are you suspecting that I, myself, do not use --recreate-merges?

I suspect that if you've had rather changed --preserve-merges, you'd
happily use it and no --recreate-merges were ever necessary. You did
what you did, and it seems to be too late to ask for changing it back,
exactly due to heavy use of this new option.

> If so, please read the cover letter again, in particular the part where I
> describe how this entire series of patch series arose from the Git garden
> shears, which I invented myself to help with maintaining Git for Windows,
> and which I use for five years now. This should help disperse that
> suspicion rather quickly: the intent of --recreate-merges is to allow me
> to simplify the shears by quite a bit, and maybe eventually even get rid
> of the script altogether (if I ever manage to convince myself that the
> concept of a merging-rebase should be official enough to enter core Git).
>
> I am a heavy user of --recreate-merges, even if it does not really exist
> yet. I have five years of experience with it, which is the reason why I am
> so confident about its design, and why I can tell you a lot about typical
> use cases and common pitfalls, and where the original design had to be
> adjusted.

I fail to see how anything of the above would change should
--recreate-merges be still called --preserve-merges, but I do see why
you don't want that to happen now, so please only consider fixing of the
manual page.

-- Sergey
