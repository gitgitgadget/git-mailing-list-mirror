Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171131EB1BC
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841279; cv=none; b=Nha0AQhlLVs9TO+kwg/DCDCwK7GRlxg+hjR/6U7uY8nbH51N1v3ce6tiMekQDGmbqKGbNZ1MbhkwTFlMPQDfKqMqamWi/nF44qOP5kMrxvuBD2/+tHene7cNbZUYhrMcNHUC7PCC5rS+wIELzNfP5i1INim2IKnhKH8GwvH2h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841279; c=relaxed/simple;
	bh=R42OIbfZUj/wSzxE2R5XNwzN+aJZ5/Q7EJSS+eA+nZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NbWJKEEM6VUBwQMwmUCSrvqRO/bUf9bidXyGTNT/28YbkC1IiGNWFXd01xC8D1qhvqS21K8kuIYIEPCN9hfDaMy6PtW9eOqAZ2XyilPvGAXjf8wm6F62xSh7XNVthYxnVvls8MYYOmG1Xa8ZzwFvwaHJ0nBplR19W5pG2ytLgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZBE5NIr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZBE5NIr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so56286145e9.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747841276; x=1748446076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SlgJXG55HeW91Kd6pjrUVE9ImKTka7Wrc13xH21MN8=;
        b=QZBE5NIraA8XkiGHTHO0YMouHbKa7IOfjfHYEdITqKOMPN0scWxH1F3YnHb4cqfYxG
         /UnkTxxIZoJphLUM4QBmYT0m8yWJGEAubBwBFRlpv4OwNX1HQRgvxqXYFp+38BEmIjhk
         2NOPIuj6q+FFZNxYyvBGc+5SQWP63LUt60qH2ZAa0JRsZ/HwuqdS4Ui5OtnMGbglp4py
         Mq6It1PWjK824rYI0uWE8X4JMTlGemrqdTWB+L/hVObBiXOp8jLJ0ChNIs5BvIhLuAOr
         5DTqGlS1oEjSbJt26rnMCUNVoRVmRo/E8D15UhG9inRKnoPoTXQQoejCWHCxoFViEhh5
         m0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841276; x=1748446076;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SlgJXG55HeW91Kd6pjrUVE9ImKTka7Wrc13xH21MN8=;
        b=k0828BtAsjrIQjo9iZvy1llK/cSTcmn73i3c8Mq1M0NG4DMbmQ8QoLvaz1qML4ZAlq
         IBZnBScJLkhlZNOHQsS6gbYNR3+S5i95ZHolP/vCCzyfRu8nOfUIjdiR/k7YgKj5avA4
         S1RvagQifwkbaCmsOm0kOco4o0D96XYQ5CXhSBT8DwdSTDoqQBPznQNSPeT0yMPkCEpR
         wOWaUcHzAmn9f6Qbimb+ptaOn6aqoTgmrjcE0B0BJfKJPG7ko94qEINGrfj1I2YAlZom
         moX+vDV+FwoYtm13WczN4akHZpycD7s/CyKwdzn2WfH1WCFurR7ZDHOoNUbEBmdMlO9R
         GZdw==
X-Forwarded-Encrypted: i=1; AJvYcCVI168o0xcAX+bBw3GlaNO46/WUQ9ZUlU6beqj4Kkk74bItycjucYdWI8me3Vt50d8zaQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYE9F7TmZ32FYxQqcpcCKLPF2njg6XJBSrC8u1lZkwEFyjrio
	c4sYRPJTCojSWEc7c5lts7fEHak4eLzNB1qJYBTco3ys6FB6ryjcne8C
X-Gm-Gg: ASbGncs7NqpxtAP6dVFiyZG8scP+vVRdq3KqPFNK0YPaHO7IOwho2CuFPsXs9mZEIPD
	OzEy0/qXuhJKW9vqMOkC+7fflmA1/MP7vzmi/tEjhwbdn9sAkjQzvLRDIs2JFx0QhB+ijxDH38m
	9bpFk2p0ostxScwAxicsj24iIKL1eRMeCfRPjYRVJTS5mnQgDpM6nbwxnuOQtSgjV1xmX7AI3Ym
	j1hP6yYG7VMG01eqDY8VInVBIxmxXPxAgwumvDBW1NorUDfGPxVcSl6Zwu7DVt+hIpG2NCP7WgP
	ek9aiQqFETpcS/ILV+20pyHawGQLRrzuQHfnaymvqt5RU/TiwvZ/xahBUEGvfLZF3HqppeWpmeg
	H4pHN0K4iEhxleSvGyNmjvoJDyxc=
X-Google-Smtp-Source: AGHT+IGsToajni3IkBSixSuRup7doJrmTLf3vlwfEvDcemmbzCguXiXizot7d/HWRGs1fmtkpKMLmw==
X-Received: by 2002:a05:600c:1da4:b0:442:f904:1f31 with SMTP id 5b1f17b1804b1-442fefffbb5mr224854555e9.17.1747841275949;
        Wed, 21 May 2025 08:27:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36835ef41sm15916152f8f.94.2025.05.21.08.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:27:55 -0700 (PDT)
Message-ID: <2a8221bf-5edb-449b-a4c9-3754350466d4@gmail.com>
Date: Wed, 21 May 2025 16:27:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im> <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
 <aC3SZtwQSt0mSVuo@pks.im>
Content-Language: en-US
In-Reply-To: <aC3SZtwQSt0mSVuo@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2025 14:17, Patrick Steinhardt wrote:
> On Wed, May 21, 2025 at 02:07:25PM +0100, Phillip Wood wrote:
>>
>> But don't we still need to change PATH so that hooks, shell aliases, git
>> rebase --exec, git bisect run, etc. still run the same git executable that
>> started them? For example "/usr/bin/git -c alias.g=!git g --version" should
>> report the version of /usr/bin/git, not ~/.local/bin/git which comes first
>> in my PATH if git doesn't change it.
> 
> There's two parts to this: PATH and GIT_EXEC_PATH. We do have to adjust
> PATH indeed to contain the location of the 'git' executable. But we also
> add GIT_EXEC_PATH to it, which I'm less sure whether it's actually
> needed.

If we were to add /usr/bin to beginning of PATH when the user runs 
/usr/bin/git I think that would be more surprising than adding 
GIT_EXEC_PATH which is what we do now. When we add GIT_EXEC_PATH to the 
beginning of PATH we only affect the lookup of git's programs. If 
instead we added /usr/bin to the beginning that would affect the lookup 
of many unrelated programs.

Best Wishes

Phillip
