Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1131F461
	for <e@80x24.org>; Fri, 12 Jul 2019 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGLNuP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 09:50:15 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36062 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfGLNuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 09:50:15 -0400
Received: by mail-lj1-f175.google.com with SMTP id i21so9413784ljj.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZRnYYW87GRgxUJgENbTziriWzEioHJsWj4cLe46N5nU=;
        b=fJzGzPCmrTVfdA3mYAQmnsG2S0YhJ3u1nILcTiwwM5+89UKem//7elf8Xa7yxh2/KW
         lysCf5l9IrQAPPrVGUzUOaMhp3+KKiSR4qDDRLhIi6t5V6zzUm50vD2Uy1b8bnY1HSWL
         ax8B1d+VFAJx8188Ldijc2QJz9eqzumiuaPkejOfDYr1rOTKNALWykVO3FM0Mj3S6dEm
         jwhLeQGYa0aZvLhi3Dh4CxWaInjFjErB/wHYBTmYf0ys+e0+KCG3UR7UVcN6JLp39rry
         YJJVpYcwicsOK3UAo6KTDHPRZa8BX1kBV4E8dwmGZy15kqD7wkRAqFy7uNd84Zty78OB
         DDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZRnYYW87GRgxUJgENbTziriWzEioHJsWj4cLe46N5nU=;
        b=N4caUfsZ+LyBqAwTEbDbdylxuHpox0RKwkj84kyWL6Vq9YF15t4keDbJUgxMCH94yC
         oB0CVRfZhGZCOlqQmMOHSFe1xbTbCS+YH1xEmlcQobdgHTOJiQM77MTjCuNJYqYyYBdt
         +sZCUBMTMiR/3jdIEQp23kbTHpJP/zMLp8O+14hcivQobgnaJ4MlVtxhmiUY2Bgu8ge3
         /sp1YoXVqkn25IiXwtia7ADmAdBTbyegAIufCmxUfkx13HhCdEQXt2RrxZ2tgVcER0hh
         OX8C/scqo9zuhhrTCjLSQmr8HNGgUBiuVdm+Ab0y0QgjcbmVUDSbAbHX7tiB3a7V/5p2
         rlJw==
X-Gm-Message-State: APjAAAW7VQ3rcoQyCvrFp/1d27TVGYRx/p4gdnXREImbqRhSbBiqRduk
        TD1LLBIJRf6u0G/ueppZTBOYF9Bt
X-Google-Smtp-Source: APXvYqxPkTTQKvH6U3twMCHAjIY2R29/oEdqHCpSFokEmwhVMgyeYln8ZIYEIHJ+lduJW84FhHyDJQ==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr5749007ljg.197.1562939412346;
        Fri, 12 Jul 2019 06:50:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l24sm1487764lji.78.2019.07.12.06.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 06:50:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
        <87sgrdf91j.fsf@osv.gnss.ru>
        <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Jul 2019 16:50:10 +0300
In-Reply-To: <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Jul 2019 10:03:11 -0700")
Message-ID: <87blxz9xbh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> [...]
>>
>>> The "the tip being merged into the mainline must always be
>>> fast-forwardable",
>>
>> It's rather "the tip being merged into the mainline must be fast-forwardable the
>> first time it is merged".
>>
>>> however, is not consistent with the topic branch workflow, and I do
>>> not mean this in the sense that you should never rebase just before
>>> submitting (which is a bad practice). For an initial merge of the
>>> topic to the mainline, the project can keep rebasing to the
>>> then-current tip of the mainline, and as long as they can afford the
>>> cycle to test the result, "record the range of the topic branch by
>>> making a redundant merge" would work.
>>
>> Yes, that's exactly it, and, as the rule holds for the first topic merge
>> only, the rest of workflow is as usual, no drastic changes.
>>
>> Overall, it only ensures the first merge of the topic is semantically
>> simpler, nothing more.
>
> But then you have to know to say or omit --ff-only if you are
> mergint the topic for the first time.  The second and subsequent
> merges, your merges won't be "semantically simple" at all.

Yes, the second and the rest (if any) won't differ, but having the first
one, that supposedly introduces most of changes, "semantically simple"
is still an advantage.

>
> And your first "semantically simple" merge is likely to be a merge
> between the then-current tip, and a topic that has been prepared
> over a few hours (or longer) and has sufficiently been tested, but
> has gotten rebased immediately before being merged because of this
> "must fast-forwardable to maintain semantic simplicity" policy to
> catch up with the ever-moving-forward tip of the mainline.  The end
> result of such a "semantically simpler" merge is as good as the
> "freshly rebased, never had sufficient time to verify the result"
> iteration of the topic branch.

Yes, this makes sense only in otherwise rebase-based workflows, when you
do rebase anyway.

> How would such a state that was freshly rebased without chance of
> enough validation be better than merging the "sufficiently been
> tested in isolation" state without doing such a rebase?  If your
> answer is "but the contributor would test after rebasing and before
> doing the --ff-only-plus-no-ff merge", then perhaps the contributor
> can also test the result of a (trial) merge before it actually gets
> merged, no?

Yes, I mean a workflow where testing of rebased (or merged, doesn't
matter, as they should actually be the same thing) version is possible
or even required, and I believe that in this particular case testing
rebased version and merging the result makes more sense, see below.

>
> If we have a project like this:
>
>         A               topic that is slightly stale
>        /
>   o---F---o---o---X     mainline
>
> M, A', and N should end up with identical trees:
>
>
>         A-----------M   topic that is slightly stale, merged into mainline
>        /           /
>   o---F---o---o---X---N mainline with A' merged
>                    \ /
>                     A'  mainline with A rebased on top as A'
>
> And by forcing to rebase A to A' before merging into the mainline as
> N, compared to advancing mainline from X to M, one major difference
> the workflow is making is to _lose_ the information that the topic
> was cooked in the context of an older mainline and did not take what
> happened since F until X into account.  Rebasing it to A' without
> giving the result sufficient vetting means you are forcing the
> updated topic to pretend as if it also took F..X into account,
> making it harder to diagnose subtle interactions with A and F..X
> later that you did not spot when you made A'; merging to create M
> does not have such a problem.  As A' and M would have the identical
> trees, the same bug resulting from such a subtle interactions would
> be there if A' has such an issue, but at least M is more honest and
> lets us know that A itself predated what happened between F..X.
>
> So...

So it has a disadvantage for the workflow you have in mind, and you
won't use the feature should you decide the disadvantage outweighs the
aforementioned advantage, as usual.

However, committing untested M still doesn't taste as the best possible
way of handling things in general. It'd be best to actually test M or N
before publishing. In a workflow where there are measures to do it,
testing A' (= N) and publishing N both makes more sense and results in
simpler history than merging A and then testing and publishing M.

That said, even if we rather all do agree rebase workflow is always
inferior to merge one, is it satisfactory excuse to actively resist
otherwise logical behavior of 'git merge' that is even documented? I
don't think so.

Thus, one way or another, I'd still vote for keeping options description
intact, and rather fix the implementation to match the manual, i.e.,
make the --[no]-ff actually orthogonal to --ff-only.

-- Sergey
