Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53A01F42E
	for <e@80x24.org>; Sat,  5 May 2018 07:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbeEEHax (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 03:30:53 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:44857 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeEEHaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 03:30:52 -0400
Received: by mail-qt0-f170.google.com with SMTP id d3-v6so30245112qtp.11
        for <git@vger.kernel.org>; Sat, 05 May 2018 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qKfVGqyMJafrAMESBIDep34HrIiYM06aOgl6RKHss9w=;
        b=tU4J8rHot2QGkbxyJtG27L+ARop+eCtC80k0nAIXks+DWdzB2N+I9mrGWkazU3CBHw
         MAnUPKBE9BCEnvOjfrl4o7wWYtD8IIrGtDBVXHvKofWtDFvyfZ6LFDjrWpyJ0psCauhT
         XdVT9o0In7+6Hn73ta6guBijH/GD6pk513UlCNb9kyLGmPLM+tnBnunol46Mj80CWd5q
         XiO53JCnywQjCZYt1efKJBwnbOmp+9FfvOXJ30piaPpDpXaCShqQOTZkGT7hRZpjOxOd
         zcwQg3NOMcVi9xAE88g3VSi3ccXnQxM6cMtzECLGR4HEzCmZVoFNtF6Ut+ZLh+ypPPoW
         /4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qKfVGqyMJafrAMESBIDep34HrIiYM06aOgl6RKHss9w=;
        b=E1qWTThWsL95LLTNWdJ0DBsnJP7sHxoMxyeU661STV1/mMJEWbzR6d6gbKmGzw5A0d
         toxw6gr1k+mk0e5Hqftr+RWoVr/Y919H4hoGKBCvlRuwvkqNy423daVeLbxJiJueMQCy
         VAacyUypkB1RRj5+xwU3rrYvChQv+rxWXeUoDpFWGnT7DWjjRLI/6tWwQjN1F3cHZUQ9
         Bn8/GIZtAkUopHLaPZXYJ2FfUccRJl0mMYhnbLpnBoQs/Cg0HOxhdqmoCC5GpVQ8KIpZ
         gYf9koLm/i3zOoBplD+r7dOUi322VPpIC0dFcNz7ErLP7hUnPBXmkA77OfvNWZ9RZqPD
         Mvrw==
X-Gm-Message-State: ALQs6tBIyppY18vzqg3/PXd0szNZI/rAb98Ryo7jJ7DaxI64eaTEji5N
        P3M9BEHTqCaFFiQovBQP5p9f5U9BEttPwZcYy7c=
X-Google-Smtp-Source: AB8JxZr8AgpbBVwEGJBIJAz0hSGT70xY9ICFXu3pMWah44BDQc4l1WjFIT7fVNfO2kdiMo93g/xuwq/ZuhLBKwb6jOs=
X-Received: by 2002:a0c:f3d0:: with SMTP id f16-v6mr26418263qvm.113.1525505451892;
 Sat, 05 May 2018 00:30:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sat, 5 May 2018 00:30:51 -0700 (PDT)
In-Reply-To: <9dc758e3517681691e0809d9e9bcca03fbdad1cc.1525492696.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com> <9dc758e3517681691e0809d9e9bcca03fbdad1cc.1525492696.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 May 2018 03:30:51 -0400
X-Google-Sender-Auth: jM5cQnFa33H8YXlsY6iT0rR8zIE
Message-ID: <CAPig+cRbBZ+QTqGiW_wQ9E-gROA-Wtevp1vcRqmJ5YQJ8tYEVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] grep.c: extract show_line_header()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 12:03 AM, Taylor Blau <me@ttaylorr.com> wrote:
> Teach 'git-grep(1)' how to print a line header multiple times from
> show_line() in preparation for it learning '--only-matching'.
>
> show_line_header() comprises of the code in show_line() executed in

s/of//

> order to produce a line header. It is a one-for-one extraction of the
> existing implementation.
>
> For now, show_line_header() provides no benefit over the change before
> this patch. The following patch will call conditionally call

s/call conditionally call/conditionally call/

> show_line_header() multiple times per invocation to show_line(), which
> is the desired benefit of this change.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
