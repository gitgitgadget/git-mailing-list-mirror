Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E761F404
	for <e@80x24.org>; Wed,  5 Sep 2018 21:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIFBsJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 21:48:09 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37770 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIFBsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 21:48:09 -0400
Received: by mail-wr1-f42.google.com with SMTP id u12-v6so9102226wrr.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LvBwPKvxKWltrtjZn/72bCM/+ZOSe+SCj6dr+dGNT8A=;
        b=u3gGanKE5jzYEO8nFNhPnkrvEEHnfJOgZaJhzNJpLWpEwTod8FuOlnm8UQkb6bUh0s
         fgy0uxtU8Qo2HjEW+at40cuIPxiWxkEjdcJO9PHfQui4ZUa+Pwg8cAG3PI/OOQI/VK9y
         RfNNOOjwYdzjckjfg4egnOqheKLSPPAQ14Uk4gXGowsqoDogjQQrSiOlyJArCG8sBv2E
         4RAp09hynA1XdzMfuR/+PL6PZd9ZqEtrOPs/mbJezuoNtYAx28I2TGKy7avF9rlXqKkb
         GKdBoO00+xP4aRYX67QydoBWg+V8YaEI0fqJwgm+BJagU/8HbUoCIVM7s0DushZ71+kZ
         La/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LvBwPKvxKWltrtjZn/72bCM/+ZOSe+SCj6dr+dGNT8A=;
        b=YtoQeD+Mrv1Z+VY/tmSDthv9/O3cPIDzBOdz+EtlxyI7ChP7gPGNLR2sURc0oGr1qD
         mtZL+kLhqhsufeTigJmo9P2vngD1lZACaQM045WLkAEhfJbqRTBn/Q3pnsIzivxFMh7e
         oUf2a9GXSddboTWEu3jlHmDCpjt7UGqmdqKya7vSmWUhkIN0rIeiyDWRtGCCnFkbs07I
         jdtnx288xGc5tVihKUvrLFsSHHc7Q+SqsxrvgCLeqyuC8JODWkFDxXPOff5XjpkbI0XB
         roYNiY95WXRc+KVThaghEdjCeQ85pEmtWQ085I6ZMmsRobHN3cj7T9+IPeQ4a+4yjyWq
         yRVw==
X-Gm-Message-State: APzg51AjyKnhDuLNGN84zPO0lvvkvmutQGl32vcrT+iy2qMpVw1/ZhRz
        2fprlV0hQhGNnxGNjUOL0tM=
X-Google-Smtp-Source: ANB0VdbBZtoNAyzDz3G8w85e+Wni5tEgRwimOjnvrpfT15KTI9HFj/VKL4UhR3rpYnpkpAlD9m19/g==
X-Received: by 2002:adf:f0c8:: with SMTP id x8-v6mr8161071wro.49.1536182167887;
        Wed, 05 Sep 2018 14:16:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 144-v6sm4572694wma.45.2018.09.05.14.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:16:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How to handle patch series conflicts
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
        <2293750.yp9BkL5mAn@thunderbird> <32028230.38oFsPliiV@thunderbird>
Date:   Wed, 05 Sep 2018 14:16:06 -0700
In-Reply-To: <32028230.38oFsPliiV@thunderbird> (Stephen & Linda Smith's
        message of "Wed, 05 Sep 2018 10:25:17 -0700")
Message-ID: <xmqq1sa74pd5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

> Junio -
>
> On Tuesday, September 4, 2018 10:27:26 AM MST Junio C Hamano wrote:
>> > t7500-commit.sh
>> > t7501-commit.sh
>> > t7502-commit.sh
>> > t7509-commit.sh
>> 
>> These seem to have organically grown and it is very likely that ones
>> later introduced were added more from laziness.
>
> How does the project prefer to handle patches that conflict.  Renaming t7501-
> commit.sh will conflict with a patch set that I submitted over the weekend 
> [1].  Should I treat them as totally separate? 

How about not doing the rename before the more important changes
solidify?  Alternatively, doing the rename as a preparatory clean-up
and building the more important changes on top is also possible.

> On Tuesday, September 4, 2018 3:36:11 PM MST Junio C Hamano wrote:
>> * sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
>>  . commit: fix exit code when doing a dry run
>>  . wt-status: teach wt_status_collect about merges in progress
>>  . wt-status: rename commitable to committable
>>  . t7501: add coverage for flags which imply dry runs
>
> I noted that this patch set is similar to the one that I just submitted.  Are 
> you thinking of not using mine (in which case I will drop it)?  If not I will 
> add a patch to fix the committable spelling[2] and re-roll.

I think that one that is not even in 'pu' hasn't been looked at for
a long time; it is probably a good idea to discard and replace, if
you have something working.
