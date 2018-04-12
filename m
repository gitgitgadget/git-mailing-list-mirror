Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782BA1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 17:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeDLRD0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 13:03:26 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40394 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDLRDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 13:03:25 -0400
Received: by mail-wm0-f41.google.com with SMTP id x4so10752852wmh.5
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wWqtx+vICPh01e9hoV81BTJ3lyFHwMlNpw+lkUCX7Ak=;
        b=atG5UPs8m81zVBSWqHZe3f1rJ8djO9URa6BSwmAckfZKtfCPkSwlqix8Tid6GmFqin
         ZyZOrNRwh/O97i/MEkCdp1JIkiH3zbL2I/nvYR6hgkyusbxJBr/xvyDl/v/rmCgcK0AE
         viJjOwmtdLwjxNQbax+k559wcwabD1clRflKQiG1OlZpT0fIn1kEAay1nw1gEuaIg3EA
         t8vqyHoTTxqurZMen75HOx9sho7qyqNug55XRu2Ceq0KDcxeRQxJL+WLWmdjK2ERRiMA
         yQxW62zTR/j2VbKmGJ/FXPuETfyLxVE+s2+vTFCWQ217aycZOKLOf0bPfcJiNdM1CTut
         LKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wWqtx+vICPh01e9hoV81BTJ3lyFHwMlNpw+lkUCX7Ak=;
        b=YQt0FQ2N+XxSWjOfaf8mqDHsk7WYci6GazT2DtNNCXdOYzliaw5YasjVZ/Hx6u6VFD
         PXKIsOZfFuN0zgQnFMKb0bXmTHWxYPFZFD2UDZ73zmlxD6e6RN3ujRhX2iHvWGNw3r4O
         TNvogNfIl19W7xsBnE7d8YIHnFqAmVSkxwB+pZtnTDMcaRc3hh2DcQrWjnaKn6lIcum/
         9YnNKLrfIdBSQfW2KgDpG4q8Qna4cQn74X+5kxgKc64DULLItxfuvRzJDqzp+x8CTApA
         yMW5TIBd8Mjxn57CDdCVnE2qj6VL/jle/WzD5h9FXnF37zousImp31EsHZiGP//+T/cH
         9dqA==
X-Gm-Message-State: ALQs6tAYdw+xFqCl6yC2PY7aYMxMDKzx1Ta0xt9rySloDIgP2tGJVQQz
        ldbIpJGAp+dDwJ+x2moC9TBuaBW5BI8tSmJagas=
X-Google-Smtp-Source: AIpwx48rz1CMqqe+VuNlS0OQaUyWZpL8ZWt5lvWORFMgyCDOMt4bAex54/9cXJQ65nlw3YRu/WhiJOSCKSA+kEwTXuc=
X-Received: by 10.80.192.145 with SMTP id k17mr340516edf.303.1523552604432;
 Thu, 12 Apr 2018 10:03:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 12 Apr 2018 10:03:02 -0700 (PDT)
In-Reply-To: <87sh810ym4.fsf@javad.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com> <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
 <87sh810ym4.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Apr 2018 10:03:02 -0700
Message-ID: <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 10:42 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Hi Jacob,
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>> On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
>>> It was rather --recreate-merges just a few weeks ago, and I've seen
>>> nobody actually commented either in favor or against the
>>> --rebase-merges.
>>>
>>> git rebase --rebase-merges
>>>
>>
>> I'm going to jump in here and say that *I* prefer --rebase-merges, as
>> it clearly mentions merge commits (which is the thing that changes).
>
> OK, thanks, it's fair and the first argument in favor of --rebase-merges
> I see.
>

I'd be ok with "--keep-merges" also. I don't like the idea of
"flatten" as it, to me, means that anyone who wants to understand the
option without prior knowledge must immediately read the man page or
they will be confused. Something like "--rebase-merges" at least my
coworkers got it instantly. The same could be said for "--keep-merges"
too, but so far no one I asked said the immediately understood
"--no-flatten".

Thanks,
Jake
