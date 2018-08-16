Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928A41F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbeHPSty (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:49:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35152 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeHPStx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:49:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so4817536wmc.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5LsPR2ZDcR6aZLsTJ0T2GPeStBJx9GX95bzAsI/6b7U=;
        b=GMpkfEkSbp0UFVGma2YmlKLzr+OBcqLc7qOZ2OSztd4NddxLQCOLBEh3cyAqDPXNp/
         1s0ODYoZ4NIE8yqtYaAK+6WXcQdDiHRD3XKJd3VvPOlSBiFl47XZYXChVWk6YLLhcQhG
         W/1j3TqfySigDeUVoILeZs7IrOZ0Y9Zl8uFNmx2ZLZcFWq0AQG/9jXJZfmimyPwM4BzI
         f34ob1B31HNN2rzqj+5P+SmeoxR8OB6fSLWysCijtoNUYo/F3U5dMPLs53cymWj7mW3A
         f2ONGNW1+5B8WbV7snGGbHKz9UXv2lvcbCNxYdzVc3Uzrc6vIkegHMvApUhxjdYrMTNp
         l71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5LsPR2ZDcR6aZLsTJ0T2GPeStBJx9GX95bzAsI/6b7U=;
        b=FsDDPrTzXYCSpoDQKnQwdELO/fUn3E4Nx2EOQV/wLeSomKoa+FJEeL5Clfo1Sakat3
         GeIrqSb388QBKYHcSs9VdauI5Q1Zqsn9B+MqjSyrl7BEy3s7/NkF7UmXrxFC4DmOfH7I
         KTgzcUQzrf1gK+B9LgBxKK2yI5GWufiG/WQiZ8fbiyg3cxasngX5h46fE0lqQA//QvxH
         J06NJKp37UKG0mDU0ZRsqDaQFkFSH0fbAbInK9UtbiRQojHseqi4aWLupU2/5xqutW/V
         TKCdVNlq7P6QPhFeraBmO/jEa743mDfcEOElQUpfI5Qral0DpC0cWBsxhiHygJmS3xsO
         YFBg==
X-Gm-Message-State: AOUpUlE6TDztnHeXfGt5q+WYk0gLIXRL5Dc+ZoO4WySPAhxkpToN9byr
        U8duj2n1DFhGC2zaTr6ho04=
X-Google-Smtp-Source: AA+uWPwc27B+qPNpQxv1iqX0p56qxWRFpjmYfTGtpjFvJHGrMaq8a9bKPt1aLSF9y9PyTUyI/4NvfQ==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr15743009wmc.80.1534434634253;
        Thu, 16 Aug 2018 08:50:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a12-v6sm29190485wru.61.2018.08.16.08.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 08:50:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Hadi Safari <hadi@hadisafari.ir>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: include PARSE_OPT_HIDDEN in completion output
References: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
        <20180816151125.11803-1-avarab@gmail.com>
Date:   Thu, 16 Aug 2018 08:50:33 -0700
In-Reply-To: <20180816151125.11803-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 16 Aug 2018 15:11:25 +0000")
Message-ID: <xmqq4lfugvjq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> However, manually going over:
>
>     git grep -e OPT_HIDDEN_BOOL -e PARSE_OPT_HIDDEN
>
> Shows many options we don't want to show in completion either,
> e.g. "git am --binary" or "git branch -l". Many of these are internal,
> deprecated, or no-ops. There's also things like "git difftool
> --prompt" (the default behavior) which are arguably pointless to add,
> we just have "--no-prompt" to inverse the default.

Yeah, and I believe some hidden ones are hidden because they
encourage bad workflows (like --allow-empty-message) especially when
used interactively, and they aren't marked with nocomplete only
because there wasn't any such bit back when they were marked hidden.

In any case, those that are hidden for such a reason now need to be
marked with both hidden and nocomplete, which is a small one-time
price to pay to make the meaning of these two bits saner.  So I
quite like the direction in which this patch is taking the
underlying mechanism.

A "blind" translation that is far safer than your patch may first

 * update the code so that ones with hidden-bit are completed

 * update the data so that ones currently have hidden bit but not
   nocomplete bit gain nocomplete bit as well.

That would give us a saner mechanism without changing the behaviour.

And then we can make policy decisions for each option separately for
the merit of keeping it hidden (i.e. excluding from short help to
unclutter) and/or keeping it not completed (i.e. discouraging its
use in an interactive session).

As I think some of the hidden ones also have nocomplete and others
do not have nocomplete merely by historical accident, the way this
patch changes behaviour for some options (namely, the hidden ones
that did not have nocomplete not because they wanted to be completed
but because there wasn't such an option to exclude them from
completion previously and because it was sufficient to mark them as
hidden to exclude them from completion) means making policy
decisions while updating the mechanism that allows us to express our
policy decisions.  I do not think we should conflate the two in the
same patch.
