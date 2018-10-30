Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080211F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeJaIuZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:50:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42676 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeJaIuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:50:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so6323121plo.9
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ef/nnzBnNhqBrWBi/Ut/8A4Jyu5V7UFOMf6txqe6YeU=;
        b=hsSJOQroqL2dg1GooKvtjgyQh/Hva35Ac/Aq9+jCO4hLyUPijNpd//IreGg/YL5Fk1
         ohJiSwYbUabcMTZPVJJgV+p3iLcTi/PJJJHS2XSiKvdOVxHzm75V/xiPGQH+YpqFhP/U
         44hGM4HQQIX6JCPDxsIopDC2heRESzN/7nVid5UU47gRUJ3l+bqdoTGcbCS0Av9iY+OE
         6V0lN8ClnEwLOBY/yhHoH7g+/FliCXhIhBhlBpGWdenCQhKFRNcKooUB+WgGSXAbsJF0
         u+qI5srEXO4HsPFCmP8LvAePINNWBu7EjE5YJnhyrXhZQS5FJeYLcAk6WR57/cYehLrv
         BSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ef/nnzBnNhqBrWBi/Ut/8A4Jyu5V7UFOMf6txqe6YeU=;
        b=Buh9CIa2wSHnCYBhfJrLFM9I31v5X1QhgGRPfc0qUO0znWlVqMq9oUgn503SJ+NmgQ
         qvut4uTz32M9LWO4zHmKiO+Ha8HggwV1oHU4cg5XZA0IuA1JYPxQ/YgQcnJQqh1dXIGZ
         QFwPK09AwGycNKHTs/9S5sIEgNUqz7Ld74VbIKQZP2MhmTR04O0Tk6Og5/gHGZANHK0o
         5Q12qXZb5xlLK5K0re6o4m6TJ/bsB2s86T6r/zIeWgQDF2w+EB8WhauFu8ytms26ipDK
         7+19aJ5q9/9mWHJQbb4hznyAQXivacZVQQ9KpLB8kvEVhv//vhsgSrjQTMkGk0RcKRAM
         Mjzg==
X-Gm-Message-State: AGRZ1gK9mf+gCkZ5YD2Q0tPejj8bsNy02GxoQoPTJbwLGtNXG54yaS6j
        /qx4+PfS++pvu3RoVREdfPg=
X-Google-Smtp-Source: AJdET5fl1i591/3dUz1pd3QzwhY2zHJr2oCszAs8cwj7s5PELdMNXF7H1uGWrPK2dlYSNwL5BJJHOA==
X-Received: by 2002:a17:902:3fe4:: with SMTP id a91-v6mr716304pld.295.1540942047990;
        Tue, 30 Oct 2018 16:27:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z22-v6sm25411679pgv.24.2018.10.30.16.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:27:27 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:27:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
Message-ID: <20181030232725.GA149989@google.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181028065157.26727-13-pclouds@gmail.com>
 <20181029105304.GP30222@szeder.dev>
 <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
 <87ftwolkl4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftwolkl4.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Oct 29, 2018 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>>> Nguyễn Thái Ngọc Duy wrote:

>>>>> -    fprintf(stderr, "%s in %s %s: %s\n",
>>>>> -            msg_type, printable_type(obj), describe_object(obj), err);
>>>>> +    fprintf_ln(stderr, _("%s in %s %s: %s"),
>>>>
>>>> Are the (f)printf() -> (f)printf_ln() changes all over
>>>> 'builtin/fsck.c' really necessary to mark strings for translation?
>>>
>>> It is beyond absolute minimum but I saw it argued here that this
>>> makes it easier to manage the .po and .pot files if your message
>>> strings do not end with LF, a you are much less likely to _add_
>>> unneeded LF to the translated string than _lose_ LF at the end of
>>> translated string.
[...]
> As Jonathan pointed out in the follow-up message[1] this sort of thing
> is checked for in msgfmt, so sure, let's strip the \n, but it's really
> not something we need to worry about. Likewise with translators turning
> "%s" into "%d" (or "% s") or whatever.

IMHO the advantage of leaving the \n out in the message is not so much
that we don't trust translators but more that where we can make their
lives easier, we should.

In other words, I'm glad the patch does that, and Ævar, I agree.

Thanks, both.

Jonathan

> 1. https://public-inbox.org/git/CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com/
