Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877E71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGaT7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:59:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbeGaT7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:59:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so17633975wrp.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2hZb2Ekw2m1/lGa9OMX8HQ/VaQ8Zg4KTs+sp6Jrx3tc=;
        b=HXFNUWLhr6qeTnPl9faDbyck56C6xITVbYWT6VSetLSqw5wS+mGgxysFnBcSiUAydf
         TsneV/ZYGZWv6LoDyL4b8v5tsOCvg/Xt/LDMtv9C/6Ynvqhjyt6YLhqnUTO/tIiqqba5
         Mj9YSOxRxwqpBNSj0aQvUG5GiQzTLljbqiixw5oyRsoXgH0PweNDF+8THQSTkvUMlgAv
         TEpKEzXZtYyjF4z3vZAmtFshjjthxAfVtbryahgwUW2O/+dl+JzDgo7s+O0+2KFkbfsq
         yGKFNJJn0j8b6NcxUxya3OqYQBau89J2j890AqUJXpzJDKjN8VvqodNpCuXQ6X1DgQkZ
         zCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2hZb2Ekw2m1/lGa9OMX8HQ/VaQ8Zg4KTs+sp6Jrx3tc=;
        b=FQRv2LNqfH5Y3HPybGRAf5R+SOUVyeNQOBJHxjcYX9AFxStzoSvaPhHaSPwr2Wqtj/
         gh1OWNto82nhiE9FgJeQalzXjQL9XqTbuaBxsVrCW82nBIRCZjkWK3VefufCq9Rq2Hqq
         CgUk+b4x82nsTCm8nGzaIOJ6n8a4kFeavkEY+4dk55E2sPQA5ySVyB2g5rq7T+N6pz8a
         Wysz2tzULPClYsOt+dVut/nseJF7IXt82nutOvWusTJgtDdD28D6asVZvVu5K9XzV7sk
         +iSOljHraqb4D49mF8vgcODzte+FMUTEnNM8JE+q2mz6TrfTvbCkyPtL5qdHRSWY1cDu
         ROHA==
X-Gm-Message-State: AOUpUlERTEcdjkQJbdPFsxjZX+8CGHlSSB3NsE+8lUyuvDQz5uEf085f
        c1URAmrw85rtSOf/WIQK198=
X-Google-Smtp-Source: AAOMgpcGeLSvONSQEtOionV340eQm66Wm353cbCSMLwnHgz/yNsYJAY8tuUhEodLiCkDeneuGi6IDg==
X-Received: by 2002:adf:f689:: with SMTP id v9-v6mr21230861wrp.201.1533061066178;
        Tue, 31 Jul 2018 11:17:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t186-v6sm4007045wmf.14.2018.07.31.11.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 11:17:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question on range-diff and notes.displayref
References: <CABPp-BH+YW6z147K-X7eTH2E9A3tUzteosKA1KadhSavM5c8Lg@mail.gmail.com>
Date:   Tue, 31 Jul 2018 11:17:44 -0700
In-Reply-To: <CABPp-BH+YW6z147K-X7eTH2E9A3tUzteosKA1KadhSavM5c8Lg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 31 Jul 2018 10:19:15 -0700")
Message-ID: <xmqqva8vb77b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Should git notes show up in a range-diff?  I happened to have
>     notes.displayref=refs/notes/amlog
> set in my git.git repo, and saw the below in my range-diff:
>
> On Tue, Jul 31, 2018 at 10:12 AM, Elijah Newren <newren@gmail.com> wrote:
>> 1:  4a1c9c3368 ! 1:  00f94a8b41 t1015: demonstrate directory/file conflict recovery failures
>>     @@ -14,7 +14,6 @@
>>
>>          Signed-off-by: Elijah Newren <newren@gmail.com>
>>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>     -    Message-Id: <20180713163331.22446-2-newren@gmail.com>
>>
>>      diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
>>      new file mode 100755
>> 2:  e105e8bfbd ! 2:  d3b8d7edb6 read-cache: fix directory/file conflict handling in read_index_unmerged()
>>     @@ -59,7 +59,6 @@
>>
>>          Signed-off-by: Elijah Newren <newren@gmail.com>
>>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>     -    Message-Id: <20180713163331.22446-3-newren@gmail.com>
>>
> <snip>
>
> Maybe this is expected or wanted (tbdiff also shows the git notes for
> what it's worth), but it seemed somewhat surprising to me.  I'd rather
> not see such "differences" displayed for the patch series that I'm
> submitting, but perhaps others see it differently?

I was surprised to see that, too, but if you have it configured I
would understand the behaviour.  

Of course, the value of showing the Message-Id: in this particular
case is dubious (by definition you won't have them on the side that
you have not posted), but if you are comparing two iterations that
have been queued (e.g. by keeping the old tips of the topic branch
unpruned by holding onto historical 'origin/pu' using reflog), it
may become useful when doing a "Wait, is that really my bogosity?
Let's go see the list archive using the message ID---ah, something
was suggested in the review and the maintainer attempted to pick it
up and squash it in, which he botched".
