Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143541F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936601AbcKNTYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:24:55 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32822 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbcKNTYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:24:54 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so8522436ywg.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=51OWhZFQ+0ojqDvc5UvLJ2DylSYVXndwcbh4TYcT5ZM=;
        b=gAMDqrNX9MC6DzcZ3FSt0nMrf/Tm6yJzDzIxZgleV+mO6yjr1NG7oZTPBjc8+WxyeA
         4S0PN1bWmtS2mEeSCaZxq9qTS1UqJtr3xn/BARCkjhrU/sdgHBiOU3ks6/U+GJEmxvcQ
         2AX80Id4E7vNxIX+cTEXLos78ge5V5TE/ihthAncgAyCp8KVmYmJD1hzYFu0bisH53NP
         vR+m2BbTRtAZeF0ztRnGnAQgUMhPaoOaBqKIER8zG3LPhv9L6L+gGWATXPU+1di/tzfo
         v+w3JJeIEFK0KBCEms160QAEsZCTQtJs0rDGLCdmrI2r0Ws55BmObRbISDVqeZH3MW8V
         CEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=51OWhZFQ+0ojqDvc5UvLJ2DylSYVXndwcbh4TYcT5ZM=;
        b=M2XxB3KpOXr+C5fVDdNzMl0xzWPWrYkbPiy0sYxXevskrjf6uuwQ1oQKT8fLN01prX
         LOMA6mFUC8a7AZYsWDxhpEVfNMbsIl0lH73kAhe8I9EoNg5HTqXAoe/hS2ZTGssGHeS2
         rxJBcIGj/loMZOZP6wyCSssy4Ajpu4CSXBYY1j5vFBc9YnGKb0EQub/OOwI+gnZaLb6s
         Kh1Qkuv1WO/bdhOrtCKuG1lB3R/X5RwyQ0ZXNyCruxt+yoJPSEDh/gN+BmrNNyJnWNuX
         vLPLlz+Imnhq7UsHkgATw24WRymRBQdI/wNwFwoRaWmmaH4kslsZDnPMyk+w3KUsBYHY
         HDQA==
X-Gm-Message-State: ABUngvewV1gdCZC8fr6tjtjnMaDmbO6II8slgMPoq1m+vfoFc7F8TZ1Rms565AKWeZNTiGNNyAFMaBQwJ0nY2w==
X-Received: by 10.129.85.11 with SMTP id j11mr15443701ywb.123.1479151493771;
 Mon, 14 Nov 2016 11:24:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Mon, 14 Nov 2016 11:24:23 -0800 (PST)
In-Reply-To: <CA+P7+xqRjMThZF7u_W6G0sHjFP3j5PMr=TszC6UxL2XCYO+CVA@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <CA+P7+xqRjMThZF7u_W6G0sHjFP3j5PMr=TszC6UxL2XCYO+CVA@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 15 Nov 2016 00:54:23 +0530
Message-ID: <CAOLa=ZRKTE7-LQ27K+aqKanfE0ioerdkgTgAmjOXxC3CZVY7yg@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Nov 9, 2016 at 5:45 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> This is part of unification of the commands 'git tag -l, git branch -l
>> and git for-each-ref'. This ports over branch.c to use ref-filter's
>> printing options.
>>
>> Initially posted here: $(gmane/279226). It was decided that this series
>> would follow up after refactoring ref-filter parsing mechanism, which
>> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>>
>> v1 can be found here: $(gmane/288342)
>> v2 can be found here: $(gmane/288863)
>> v3 can be found here: $(gmane/290299)
>> v4 can be found here: $(gmane/291106)
>> v5b can be found here: $(gmane/292467)
>> v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
>>
>
> I reviewed the full series. I found a few minor things I would have
> done differently, but overall I think it looks good. Thanks for the
> hard work and the time invested here. I remember seeing this on the
> list quite some time ago, so it's nice to see it finally come
> together.
>

Thanks for the review. I've gone through all the mails and will follow
up with replies.
Will post the next version as soon as possible. Thanks.

-- 
Regards,
Karthik Nayak
