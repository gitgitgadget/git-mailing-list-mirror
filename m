Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A64E20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdFVUTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:19:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33464 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFVUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:19:47 -0400
Received: by mail-it0-f65.google.com with SMTP id x12so4483717itb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/0zsmuINMuBbfJmi9ulNjseZECqqM4Rb3Cq3hy6SD+Y=;
        b=LtteJo2xcaujQsDIFlIPbMlFjdBFTG+dC+WlsBhe2a6aL7KlxTk9RiZplk0wYB+0LB
         WkNIqpqssszbTuoeAUrAx55jiBjK+2KO0x+860dltsy09IN0yXhD2z1nt1eQ4+Yxov48
         SDZ1UGtitaR2uFkadz9tcZXBBn1KK7qlBneP1keafKEa72XlDLZaeyRs1xIzfF3A/P5P
         xwZsemxOyu24rPd2nGf1f7Kb4APyKR5hBLN/MNbvjyb9bfrABHIbBMxQFPzDNQOvT45s
         Jx4yn5deBjnpx1cJ43phKGM9Sr32mmBrfmkXiYraOHeFf7F/F8qZj/tiZkIUD7W/DBs4
         UL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/0zsmuINMuBbfJmi9ulNjseZECqqM4Rb3Cq3hy6SD+Y=;
        b=UVtTCo0IeJB9Grfcd6piq2X6vddbTYsERawpNvLrscsIkSCj9XYhWzJ1gUKhASjYnS
         qOQnJO+PrsRFycOe7AARaWdkMeE+ZD+gzBktzG5323UdPn40LV+0ZT4+RwSMXBbqeTKH
         7tNnSk/y+cyRe1N4otO4wJNondBu6ppM5K+jqhyiQm+sjGp6AfQizl29T/1uee6R5PeZ
         A0/b8ClrrBMgb6hz7peamnu5lUnBggQ6MBbOE5vLp2+rjXdzCVBa6FO0ZK2CZaJeSA6F
         7cCAR0NLgy6n2yfkq1yQpusqolFAMgnWAfXUxoecgW4Cutu9zx5Lwy7Rmp+k/v70vII1
         ABZQ==
X-Gm-Message-State: AKS2vOyHb0ZqjvAyl/W3N2al+C0hs0+27UuWF95gnI4zFNRz4GUb60Xc
        9q/1AWBiynoUUJ3/GqfbBMm/NI3DiQ==
X-Received: by 10.36.84.144 with SMTP id t138mr3773468ita.76.1498162786522;
 Thu, 22 Jun 2017 13:19:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Thu, 22 Jun 2017 13:19:46 -0700 (PDT)
In-Reply-To: <xmqqzicziyss.fsf@gitster.mtv.corp.google.com>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
 <20170622190158.13265-3-chriscool@tuxfamily.org> <xmqqzicziyss.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jun 2017 22:19:46 +0200
Message-ID: <CAP8UFD2QwN_8Mn3eFT_FRRbXNfnQFwt53nofh8AUzR0Zhx5EgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t1700: make sure split-index respects core.sharedrepository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Add a test to check that both the split-index file and the
>> shared-index file are created using the right permissions
>> when core.sharedrepository is set.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  t/t1700-split-index.sh | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index af3ec0da5a..a52b92e82b 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -370,4 +370,16 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>>       test $(ls .git/sharedindex.* | wc -l) -le 2
>>  '
>>
>> +test_expect_success POSIXPERM 'split index respects core.sharedrepository' '
>> +     git config core.sharedrepository 0666 &&
>> +     : >seventeen &&
>> +     git update-index --add seventeen &&
>> +     echo "-rw-rw-rw-" >expect &&
>> +     test_modebits .git/index >actual &&
>> +     test_cmp expect actual &&
>> +     newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&
>
> Hmph.  Don't you want to make sure all of them, not just the latest
> one, have the expected mode bits?

We use "git config core.sharedrepository 0666" at the beginning of
this test, so it will only apply to the shared index files that are
created after that.

Do you suggest that we test before setting core.sharedrepository that
the existing shared index files all have the default permissions?
