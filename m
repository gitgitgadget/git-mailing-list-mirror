Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3031FBF70
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016906; cv=none; b=T66bD3u8c/Ace6JOZEFcNU9MtRP6itGSLSaFz+1+jfX/O3RSeOBqip3GGZ5d6j3eqwRO1uq9cU+fRJInQB+XLcH1nBOntQBG1PxsD63qydlmSuzg5fsh0lCidAxv6cOlLCc4b77jEExPUIljTJbMnGTE7NZn53C/3IiIWdb/56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016906; c=relaxed/simple;
	bh=mRpt8bCfIUUig6+bbymEl6qXD3zI9B/bRzrDLj5Wh+Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IvJlgrCkRPjzPMUlDzCtzdV76EEwvzPRH14+dO7/Z5T0gqcn36x9X8pH2+NBmey6WxpPaKSEVHqAGobvZDW0IfscEcvJ35EPnjkfKBlJaCzKpml3gE3FcpyNphkvpuPUveJMilCOivRUNcZ0BUpuW5Fm8jYbmt6DxYT7jCv4bBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZu5P8nS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZu5P8nS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431481433bdso5777385e9.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016903; x=1729621703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=430+WFZiHWPuXxjm+escTApMbCD0ja4Owv/s2LM89bw=;
        b=MZu5P8nSqCBp1ZSMQTPEJkp3qM1aV5BpO8uZrYQ7kHOd4W9/1+RA4drK44SvZgR9jK
         L53g8pOKaIeSQAPojB6ZJbxsy7QkysVYMrmfIR0YB0f9YxtW7pAd3RfklPOQUUFsD8jh
         Md91XsHs8GszhElUUJCeinpYhEWOm0wgk+RC1XVtITOwkfb3ILnbJQmihN7cJvbNCByH
         NIJSG4TBGaiBKb4P8NdMl8zQUGbD/O4zRtMOwrAjoIvdWi5pyvhsCltY0uYpFQhydEL+
         voqugDcLu9IgrTpAOT74bqVl/ZubmjYyG3/bdvzqekG2g2ToN1CeNhnrC6XJB7ABZ/LA
         YLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016903; x=1729621703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=430+WFZiHWPuXxjm+escTApMbCD0ja4Owv/s2LM89bw=;
        b=mbLmLDYul3ke1dVOvR//lTXE7gsWc2zAt0lyhqTa6zrfpLg/sc/GqpnoG5AfHhRxFE
         dV4HlpA0IeFNoXBfygwOrrDdf+Cnb2MQX4u5dRRvQobs4+58euKb7htXifXf5M2ux7WE
         TcgmhtdWIe8/sOkh2iIJrLtNl3XdGlg7a39+SYWIhgizuqSAKhbhrpYxZ8S583d5/Tm+
         +V5ivC3UhfxpQGNPjaUv7ZDCSok4o1TlgkUoKsLwDWmlrU2z+MnfbSsjFQYxIY3I47nE
         JEQXRRhAfLuaUdojsPAWne1NX7eL9GYRpx+V0euY5GMOaL2E2haAUToSKm6pRqhh7zY2
         KxtA==
X-Forwarded-Encrypted: i=1; AJvYcCX7+Xmbk+6hd0ZViJxKIFsFFPuBSmT0FTjJdu9WTS1HinXahQwBo/YFfCSX+ho+PZqdR10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvJ1kr5OVYKqq/oI7xejaw9Ge7KR7XDJTKNnr4N6SWzoTNrXa
	S+oJ2jOz371TH/zr7m4hvY/oUajd/d6rj4JQ+40BnUVXwbADpobv
X-Google-Smtp-Source: AGHT+IEAYGZxfbfN3Ekk7oxeOwHcL4ef6xcCxXvfGymEhLQETCJ1vhsfEXmafeA05H5b3vS1VPdOpw==
X-Received: by 2002:a05:600c:3581:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4311decab1fmr143100455e9.11.1729016902954;
        Tue, 15 Oct 2024 11:28:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b3224sm25211055e9.32.2024.10.15.11.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 11:28:22 -0700 (PDT)
Message-ID: <9952b3a7-0ebc-4555-b8b3-f50f6f383704@gmail.com>
Date: Tue, 15 Oct 2024 19:28:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
 <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Usman

On 15/10/2024 16:17, Usman Akinyemi wrote:
> On Mon, Oct 14, 2024 at 6:36 PM <phillip.wood123@gmail.com> wrote:
>>
>> On 14/10/2024 17:26, Usman Akinyemi wrote:
>>> On Mon, Oct 14, 2024 at 4:13 PM Usman Akinyemi
>>>> On Mon, Oct 14, 2024 at 2:55 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> I got this from a leftoverbit which the main issue was reported as
>>>> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
>>>> For the test, I should have the test as another patch right ?
>>
>> In general you should add tests in the same commit as the code changes
>> that they test. In this instance I think you want to split this patch
>> into three, one patch for git-daemon, one for imap-send and one for the
>> merge marker config changes. Each patch should have a commit message
>> explaining the changes and whether they change the behavior of the code
>> (for example rejecting non-numbers) and add some tests. Note that I
>> don't think it is possible to test the imap-send changes but the other
>> two should be easy enough. The tests should be added to one of the
>> existing test files that are testing the code being changed.
>>
> Hello, thanks for this, I was working on this and I need help. For the
> merge-ll.c,
> I noticed that the check->items[0].value were already checked to
> ensure they do not contain letters in them.
>          if (check->items[1].value) {
>                  marker_size = atoi(check->items[1].value);
>                  if (strtol_i(check->items[1].value, 10, &marker_size))
>                          die("invalid marker-size expecting an integer");
>                  if (marker_size <= 0)
>                          marker_size = DEFAULT_CONFLICT_MARKER_SIZE
> 
> error: option `marker-size' expects a numerical value
> not ok 38 - merge without conflict wrong marker-size
> #
> # cp new1.txt test.txt &&
> # test_must_fail git merge-file -p --marker-size=1a test.txt orig.txt
> new2.txt 2>error &&
> # cat error &&
> #     grep "invalid" error

It would be better to check for the error message with test_cmp or at 
least grep for a longer phrase so we're sure the error message is the 
one we think we should be getting.

> #
> I grepped the error message and I noticed that the message is gotten
> from parse-options.c and it ensures that the arg is negative. How to
> proceed in such a case ?

The code you're changing parses the conflict-marker-size attribute so 
you need to set up a .gitattributes file with an invalid marker size and 
then run "git merge" or "git cherry-pick"

Best Wishes

Phillip

> Also, for the daemon.c I am finding
> it hard to get the exact test file to add the new test.
> 
> Thank you.
> Usman Akinyemi
> 
> 
>>>> Thanks.
>>> Also, do I need to add the reference which mentions the leftoverbit in
>>> the commit message?
>>
>> I'm not sure that's necessary so long as you explain the reason for the
>> changes in the commit message.
>>
>>
>> Best Wishes
>>
>> Phillip
>>
>>

