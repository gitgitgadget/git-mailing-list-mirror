Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E58720193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbcJ0Vck (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:32:40 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33958 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJ0Vck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:32:40 -0400
Received: by mail-qk0-f181.google.com with SMTP id x11so15974270qka.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WAmFVe6dImrsj8pXW5oIykjQ2VY7AYCkNlSwcAugauA=;
        b=pGhe8Auj9A7DftByEBuS1hS53lVIOvPmKRJvKb1BsVokPesM6wAVfmtjfcOti8m5Wr
         GMAeQNIDB/e3ffnL5oB85+G/4LFvkpTjMIBhvd7rjI1T+niBxmHhz8J9uheBnlT6/46n
         oXlAs4stoJJupc8D22aBvHt09Y5x5TYL5rXL7GNHcimwHb7RvD8jB9M42V+kMVriI7je
         ZjmYAgVeYKC2mK+mRm5FWOe8iyYS1egQmy3fLjDTRNkh/Xgz0rKc7EBLSiISU3iAIo3s
         Knchn3ndseKhzy/pCaEHslnJ4HxMe3nPKvY/hPDOfefbopgvyoljmOZ3RKKV3yYBCvDn
         9o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WAmFVe6dImrsj8pXW5oIykjQ2VY7AYCkNlSwcAugauA=;
        b=fBkKv39KusVdbmNOhCrllQmjU8fvuye+wgfSTmkhZS4Nk+hYBa94ST3deYFVFXiSSE
         xPx7HkB/F7gzm0DwS+FjR4OVuHnhlBD6s2vtV3bqPJ8rFCIwHokKV5jXV8HpjEii5Jmh
         /ta7ze8yR/1WRbEznhDoZtMT20hMnjhUbUG2fpWUnXEFc6GaTLyC3nP7yAFmXdGYWh2u
         ycjJnpNAjiHze/QcxyhNb3gP0PvIH+zVoBAqgdrLvXm75Ohm97uKl5did2rIBzrNG8Ol
         taeGDxuhfTmMtT79LqkVO0BQWYOG+1R61hlurjwIjeakNsY064dIRoMSgKe4xs2WpDeg
         z35w==
X-Gm-Message-State: ABUngveXo3wpUJNtvpjGyD+Yq7+iMft0LJsPtXm22LtJ3fPB77X1P0E2UuH/sNu/T6DyThEk6+Uzfgtb7eEpGqHC
X-Received: by 10.55.20.164 with SMTP id 36mr7148421qku.86.1477603959028; Thu,
 27 Oct 2016 14:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 14:32:38 -0700 (PDT)
In-Reply-To: <CACsJy8DhsaTY1w_e-0O5d4KLxr4Gmo3g9rDagQq1ooSHywcRoQ@mail.gmail.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-33-sbeller@google.com>
 <CACsJy8DhsaTY1w_e-0O5d4KLxr4Gmo3g9rDagQq1ooSHywcRoQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 14:32:38 -0700
Message-ID: <CAGZ79kYTOhWbmk27x3JwwBqPedmw-sKbP9S4FJqcM6yT_uQKiA@mail.gmail.com>
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 6:33 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> (sorry if this should have been answered if I went through the series
> patch by patch, I wanted to do a proper review but finally have to
> admit to myself I won't, so I just skim through a single giant diff
> instead)
>
> On Sun, Oct 23, 2016 at 6:32 AM, Stefan Beller <sbeller@google.com> wrote:
>> +attr;;
>> +After `attr:` comes a space separated list of "attribute
>> +requirements", all of which must be met in order for the
>> +path to be considered a match;
>
> What about (attr=abc def,attr=ghi lkj)? Does it mean (abc && def) ||
> (ghi && lkj), or abc && def && ghi && lkj? Or is it forbidden to have
> multiple 'attr' attribute in the same pathspec?

Good point. I'll add a test for that.

Remembering the original discussion, multiple attrs
are forbidden for now as it is unclear what you want to see
as a user.

To model  (abc && def) || (ghi && lkj), you would need to give
multiple pathspec items as these are naturally ORed:

    git ls-files :(attr:abc def) :(attr:ghi lkj) .

(compare "git ls-files Makefile README" which gives
2 files to you, that are named respectively.)

To get "abc && def && ghi && lkj" you go with

    git ls-files :(attr:abc def ghi lkj) .

as then all things included into this one attr are
ANDed. I hope the documentation is clear for one
attr.

Thanks,
Stefan
