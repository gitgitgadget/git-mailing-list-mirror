Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCFB1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 06:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJLNks (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 09:40:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeJLNks (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 09:40:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so11979342wru.13
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F54hyyJqaxMPgF83J9L6FocDFA+mANqYud810b8W7P4=;
        b=teUw2tUm7+fqjeHVWBpWEV59ZzxgV4oTp+hkO6BZXyEgyx+mLsJ2W7uoBr4XjfIggz
         JElae6+xTnDhXR3b5lfTAu5tEc47lKCwaLRM2OODkbt0Mn4dEeF+hiq6fo9MAT9Dd2j2
         Q+NRtL4Wz+8SY2J2sGO9mj5Fvbp6S8IQ9lmF5cB7CcVa2tccu415jRXUYNQImHts+nFz
         Hkv31aqhqkViotZt04HY2Uo+262RUYNwdD2xO891JglG5qEH/iC7yrU8qGnJYAPBKvCJ
         J5J0E3wl8UzmEJ3zRJ+wPk/4nl2o1DTTUPSzluDJ5z1Ljg9gJYx93PUSJzyKBinGyUzd
         m53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F54hyyJqaxMPgF83J9L6FocDFA+mANqYud810b8W7P4=;
        b=lK7r5bLRySZjdQo+0NdVIwrSsV2D3UtdJKpk18suPraZPkOhO7zUPLjp8uNloN+pCS
         fYDlyFOn+WTUYxnSMElFZ4WX4fu3jHLT8vnvPRJR7CmTPiIeartHNwgpZvs0D5etSoxB
         sakOuq6WOoDSoWXdLLtVzi0EKl8DftRnVPf4+tIIqwmSTD2tsafS+d1g7wZNkjDA8gob
         PXxHODUzGgBlHMn6YVDMtsYyhqy3XPiNDJH1R42dXPfUjI73h5OEow4Po7cjqwJR53Rq
         Vt+FdQeybvqLMp7kjE0CfUMcKmbSmH8Q+u+YHOfZv0f9I+knL7WYtcGIAvwHubjiHXBb
         gc6g==
X-Gm-Message-State: ABuFfohgV96+DNlhhs7SJwYYSWrIB+wM2epA6rptZ4R5OrfLjxvX6nQO
        voE6/89XN6eAUWkUDug8hhM=
X-Google-Smtp-Source: ACcGV62z500c1QhXs5O5MTtfEvhz1vI1jr0O2AYFgfLVSBcITKaELLnB3hCcPDSKBUc5vhXQ+yxXMg==
X-Received: by 2002:adf:eac5:: with SMTP id o5-v6mr3850536wrn.284.1539324595227;
        Thu, 11 Oct 2018 23:09:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 82-v6sm457410wms.17.2018.10.11.23.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 23:09:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
        <20180917153336.2280-2-avarab@gmail.com>
        <20181010203738.GE23446@szeder.dev>
Date:   Fri, 12 Oct 2018 15:09:53 +0900
In-Reply-To: <20181010203738.GE23446@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 10 Oct 2018 22:37:38 +0200")
Message-ID: <xmqqa7njd7bi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  	for (i = 0; i < oids->nr; i++) {
>> +		display_progress(progress, ++j);
>>  		commit = lookup_commit(the_repository, &oids->list[i]);
>>  
>>  		if (commit && !parse_commit(commit))
>> @@ -611,19 +624,28 @@ static void close_reachable(struct packed_oid_list *oids)
>>  	}
>
> The above loops have already counted all the commits, and, more
> importantly, did all the hard work that takes time and makes the
> progress indicator useful.
>
>>  	for (i = 0; i < oids->nr; i++) {
>> +		display_progress(progress, ++j);
>
> This display_progress() call, however, doesn't seem to be necessary.
> First, it counts all commits for a second time, resulting in the ~2x
> difference compared to the actual number of commits, and then causing
> my confusion.  Second, all what this loop is doing is setting a flag
> in commits that were already looked up and parsed in the above loops.
> IOW this loop is very fast, and the progress indicator jumps from
> ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
> progress indicator at all.

Makes sense.  If this second iteration were also time consuming,
then it probably is a good idea to split these into two separate
phases?  "Counting 1...N" followed by "Inspecting 1...N" or
something like that.  Of course, if the latter does not take much
time, then doing without any progress indicator is also fine.
