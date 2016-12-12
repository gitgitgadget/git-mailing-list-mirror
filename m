Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2034B1FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 05:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbcLLFi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 00:38:29 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34679 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbcLLFi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 00:38:28 -0500
Received: by mail-qt0-f172.google.com with SMTP id n6so67181586qtd.1
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 21:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xS2BzKb7Gdn9ywfYcKclBZZC80ASbLHZB7pjz8oi9FU=;
        b=mJk/htV4QDldwaNGXbKMU3BhhD7wAu9nYR4m2fe7R96VVczV7l2DjZ4Iet1NaQFSti
         k1kxEQuI61AE6djHF+K3zMEGg2j6RfDMPLZUMmA6Jfs2I+25+T75a0Px4zJ0tu4RQlK8
         qFshu9+HHMS1qrbF3HfAfvAF2sQ5gPBjY4x4zTbJWZanPXFcUQgBLpJh3h4FW7mWZM3X
         3Anb/cOcsh2h6RwpOr+A77GuaQjTGkQcd3cJ903PPSb+h3abSp6CA9modda8SP/6KHu3
         ecHMtv33Ms6mo5eKHo6sSPwvLWs8TjymbMkCI3ffHkZdL/wnYSBp/FtxM1zrUStTDDWN
         wrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xS2BzKb7Gdn9ywfYcKclBZZC80ASbLHZB7pjz8oi9FU=;
        b=IWieFQwx7MR58JLpzy3Al3BubKLDTp0py/J/p5Vq69qg6lWT4CZJkmC+Zo0ehNRkZK
         lT5lSpRilIFMTxuudr5+jSiL+v9hwwYYIyBXipanNsUbU1QtchmSwGXVSmhAINay5aF2
         5T6sQsOUuA8KoMUkyk98IBqJ2EkaXQQ5zApynyOmPIeYZFlF8qWKUimBSwg6gumvAWOz
         f2oenM+NLoS/qKNFoUrwvAFcFPcFiGob5k+3cScEmoutRg9HBSZ5a+7DNuT6jXHMwmz0
         3L6+dU+fTLxiCCAyUEfld9kXaUc4QXDMornBcGDP6ByvfghcCe+kGrctFQIdf0zCYxYH
         h92Q==
X-Gm-Message-State: AKaTC00CT1Y7P/5WYBbPu+GLjt/S92rmwKWHqIgWl5N8W73pU5QYBb+VVOeWxjI+yRWbI5MWnCBYvnvHf+vNVLLS
X-Received: by 10.200.49.235 with SMTP id i40mr89223649qte.170.1481521107304;
 Sun, 11 Dec 2016 21:38:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Sun, 11 Dec 2016 21:38:26 -0800 (PST)
In-Reply-To: <xmqqk2b7ps08.fsf@gitster.mtv.corp.google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com> <1481223550-65277-13-git-send-email-bmwill@google.com>
 <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com> <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
 <xmqqk2b7ps08.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Dec 2016 21:38:26 -0800
Message-ID: <CAGZ79kbbk4vdW_mbC0riXOf=31V9AQV7zKEh56G+sxjjzAr2-g@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Jonathan Nieder mentioned off list that he prefers to see that
>> series rerolled without mutexes if possible. That is possible by
>> creating the questions "struct attr_check" before preloading the
>> index and then using the read only questions in the threaded code,
>> to obtain answers fast; also no need for a mutex.
>
> I do not see how it would work without further splitting the
> attr_stack.  I think you made it per check[], but you would further
> split it per <check, thread> before losing the mutex, no?

Well I have not yet looked into it again, so my memories are
rusty, but the <check> is read only, such that the answers only
need to be per thread?
