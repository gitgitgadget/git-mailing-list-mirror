Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1014E1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfGOMrf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:47:35 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40384 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbfGOMre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:47:34 -0400
Received: by mail-lj1-f177.google.com with SMTP id m8so16039165lji.7
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kmz7igX4pOqWF0t7kCrfOJtYZgx95l59KS8DxuKSrhE=;
        b=X7xt91MDjJda1CGirA9iB+CTigbczWM9aywxVWLQC5aJt4H+EmW1g1ll2BiLwmNp9j
         cAp5PaUKiCeiNSDbj0faKSWEV3mIK/bSj4qb1am7lr1VEMuo2XvVGs06cuUHoyUiCbtH
         IfBhAV8j+/FRGmNQ5+Cc2Yb5qNa+tDbU7cAa/LXmJEMPBvvdARVc9d5YpYtBnt2DDY5T
         WKkQnhjqqLWfDWt/SWAm6Ab+AqhkfLIChXS0VB/RjSH1QsnVGTNeZSedhn5VpooXl63M
         n18X3/+ctciAiVd3oOcnDVagdQ5xUdSVReh8EWp0R1MPewTvVMk4k1sD00ZqM5J0PEpY
         IshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Kmz7igX4pOqWF0t7kCrfOJtYZgx95l59KS8DxuKSrhE=;
        b=lQR08zOHZ4QqWFFgLLJFGPPqnXxiomA/4fPRzZJtQxQhIDXvF+uT205f7l6siW+f/0
         FsNBCypGo1I/hoh3nVETqwRDfk0ljDKlqJ3JHcEualU0WJ5JdRjJLtu4hgzFnvwEG4Ma
         tzTgt7GnGulh+Xd7uhZwWgGn2X2VXMm88MWtE54N0z+SmCgoX0miC4oSh6Wv+TEgFrgL
         i9+VRiA97f/LvxKvi4sQzL+yXzLLbRexryIlKyrQhEYy2PKwIuB2y7mElt0MorBCCT1k
         QKFUnqeypK3Hj2h9PfU8OVJK4q4nlGxqwASPMpkPkMBN22N6XDkVhwtXo9AM1rpg6OiF
         cN/w==
X-Gm-Message-State: APjAAAU5PXtS2LT4Jrpq/40xdNqMAAUXtObM3f1X8ntuHcRWIzJdkqYH
        btG2DOU6oGyD9YZLcIrcET/DRnzq
X-Google-Smtp-Source: APXvYqx4kgm7OOxwE2AgBW8SEwvQRTXFhoArX6JrWWGKvzaFW9jTxQN78bRTQvoBXc71yNdAdXx99A==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr9322228ljb.120.1563194852684;
        Mon, 15 Jul 2019 05:47:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u22sm3455916ljd.18.2019.07.15.05.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:47:31 -0700 (PDT)
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
        <87blxz9xbh.fsf@osv.gnss.ru>
        <xmqqh87rp0gy.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 15 Jul 2019 15:47:31 +0300
In-Reply-To: <xmqqh87rp0gy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 12 Jul 2019 11:33:01 -0700")
Message-ID: <874l3nzcpo.fsf@osv.gnss.ru>
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
>>> If we have a project like this:
>>>
>>>         A               topic that is slightly stale
>>>        /
>>>   o---F---o---o---X     mainline
>>>
>>> M, A', and N should end up with identical trees:
>>>
>>>
>>>         A-----------M   topic that is slightly stale, merged into mainline
>>>        /           /
>>>   o---F---o---o---X---N mainline with A' merged
>>>                    \ /
>>>                     A'  mainline with A rebased on top as A'
>>>
>>> And by forcing to rebase A to A' before merging into the mainline as
>>> N, compared to advancing mainline from X to M, one major difference
>>> the workflow is making is to _lose_ the information that the topic
>>> was cooked in the context of an older mainline and did not take what
>>> happened since F until X into account....
>>
>> However, committing untested M still doesn't taste as the best possible
>> way of handling things in general. It'd be best to actually test M or N
>> before publishing.
>
> Oh, no question about it.  I am not advocating (and I do not do
> personally) publishing an untested tip.  
>
> But the point is, if M and N are equally well tested before
> publication, they may still have bugs resulting from subtle
> interactions between A and F..X that is not discovered during that
> testing.  And N loses the information that would help diagnosing
> what went wrong, which does not happen if you published M.

I see your point.

My point is that it's still a /choice/ between more information and
history simplification. It's not one way. I dispute that keeping
reference to the original branch has enough significance to /always/
overweight opportunity for history simplification, no matter what
workflow is in use.

> About the docs easily getting misinterpreted, I think Elijah covered
> it pretty well.

Yeah, sure, the docs should better be fixed.

Anyway, bare "git --no-ff" is still there, and I can live with no safety
belt that '--ff-only' could easily have been, it's just that it's a pity
to see lost opportunities in the design.

Thanks,

-- Sergey
