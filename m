Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB3D207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbcIMAZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:25:39 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34465 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIMAZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:25:38 -0400
Received: by mail-oi0-f54.google.com with SMTP id m11so346726301oif.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 17:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pI9Cbgj7g3CWOtCXBYy45NPyvKk5b9efD8IpbdeJAOk=;
        b=H/TZ7R2xvbGLvPJpRAH2T+LBpWYJg8RnPe4wXxN3pN3okWgargYDMf2NrOC5vMhEQz
         0LtVLvThEZ+YgpjLDU+LiV9qcepqzcL0Al4/Z9CMYxO6lNTY5Wpr+hE5VILAFjCvMXuA
         bpd7fELpCip0fxZaTi9306/4wVShfcpM3FM858laI7FzmCMHrRvK4K2xd7WYoy/TpwIW
         aaopzwNyX/O9Ud0qsvwMdTMDh4hZTSjhA64nBJDP0Cz68Qx2A4Bdwk5r4CghT1lwk0wD
         OIbJrySokjmXC2Mj9AQiBLKQXsN2N/xT2+hwP1YfizZ6raS/1XkVG7EXjg9OJrzMGOAr
         /e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pI9Cbgj7g3CWOtCXBYy45NPyvKk5b9efD8IpbdeJAOk=;
        b=jmcwRJUFJ/X0uEsbMi99rmyurkSLADzTHsKk/yFb9K6T/7pU6WlbD/pPZGPQ7ttrqB
         ncTVL+gtqplxMM7EYc73r5tsjAflMVd451AV0tFcwzDG1b8DvA+yDWgHJa8jLPmZX8y9
         W6e5N0I3bMsYhd95nE0Hncshn/vCZhwoKZO3Z8nwZMhW+o1lUkMj8pPEmdq1Fc2FSx8G
         axosmwapSb/cHpXpITVyL5AbhifcbXSjuksBKGoEiar5GLmZvyMJt+ENYrvixWzjAixH
         1EhqoiNJizdKv3AUVzddbvbF8qDx2ZFWftlxNyjQ/G6Zm+t33Y3JRp4sWxsd2HFSqkLH
         0ULQ==
X-Gm-Message-State: AE9vXwMK6qC/nBLQabX9YcRGGPQP3Sded8nEU27o3G1bCFzAWDUIOo4YT7sbhIuqXGlQ+xK02FfmZbDvAuIXgYeE
X-Received: by 10.157.6.197 with SMTP id 63mr29487167otx.190.1473726337705;
 Mon, 12 Sep 2016 17:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 12 Sep 2016 17:25:37 -0700 (PDT)
In-Reply-To: <xmqqoa3swteo.fsf@gitster.mtv.corp.google.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
 <1473572530-25764-7-git-send-email-stefanbeller@gmail.com> <xmqqoa3swteo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Sep 2016 17:25:37 -0700
Message-ID: <CAGZ79kbP3k0pa62xpv3SCnTvp-qSzfGKjSy8infcx=EexnBOTA@mail.gmail.com>
Subject: Re: [PATCH 06/10] diff.c: emit_line_0 can handle no color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> From: Stefan Beller <sbeller@google.com>
>>
>> ---
>
> "X can do Y" can be taken as a statement of fact (to which "so
> what?"  is an appropriate response), a desire (to which "then please
> say 'make X do Y' instead" is an appropriate response), or a report
> of a bug (to which "please explain why X should be forbidden from
> doing Y" is an appropriate response).
>
> This is way under-explained.  I think this is "make X do Y" kind,
> and if so, please say so and possibly why it is a good idea to teach
> X how to do Y.
>
> Thanks.

Ok, I see the general pattern of your answers: Add more explanations.

Answering for
patch 01/10 as well as this one here:

    I want to propose an option to detect&color moved lines in a patch,
    which cannot be done in a one-pass over the diff. Instead we need to go
    over the whole diff twice, because we cannot detect the first line of a
    line pair that got moved in the first pass. So I aim for
    * collecting all output into a buffer as a first pass,
    * as the second pass output the buffer.

So in a later patch I will split up the emit_line_* machinery to either
emitting to options->file or buffering if we do the 2 pass thing.

To make sure the 2 passes work correctly, we need to make sure all output
is routed through the emit_line functions, and there will be no direct writes.

Now that we will be using the emit_lines functions for non colored
output as well,
we want to pass in "no color" which I think is best done via NULL and then not
calling the output of the color writes.
