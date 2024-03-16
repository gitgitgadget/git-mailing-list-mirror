Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E811C680
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710619269; cv=none; b=C6HgEt8dU7AQQ11uvsWT/HyKclG3+q3i2yPSHshqIlSphBOaykd7T+wukFaXcCW2a03Yy5qSray7qE6JXO2BHDkw+E3M5uLSHIFSb3REF/TxLkV9ofCAiPnneCAr7KzVrTiyet4NXF5aEJtOOeIOEyHj34DR2RHrnx5X4qIrGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710619269; c=relaxed/simple;
	bh=FeOKXcmwps/WT+8m13LDVk8fMd2CgyugNsj0bdfB/Fo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eTydBcbsN6bVr7SD6dpWAETi90L/N8FU7Z7o0VyxFeqrEoXDpFpbtLdPheAUQKaQAfjlHiojFqKvxlUVmGQQkRRKO+nh+RTc2CDapjYCqLW6OFv0wJ+gfWt+EavbwksVHFxlJjE8Oythr66LSROiAuqLEm7K8MCAWY15CGcHWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnXBQWOX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnXBQWOX"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42f52226f9bso13140381cf.3
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710619266; x=1711224066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez6+brGXqBaC/f6jAb6bZb1jqoH5JbC9tBdSLl0My4c=;
        b=CnXBQWOXhl0qlLywl2HdYKjV5yBd+2Fq6CTs6zOwmMKKBQo8f3UX6Uu8VhLqhjEy31
         caoeItwz15iRicgFTTARthrUcHWWzm3WI+u07HQ9IcE7Nzl4P7iDFmwuno2HCBcw1Wqb
         /t5Na0aZXHNqK5yVDYPdIksa3wj2MNrZJREO/z0PjTlLauZH6BpVmxnlmNnU57B93BjI
         HAqGXJYF2p6JFJ9mGR+Yng87hXN3zP6yiCBVlewx9y+PmPHta/xZmKG7B3GdtuHVUIaR
         39FWZu6Cq/Cg1ESNNj+V8gDyUZb5STkv4gPwTW4/kiJ+C2UOGVBXrzB9EJ0GFUPZmV90
         1WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710619266; x=1711224066;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez6+brGXqBaC/f6jAb6bZb1jqoH5JbC9tBdSLl0My4c=;
        b=dS6uWLs8t+1H7ZSgwGTIPO3LRnfSW7HnEdvHoh+T8BDlZ6BXZrI/DcvA1Kb1RCcNlF
         8/CJFGW9oxc6CxU2v+lsuRS+Jcl+KoSgFu4RMWhLRf/pl/0mYSTd9MPd5TqEgkbuUmDr
         oc/1IIduRymgT+A2ZSDeOWoIjSd2fVZT5jVrWvtI9DR6TJLUtmjPYiZmU8GGH3OYAVzH
         /zhvFNwqOeqB9yv2JpYcWG7oAvY86ycNP5/E/ZpYdYfyDfiTrId8OgOp8Sx3SeAgjnwi
         CNm7HXI4BDmCaCpRKEfJoIhho28zQgIm7DOFYetIjyfQbOMNsb/G3Mk9PijkBKrHBM2X
         ngqg==
X-Forwarded-Encrypted: i=1; AJvYcCVU332JV3BXcBl1/ObGWdnONxgEQaplI1mmwnI19q++VOgDJgc4ulACeFzi8F2xmGi+kH+WZwOhHdgSrSMsDXt+tSIL
X-Gm-Message-State: AOJu0Yw+HMjhsIj6xAwucRl3sl/LJuyZ1a2jP5v8iU2BkbUBAzyiVm8q
	H8Y0StbGb4hkB7+ZEDUQKlJrTWmQvgWF0WwFiW6vCx/L1DAjTzoO
X-Google-Smtp-Source: AGHT+IGk1fFEY2ouWsDGZgAtaktxAfkhS5hEQvhMnGCk1fSK5A4GSPUQUvz4BS1j/Jdv5ZDuAc/rXQ==
X-Received: by 2002:ac8:5a8c:0:b0:42e:f816:cb6c with SMTP id c12-20020ac85a8c000000b0042ef816cb6cmr8552679qtc.7.1710619266699;
        Sat, 16 Mar 2024 13:01:06 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:f04a:b551:cd51:32ac? ([2606:6d00:15:103b:f04a:b551:cd51:32ac])
        by smtp.gmail.com with ESMTPSA id j2-20020a37ef02000000b007883b9681a6sm3097096qkk.26.2024.03.16.13.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 13:01:06 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
 <f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com> <xmqq5xxsu1z5.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c9b3714b-e009-5c86-3cfa-993be018dd01@gmail.com>
Date: Sat, 16 Mar 2024 16:01:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqq5xxsu1z5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit



Le 2024-03-11 à 13:12, Junio C Hamano a écrit :
> phillip.wood123@gmail.com writes:
> 
>> Hi Philippe
>>
>> On 10/03/2024 19:51, Philippe Blain via GitGitGadget wrote:
>>> diff --git a/builtin/am.c b/builtin/am.c
>>> index d1990d7edcb..0e97b827e4b 100644
>>> --- a/builtin/am.c
>>> +++ b/builtin/am.c
>>> @@ -1150,19 +1150,23 @@ static const char *msgnum(const struct am_state *state)
>>>   static void NORETURN die_user_resolve(const struct am_state *state)
>>>   {
>>>   	if (state->resolvemsg) {
>>> -		printf_ln("%s", state->resolvemsg);
>>> +		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", state->resolvemsg);
>>>   	} else {
>>>   		const char *cmdline = state->interactive ? "git am -i" : "git am";
>>> +		struct strbuf sb = STRBUF_INIT;
>>>   -		printf_ln(_("When you have resolved this problem, run
>>> \"%s --continue\"."), cmdline);
>>> -		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>>> +		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
>>> +		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>>
>> I think you need to append "\n" to the message strings here (and
>> below) to match the behavior of printf_ln().
> 
> Good eyes.  You'll get the final "\n" but the line breaks inside the
> paragraph you give to advise*() functions are your responsibility.
> Even though advice.c:vadvise() handles multi-line message better
> (unlike usage.c:vreportf() that is used for error() and die()) by
> giving a line header for each line of the message, we do not wrap
> lines at runtime.
> 
>> Apart from that both patches look good to me, thanks for
>> re-rolling. It is a bit surprising that we don't need to update any
> 
> Thanks, both, and indeed it is a bit surprising.
> 
>> rebase tests. I haven't checked but I guess either we're not testing
>> this advice when rebasing or we're using a grep expression that is
>> vague enough not to be affected.

We are not testing this advice when rebasing _with the apply backend_. 
We are testing it with the merge backend (in t5520-pull.sh) but we are 
only grepping stderr for  "Resolve all conflicts manually" so I did not 
have to change anything. I'll add that to the commit message for completeness.

We were testing the apply backend through the same test before 2ac0d6273f 
(rebase: change the default backend from "am" to "merge", 2020-02-15).

Thanks,
Philippe.
