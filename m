Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5131BCB8
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369422; cv=none; b=oO9aJ1QVgcKgPFpUS5G1tBy1j2xygzafXTM3ZshZatxUhnuXz2E9+HPN/p5Urt0Oroumz3ID/2Jb2uMHqFzFwB7/pg4HZ/CsRpKG5wwnTB8wX6wl95WQmbcLZt2evSxjpcKI31Qe9tnFUZ/1douYkvTM6WGM1e7uD8pZNN/CB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369422; c=relaxed/simple;
	bh=2NbGmsKy6DvBKDyk34VK0Pc70TVS1wQLOBFuYYYs9c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJL80jLQ2AA/usR6O/5wKS5rHBUjxFD8WLwulNQThdCFkF4iF5CLII73eR5n1EG9urd60VfvlBbgsVyljLeJaCkzzOAb9LZlxo8Luv5nWv0KlxK9Ks+vobjQspE2lIkyIC0iId9ZsAtj72DAo0/xfYUKr+fK/qKCny6poI7M6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgbV4gvh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgbV4gvh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ba599137cf7so134961a12.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369420; x=1762974220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozIA9mxgqZRRCTICLo91JgtoLU7V0JT8xRj6Fp6Pnzo=;
        b=GgbV4gvh6FAGGVEKgAdn71uU59mPKDUiMqsr7xw1CwthnJ9u2hLN85fYOjZJLXhLBX
         p4K7l704lZ8Ogvm3cpDbayInxKeG+MMfBFkfH8AmFqjVj6+TtKFA/ggSP00ktPRMlRHs
         oK3aYMKYllAJhXjpvWzEw7IQyTa2GrVt9YbM3a5WTgc1YB913yqxnE8dZKDQZOsvbRgA
         qBGNE0wwuBUOJ25ZEbx8UPn4fj5zf2gsS3U9H/tCf0IH4WWdJa7IGSzoTLWYL9k5MvBE
         FiXz5RiJG15rD1O0j2qWTPxZuP3Im/if2JdJp0l0AzXFqcRzLYVX4EKdReFHONTPwsol
         9TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369420; x=1762974220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozIA9mxgqZRRCTICLo91JgtoLU7V0JT8xRj6Fp6Pnzo=;
        b=a8s/nfv8+fCGrSXRjNxSgoceK+3+DVXlB5yVm+Uf6fNWnXq/3uYBfdqGxSjX/i9zMV
         yU2MIwj7ukq26/05g+lnci6JQdPbD3FJKrofB4ZtvCBqxmxGMwrWCe6qmwFGfrnH0+G+
         AZvP4TFA5ywZA//xlJS0wWF15a1X8D/QwzFekM/NXFDqSvAz8HW3v2Y3qoxahp+0H5qq
         QwFZXIxXd+MvTVcCey6BLpfHqZAIZ17Xz7bqoKP9GWWV2c8G8E11DbBlZ0CIw4TCYRoB
         YNWNM6MtazfNVqBaiWxZZ7VG/kMjEvcvIVEpE7AsgDPnR+S4F4d3lrQbdkxaphCnNPME
         gQ0A==
X-Gm-Message-State: AOJu0YzTliGqHJb/cX4o3RVP/6PgA4pFRSaMMnvdnGnDRoFnsalvcIZ4
	7ovSzZlwDcUWaoxkEgxq+jLg7SjITExQG5i+aMzGuTUtmviOJ0I0t+5n
X-Gm-Gg: ASbGnctIK3RhtmNtnOPsYmMyDE2H4bO2Ji11fBXiAwE22LxBQS3yvG54oPJTN5Mv2Le
	UHp0O/JeYcwLtVe3KOvHwjMnkYaasDu1LGir4fD7vPRMKUu+N+5DoG7pX8kNIsgA5imnq/MGawX
	PfRPQ2i23oD+BA85lX0z6HXDRwexwue/4Slkpooxr3kzI5vSwrF+BayD3I3Kx3a+Np58FiKVubF
	s90tHCSjzH1B/0YtRJCAfqIHvw6ralATLvY5sAkuLIUd4yFbltmkhrEVV3xR25L2okEAb1PLXai
	4yA9LJOXGKCHiE2dzE5/hFDOj5BMAi+449Xgf+tMt7vnEfJu2eiq1yZfiTXBnCbRL/4bOeZ6Gnf
	jhvV2Zy61GI4FyQGVg/D8y621NB/uSRom5lCnoGaTxRUCGZIBu0DQ2vxPYRGp26EXCSfDpnVIrd
	vuW61rYyzaim+MejNBr+GARNlLRm6xJvBrL77cfb1+Ik340AbD/wkrkuBGRQLnnjNFMBt8p1Cnr
	xHgXEtbee4DAzmwp3szLd4WVyhbYa/GftArKrU6l8x2nhq5kqmwTSM2wZ0AKjEx6XDW7X/OD5iL
X-Google-Smtp-Source: AGHT+IEtsUNnGS+0eC9trgVbB6QHfInsoPtg1WRNXs37cLTnXZDpz+tUvatqA9z1ijJo8zIUdnrL5g==
X-Received: by 2002:a05:6a21:9981:b0:342:2a1b:86fa with SMTP id adf61e73a8af0-34f85d10f42mr5437400637.45.1762369420437;
        Wed, 05 Nov 2025 11:03:40 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5? ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce9645sm83650a12.10.2025.11.05.11.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:03:39 -0800 (PST)
Message-ID: <33578d71-2145-4256-8c90-0039ecf8fdb9@gmail.com>
Date: Thu, 6 Nov 2025 00:33:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, gitster@pobox.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-4-siddharthasthana31@gmail.com>
 <CAP8UFD2xJVtQMEFBQAZJP+kYq5iYCcQYn9WD_x+SO8grauPrZg@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD2xJVtQMEFBQAZJP+kYq5iYCcQYn9WD_x+SO8grauPrZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 31/10/25 12:38, Christian Couder wrote:
> On Thu, Oct 30, 2025 at 8:20 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
>> +static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
>> +{
>> +       if (!ref_action || !strcmp(ref_action, "update"))
>> +               return REF_ACTION_UPDATE;
>> +       if (!strcmp(ref_action, "print"))
>> +               return REF_ACTION_PRINT;
>> +       die(_("invalid %s value: '%s'"), source, ref_action);
>> +}
>> +
>> +static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)


Hi Christian,


> I think it could be "ref_action" (instead of "ref_action_str" ) in
> this function too.


Good catch. Will make this consistent in v7.


>> +{
>> +       const char *config_value = NULL;
>> +
>> +       /* Command line option takes precedence */
>> +       if (ref_action_str)
>> +               return parse_ref_action_mode(ref_action_str, "--ref-action");
>> +
>> +       /* Check config value */
>> +       if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
>> +               return parse_ref_action_mode(config_value, "replay.refAction");
>> +
>> +       /* Default to update mode */
>> +       return REF_ACTION_UPDATE;
>> +}
>> +
>>   static int handle_ref_update(enum ref_action_mode mode,
>>                               struct ref_transaction *transaction,
>>                               const char *refname,
>> @@ -367,17 +393,8 @@ int cmd_replay(int argc,
>>          die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>                                    contained, "--contained");
>>
>> -       /* Default to update mode if not specified */
>> -       if (!ref_action_str)
>> -               ref_action_str = "update";
>> -
>> -       /* Parse ref action mode */
>> -       if (!strcmp(ref_action_str, "update"))
>> -               ref_action = REF_ACTION_UPDATE;
>> -       else if (!strcmp(ref_action_str, "print"))
>> -               ref_action = REF_ACTION_PRINT;
>> -       else
>> -               die(_("unknown --ref-action mode '%s'"), ref_action_str);
> Maybe parse_ref_action_mode() could have been introduced in the
> previous commit already?


You're right—since parse_ref_action_mode() is actually used for 
validation in commit 2, it makes more sense to introduce it there rather 
than wait until commit 3. Will move it to the earlier commit.


>
>> +       /* Parse ref action mode from command line or config */
>> +       ref_action = get_ref_action_mode(repo, ref_action_str);
> Here it could be:
>
>        ref_mode = get_ref_action_mode(repo, ref_action);
>
> Thanks!


Agreed. The variable naming was inconsistent—I had both `ref_action`
(for the string) and `ref_action` (for the enum) which was confusing.
Will use `ref_action` for the string parameter and `ref_mode` for the
enum variable throughout for clarity.

Thanks for the careful review!

