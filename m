Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C116EB49
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403593; cv=none; b=eGA46br9qtsPnkh6goswAmMBkwGf9TGeJ9M0ChI2A5DKCrZuVCkRDj4VUbcs0zfoCtYLEeP1Ykvd2h6GsHP8gziMkM0ivnmofkYBGh34qaqXszcYBSbLrkhCKKiBvXty1gAC59ZXNre43AVtQ/B5rmFNSYcOtIfnZ3hEJtDcxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403593; c=relaxed/simple;
	bh=9p5xG8N9AMKJqK6ZjEIsQnO0OOpmcP33ZKFdEmjVS90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrqdI9TNwHJ4fYaaTOkSxFuDqWIQ5a54f9TNb5v8+ATmi5SBYbnFyKFzSqge7ZStAEIUW0vTO62afQPVFLcdfmTJVrMOq+phIc3TVnP2pSIyObb/aEziveyA9hao5oU/UMtBbNOyo9KbJDzx0c4CHPBHmI/rObYKeTRY9GQTqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoiRIC8f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoiRIC8f"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa782ff72aso558425ad.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719403591; x=1720008391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVQAbDEzPeGoluh4ncDkmGasdJcjtbbu5O3iIX+yHRw=;
        b=SoiRIC8f+mB+GiJyWu0kjD8teoIgUsxPPiTRa78M3QJLUXjyjDf3VnDXWqOy0C8hKC
         cD45HgHTs0kXURnHHsBLSZ0u4RpTwxOwXPIgBhCmd9WjQxaMKLOMpo6iGYjUhabAOjND
         cH3sy8gc7YN7cbmcNvSP46FCj+FNHwiTy/DEBZpKpiqcB5jcQnNjGzG/MW57/NYzQlFs
         3RyfYEIJTP1YG67PPo0xrbfAkA+157BMNmdIBD+xcFfGbteh4KpL0bWkouOA5rBmPWQs
         dBQgmmNAPKAtEwiNC5wymJA4QtDgQILaVr7O+HdYDtBSzEgjeCeGzf2RC/JXnFRJXl8+
         xBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403591; x=1720008391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVQAbDEzPeGoluh4ncDkmGasdJcjtbbu5O3iIX+yHRw=;
        b=iMs44wC6PHuwzr1i3Lh4OH/P9OFpZXoE2jUQFtNAIYRNL23bsNTHyDdNjK5Q7TdsaP
         wmHKv+98mRxhHbagozAHAa5nVZlMl7P/iWHzpRyGrg3qgAhbzIUsCNiL85zCEgRIxbxG
         xCJjxcpobJg+byoYI2ctpZ/71O270T3XVPrMRasi6MTZJ9SFHqDVCsOP5clxbYXYtYHw
         T6SrmpLjlz5q6wIAv4sqsMX+Rz0oqFSRT3gndZ4uP4YcgzEcwco8AlSgkP8ZsaPdWxf2
         sR7ZSmicDEblbo8C4lsri5S2TuWh3fpMp28exgJxTfmofsKVU5p2lzkfk9g805G1T+F1
         Ww5g==
X-Forwarded-Encrypted: i=1; AJvYcCUdS6XdCwuaZZ9m/I56pZL65pZY3GU3gW8KpTAZtv3B/bMATr31IUyJnBMxqbgj2T0BNINA1TfEY8kJvnknk2zrzXnk
X-Gm-Message-State: AOJu0Yy9IQMl6SR4xCxLSX+jJoJ7K7vtTSOz33dLgpD/46TSYV4U2m6I
	pBdZFg4aP/qKb9eTADlTn0EolP1hesdjBeeOKD+S3+HcCSeESmzp
X-Google-Smtp-Source: AGHT+IE+X/D1UCB27nwOnk/oknFKfSBqDU6GSO43tPX3WU/keYC6kW9d+L9cxwI1nv0SEyggwLeVsQ==
X-Received: by 2002:a17:903:22d1:b0:1f7:178e:6091 with SMTP id d9443c01a7336-1fa0d5a9725mr141241215ad.0.1719403591157;
        Wed, 26 Jun 2024 05:06:31 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:708d:222f:b6ff:a843? ([2409:40c2:205a:5198:708d:222f:b6ff:a843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb3f1esm98042315ad.265.2024.06.26.05.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:06:30 -0700 (PDT)
Message-ID: <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
Date: Wed, 26 Jun 2024 17:36:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] describe: refresh the index when 'broken' flag is used
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <xmqq34p1813n.fsf@gitster.g>
 <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/24 17:00, Karthik Nayak wrote:
> Not worth a reroll, but you don't have to create file.new twice.

Actually, now that I think of it, those two were better off being 
separate tests.  It might so happen the first call to describe refreshes 
the index, due to which the second call with the --broken option does 
not bug-out in the way it would if the command was run by itself. 
Having them separate would give them enough isolation so that previous 
command does not interfere with the later.

>> Range-diff against v4:
>> 1:  1da5fa48d9 ! 1:  52f590b70f describe: refresh the index when 'broken' flag is used
>>      @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
>>       +			cp.git_cmd = 1;
>>       +			cp.no_stdin = 1;
>>       +			cp.no_stdout = 1;
>>      -+			run_command(&cp);
>>      -+			strvec_clear(&cp.args);
>>      ++			if (run_command(&cp))
>>      ++				child_process_clear(&cp);
>>       +
>>        			strvec_pushv(&cp.args, diff_index_args);
>>        			cp.git_cmd = 1;
>> --
>> 2.45.2.606.g9005149a4a.dirty
> 
> Other than this, this looks good to me.
I am not sure if I follow this one.  Am I expected to not share the 
struct child_process between the two sub-process calls?

Thanks

