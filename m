Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D551F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbcHCRsG (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:48:06 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34005 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbcHCRsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:48:01 -0400
Received: by mail-io0-f171.google.com with SMTP id q83so250785221iod.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:48:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R6Ik/qaQbTrMSwWH84yZuzFAnrwswGixi6/Pnh4AJV4=;
        b=Q26Qx4zvvrvprk9dUqibezIe5UubcdRsaYfmSdLo2OHa17FS/eSTMp5EHZoQYh2gHe
         NzyF8zDPqTJyyqbm38Dfa9i5vZJCkRdOJlP2NqPvoaSVzDheG9/BOfL9RzbkRUUSPA29
         q47rlXBe1nMKtFieDZUT3p0vyjGGaFvw/QsYJeHhWt3Dk/IbJqFD8NrkAB1sbI4r07ax
         3f4xq3+7k79cWekvMY4zG4S0bza5aE0EUcC97owcQjorOrdpI6qJuSJOmP9F2431Cdmy
         xtZMimbT0E+q7hBOLgIiVUouEQjFvih1nJhMkxiYkpNxjqKeXbNZsiXv5PkSgOox3OYF
         eGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R6Ik/qaQbTrMSwWH84yZuzFAnrwswGixi6/Pnh4AJV4=;
        b=GooBV82ePr1kQZ1cxYm0YwAIsveoUDt59HjKDRqL395uAyqNslXhgDX3LlaXiezPWa
         2lrAyS2koWkS+dTFkZp1r6tF1eyDxd9nGfSya6ka5e7v/9zgxq7/xf0hNbKUL7hpupye
         EbgBGIn91/+9/ztlaYVt3fTEOTE4oaiX3g7KqR7CXhDtaprYZL3dJfgxu/12Zu6F917i
         D8r2ZVN1Y8nqQmbVabQq7L8Z5phE4HFSjr6ciIT+Llnp46DgsW1HYRzvOllE9+Q/ahSz
         /bHsBKdbsLacwlkNOSJ7rhMav9QZLB9K7Ri9znUMWFNe1IRj4HNXpRQWZIiQx0p5Xt90
         ikig==
X-Gm-Message-State: AEkoouvvqxwAfpXErl4pFxL5x0SiLai43unBiD6UMUaRJ6CK7YjB5/8st35MaEiohbZjMKSzClBYPNtP8MBOnLZG
X-Received: by 10.107.144.10 with SMTP id s10mr65956258iod.165.1470246479850;
 Wed, 03 Aug 2016 10:47:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 10:47:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031753431.107993@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 10:47:59 -0700
Message-ID: <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 9:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Wed, 3 Aug 2016, Junio C Hamano wrote:
>
>> On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > I disagree, however, with the suggestion to sift through your `pu` branch
>> > and to somehow replace local branches with the commits found there.
>>
>> To be more in line with the "e-mailed patch" workflow, I think what I should
>> do is to send the version I queued with fixups back to the list as follow-up.
>> Just like reviewers review, the maintainer reviews and queues, the original
>> author should be able to work in the same workflow, i.e. reading and applying
>> an improved version of the patch from her mailbox.
>
> You seem to assume that it isn't cumbersome for people like me to extract
> patches out of mails and to replace existing commits using those patches.
>
> So it probably comes as a huge surprise to you to learn that this *is*
> cumbersome for me.

It is also cumbersome for me, because I never had the need to setup a proper
mail client that has the strength to apply patches. The need was not there as
I tend to apply only rarely patches by email, so I can go the painful
way each time.

But if we as a community decide that we bounce emails back and forth,
I (and you)
may have to find a proper email client that is easy to work with, e.g.
one key shortcut
to apply a patch series to the HEAD of your local repository.

>
> I got too used to the ease of git push, git pull with or without --rebase,
> and many other Git commands. Having to transmogrify code changes from
> commits in Git into a completely different universe: plain text patches in
> my mailbox, and back, losing all kinds of data in the process, is just
> not at all that easy. And it costs a lot of time.
>
> In short: if you start "submitting patches" back to me via mail, it does
> not help me. It makes things harder for me. In particular when you add
> your sign-off to every patch and I have to strip it.

You don't have to strip the sign off, as it shows the flow of the patch,
e.g.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

may indicate you proposed a patch, Junio picked it up (and fixed a
typo optionally),
I obtained the patch (via mail, via Git?) improved it, you improved it further
and then Junio took it and merged it upstream.

>
> If you change your workflow, I would humbly request that you do it in a
> way that makes things easier on both sides, not harder.

When attending the Git Merge conference in May, gregkh said roughtly:
"We deliberately waste developers time, because it is not scarce.
Maintainers time is scarce however " and it stuck with me. (and I
am a developer, not a maintainer ;( so at least the kernel community
deems it ok to waste my time).

While that is true for the kernel community, I guess it is also true for the
Git community, unless Junio (and the community) want to appoint a
bunch of maintainer lieutenants, such that they outnumber the number
of developers, e.g. divided by areas of the code:
a refs backend maintainer, a submodule maintainer, ...
or rather by area of usage: a porcelain UI maintainer, a git-on-server
maintainer.

Though Git is not as diverse and large as the kernel, so the horde of
maintainers would step onto each feet quite frequently IMHO.

>
> It would be a totally different matter, of course, if you used the
> branches I publish via my GitHub repository, added fixup! and squash!
> commits, published the result to a public repository and then told me to
> pull from there, that would make things easier. We could even introduce a
> reword! construct, to make the review of the suggested edits of the commit
> message easier. I could easily verify that my branch head agrees with the
> base commit of your branch, I could build proper tooling around this
> workflow, and it would lighten my load.
>
> I guess what I am saying is that we might just as well start using this
> awesome tool to work with code, that tool named "Git".

I think Git itself is for the tracking the code and managing it, e.g. merging,
moving, keeping it. That doesn't quite include modifying and creating code
(e.g. there is no "git edit" command)

If we were to change our workflows drastically, I'd propose to
go a way[1] similar to notedb in Gerrit, or git-series, which defines
a common review format, such that we have a "protocol" how to store
the review data and how to store the progress of potential collaboration
and then we can develop tools against that protocol. Some people
want to have a web UI, whereas others want to have a text only thing
as they are faster keyboard only.

[1] http://git.661346.n2.nabble.com/Working-towards-a-common-review-format-for-git-td7645242.html

Thanks for starting this discussion,
Stefan
