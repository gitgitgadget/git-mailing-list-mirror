Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BB6207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 00:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdD0Avk (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:51:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36615 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdD0Avj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:51:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so4112305pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hjUFuHSKbUZITJiYWVNERQbdHrWLlTfgsAhOV2V8WCQ=;
        b=pbB18UAEFmF9wMAINcnW5NJZ7rbJlzgaJdFW8SxiLIHzXkNsNJk1wjdKxxfu+6x9AN
         cLEGhmc7rbc/E6rvJOxhXABZy64Q9P2I5BTKKISf6xYg2XVXPOCc/DswCoiZoMBzdL7L
         csMJw5SwY4FnBL8xgY7TV4vH+B2OKfgre+q4qgsNnNk6ExVMxS/9JTVVmx/K7U62kTno
         Dj9pEDbBF0ZMhHXc9RYqU+F6xaBPsqjdilsm/cLjWTTz3Bjd446qiBvJro4ztdny0DPN
         TcUxXzI9fMDWQHZzbAmJptxvOMmqx/YLn70JPIww1yiDpQ6EGCOdfy0O3QvafhsERy6O
         1GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hjUFuHSKbUZITJiYWVNERQbdHrWLlTfgsAhOV2V8WCQ=;
        b=MkOCQfS/xVh21Lrs8M4tr40WM+QW4m0T+uob3reR1RotnjqU2yGEC354zOkXTzyfXq
         DnhUOhIuio5VpS6VJoAR5HUPtzYPOReSLb/sT6dhxY5YhzackYKExGoijADpxC8jrDwM
         M4ZWk9272ZhglfYLShfsl6KfXJPAyELxZ3/tjmg9WMQBtGQrOjEuQHFWBLvBTgq7TPSg
         uZVRohSwZqKZGl+uLfDoa6pasmzti+svYUzjAN8B7IDwKLHBZUUWwCZj8h7jmV/MXNxB
         FkGsXbePkTbQ1HlVYGaH3XEoyigHJ/08Hrh2m/Tw2ODpAM+4BWkhKPHwO46+HROW9Oth
         MxYA==
X-Gm-Message-State: AN3rC/5RISdGde3hK8fipTdqeJzmCKkQv5quHTFbMrU8CO6E4mUj3xRv
        IFhqomC5Ls7HAOE6dhL0Jw==
X-Received: by 10.84.238.198 with SMTP id l6mr3445328pln.95.1493254298484;
        Wed, 26 Apr 2017 17:51:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id e131sm785443pfg.10.2017.04.26.17.51.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:51:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?utf-8?Q?Zol?= =?utf-8?Q?t=C3=A1n?= Herczeg 
        <hzmester@freemail.hu>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 05/19] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
References: <xmqqvaprrb37.fsf@gitster.mtv.corp.google.com>
        <20170426074856.29903-1-avarab@gmail.com>
Date:   Wed, 26 Apr 2017 17:51:37 -0700
In-Reply-To: <20170426074856.29903-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Apr 2017 07:48:56 +0000")
Message-ID: <xmqq1sser7ty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>>> @@ -417,7 +415,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>>>       int regflags;
>>>
>>>       basic_regex_quote_buf(&sb, p->pattern);
>>> -     regflags = opt->regflags & ~REG_EXTENDED;
>>>       if (opt->ignore_case)
>>>               regflags |= REG_ICASE;
>>>       err = regcomp(&p->regexp, sb.buf, regflags);
>>
>> This hunk is wrong.  Now the use of regflags we see in the post
>> context is mixing ICASE bit into an uninitialized garbage on the
>> stack.
>
> Oops, sorry about that. Here's a fixed version. Just sending a v5 for
> this, not the entire rest of the series. If you'd like to grab it in
> .git form it's github.com/avar/git:avar/pcre2-5, this is the only
> change from v4.

Thanks; I think I already queued an equivalent SQUASH??? patch
queued at the tip before merging it to 'pu', so it hopefully would
be the matter of running "rebase -i" and not making mistake when
instructing the command where to squash it in ;-)
