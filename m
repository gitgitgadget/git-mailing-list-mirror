Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA251F404
	for <e@80x24.org>; Mon, 16 Apr 2018 17:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeDPRn4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 13:43:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46470 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeDPRnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 13:43:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id d1so28355856wrj.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lucjlbS+kyLM9BL147Oa8UCF6iEEeubFPSKywnC4Y4o=;
        b=U+TKxm5obR5+yeigDxSiSWtqeoVYM5oMs94vO2Al+3Macw1S14NUzevD0fK/Sa+yJf
         eKEH15joj7ZM+weSTGLklYolPRWT8Mb3KpEE9M46Mzj18asoIlEW47Sbqsu1aYWGpO2Q
         OBnf69Sf4TmS/6IiiAjnf+AtK+BzyvEdu14tP5s7J1MgpelmdLN6ye3xeZiDd0L+ttI7
         mSRgU5k6feACmq9dEWTF/YMxdyWubCPXb1tohynnFdvk7TgfXi0Ae/C5f7NZWuHP3YyQ
         oWaO7ginOAOxUo7meuK9XxlpYOF+kyVJp9GKyZJsUXn24JKOsgk/DkT3q+nCTFmK2PBI
         wOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lucjlbS+kyLM9BL147Oa8UCF6iEEeubFPSKywnC4Y4o=;
        b=ae46cAkbVNFlMft1NrbALN7H7AfFtT3eyeXyGTB6p7LVvIxnjZap9EYNWZz9FYyiOn
         RetSCOm5GgBnSUJNwO18ul7yyPirST5kDT/FsMGvLK6szOty/zIZoh/RE3KU7nHA/Tpb
         64MC9/9uVZo97bOl1bY+28cli6TGhnYaNERpCIz9FBD/b+Vl6IvzSGEDkQz3lBJrlmaT
         pTOiVO7SNvcxQGQAqgHLQXjyZrJOV8qHy2UrAjYWZ6SclBGykezKFzMHMA9iBQlK1PJk
         clnz14Q53G9623+A4gddYoF6Zw1eHTNiVxDcZaFT4TSeNy9NxJ5F9zVBo586uSYqPhYN
         c3/w==
X-Gm-Message-State: ALQs6tDRUYd5zmjN+wkuYdLw3OALx69llYv9e5Q3I1tULWnXN25sx4Ae
        4decKuXRdTdkCpvOYXERc37BrlSuxqWOvBOVszQ=
X-Google-Smtp-Source: AIpwx4+2E80M5Rpxgts7u7g/kIBP8r0ELc+mb7uxVOmoyXpijmDzOW3L/BumhqbNDYzgRDYc5vqqDO0oN3IJEK1hu/g=
X-Received: by 10.80.192.145 with SMTP id k17mr17736206edf.303.1523900633626;
 Mon, 16 Apr 2018 10:43:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 10:43:33 -0700 (PDT)
In-Reply-To: <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
 <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
 <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 10:43:33 -0700
Message-ID: <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        winserver.support@winserver.com, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 9:07 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 16 Apr 2018, at 04:03, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>>
>> On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>
>>> I think Elijah's corrected was_tracked() also does not care "has
>>> this been renamed".
>>
>> I'm perfectly happy with the slightly smarter patches. My patch was
>> really just an RFC and because I had tried it out.
>>
>>> One thing that makes me curious is what happens (and what we want to
>>> happen) when such a "we already have the changes the side branch
>>> tries to bring in" path has local (i.e. not yet in the index)
>>> changes.  For a dirty file that trivially merges (e.g. a path we
>>> modified since our histories forked, while the other side didn't do
>>> anything, has local changes in the working tree), we try hard to
>>> make the merge succeed while keeping the local changes, and we
>>> should be able to do the same in this case, too.
>>
>> I think it might be nice, but probably not really worth it.
>>
>> I find the "you can merge even if some files are dirty" to be really
>> convenient, because I often keep stupid test patches in my tree that I
>> may not even intend to commit, and I then use the same tree for
>> merging.
>>
>> For example, I sometimes end up editing the Makefile for the release
>> version early, but I won't *commit* that until I actually cut the
>> release. But if I pull some branch that has also changed the Makefile,
>> it's not worth any complexity to try to be nice about the dirty state.
>>
>> If it's a file that actually *has* been changed in the branch I'm
>> merging, and I'm more than happy to just stage the patch (or throw it
>> away - I think it's about 50:50 for me).
>>
>> So I don't think it's a big deal, and I'd rather have the merge fail
>> very early with "that file has seen changes in the branch you are
>> merging" than add any real complexity to the merge logic.
>
> I am happy to see this discussion and the patches, because long rebuilds
> are a constant annoyance for us. We might have been bitten by the exact
> case discussed here, but more often, we have a slightly different
> situation:
>
> An engineer works on a task branch and runs incremental builds =E2=80=94 =
all
> is good. The engineer switches to another branch to review another
> engineer's work. This other branch changes a low-level header file,
> but no rebuild is triggered. The engineer switches back to the previous
> task branch. At this point, the incremental build will rebuild
> everything, as the compiler thinks that the low-level header file has
> been changed (because the mtime is different).
>
> Of course, this problem can be solved with a separate worktree. However,
> our engineers forget about that sometimes, and then, they are annoyed by
> a 4h rebuild.
>
> Is this situation a problem for others too?
> If yes, what do you think about the following approach:
>
> What if Git kept a LRU list that contains file path, content hash, and
> mtime of any file that is removed or modified during a checkout. If a
> file is checked out later with the exact same path and content hash,
> then Git could set the mtime to the previous value. This way the
> compiler would not think that the content has been changed since the
> last rebuild.

That would only work until they actuall *did* a build on the second
branch, and upon changing back, how would this detect that it needs to
update mtime again? I don't think this solution really works.
Ultimately, the problem is that the build tool relies on the mtime to
determine what to rebuild. I think this would cause worse problems
because we *wouldn't* rebuild in the case. How is git supposed to know
that we rebuilt when switching branches or not?

Thanks,
Jake

>
> I think that would fix the problem that our engineers run into and also
> the problem that Linus experienced during the merge, wouldn't it?
>
> Thanks,
> Lars
