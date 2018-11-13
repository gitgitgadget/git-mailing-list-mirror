Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA9E1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbeKNBNE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:13:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34617 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbeKNBNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:13:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so19952646qkg.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KSxCMFRBQmZu8SNvU0RxMrf1Y23XQkD8dv0NMip1/Hw=;
        b=rZ8w20SoJGuxBy1ycc6SoZkvGu6gn7nii4RDnWz4vkvfsqtqsf2+dpJTsPVjeyIZLw
         NP/v0Zm7DULy7OMqCLqym/0lDkYGc1CZBbfN6IdO+qmBDSSXrE/ZEWtK2KrRE5hDDTd8
         QI1wXqEQfl0acJB9+fVxeRRT6GvGVJyN7Qx22jPMymdaCypD6uCNXhwg67aZJKKOU2qP
         4U8wtYMkBrHqgMdLUKU0pB1gizplY8hAfH/kAZHqSbEI5bT1LGnKz3mkNGF4Q58u3gff
         PMLKfKiyI48KhyiIx+qjpHxjTg/hxvfyhphkjBgggSZJl4EG0sBXgu0oNoCJDfkaP8kf
         VlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSxCMFRBQmZu8SNvU0RxMrf1Y23XQkD8dv0NMip1/Hw=;
        b=c+cLY9FoyWtaz9r1QRlf7KYmfHpnwh1q+AyGEZZ416yTadH+uzq/Q796XH8DY2RYmk
         4lFLU6B5KRwUCxh7LnlyI9GWELVgAmRO8GifaJs2nBK691L7wC5H8NVJOGGgpftybiGy
         Cep9FQteFg3K720Psvfy6gKarZB1MK93su3nY40rP6ZcDuImmo3Qwhtqzk0jeHz82/Hl
         /vm2v9jH3C4uzgYdrUTgfJquea2fci/TAajvMQKI6l/3OPazfsup+MZRtJB7Y9aEs1DI
         0sDm0H5XpcY0OHkG9scyVflFlcWdjZ6hSlaMrOxxdnr1KdCTgOxnY3ZOMxjLE+kk1YqX
         9Edg==
X-Gm-Message-State: AGRZ1gKSkzQbBhkMBUPgnI8z2P4WDVGFhWwDERuq4nWOCAI26WuggEhc
        p+tjwOQXq0f5jSuPxZZ0JQY=
X-Google-Smtp-Source: AJdET5enw98ElWIrhNsmdKwLNdiTDo6Vq0mSkGw1UltTGvuCkCMRWEevYTLrILJKYBoCQZENrqcmNA==
X-Received: by 2002:a0c:d0a8:: with SMTP id z37mr5765018qvg.86.1542122068191;
        Tue, 13 Nov 2018 07:14:28 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h187sm10151894qke.46.2018.11.13.07.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:14:27 -0800 (PST)
Subject: Re: [PATCH 1/3] eoie: default to not writing EOIE section
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003911.GB170017@google.com>
 <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5fae19dc-2e77-1211-0086-e7aa9d30562f@gmail.com>
Date:   Tue, 13 Nov 2018 10:14:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/2018 8:05 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Since 3b1d9e04 (eoie: add End of Index Entry (EOIE) extension,
>> 2018-10-10) Git defaults to writing the new EOIE section when writing
>> out an index file.  Usually that is a good thing because it improves
>> threaded performance, but when a Git repository is shared with older
>> versions of Git, it produces a confusing warning:
>>
>>    $ git status
>>    ignoring EOIE extension
>>    HEAD detached at 371ed0defa
>>    nothing to commit, working tree clean
>>
>> Let's introduce the new index extension more gently.  First we'll roll
>> out the new version of Git that understands it, and then once
>> sufficiently many users are using such a version, we can flip the
>> default to writing it by default.
>>
>> Introduce a '[index] recordEndOfIndexEntries' configuration variable
>> to allow interested users to benefit from this index extension early.
> 
> Thanks.  I am in principle OK with this approach.  In fact, I
> suspect that the default may want to be dynamically determined, and
> we give this knob to let the users further force their preference.
> When no extension that benefits from multi-threading is written, the
> default can stay "no" in future versions of Git, for example.
> 

While I can understand the user confusion the warning about ignoring an 
extension could cause I guess I'm a little surprised that people would 
see it that often.  To see the warning means they are running a new 
version of git in the same repo as they are running an old version of 
git.  I just haven't ever experienced that (I only ever have one copy of 
git installed) so am surprised it comes up often enough to warrant this 
change.

That said, if it _is_ that much of an issue, this patch makes sense and 
provides a way to more gracefully transition into this feature.  Even if 
we had some logic to dynamically determine whether to write it or not, 
we'd still want to avoid confusing users when it did get written out.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 41a9ff2b6a..d702379db4 100644
> 
> The timing is a bit unfortunate for any topic to touch this file,
> and contrib/cocci would not help us in this case X-<.
> 
>> diff --git a/read-cache.c b/read-cache.c
>> index f3a848d61c..4bfe93c4c2 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2698,6 +2698,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>>   		rollback_lock_file(lockfile);
>>   }
>>   
>> +static int record_eoie(void)
>> +{
>> +	int val;
>> +
>> +	if (!git_config_get_bool("index.recordendofindexentries", &val))
>> +		return val;
>> +	return 0;
>> +}
> 
> Unconditionally defaulting to no in this round is perfectly fine.
> Let's make a mental note that this is the place to decide dynamic
> default in the future when we want to.  It would probably have to
> ask around various "extension writing" helpers if they want to have
> a say in the outcome (e.g. if there are very many cache entries in
> the istate, the entry offset table may want to be written and
> otherwise not).
> 
>> @@ -2945,7 +2954,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>   	 * read.  Write it out regardless of the strip_extensions parameter as we need it
>>   	 * when loading the shared index.
>>   	 */
>> -	if (offset) {
>> +	if (offset && record_eoie()) {
>>   		struct strbuf sb = STRBUF_INIT;
>>   
>>   		write_eoie_extension(&sb, &eoie_c, offset);
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index 2ac47aa0e4..0cbac64e28 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -25,14 +25,17 @@ test_expect_success 'enable split index' '
>>   	git update-index --split-index &&
>>   	test-tool dump-split-index .git/index >actual &&
>>   	indexversion=$(test-tool index-version <.git/index) &&
>> +
>> +	# NEEDSWORK: Stop hard-coding checksums.
> 
> Also let's stop hard-coding the assumption that the new knob is off
> by default.  Ideally, you'd want to test both cases, right?
> 
> Perhaps you'd call "git update-index --split-index" we see in the
> precontext twice, with "-c VAR=false" and "-c VAR=true", to prepare
> "actual.without-eoie" and "actual.with-eoie", or something like
> that?
> 
> Thanks.
> 
>>   	if test "$indexversion" = "4"
>>   	then
>> -		own=3527df833c6c100d3d1d921a9a782d62a8be4b58
>> -		base=746f7ab2ed44fb839efdfbffcf399d0b113fb4cb
>> +		own=432ef4b63f32193984f339431fd50ca796493569
>> +		base=508851a7f0dfa8691e9f69c7f055865389012491
>>   	else
>> -		own=5e9b60117ece18da410ddecc8b8d43766a0e4204
>> -		base=4370042739b31cd17a5c5cd6043a77c9a00df113
>> +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
>> +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
>>   	fi &&
>> +
>>   	cat >expect <<-EOF &&
>>   	own $own
>>   	base $base
