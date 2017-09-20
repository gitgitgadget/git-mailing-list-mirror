Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566BE20A28
	for <e@80x24.org>; Wed, 20 Sep 2017 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdITQ3o (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 12:29:44 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:54009 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdITQ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 12:29:41 -0400
Received: by mail-qt0-f170.google.com with SMTP id 47so3330663qts.10
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fLe+WsdoEMspEQwKqhbMh5VUEtEScd5DwD0JDMGu5rM=;
        b=I4rRozdx8+qtOZ3m1JOCZ/znU9ea8RrdXpuzLfHHE1DTN3ZkS7NuMCCFIYk+tH/IHu
         WsMWT3kC5NkvfOr2eU9PNXEcy0TQZE+k9o6WICP+Kq21ZbWkqCYeybbN/GAra/dZXAwe
         6zeQfaAVZD9ahYx25vVR2s0/JtWP8b1x/nwgnNw1W/Ru6VexNLE/S2YRhIi+Q0+uKSQY
         QCavWIQ89hvMKDxkXcnXF2pypmn7jej3dbBf8WbeRUVckDcPqqWMPcVg+Zf9GEf1EhAR
         zXBOm7lJn2bG6MitPiuTb32Mfz4LpdRufGTz2MvGkbR2ws3Z6M6PRjOKGJzjMrjeb86r
         mPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fLe+WsdoEMspEQwKqhbMh5VUEtEScd5DwD0JDMGu5rM=;
        b=d64wN534W+527jWfmJY78nrJ6zzKfyp6/M1QAXHJC5nFZvIflBqFHeytNunWUs7Jsa
         Prnw0aGKA13EAzTkj0ReV+1lwhnXu/03kev/SfLXfJKUSoJA2irUZrNFzAItgvnAhXXC
         /s2qd6Gd33qhumN5On1GnNMAm9ue/O+FbzfWmv78A04fSIKgf49P8WIWHmxvnwYFooWz
         me9d5/kHEoWnEFvjf8vlFkVuiMvwK/9z7XA5RzX1tGsEzYUDa517L/2ddRskb9HVJ66S
         J5Ub5G4iTvtHbhODAs3H+2LynSzxOpaCKYXaD0KqhTL8rl0W/QEM6NzQyns79w6D5Oq7
         r0Mg==
X-Gm-Message-State: AHPjjUiPr6t0CjEJ3hnNCaYsDqysuptIGWdQyJPvQLJHEhoF+OqTPgvO
        tyUPWsNg2jzhBxi+uoCKJt6LJ4m1
X-Google-Smtp-Source: AOwi7QCmT5IhSh2EmEVpt5n5HDIjmaxuiN99oAGeROuX8K4FO5kZFROqVj9644ybEyIQ7sCFd6RFFw==
X-Received: by 10.200.17.20 with SMTP id c20mr8487649qtj.321.1505924980789;
        Wed, 20 Sep 2017 09:29:40 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d186sm1553615qkg.46.2017.09.20.09.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 09:29:39 -0700 (PDT)
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-5-benpeart@microsoft.com>
 <xmqq377hopma.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <53d05ca7-381b-255c-1362-ca1888d626fe@gmail.com>
Date:   Wed, 20 Sep 2017 12:29:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq377hopma.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 2:23 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> @@ -344,6 +346,7 @@ struct index_state {
>>   	struct hashmap dir_hash;
>>   	unsigned char sha1[20];
>>   	struct untracked_cache *untracked;
>> +	uint64_t fsmonitor_last_update;
> 
> This field being zero has more significance than just "we haven't
> got any update yet", right?  The way I am reading the code is that
> setting it 0 is a way to signal that fsmon has been inactivated.  It
> also made me wonder if add_fsmonitor() that silently returns without
> doing anything when this field is already non-zero is a bug (in
> other words, I couldn't tell what the right answer would be to a
> question "shouldn't the caller be avoiding duplicate calls?").
> 

Correct again.  For better (and sometimes for worse) I followed the 
pattern set by the untracked cache.  If you compare them, you will 
notice striking similarities. :)

>> diff --git a/fsmonitor.c b/fsmonitor.c
>> new file mode 100644
>> index 0000000000..b8b2d88fe1
>> --- /dev/null
>> +++ b/fsmonitor.c
>> ...
> 
> This part was a pleasant read.
> > Thanks.
> 

Thank you for your careful review.  I appreciate having another set of 
eyes taking a close look especially as I see this as a big first step 
towards making many git operations O(# changed files) instead of O(# 
size of working directory). Seeing status times drop from 1m22s to 1.45s 
is a huge perf win - but only if it is correct!
