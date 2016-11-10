Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0363820229
	for <e@80x24.org>; Thu, 10 Nov 2016 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965792AbcKJRhF (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 12:37:05 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35980 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965733AbcKJRhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 12:37:03 -0500
Received: by mail-yw0-f174.google.com with SMTP id a10so22926856ywa.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x7xwKH9pBxVXM5QBYoD4Yn6Yq+I/hKETQPq3vvG/Fe8=;
        b=ATBAJ/VOiDxGCMUjHNyblUODtmDaHlg0UNEDIf8WwopERba+JZh7o6T1FhwZzjNC6L
         lRcVXuQc8N9sGEWXxfVUV9ufKLiPMb5boRlTFAGgLP5UbwaUzZ1tPCsXbtVNF1B3qm33
         Y4IuKXGsyL6rT6Jj1X+tc3roaiJEM1IMbTAHM3az8xuoVFBkyOvixgSHIKOUyPxuF41j
         47grvKgZy3yt6h7wpyJHVCjCJSQxO6aVzi8AVk1MIM8zTvDSG5FCnivhVPaV2cSvDru7
         Iu//qjEEsiKnCkn5PNt0AuCKgX2oNlJk1IfsfY3Xk7HzW1MkMBSt4JVJ9lqaJESF4JIc
         sjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x7xwKH9pBxVXM5QBYoD4Yn6Yq+I/hKETQPq3vvG/Fe8=;
        b=T2pK8rybw3YKvpulYpF/a4gRTS0WGzZc+6qCQCOvZHJe2FWfVGiN2+PyUmsbjCImag
         mlX5d5ECRsGw9pyTX4VdFOoTArqhelDOJ7fphBW9hTmBW2LBCLMdo4MjvkAPCpsxdXFg
         snluDknoBbKQ5mvPJsuuocFqCjUzcUSxxDWgRWUzWGt4DJAdBhdCNOa2M70hfY07rSrI
         YB17zJtXAY6oj/8Te3i5N4o0ix3PZGIzYtb/vN/grDuZEcEjAaF1qan2ZcMdbAdpewuJ
         q9A43T0KQho3m7ZDCJDs8SWQeCUETn7SA80eFWcNJ1wI+XImeSBINcf4H3jxjo7NbhJE
         xSDQ==
X-Gm-Message-State: ABUngvdPNX1cNugXz7J5T5FOhIMTmwsZn8zWjP1NcrJeyo+7VBHZNyN3VdwIw7jbGThENY4d5j78Lt3PTKp+Ww==
X-Received: by 10.129.85.11 with SMTP id j11mr6026474ywb.123.1478799422660;
 Thu, 10 Nov 2016 09:37:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 10 Nov 2016 09:36:32 -0800 (PST)
In-Reply-To: <CA+P7+xqG5ACT2ZB=M8gLmDaYgSgX202+afJmZJKat6NzbFzL=g@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-5-Karthik.188@gmail.com>
 <CA+P7+xqG5ACT2ZB=M8gLmDaYgSgX202+afJmZJKat6NzbFzL=g@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 10 Nov 2016 23:06:32 +0530
Message-ID: <CAOLa=ZRDNGGc-OA+d+T1=9JvoVe2eBZt0DYQEHmeNKhDpxQbdg@mail.gmail.com>
Subject: Re: [PATCH v7 04/17] ref-filter: modify "%(objectname:short)" to take length
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 4:57 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add support for %(objectname:short=<length>) which would print the
>> abbreviated unique objectname of given length. When no length is
>> specified, the length is 'DEFAULT_ABBREV'. The minimum length is
>> 'MINIMUM_ABBREV'. The length may be exceeded to ensure that the provided
>> object name is unique.
>>
>
> Ok this makes sense. It may be annoying that the length might go
> beyond the size that we wanted, but I think it's better than printing
> a non-unique short abbreviation.
>
> I have one suggested change, which is to drop O_LENGTH and have
> O_SHORT store the length always, setting it to DEFAULT_ABBREV when no
> length provided. This allows you to drop some code. I don't think it's
> actually worth a re-roll by itself since the current code is correct.
>
> Thanks,
> Jake
>

That does make sense, It would also not error out when we use
%(objectname:short=) and
not specify the length. Idk, if that's desirable or not. But it does
make the code a little more
confusing to read at the same time.

So since its a small change, I'd be okay going either ways with this.

-- 
Regards,
Karthik Nayak
