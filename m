Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBB42BC46
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086137; cv=none; b=Xb8Gve2O2nxI5M8cMMJ0HhWnBUiZTPNs977g6HIRM5ofHjqfjzBqoY6Kn/KmfOMMdbC+YUKmINSM42bTtPnYoK8/PZlSfEVXBIR40dto1BFvCnnCAYf8VDtU23bZeKL3T6zRHxNRDseheECftqy3Sn11n6sQpdsm42HtHHV6hIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086137; c=relaxed/simple;
	bh=grEBZ4Mbbw2j1uKL+tnp68EYHyMYYImChfFa3/J5lsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMCWXh1gS0B0cr/Zx2j4xWxJDjBou7E6Lh/hoB9BVTJo4B7Wvq0YM8CSLAzj66bBEhlgW/x/62L51jdymyt7SOGHnTTvu+6grEwojpYShvrYZbCw1hQU7fCqoum5rqscFgg5SwLYviDYRKQvEuO4MEgJDOtW50iMNG4sC6G5Ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=f1XKy9l/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YmIvL/Te; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="f1XKy9l/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YmIvL/Te"
DKIM-Signature: a=rsa-sha256; b=f1XKy9l/bZlg5BtPKJu48MC+jZ+v72d/fJaWYXEHagR84jVw81eTNTxts5Xf9KlNcnyPX25SB3IP6ZljoU7O/ola6RXVvNMrak+g4Ungo2vdYjIqELwmAvlrCzXr7gTc30VgZjWqHu3KTxggOnMlswMELggcx3ULzoQVfHNJbfz/YundxRqwbESB8jQHzYhm4tWzvOIspE0K0JZef4So0oXE1S0nfy1UdDLeJTfPKZ9RNuvImAmW5dIs3N+iN5JpmCL2X2SacSUseoLd+A/zTXJe5VCQlKN62FAGeSajl+kdLc+JUCwjGHkirxzDgK9hkU6W7vnCabGbPkWdmHcnDg==; s=purelymail1; d=malon.dev; v=1; bh=grEBZ4Mbbw2j1uKL+tnp68EYHyMYYImChfFa3/J5lsI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=YmIvL/TeHBupe/UQ3fUcyXryJR4xXX/Yfs/e4UpJnoizIWIEcbyckLp1GgVidixtFHhPzmwPBJ0xA/JtIrSJsAr45BMc03ZkQH+6UHs6Qni5PhLil23neaoyYzZqOL2752+j8JMQn3rOQfEK695YWQXRVC2TDYpCUDpSrVEsZVlH+ZOi9jnqM1H4dqGdnkOAIfICmluricZeAkrYrb7A07IbUBK9Yu0eywmJw/aA5+DdNXu7yRFjBxZCvhoLGPl6pJYc6gvdxMbFsaxLQIdJDEKw3TO4ESh7oJovPoZYAbjjhzaEWAQeLgyRy7C8BcgVFbeB9vSypnLP7nhtis0tjw==; s=purelymail1; d=purelymail.com; v=1; bh=grEBZ4Mbbw2j1uKL+tnp68EYHyMYYImChfFa3/J5lsI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2076641313;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 03:28:53 +0000 (UTC)
Message-ID: <ba63b45c-b078-4d12-b699-ee4f57549c40@malon.dev>
Date: Wed, 15 Jul 2026 11:28:48 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] environment: migrate 'trust_executable_bit' into
 'repo_config_values'
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260612160527.167203-1-cat@malon.dev>
 <20260619162105.648495-1-cat@malon.dev> <xmqqcxx9ukvw.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqcxx9ukvw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/26 04:55, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> The 'core.filemode' (stored as 'trust_executable_bit') configuration
>> act as a core filesystem capability flag.
> 
> This unfortunately hasn't heard any responses since June 19th.  Are
> there remaining issues with it?  Or do people fundamentally have
> objections against this change?  Or things are too busy in general
> that there are more patches than there are folks willing to review
> them?

Seems that no many people are viewing this. Let me send V5 which 
includes a new commit and a few changes.

Hope this helps.

Thanks, yuchen
