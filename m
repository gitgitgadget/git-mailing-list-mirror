Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEFF208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 16:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbeHGSoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 14:44:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51843 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeHGSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 14:44:04 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so22868122itf.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tufmQlh2W0DTsUE/lYzJx1l4HHxNDNHrL+xqwtAKIrg=;
        b=d8c9iOx7bRZwz0QBl8ZQh/sxfj8+I47kgd8FTTM+10f+eaZ2nQdDamHb2gW6xASBxr
         /ZQKBVLlfjVTVUd3rrK2xR3NgbB2SjunxTrzZUKokNV+ShtUuZxr1waKVoX1x7QF3h5V
         d+U6gNV/y3sRuoNqbBbvAAPlFG/gZrmUh+rG2W4fjrTyy73Qd1uNn+NDbu/yC2DHs20R
         rhRpLEj3UVCVuyFInOYYsLC9tVfYbOYhPRg8UUDkBbliLt2BQA8S7Z3ZQgSsjSQrkcnr
         rCGb8MQffyg4DBgdV5XCufab/2kL4+XjTt2QxEueWTVOxFjMzxayPid3ob7tknGCYL+F
         bBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tufmQlh2W0DTsUE/lYzJx1l4HHxNDNHrL+xqwtAKIrg=;
        b=sLwT3/NC3b08A6EKh47UyayZvrROIEKSFO7GskxdfXCMoOKZ7MJIS5RLWLH1g2eTn/
         mMy/lviTjKHXIeM+PDXzQtSGonHeZVzunKejq41eXqemJU+Sbcbkm5cYRee7e2rRc611
         GFV8yII0sNR5ogK4YKWpyLldpQX/q+d1fO+5qJUf6wiNU3OZrwtbEdHW40+JOKZga1u4
         8A6PWunA55YUfP1k47QXdg+1GNLR0RWp9tpzvXFDx3xFyoSrsDFmtPrKBb5PBmO1gmVY
         MeZyGn5/cshQstywpGJfK5PeFYf6ncsP9dC3nKptFMf4vJnvCHwTP7IQ8SoQ50zMw50n
         132w==
X-Gm-Message-State: AOUpUlFcNmoaE0YUEPqchBiMwB0Q7C8dAFApGmKH69EX7iL6xybMlvdi
        YwDlWK3/2ZiDUbcMnFlRzqEvoS4IQu8SOdIqX9M=
X-Google-Smtp-Source: AAOMgpdBOUeJoSntLH9caq5XbupBSlUW3mmgv4fg0IB7hTdsAi62WbpgenJ7Ylh38gyU25TtClA+K6O18jMA0HjwPhg=
X-Received: by 2002:a02:6016:: with SMTP id i22-v6mr17827003jac.8.1533659339461;
 Tue, 07 Aug 2018 09:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 09:28:58 -0700 (PDT)
In-Reply-To: <6832700d-d7be-1df1-8b24-6e0290de63ed@talktalk.net>
References: <20180724163221.15201-1-alban.gruin@gmail.com> <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com> <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
 <CAP8UFD3KbDrvU3zj24F7FF9ui2X75Vih4CoYE=cCZEWMsKP9Fw@mail.gmail.com> <6832700d-d7be-1df1-8b24-6e0290de63ed@talktalk.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Aug 2018 18:28:58 +0200
Message-ID: <CAP8UFD2_oxn=auXb1tYCb5xED5YmKU3W=fCrpMsyxdZBfs2qcw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 6:15 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 07/08/18 16:25, Christian Couder wrote:
>>
>> I agree about checking the return value from fputs(), but it seems to
>> me that we don't usually check the value of fclose().
>
> A quick grep shows you're right, there are only a handful of places where
> the return value of fclose() is checked (there aren't many checks for the
> return value of close() either), I'm don't think that is safe though given
> that write errors may only show up when the file gets flushed by closing it.

I vaguely remember we tried to check those return values but it didn't
work well sometimes.
