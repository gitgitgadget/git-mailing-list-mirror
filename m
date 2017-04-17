Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AE120A04
	for <e@80x24.org>; Mon, 17 Apr 2017 14:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdDQOMn (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 10:12:43 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35316 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdDQOMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 10:12:41 -0400
Received: by mail-wm0-f52.google.com with SMTP id w64so34737719wma.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s2sKz/fcRrrftl817cgxCcwnl7mtKc0nUB4l3AgvbYY=;
        b=ew0nrpvr/ZSmZw3zbgoCf/zKbi45v0NqtxSql9r/XKSD2z/uTB81pe4bRgtE9KS3gs
         PIIuWpJuoWYKxoxzRqQ72DRFbXMRpQuHUoiQsyR1b5vGTINWQHUPwKgqJ59Mv1g6vTj3
         AUcVBcPpjwf7avY7yQGiZ7SMVxJNO1Ems/TVVUKysMhwjXu+ZKweczuw8Klr8ZxKH/Cr
         m80L8cmDY9Wrgd0ZfYI2uCO9TBQacO87/OHVPpKZuXFMRO1ClKbsO6bejjpT4Bw+MFjc
         yeGMUnygJuiJEGhajqc7TBtCiAreWeeNcVKhOfvHruxH0k/iFE5+BfwIM4mhjlhfvIlW
         x7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s2sKz/fcRrrftl817cgxCcwnl7mtKc0nUB4l3AgvbYY=;
        b=dyc6NRmV9aLtqvDn+UrZK9b5sLRj4koObe/UtP8p9Olyz3X0NlqDNy7GUEPYHyM6RA
         e3Q8CH4/tiwif1FFdFw6gThgozADWZbCrnj6vLEst8YhsMofExvnjgKCZMWo3laAmEZu
         rxi7tK1ad3wXby5QFpkUsbWb6ewnUFiHQXF3avgIJ2kKJHa0ANFiS+nZTjS6SkPCgp72
         NmZ1SCjo2hqvQ3ToDu4ZuYF4z/2HFZVwz8hmma+rlzzOb/58GoKvkYdeNAn4LeZm6rhM
         Fq/25/SAlRz4TgyFaak5Jah0l25yRtkkLQUc1gq9TlK/i8fvyGwMcAmEzmzwT3CnfU2I
         sIVg==
X-Gm-Message-State: AN3rC/7+qt1/8WktHCqhvpT/JkbcWdKRXdDEdAPOK5UsxI4Apnpiz6lO
        I98W+MF1eGwpKK8iVYSPqXkY4Gqbnw==
X-Received: by 10.28.74.147 with SMTP id n19mr9339488wmi.86.1492438359767;
 Mon, 17 Apr 2017 07:12:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.98.212 with HTTP; Mon, 17 Apr 2017 07:12:19 -0700 (PDT)
In-Reply-To: <xmqqshl7ik21.fsf@gitster.mtv.corp.google.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com> <xmqqshl7ik21.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 17 Apr 2017 16:12:19 +0200
Message-ID: <CAOxFTczhfvzhrSiCj7SgLXbO3hrBW_QaDVZMpOqrij_hCJyCzg@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase --signoff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 9:12 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Two questions.
>
>  - Is it better to add a brand new test script than adding new tests
>    to existing scripts that test "git rebase"?

Since this is a completely (in some sense) new feature, I felt it was
appropriate to put all --signoff-related tests in their own file. So,
if the need arises to put more tests concerning the interaction of
signoff with other stuff, this new test file can be extended.

>  - How does this interact with "git rebase -i" and other modes of
>    operation?

A better question would maybe be how do we want this to interact? For
example, with -i: do we want -i --signoff to just sign off everything?
Or do we want a new -i command (o, signoff) to signoff only individual
commits on request? When preserving merges, do we want to sign-off
merge-commits too? I'm not entirely sure what the best policy would
be.

-- 
Giuseppe "Oblomov" Bilotta
