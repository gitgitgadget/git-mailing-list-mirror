Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34CE20A21
	for <e@80x24.org>; Mon, 18 Sep 2017 11:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbdIRLh3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 07:37:29 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:53786 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbdIRLgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 07:36:14 -0400
Received: by mail-qk0-f178.google.com with SMTP id t184so171942qke.10
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIjuvuVMaueC/Z7HE1OvL7u3ZhJcQa8tGqULVCX3JU4=;
        b=e7Igda8x5yzDLDzVUSQl5rpPll0Th0MLr/BriwewiP3hSNVGipv8D9Hl17ekP8W790
         USH0u+YQ10sgOML+1fj62+EJ9witGddzgH7ZYBdB+CpcqR1c+cCx2gC/qEwhTKKa33Ni
         2/v06xkA7OQlSB2B0O2sI+Dx7TW1nfLbDuGes1GFwK+f6oWpEIo0uym8pizM5+9Zcpie
         OIoHAQ28JbInTC8ArhSHicRAr+6HoBsT1PS7bCwueGnDFrD6OmXjCuxOYPj13Oli5AJJ
         922DAVOsWS4TAUtU08ct3G8GF9iVu485uVXewjL0KlS983dEC9McgHRinl3tZCwbP85c
         WBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIjuvuVMaueC/Z7HE1OvL7u3ZhJcQa8tGqULVCX3JU4=;
        b=IYD1v704QOTguwo0iGUdEG8Ke9YAryhCdysFUvthSGXJ9+CkxWi+d2oEor0jXNmiO5
         lq7A78MpeCn+eIiPIPasGD+pZBUO/V/cChPDSeADUcys8lBWslfqlO/sy3Zs+ipmU6FC
         uZwmLgKJ6nnZ6fdOWMePcKMZ4pIzCucTBjUapzA/8DqjFrw59GfFDfvIqHy1Abtu+Fcl
         kuAX1WoWvbQV6be7QX1duhu+iAMX27hdxmtyjtuM3BaoiKVqPyBy/ly1mX6QV1B1nUrJ
         XtZ31zUtLEyPuiCHdprjyrNPVCVuEYMOaQmjbilbWwc6ShCOhYIW1ebKlK3bo0i/qo8c
         UztA==
X-Gm-Message-State: AHPjjUhmdjt1ElwKrn2THS5Mn7AbklWcgLF9smbAuGacxviu+tn1IDV4
        /VOmumH+TzHm6g==
X-Google-Smtp-Source: AOwi7QC/kL4fweX/UgE+idS4Ap7oLgQ+1ICW2WZR797meIuoJTFS6Gtb4O8eGotwMrsVP7FB6Lwv1w==
X-Received: by 10.55.79.68 with SMTP id d65mr20077967qkb.110.1505734573397;
        Mon, 18 Sep 2017 04:36:13 -0700 (PDT)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id s44sm5003001qtc.92.2017.09.18.04.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 04:36:12 -0700 (PDT)
Subject: Re: [PATCH 1/3] sha1_name: Create perf test for find_unique_abbrev()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        git@jeffhostetler.com, kewillf@microsoft.com
References: <20170915165750.198201-1-dstolee@microsoft.com>
 <20170915165750.198201-2-dstolee@microsoft.com>
 <xmqqa81su8v9.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <960c73e2-6909-6894-a9ab-a191426aeda9@gmail.com>
Date:   Mon, 18 Sep 2017 04:36:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqa81su8v9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/2017 5:51 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
> 
>> +int cmd_main(int ac, const char **av)
>> +{
>> +	setup_git_directory();
> 
> As far as I recall, we do not (yet) allow declaration after
> statement in our codebase.  Move this down to make it after all
> decls.

Will fix.

>> +
>> +	unsigned int hash_delt = 0x13579BDF;
>> +	unsigned int hash_base = 0x01020304;
>> +	struct object_id oid;
>> +
>> +	int i, count = 0;
>> +	int n = sizeof(struct object_id) / sizeof(int);
> 
> It probably is technically OK to assume sizeof(int) always equals to
> sizeof(unsigned), but because you use 'n' _only_ to work with uint
> and never with int, it would make more sense to match.

Will fix. I also notice that "n" should be const.

> But I do not think we want this "clever" optimization that involves
> 'n' in the first place.
 >>> +	while (count++ < 100000) {
>> +		for (i = 0; i < n; i++)
>> +			((unsigned int*)oid.hash)[i] = hash_base;
> 
> Does it make sense to assume that uint is always 4-byte (so this
> code won't work if it is 8-byte on your platform) and doing this is
> faster than using platform-optimized memcpy()?

I'm not sure what you mean by using memcpy to improve this, because
it would require calling memcpy in the inner loop, such as

	for (i = 0; i < n; i++)
		memcpy(oid.hash + i * sizeof(unsigned), &hash_base,
		       sizeof(unsigned));

I'm probably misunderstanding your intended use of memcpy().

>> +		find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
>> +
>> +		hash_base += hash_delt;
>> +	}
> 
> I also wonder if this is measuring the right thing.  I am guessing
> that by making many queries for a unique abbreviation of "random"
> (well, it is deterministic, but my point is these queries are not
> based on the names of objects that exist in the repository) hashes,
> this test measures how much time it takes for us to decide that such
> a random hash does not exist.  In the real life use, we make the
> opposite query far more frequently: we have an object that we _know_
> exists in the repository and we try to find a sufficient length to
> disambiguate it from others, and I suspect that these two use
> different logic.  Don't you need to be measuring the time it takes
> to compute the shortest abbreviation of an object that exists
> instead?

First, this doesn't just measure the time it takes to determine non-
existence, because it finds the len required to disambiguate an
"incoming" hash from all known hashes. When testing, I put in a
simple printf to report the result abbreviation so I could see how
often it needed to be extended. In this sense, the test exposes the
while loop that is removed by PATCH 2/3.

Second, your criticism about extant hashes is valid, and one I
struggled to reconcile. I see two issues with testing known hashes:

1. By determining the hash exists, we have inspected the file that
    contains it (either a .idx or the loose-object directory). This
    has side-effects that warm up the file cache so the looped method
    is artificially faster to find matching objects. The effect is
    particularly significant on a repo with exactly one packfile.

2. If we iterate over the entire set of objects, this test takes
    O(N*t(N)) time, where t(N) is the average time to compute a
    minimum abbreviation. For large repos, this can take several
    minutes. Instead, even with the constant 100,000 test hashes, we
    have an O(t(N)) test. We could avoid the asymptotic growth by
    limiting the number of existing hashes we use, but how do we
    find a sufficiently uniform sample from them?

By looking at some other perf tests, I see that we can add a pre-
requisite action. I will investigate making another helper that
uniformly selects a set of hashes from the repo and writes them
to stdout in a random order. p0008-abbrev.sh will run the helper as
a prerequisite, saving the data to a file. test-abbrev will read
the hashes from stdin to test find_unique_abbrev. This should avoid
the side-effects I mentioned (test-abbrev will not warm up indexes)
while also testing abbreviation lengths for existing objects.

I'll get started on these changes and send a new patch with new perf
data in a couple days. Please let me know if there is a better way
to measure performance for this change.

Thanks,
-Stolee

