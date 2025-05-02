Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28B2DC77E
	for <git@vger.kernel.org>; Fri,  2 May 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198064; cv=none; b=UCaYcHIve905ZqXhdbvQOaUv968mdCyQOrjqmpHVkOGukUU0A4KxP34A2ZjTT9EIiowRomgP9gy/Sn90HHET6wMPorjYmIHv9idOjW+3ttgnd0rFOPbwkFW4ZbgQBOm+QevdsUGl7X1t6Ccx+p8r4WlFCkhtuhUZB/20V4rRfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198064; c=relaxed/simple;
	bh=gYaHMqy/7XBxFFzGDuy84y0nmwSpRGUqq+Ei7fCaoWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jcnikgwbfw40O5sqWUcvxPckrowwuwvYbvrlLVZsDtk50AiR8k2xG+zQTE3iGedMUkA3cc1QP1MiJvYrHFf5yLAnWqasiwspvN2/QtaUvJdI+minuiHEcCjUskpM07eyCwuNabP2g5/oQPS5dklCgjKIr6duWCH6/cY99u6wSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LORLycB6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LORLycB6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f94b7bd964so1695862b6e.1
        for <git@vger.kernel.org>; Fri, 02 May 2025 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746198062; x=1746802862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBwAGqJHHickrMbLMiIlBH6SScGl2NlYYs1K8bjwNWA=;
        b=LORLycB6BUe6XPr/E0C2sPop0yWSKUTsezX9DbGKYUhDExgS+QdTizSSHysJTdnFAk
         IyBIa1EV1il1nKE4OoHfBSK3xG02xBzFjm5uhYPn7Ff0+QVrK1624Ydxty0B4cSoMW0p
         I5vPLYCnIyWc9QZ75GwcmzuV8xQizlrzNTsKuG/beEeMtNDEx7OZv7kAYjp7VBUIhQIV
         zZmyEnW+UUGMvQFu4IZ56IkYD5gi4/cXJA6LzzDIenVOQ+Wljwwnk95xyCFG1JFVD4WW
         aDj26Cw2/hcUUJY0nQnINNScqP5yXrkrO9j9Hahnp7RNA7PnJJst7pw7jwBbfp+OgHIo
         A0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198062; x=1746802862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwAGqJHHickrMbLMiIlBH6SScGl2NlYYs1K8bjwNWA=;
        b=mZb/ZCn1TUWAxwYn5a2PLMsPAyYsWWde1QXUHrKGJY25/dV1fOLWJUCUsVcu5wLceB
         Om5o2Y+9+qlDB779nnTwpoGdg3AVD9nsTq8iuCDDBEnstCNP3Gb7rFp7SBE5JqeP99EU
         dUAZShuT7f/BC3Sn9FEXnpWaJkJLqODaJ2yVsVvom/52rgNvqqc2V/JM9uJDJZPLao9R
         oHaWVB+ryD1kbunVN+/4niDPLeHcTxx1HFXjkIgTlPJtQz+yKOVGArIr8umh3lOWM+KR
         ZVVMJ0iPGVTTjHU7BNq3uZKN8PwbbW2OOnpzwMgM8xY23FME6PhpFl08TobGlPDxeImM
         haPA==
X-Gm-Message-State: AOJu0Yz+r6ASt/4V1v/GJ6uqHthFG9+esmxMNDoiKq1d75RphncrOnqy
	RUYAsDUb5Qalo9voYpG31kMwYHsKu/+NuneYwWjcte7swdiUtVqq
X-Gm-Gg: ASbGnctTuCftnP0B+4/uWdUf0Q/RFVUQPmafMxoezpqxlnF3Aw37vjzRPd/rBZ0a84k
	/2CbazL+Tt42qRCjROxfpmF9kpIVUcb2D+sA0LTmVtQBZzF4kAcdHZzsmsirxbY03wJdMTYiwbt
	rJ4auqcQLP/CJjxM2Il4WAmz+oFl2FVdiJICW5YK9H/SoWiMpMbBgGO852HH9DTwSiyeeVP24rZ
	MW7gzfOvxTTaHClt+1tKbWYc0Z+lfO0IeCOxoL4Z6eZ+Sd+SywwlfMLH970cPEZKiqMzC8c6w2g
	/geLAn05QC+L0JUaoUXWCO9sODb7WN4Keoc+wpSNl+QgAwnhb4kA0HCTQ4R6QMhiLX33UM001+m
	+7afpGgd8SOZT5g==
X-Google-Smtp-Source: AGHT+IHLT9N5vzpsQutQQ9ulKp582Ah2foW9PDWR6BJHOqyq8AooDUGWjRTE2QRmMzz/URWTOsvn2g==
X-Received: by 2002:a05:6808:6f8a:b0:401:be80:3235 with SMTP id 5614622812f47-40341163029mr1741524b6e.7.1746198061600;
        Fri, 02 May 2025 08:01:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:82c:13ff:f438:6d53? ([2600:1700:60ba:9810:82c:13ff:f438:6d53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c3f3cfefsm7346937b3.33.2025.05.02.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 08:01:01 -0700 (PDT)
Message-ID: <b9a4dbf2-0064-4933-985f-b34dcb133030@gmail.com>
Date: Fri, 2 May 2025 11:01:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scalar register: add --no-maintenance option
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
 <4910bacd0524a29186e673a174a47cd46ac95b5e.1746008680.git.gitgitgadget@gmail.com>
 <aBSNN6Z3Vve6c6Bm@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBSNN6Z3Vve6c6Bm@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/2025 5:15 AM, Patrick Steinhardt wrote:
> On Wed, Apr 30, 2025 at 10:24:39AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
>> index 7e4259c6743f..b2b244a86499 100644
>> --- a/Documentation/scalar.adoc
>> +++ b/Documentation/scalar.adoc
>> @@ -11,7 +11,7 @@ SYNOPSIS
>>  scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
>>  	[--[no-]src] <url> [<enlistment>]
>>  scalar list
>> -scalar register [<enlistment>]
>> +scalar register [--[no-]maintenance] [<enlistment>]
>>  scalar unregister [<enlistment>]
>>  scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
>>  scalar reconfigure [ --all | <enlistment> ]
>> @@ -117,6 +117,12 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
>>  parent directory is considered to be the Scalar enlistment. If the worktree is
>>  _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
>>  
>> +--[no-]maintenance::
>> +	By default, `scalar register` configures the enlistment to use Git's
>> +	background maintenance feature. Use the `--no-maintenance` to skip
>> +	this configuration. This does not disable any maintenance that may
>> +	already be enabled in other ways.

>> -	if (toggle_maintenance(1))
>> +	if (toggle_maintenance(maintenance))
>>  		warning(_("could not turn on maintenance"));
>>  
>>  	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
> 
> Isn't this change contrary to what the docs say? `toggle_maintenance(0)`
> would cause us to execute `git maintenance unregister --force`, which
> deregisters maintenance for us.

You are right. I've confirmed this using 'test_subcommand' in my test, so I'll
plumb the ability to skip toggle_maintenance() in certain cases. I'll carefully
document this in code as well.

Thanks for the careful eye. 
>> @@ -597,11 +597,14 @@ static int cmd_list(int argc, const char **argv UNUSED)
>>  
>>  static int cmd_register(int argc, const char **argv)
>>  {
>> +	int maintenance = 1;
>>  	struct option options[] = {
>> +		OPT_BOOL(0, "maintenance", &maintenance,
>> +			 N_("specify if background maintenance should be enabled")),
> 
> Maybe s/if/whether/? Might just be me not being a native speaker,
> though.

I like your choice here.

>> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
>> index a81662713eb8..a488f72de9fe 100755
>> --- a/t/t9210-scalar.sh
>> +++ b/t/t9210-scalar.sh
>> @@ -129,6 +129,13 @@ test_expect_success 'scalar unregister' '
>>  	scalar unregister vanish
>>  '
>>  
>> +test_expect_success 'scalar register --no-maintenance' '
>> +	git init register-no-maint &&
>> +	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
>> +		scalar register --no-maintenance register-no-maint 2>err &&
>> +	test_must_be_empty err
>> +'
>> +
> 
> We should probably have a test that verifies that we don't deregister
> maintenance.
Yes, will do. The currently-passing test that confirms the unregister is
happening would look like this:

test_expect_success 'scalar register --no-maintenance' '
	git init register-no-maint &&
	event_log="$(pwd)/no-maint.event" &&
	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
	GIT_TRACE2_EVENT="$event_log" \
	GIT_TRACE2_EVENT_DEPTH=100 \
		scalar register --no-maintenance register-no-maint 2>err &&
	test_must_be_empty err &&
	test_subcommand git maintenance unregister --force <no-maint.event
'When using test_subcommand, it's really important to verify that this kindof test passes before changing the behavior and turning the test into a
negation, since it's easier to accidentally "pass" a negative test if the
test is malformed.

Thanks,
-Stolee


