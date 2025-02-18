Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD159145B25
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872909; cv=none; b=aV/Rp2E66vLZgArrsGnb4bd0cb/CMuD+KWBZ2EHenCd7bBOsTtLbbipFMh38uFR6AZx142R9hfeDCGJZubR+KT6kq0oOuw7oX7B/xikgDmMC0wZPSYFxy1xWF8jnZrGByLA9g1Ut0d1PiGKHtkIhsDUNaEF6ED8EaxEKCfOlbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872909; c=relaxed/simple;
	bh=tW3Qb4Kj+oky9je++JLq2f7XlQHjmB9e0GU3aNTmc9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dfsf5a4hZZ3srrjShVkIk5AfnaOgnFvz8uOalkdJE4d2dDeBl7KcRGvv1wL/7X5hRECX6icHLV65Bg0le7aFJwvUFKyvZ1ftIZDV6JloaPl2ilonA1JJMohEpTf4duh149DYQF2FV03/LxpS9QscW04+ZeyjXOeAL5sNypX77nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu6sTdt8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu6sTdt8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so3012480f8f.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 02:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872906; x=1740477706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5dy9omecOl4vvub8ySvHsNq6ZysN51JbJ7d1a1cFOk=;
        b=Hu6sTdt8bAADEl8TDHPkPaM2tYfQ65YHPnHenfJtrocuOix25PpF3BWewFQpeVJ2jH
         IHpt8/7xIdeqm1VB6Z0M6mTRgDWxfh2Kwx/atnmDdfEVG9SOhlhlr5QmXc9wo3OUjSYD
         JbOF19UMcjb9fmJ+5IFREc5iRCr1t13hSGXjMOBrLt0foYl0Q2ENn0a8jf1rHsWhHVSV
         QGTDRi+/aHcMNIuAwRmPFmQkgfftJlMdfDQchnRO3MXH/lWUvT9VdHMbDdUNH4AmVgLa
         lFygJkTo2u7kPiTc8ikVzeUdGT/SH37UIgs0S5EOH9ZSIWZeUoNtm2SyIbhUZOLGcj97
         cE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872906; x=1740477706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5dy9omecOl4vvub8ySvHsNq6ZysN51JbJ7d1a1cFOk=;
        b=XX7WeiRJxsa9163gKhvYFCD44cOUTUyLgYW54gKBvltWuDOYcOzw+gg01igJRk9cNX
         eBP1zma3BPL+81cyIySG2zb5qfe29NstkLp1qnP881LDooAHwEr6Drqd95eaX+E3sz7/
         w+7x5etPvXXPgINgOEZbQEE2I824HQzNr4Jpj/TxaSDeKeSnHlqK5eODNyvzlhpBxijz
         1RCqG+9hWdJGc5xGV5roFeQUDqpKFbX3TwPbjOJZDOyjK99VxYl67qKH9o56guwTP4YJ
         CBU5KeaDzJax9AwepgiYfTxtHtLiwoLPOY/p69dQogXd6lYxuUeqW7RcryAKcvCtuEd/
         iolw==
X-Gm-Message-State: AOJu0YwR6aItMRKv8sU7ZEX9QC5eiktN1sM6Xfk/6H4E4f4BwkjByLTV
	Fb/RobWCTlWd5ccfqXgY+DodOAMSPjQBl/RJv7/lqKakqHgKPuiD
X-Gm-Gg: ASbGnct6BTk10GwreUX+g1eZBUaCPj/gPSZnvvluHd4sn4JicYqgTBnazb4OSKAU50C
	yeIE422w5SzHZnN87kVJx1Xwik8zI6GnlZ1eiEOHCKL7qXqQHkbj+ZOLVW8hDHoWn0peNW0AKdt
	xD8h9D3AbmhARpMe7LvtEuO4v/eXaP1i8x3yKhu6pNvijSLVy7wWpAlH0DDyvnENsM770WgychD
	rq//+TeQdhmXGm+2Pq6s6F6xf+os8lWtHKPTdF20Z+28HOL23GKY50+ldEyOqmTWgL8jlywSTmG
	5U1ePZ4dTM7jL6FJnFAZZXhD7dbSKUmEh/NRj1tYYRcum7wD4H+BsVPJ8MEsnYvQCzJTtA==
X-Google-Smtp-Source: AGHT+IE04b9i9Da1uTTvFddxXdf8vzN3nbeHqrboIHrIixmTpZpBHPqjY7zKDKL9+zg/Fdsd6pQlsg==
X-Received: by 2002:a5d:6c63:0:b0:38f:4a0b:e764 with SMTP id ffacd0b85a97d-38f4a0bea35mr5566410f8f.28.1739872905535;
        Tue, 18 Feb 2025 02:01:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm14929519f8f.18.2025.02.18.02.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:01:45 -0800 (PST)
Message-ID: <06582f75-c14c-482f-a9d8-b2c2e77ce2c8@gmail.com>
Date: Tue, 18 Feb 2025 10:01:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] merge-tree: remove redundant code
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <16fec87766f97d46a337f5c514f1aec0668546ec.1739723830.git.gitgitgadget@gmail.com>
 <CABPp-BGTSciJMRWBGe9qOFh5wGuLppB6L+v9J5-KVdbNc6H3Hw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BGTSciJMRWBGe9qOFh5wGuLppB6L+v9J5-KVdbNc6H3Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 17/02/2025 20:15, Elijah Newren wrote:
> On Sun, Feb 16, 2025 at 8:37 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> real_merge() only ever returns "0" or "1" as it dies if the merge status
>> is less than zero. Therefore the check for "result < 0" is redundant and
>> the result variable is not needed.
> 
> Indeed, the only return statement in real_merge(), occurring on the
> last line of the function, is even:
>      return !result.clean; /* result.clean < 0 handled above */
> 
> However, it might be worth adding to the commit message some comments
> about o->use_stdin here.  When o->use_stdin is true, that the program
> exit status is 0 for both successful merges and conflicts but the
> conflict status for each individual commit is printed as part of the
> output.  As such, the return status isn't used in those cases and
> real_merge() might as well be a void function.  However, when
> o->use_stdin is false, the exit status from real_merge is used, which
> is why that callsite (not visibile in this patch since it is
> unmodified) still pays attention to real_merge()'s return status.

That's a good suggestion - I'll re-roll

Thanks

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/merge-tree.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>> index 57f4340faba..3c73482f2b0 100644
>> --- a/builtin/merge-tree.c
>> +++ b/builtin/merge-tree.c
>> @@ -601,7 +601,6 @@ int cmd_merge_tree(int argc,
>>                  line_termination = '\0';
>>                  while (strbuf_getline_lf(&buf, stdin) != EOF) {
>>                          struct strbuf **split;
>> -                       int result;
>>                          const char *input_merge_base = NULL;
>>
>>                          split = strbuf_split(&buf, ' ');
>> @@ -618,16 +617,14 @@ int cmd_merge_tree(int argc,
>>                          if (input_merge_base && split[2] && split[3] && !split[4]) {
>>                                  strbuf_rtrim(split[2]);
>>                                  strbuf_rtrim(split[3]);
>> -                               result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
>> +                               real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
>>                          } else if (!input_merge_base && !split[2]) {
>> -                               result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
>> +                               real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
>>                          } else {
>>                                  die(_("malformed input line: '%s'."), buf.buf);
>>                          }
>>                          maybe_flush_or_die(stdout, "stdout");
>>
>> -                       if (result < 0)
>> -                               die(_("merging cannot continue; got unclean result of %d"), result);
>>                          strbuf_list_free(split);
>>                  }
>>                  strbuf_release(&buf);
>> --
>> gitgitgadget
> 
> Looks good.
> 

