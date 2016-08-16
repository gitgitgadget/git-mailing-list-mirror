Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3391F859
	for <e@80x24.org>; Tue, 16 Aug 2016 18:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbcHPSI7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:08:59 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:33435 "EHLO
	mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbcHPSI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:08:58 -0400
Received: by mail-yb0-f174.google.com with SMTP id a1so9282307ybi.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 11:08:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dwe/TygZbwUFdH9aH+P++3Zjg8otvRDIUBYbrEVgZQw=;
        b=wZZfkYqV6bYjjqyBn7/YYKeJHu+ptz79v1iOFLWpYLBzNhV0QK37pnsQzmci9uqeD7
         fDJF08QaLZQBfP7fFr4zRScieFn/Oaj39SrnxWPwUqxzTYTcTLv20mzT8MPziKuBmtzB
         VfaR2Hbf8hns/1UfJiwfeIDeMpB/Z/cnsJnFano0WM2404wLFYZf0id+gCIdgCt55qgF
         07DrW5BC4+2M5qOuLgQHe58b/p1RLxRyTKHrprjsxoWZs+xU9/pVIk1QBaWy0hpD4hz/
         UH9h+A5/iNqk2F14fdO2znFuxTPPXOrqKKEGGEERuAYrsCn1EA/Pwmp3ArJV4PiewGCh
         s5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dwe/TygZbwUFdH9aH+P++3Zjg8otvRDIUBYbrEVgZQw=;
        b=h7vrIgXsoFbfKd0Uan2IujzLGYbqbpWgA0gHBqnEYJQ3ipgaNQujW5MnWfu0nvFmx5
         Jf5kn94cW8+X9mtGc8mBp+tN1OEUXn39kGd/IGD3Oy0IiLY/9bswBxY6e9LLrk1OChkb
         ieckSnCPOFr7f7B5cUfZXlLtGK9x+34sIK0tUAfWcUOaJt9zUC5ZantLQD9yW5DD6rtU
         fTNpThBGIAMz9jxmDwWVbqGkDDh2tvG27ErDc021Ci7FFoOwfoLNeoh9DExB6dbWvVJM
         iyj5kt31XWLx4v6A9jP72ICJEnN7OmPXtKwq/ERx7EAy2jd66EuX4hJcy2yDL5g7G+wR
         T8bg==
X-Gm-Message-State: AEkoousQD9pcErh/YfO7KSJ5DkGMU4V4fQP0N7/Yc/x5/FqypuIE9r75BFuhbzsiwXIKpLnn5paxZ1CTrLA6Tg==
X-Received: by 10.37.198.210 with SMTP id k201mr21489420ybf.113.1471370938064;
 Tue, 16 Aug 2016 11:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 11:08:37 -0700 (PDT)
In-Reply-To: <xmqqpop8d21j.fsf@gitster.mtv.corp.google.com>
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
 <20160815230702.30817-2-jacob.e.keller@intel.com> <xmqqpop8d21j.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 11:08:37 -0700
Message-ID: <CA+P7+xqG_3KS7tGS_DAuDx5aVTkfiO5k5biECcbbvA06PtXrhA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] diff.c: remove output_prefix_length field
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Junio C Hamano <gitster@pobox.com>
>
> Thanks.  I had quite a many typoes in this one.
>
>
> No need to resend; I had it with the above fix in 'pu' for a few
> days already ;-)

Thanks,
Jake
