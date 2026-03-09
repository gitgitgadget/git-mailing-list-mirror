Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6283E0C6B
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073405; cv=none; b=V/+MIqRbPZk3Lj4fUE886R/B5THMWNiKyGhrsH1satAK+eVd8e+agmSnnWJAmy7+P9JGMPITBNUgkVfuynd6WajuQoI0LrT+D+HONPQYonOxSJpC58731DHK8mQgoMcpOurg2PlMauoxLyxu/ERCp/tKEk+MweG887tCRO7Ov3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073405; c=relaxed/simple;
	bh=uUjUHwHeuR16RTlor2JqLyBl4iDAVWRwzD06kavd8Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSNjl3koyRxBRNtEpJtiGNdbo6vvyuv1mp1ow2WrOB9huKo/e/78sJDTa6TMvMsV66S2M3PBP0Gbe6iPWBpIWezbt2/NzF3IoFQVp7rgtSiFlY1YJDWBrPSQNalg/VaC1r9TKPEznh5cLbRUats38q7MyUlUE4ayBS4q+1EuAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=XJ6GH1A6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XfNkZDZ8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="XJ6GH1A6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XfNkZDZ8"
DKIM-Signature: a=rsa-sha256; b=XJ6GH1A6jhpqDReu+L++oS5Kn3Yqz5iWU0IMyjyL6GPZ2mYj4F8sW/Aiep/t/guC2u/hH6d5aUQSi2tV3Z1SYy81G71qsuC6xPYQ4DjFtSmn/3XBNxyD4ec4rLBgps5V8O3LYed3Xy5bm9XOd4VY4kntKX87PfCs9Ub/vIwWZoDwdUX9YwSKPDro3F7ox5peBvtrLJPwgAoQI1Xl5kdY3tIglnQU6LDvjmJoYmEa/VwZVzv4NRMEAofHG09/2gn5VbTWMGqniVgLm3xxCe8NoMHQUm0IXfcWv51EpPl8gbTkeERsT9Q5fyY6QDvRM9DBkLeipz1CGcjbw7q5n6Zeqw==; s=purelymail1; d=malon.dev; v=1; bh=uUjUHwHeuR16RTlor2JqLyBl4iDAVWRwzD06kavd8Gk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=XfNkZDZ8iyGF2XsrctatL4PYzYaFskeqJth6AfHSstQxe2/OElqHvpdh0d0EU8DAzVzVbit+8fPO2FNRIBL6jvqDXd+jd+AF6Ko2/GnWjFXZH2WytZbDmhY+/Jf2VV9r6w9vxhFXpivRReIm7k3DghoJSLQgOJOUuSHUqvto1/TK6+zSofmj/C4qfGTe8nfmO4FMHFYc45JUQrRVtdqQ9/Gy++KFWlanVhPEF6g9dO/2nuhGAz6h6nrNdOTZUA6fFthIQl1GEB4eIRiS6t9NG76cqxol9vQ1mH/jhjq277Mrsind7XSEFR/f+/xiC71+GeR310SWGg7C1C8LMyLjvA==; s=purelymail1; d=purelymail.com; v=1; bh=uUjUHwHeuR16RTlor2JqLyBl4iDAVWRwzD06kavd8Gk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1541362721;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Mar 2026 16:23:20 +0000 (UTC)
Message-ID: <615caf83-71be-43a6-bcb0-3a0c5e14d699@malon.dev>
Date: Tue, 10 Mar 2026 00:23:17 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
Content-Language: en-US
To: Dronaraj Gyawali <dronarajgyawali@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
 <20260308183756.31860-1-dronarajgyawali@gmail.com>
 <f03d40072ab106d1a0a7852718d42f56@purelymail.com>
 <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
 <CAJtK1FMzbX7dO9y7hM_6_DbLpwbeYHnrg7WLjAghGX6UDVDmJw@mail.gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CAJtK1FMzbX7dO9y7hM_6_DbLpwbeYHnrg7WLjAghGX6UDVDmJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi drona,

Junio C Hamano <gitster@pobox.com> writes:

 > There were discussions on pros and cons moving global recipients of
 > configuration values into a dynamically allocated strucrure...
 > and excellent pieces of advice have been given by Phillip Wood.
 > If anything, a change like this should ask for input from him.

That makes sense. I think you should CC him whenever you've thoroughly 
polished the patch or when you encounter unresolved issues.

 > This "v2" applies to a mythical codebase where trust_executable_bit
 > is somehow a member in the settings structure, which I do not think
 > we have.

Given Junio's observation, it seems this iteration is targeting an 
incorrect or non-existent codebase structure.

I'll hold off on further reviews of the specific implementation details
until the base codebase issue is sorted out and the structural design
(incorporating Phillip's previous advice) is settled.

Looking forward to the updated version!

Thanks,

Yuchen
