Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF6B1F462
	for <e@80x24.org>; Wed, 22 May 2019 19:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfEVTGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:06:37 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45104 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfEVTGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:06:36 -0400
Received: by mail-qt1-f172.google.com with SMTP id t1so3726985qtc.12
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgEg680OqUUAhQVn9hdSvMA7ovJBB6VRQOFr+/skJvE=;
        b=h/bjxR03t60hTry6orGykgy/QpB/9nXaY/9PfJqgjz+fpkiylMETSpNCfTXrQD5uyK
         /Z87Y2kM3xHG6URelEIG9nmGM17E4KQWNIvVF/TGvDAhz+Ng9/MFOhBN+hrxTe+JVMDg
         izSOaVMalwC3ojqc1KuOt7dHHQJo/v15KFZHyzTlbjY6zRozDgIhfFnVuMn6wpTuqmjc
         x7GpnVzeI49WXo/QTr9OX4bnEC08irG0sxMLT3b+ojxqqicTHgwzfSgRJRlNMukvj6Np
         jzN39HFV/QS0r//iwusnlPyPg8Fn9zYW1jDAefiSQBS/JobFxSfqFdcjccPyqKxsYWlt
         l5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgEg680OqUUAhQVn9hdSvMA7ovJBB6VRQOFr+/skJvE=;
        b=lW8buPLJcUu8+0UxwZ2PyCYgchXan7VNY13pdXXbXveueAnjg5Q0LO+2n6+3abvRRo
         9LDFbCZVB2poy+jZnx1Zm9+Tv1hYCu/fBaS5Fl7Z1PL7jtGkw1/h8SdeuuB467bmomBi
         fK9yu6Qq9LD+vbnFt0uqXPNX7NiYMT02hsvhsPalIzmm7y+fAtIhE9NvFBSGefSxdHVy
         unO98qZBKu4IO3IQHNZJp/Njb6LHIeeZQCNwYgOP0spcJjT0q/t7pmG2b9DFC+9bDlrV
         FlFwTwjHUIHfPsveRlncWLm95EeRAV+i4Oab90x2GAwa6LhA45Mk3Mh2QS+DgAbLert8
         t5Og==
X-Gm-Message-State: APjAAAVHtbABiiK73cqnV03oQ3L17YHfwrukRH9sG15EkBBoTHnPr8hL
        tQQGt5HC4PlhNTpvvWjjGG+oczUuahM=
X-Google-Smtp-Source: APXvYqxwYtOz/8Bh3Zt6gv43LJpKmhzKtoAO8WTrsWtUNYm4dXdliLfO2Z63O3qJxZ8aOfbE3M6tfA==
X-Received: by 2002:ad4:45ab:: with SMTP id y11mr73166461qvu.137.1558551995205;
        Wed, 22 May 2019 12:06:35 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n67sm12384304qte.42.2019.05.22.12.06.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:06:34 -0700 (PDT)
Subject: Re: Revision walking, commit dates, slop
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
 <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com> <86mujhpewj.fsf@gmail.com>
 <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com> <86ftp9p7i8.fsf@gmail.com>
 <864l5opuz1.fsf@gmail.com> <88662e18-db51-cb48-3307-0ea2a91c4ebe@gmail.com>
 <86lfyyny0p.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f1f2c7f5-9b78-8404-2738-ab895a06c133@gmail.com>
Date:   Wed, 22 May 2019 15:06:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <86lfyyny0p.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2019 2:29 PM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 5/20/2019 7:27 PM, Jakub Narebski wrote:
> Restating it yet again:
> 
>    A.  corrected_date(C) = max(committer_date(C),
>                                max_P(committer_date(P) + offset(P)) + 1)
> 
>    B.  offset(C) = max(corrected_date(C) - committer_date(C),
>                        max_P(offset(P)) + 1)

The problem with this definition is that it "defines" the corrected date, and
then _adjusts_ it by updating the offset. I consider

	corrected_date(C) = committer_date(C) + offset(C)

to be part of the definition. You could restate the definition as follows:

	corrected_date = max(committer_date(C) + max_P(offset(P)) + 1,
        	             max_P(corrected_date(P)))

or, equivalently

	corrected_date = max(committer_date(C) + max_P(offset(P)) + 1,
        	             max_P(committer_date(P) + offset(P)))

This definition, in a single step, satisfies the conditions below:

> 
>> The final definition needs two conditions on the offset of a commit C for
>> every parent P:
>>
>>  1. committer_date(C) + offset(C) > committer_date(P) + offset(P)
>>  2. offset(C) > offset(P)

Plus, the "+ 1" in the first step takes into account that "0" is a special offset
value in the commit-graph file format meaning "not computed".

> Well, we should check/test if performance benefits of "offset date"
> ("corrected date with rising offset") truly holds.

Yes, a full performance test will be required. I have full confidence that the
monotonic offset requirement will have only positive effect. That is, it will
not affect the case where committer-date was better than generation number, but will
help the cases where all the committer-dates are equal.

Thanks,
-Stolee

