Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73AA1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeHaUeW (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:34:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55785 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaUeV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:34:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so5786912wmc.5
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bAHIDuExOMKlW1tttzAJGP+QWlHb6OFxs1w2MVS9uXY=;
        b=uIru8KxQk44WaTwfdArHE4PkM70gAo5SUeHy4dkkI1kaCd1v1mwdHO3FmYkwzzblC9
         4+1n78SrhHFGd7vUSb9CydL5dTpUEorMl9wL3/br/SSfYVCQcQWUu4PeMRXn8FJrBhln
         IwkA+S4QY5tKkzb4WeTCDdRWMPeCMCFSVLU2BhWaTKwoGqdSuTe6iiLtYSW8NBeiWHLH
         haD5URvsXDgQdYd3ZL9xNaiPo7WmRROTxZ3DO6gqpCTsuZ/wNIkbnaSsoauUVi/uB3Oq
         qFMaZN5jCsW4yYim9P2Y4RoNyC8f9IlIkVTVSEJWV9lKxbA/AHgUh02b+1q9P0kJUk1H
         t/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bAHIDuExOMKlW1tttzAJGP+QWlHb6OFxs1w2MVS9uXY=;
        b=Wach+e6zTmpCswCRyc5DNPvdTuAlDyJFP+NYqAUFBkAQCAWdCZ3N+Hzu4XY8Dni+Pg
         gUno+6gOVxKEHnGd2SqqwULqYcNczOmhXQe2EqkhzniILR5dVcIcftECtmEbXnqu2K9c
         JHj4BODDvFFnmx9SOwCdicTvZtrDi0L3HqISIVmaD/JJBdnAP4tINAuAQxZ8pkVmvxN+
         hWANzM0aimbQ6Fff/UOXgIQDIh1SKfwjP36kxeZrUo/gtX+TFXCupTE3++1YfsYOi5E0
         9FGIRaAwVcBMWbb6dfgAUQK0NfVnnCkzXKLYPsYOuSv6TSQN5+DoOe7RaPYoi+EYD67F
         +vqg==
X-Gm-Message-State: APzg51ClBiz19pBWZxoI8R2WdTaA4ZibiGdRFqyublEzASRCvlbtoF66
        j/t5GqHXNH3FjdVGD93p21lJPjh+
X-Google-Smtp-Source: ANB0Vdbjl4N2fib7QWVRIsHY65xBE6NRLANSlSSCFEk0Wn1C4tddsGVXkg86m3+izrNJ1BZ4S97K6A==
X-Received: by 2002:a1c:c95:: with SMTP id 143-v6mr5449080wmm.50.1535732763818;
        Fri, 31 Aug 2018 09:26:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b2-v6sm4775256wmh.3.2018.08.31.09.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 09:26:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Stephen P. Smith" <ischis2@cox.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Add test for commit --dry-run --short.
References: <20180831053921.8083-1-ischis2@cox.net>
        <20180831053921.8083-3-ischis2@cox.net>
        <87bm9jc8cq.fsf@evledraar.gmail.com>
Date:   Fri, 31 Aug 2018 09:26:02 -0700
In-Reply-To: <87bm9jc8cq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 31 Aug 2018 09:18:13 +0200")
Message-ID: <xmqq8t4m33l1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 31 2018, Stephen P. Smith wrote:
>
>> Add test for commit with --dry-run --short for a new file of zero
>> length.
>>
>> The test demonstrated that the setting of the commitable flag was
>> broken as was found durning an earlier patch review.
>>
>> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
>> ---
>>  t/t7501-commit.sh | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
>> index 810d4cea7..fc69da816 100755
>> --- a/t/t7501-commit.sh
>> +++ b/t/t7501-commit.sh
>> @@ -682,4 +682,14 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
>>  	git commit -m "conflicts fixed from merge."
>>  '
>>
>> +test_expect_success '--dry-run --short with conflicts fixed from a merge' '
>> +	# setup two branches with conflicting information
>> +	# in the same file, resolve the conflict,
>> +	# call commit with --dry-run --short
>> +	rm -f test-file &&
>> +	touch testfile &&
>> +	git add test-file &&
>> +	git commit --dry-run --short
>> +'
>> +
>>  test_done
>
> Ditto my comment on 1/3 on this. I.e. this changes the failing tests in
> this series from 2 to 3.

Correct.  Thanks for helping Stephen on this topic.
