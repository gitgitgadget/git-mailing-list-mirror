Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657318453C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914243; cv=none; b=TuwqVqr67Oa063eK8op0+6Xfi805A7egWhGglT2A8k2P4xClpG2JkN+Hq9Ci2eDsVrF1zFsNUlyLW5rtN+wx13U65P/LmlW0DObUdoWUhxdNdAb2uzxkBPsnNwsjG5ByvkVZID1ERe3loSflaSxJHAIwUD5mpgIPaaMLhWHx9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914243; c=relaxed/simple;
	bh=Y7Np7lHvWTGZNZIbeoyvLIiFEcYKCUz8ZgQvZm/9hz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrAUAt0mgk8qJT1hJLun9pflYy3sbg5q2kk5i0Heb7RV2sPa8mmdSLNsEO78ecL92TfWghx/rxfTAmS4lMMKAjC/JnMxLBMCwNaVHfLRmzLdGOqmrUyVPXrwbnK+yMOzw2jvF3m/CtnidTeN3D+YGd6rpfOzKu1mO05pHzrJK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IskQjv/d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IskQjv/d"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso27508165e9.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728914240; x=1729519040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pNEE9hfBXLgwnTrtI6FfwtB8v2lN7ha+hivzsRuiAGw=;
        b=IskQjv/duG6DVLwmPFBjIMzHqqf4JvxzHmdHs16b1gVbRyxXHhsucnqczEx9CXUSSi
         F5Riy1V0k67aCin/QI69IpgqCk6Sz3T7ZQnp7plJCUAyEVXKU/g3SW698R1ShjmXp8aH
         p38Ejdj0LnUKQ9GMyv448svjC4MPdwTkScu6IG7hyjxnW6gs3TRL74WA6dRFkJuG9Vy5
         zNQ/Y7O+JJ8YeBCPFhzu4+fGwsxhjurU18HiHDb+x4E/K0eZ4P7ofVJx876Zl/BsvCY8
         RzQorsj7iWz/noEpl8kCRn/cAj6U/gajY4eFlP9lQkw/r75FPfaMBJDhVhpNExwFPFxJ
         SV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914240; x=1729519040;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNEE9hfBXLgwnTrtI6FfwtB8v2lN7ha+hivzsRuiAGw=;
        b=FXH1eRLgdI+c6rrMoMb9Id4c/sjEKKgOIOuI6ry3MBROhMKN6qV8w096A7APkIjDM3
         GGuX4D++rlyoKIGUWutNMM5xx8IeML0Kd4n/XsqIRCI9suY2sw3kCl30lq3G82RN0SpZ
         qKky4l6gL4l7JhDKRFmgNs4v2fzpjH+iMmuQfmR5pbd3PgB24ZhvDyDmW5+Tyc5R49+W
         qQk/5MasEH2tsnwxKiXU7qSUV2V0VDVXiRaKh/bH3SeCKrSoTFiFkDO2jG4BYHpU7a19
         fhivHGVroXolkp1zNsfGYj8O+Qcy9ywtE/te1bzATROd+fzY9SuTmMpMyYGreec87iHA
         ho3w==
X-Forwarded-Encrypted: i=1; AJvYcCWmiFO2ZTGmLLfdahsK8QGvly1okUyPNCAJTNvXTvkmw7PibxARgJrUmhiEBwE63GhU3KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDHgER/k8xAuT5ozA5TTezgz4pCDJJQECQHiAosbMW03Lzabn
	i0zS2WiA05Rod6u9aDqRw9Pp+hUFmMr3gcEnKVVztYjJgieJkPLxcvDnuw==
X-Google-Smtp-Source: AGHT+IGIjKkRatQlkylVuq9zSNI+TRLlHU/oM95q6ckxRDunCm18ASSJadWgMgMrCJPB7m7D0gOxvA==
X-Received: by 2002:a05:600c:4e4f:b0:42c:ba0d:c766 with SMTP id 5b1f17b1804b1-431255d4dd5mr73822125e9.6.1728914239453;
        Mon, 14 Oct 2024 06:57:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf49910sm154301735e9.20.2024.10.14.06.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:57:18 -0700 (PDT)
Message-ID: <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
Date: Mon, 14 Oct 2024 14:57:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zwz4B4osJnYJw6pd@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/10/2024 11:53, Patrick Steinhardt wrote:
> On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
>> On Sat, Oct 12, 2024 at 11:09 PM Usman Akinyemi via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>>
>>> Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
>>> and strtol_i() for signed integers across multiple files. This change
>>> improves error handling and prevents potential integer overflow issues.
>>>
>>> The following files were updated:
>>> - daemon.c: Update parsing of --timeout, --init-timeout, and
>>>    --max-connections
>>> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
>>>    tags
>>> - merge-ll.c: Enhance parsing of marker size in ll_merge and
>>>    ll_merge_marker_size
> 
> To me it's always an indicator that something should be split up across
> multiple commits once you have a bulleted list of changes in your commit
> message.

Agreed, but I think in this case there is a common theme (converting 
atoi() to a safer alternative) and the problem is with the commit 
message listing which files have changed rather than unrelated code 
changes being grouped together. This patch could be split up and if 
there were many more atoi() conversions it would need to be split to 
prevent it being too long but I don't think its essential to do so.

Best Wishes

Phillip

>>> This change allows for better error detection when parsing integer
>>> values from command-line arguments and IMAP responses, making the code
>>> more robust and secure.
>>>
>>> This is a #leftoverbit discussed here:
>>>   https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
>>>
>>> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>>
>>> Cc: gitster@pobox.com
>>> Cc: Patrick Steinhardt <ps@pks.im>
>>> Cc: phillip.wood123@gmail.com
>>> Cc: Christian Couder <christian.couder@gmail.com>
>>> Cc: Eric Sunshine <sunshine@sunshineco.com>
>>> Cc: Taylor Blau <me@ttaylorr.com>
> 
> The Cc annotations shouldn't be part of the commit message. If you want
> to Cc specific folks you should rather do it e.g. on the command line or
> whatever you use to send out the patches. Otherwise, these will all end
> up in our history.
> 
>>> ---
>>>   daemon.c    | 14 +++++++++-----
>>>   imap-send.c | 13 ++++++++-----
>>>   merge-ll.c  |  6 ++----
>>>   3 files changed, 19 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/daemon.c b/daemon.c
>>> index cb946e3c95f..3fdb6e83c40 100644
>>> --- a/daemon.c
>>> +++ b/daemon.c
>>> @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
>>>                          continue;
>>>                  }
>>>                  if (skip_prefix(arg, "--timeout=", &v)) {
>>> -                       timeout = atoi(v);
>>> +                       if (strtoul_ui(v, 10, &timeout) < 0) {
>>> +                               die("'%s': not a valid integer for --timeout", v);
>>> +                       }
>>>                          continue;
>>>                  }
> 
> We don't use braces around single-line statements. It would also help to
> explain whether this is fixing a bug and, if it does, then it would be
> nice to have a testcase that demonstrates the behaviour. The same is
> true for the other sites that you convert.
> 
> [snip]
>> I also want to ask if this is the right way to send another patch as I
>> noticed that it is showing my previous patch which is not related to
>> this. Thank you.
> 
> You shouldn't ever include patches from another patch series. I guess
> tha problem here is that you created all of your work on the same
> branch. I'd recommend to use separate feature branches for every series
> you are working on. In general, these branches should start from the
> current "main" branch.
> 
> Patrick
> 

