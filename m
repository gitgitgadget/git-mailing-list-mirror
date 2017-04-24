Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF220207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046492AbdDXGPd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 02:15:33 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32883 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046489AbdDXGPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 02:15:31 -0400
Received: by mail-lf0-f53.google.com with SMTP id 88so68125569lfr.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TMQF+RZ5LPzjyMUM/TMb7+w+On+TIsQQb6NakySEm0E=;
        b=kbfS6+NWKUd6ylR6ukuW0GPHpoMTLslSqv9L7ISA1fEtrgcsSvhzfBJYQkHKBWnBLf
         hjbf5S4J6S6gKolbBbfFcGNEUozlSkfpxc9yYkI4iJhk/O20lFM+1xvczgayIR0xL5qU
         k5GH8SbkbjmGvYR7JqSKMmyqkI6jnXQjoOISUDasnrrzJc88Tkp0gP67KbluKjY3pxtl
         s1DNCEeyi1y57Dbdp9A2sfP2vQF7HwRtJJCM3WIzFyLAKDMbJSQQRlBADVX8WsGtLMEj
         V4d/nxjAtrDaThrR8GCE2wLSujgUmv9EvkzaY36JWBpGchBj62yrvhCt3c2CE12Kjj6e
         9vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TMQF+RZ5LPzjyMUM/TMb7+w+On+TIsQQb6NakySEm0E=;
        b=FxTw6Z7syIvY90KQJ5IMY40P3jdtJm2FCJrI8d3/NSe1KjV99mZEYxq+NxjpWLy/A7
         UFBNAVqPyJ0koA02k06BCyr7Z+zWEj3TP8KsOxPTQC2JUPWtIy+2FvpNTqoyrGpO0vB7
         QyNzcWtGGZ5et+BGvfkfoM0GVyWgzrdZhTrPFoMefEWJL1C0UwrtmJ73yk/1nm/CDLx2
         v9PpMTzWmO+tPMPG+8SfdjmtKVXv/AzwNSSu7k2xBCat6MepYx5YNMnPSVtC1bHCxmpv
         NZYKfmoc6A/jlpiAVdZgA73W9T/Ro+4IjKCtIRm9j1wTMS/MhCWrG5HGRnSSydXZHIFw
         eVAQ==
X-Gm-Message-State: AN3rC/6woH8/eLuKwZNQzay7RMAseo4sYSNUT08vzzUduMpQ70tJsUx5
        7TIZYaapCHAZzSFjB3/0lGqFdlx9Ug==
X-Received: by 10.25.100.5 with SMTP id y5mr7885229lfb.58.1493014530085; Sun,
 23 Apr 2017 23:15:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Sun, 23 Apr 2017 23:15:09 -0700 (PDT)
In-Reply-To: <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
 <cover.1492771484.git.johannes.schindelin@gmx.de> <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Apr 2017 23:15:09 -0700
Message-ID: <CA+P7+xoZ_dTvg9b6uckD4-=hHHNE42SCApzs9QO0YddpKXCR5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Changes since v3:
>>
>> - fixed the fix in archive-zip.c that tried to report a too large
>>   timestamp (and would have reported the uninitialized time_t instead)
>>
>> - adjusted the so-far forgotten each_reflog() function (that was
>>   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
>>   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
>>   too
>>
>> - removed the date_overflows() check from time_to_tm(), as it calls
>>   gm_time_t() which already performs that check
>>
>> - the date_overflows() check in show_ident_date() was removed, as we do
>>   not know at that point yet whether we use the system functions to
>>   render the date or not (and there would not be a problem in the latter
>>   case)
>
> Assuming that the list consensus is to go with a separate
> timestamp_t (for that added Cc for those whose comments I saw in an
> earlier round), the patches looked mostly good (I didn't read with
> fine toothed comb the largest one 6/8 to see if there were
> inadvertent or missed conversions from ulong to timestamp_t,
> though), modulo a few minor "huh?" comments I sent separately.
>
> Will queue; thanks.

I think that this timestamp_t makes sense. I didn't get a chance to
review the code to make sure nothing was forgotten, but I think the
direction makes sense to resolve the problems with current time_t and
ulong assumptions.

Thanks,
Jake
