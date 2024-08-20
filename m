Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD61C28E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117634; cv=none; b=geZ+H8+/z68vdjADQ4+ZS22oaJSkWcgNbDY6Pg0D/n7RmOBdS7bHrW5hrIA4DT1kJvxAs8Uq6IQWDczzoW/pIn2kyX9BN8j2T4Bg2nn2KpBuREtypNHcO5sYkMGhy8OoXhp433xSfpGC49PmefB8EFzyqUiP50tFtmSFKJLUUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117634; c=relaxed/simple;
	bh=hW8xiXPMD7MOQAN7HYUm77lyzqiS/RYIA4QUkXHNWBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW985D9oReWjxkQ+yBhjr86hJvJPKg3ieK6BnVmifbvsD7Z8BbPWOrqr4LNASWwn61N4rzF1z/Ena1QnAYIB7HC0oKTXCrGC/rpCn61QpnMyWiZCQFcOjJwoMRksErJxZRbsygjPuUKEi2/uliW6DGNCNqtPT+yRhQNcg7ri78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIWYaUwN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIWYaUwN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20208830de8so27659515ad.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117632; x=1724722432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPT3J07JSvqOZz/rdtnuuvFXTM/eiK+sYPSwXcez5F0=;
        b=CIWYaUwNiCxEDDsoYuJYt4Kn3Lc0iYAuLoLGmet6dU6ptBe/eDIUzOEm65TBnTMAMd
         XQ3P34fydM8+1X9ODcqylMaIUvZxKrqiZ4sdSeEYV0XWK5qQOjltQL1KCSL/wOBfgx36
         p0Ui9Ak9Cm685sitVXt4OEnVn1da9xUEf3US5U1hCurq0Wm+KBB2cFgqxLjsG1q3h2jp
         H77voLr11ltcqqZm+BrxBndstrrwH6VxDrDU0fIGgvapZXDrUhanWVqTmD72NoAql4Xu
         5gRlTfB6oh+Gz0GI30Kp4cfe1TA8TauqO8lQG/1SpLfv+tEtdyBvwfq+NF3HqtAOIzIO
         eRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117632; x=1724722432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPT3J07JSvqOZz/rdtnuuvFXTM/eiK+sYPSwXcez5F0=;
        b=mm+JNvFvg3ItR03dCumyxPwqS5CA07vDwmAtr4pk6v24pxzTyBCP1LoWdBHXSgvKuO
         iKZJuLjV8EJ9Amoc/ElYEpy8KQraXc3hup+XrmdGeztIKRb7TT7J3bih1lWC7I6Zfa4u
         h+YF4hTUonZ+5zNSAnsRgIRPWF7rF4br7EeMoUtnu5d5S7OYyi67jXYn1ul0EXkO79hR
         pjc1AsEJs9dOnUWl/GsSsRu1E+93XAxjX4CwlOyV1is2oVimePLcbqm6ix7wkutagpZJ
         jMTSI+gXxBmhGenfwe6iqAEVg9/5iRbW8hD2c88kIjaFFWwV0YJrUUJtVZgLIzzCGDV+
         nMiw==
X-Gm-Message-State: AOJu0YxAoviyBhzgIb7u8yMZPKXpXkrP9qKbtoW1t6gXVGL4xQO9TsCq
	cKRfJKB2Wv7bRwdMzlCHeYwpeb0g1D9oiXTBIxeLoWr1k3kvcq66k1hiY2Th
X-Google-Smtp-Source: AGHT+IGRQAamGIqTljPB/8G2NUgooB9sQ7N7pEWOJXUv2bX4ttyXCiM2xplks+tzRTSOz+vZfTkdpw==
X-Received: by 2002:a17:902:d4cb:b0:202:85e:cf56 with SMTP id d9443c01a7336-2031512f6fcmr7404695ad.38.1724117631680;
        Mon, 19 Aug 2024 18:33:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:fd03:4092:1a29:3499? ([2600:1700:60ba:9810:fd03:4092:1a29:3499])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03753c9sm68352235ad.167.2024.08.19.18.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:33:51 -0700 (PDT)
Message-ID: <be1182e5-5b0d-4deb-8b47-e38d05d184a0@gmail.com>
Date: Mon, 19 Aug 2024 21:33:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] git for-each-ref: is-base atom and base branches
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, vdye@github.com
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
 <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
 <xmqqed6ke1dx.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqed6ke1dx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 3:52 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> There are benefits to users both on client-side and server-side. In an
>> internal monorepo, this base branch detection algorithm is used to determine
>> a long-lived branch based on the HEAD commit, mapping to a group within the
>> organizational structure of the repository, which determines a set of
>> projects that the user will likely need to build; this leads to
>> automatically selecting an initial sparse-checkout definition based on the
>> build dependencies required. An upcoming feature in Azure Repos will use
>> this algorithm to automatically create a pull request against the correct
>> target branch, reducing user pain from needing to select a different branch
>> after a large commit diff is rendered against the default branch. This atom
>> unlocks that ability for Git hosting services that use Git in their backend.
> 
> Thanks for an update.  This iteration looks good to me.

Thank you for your careful review.

-Stolee


