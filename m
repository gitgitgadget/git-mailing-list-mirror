Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148C434E21
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931850; cv=none; b=fmqXFsnVXZwGX2WvZGQ2eca/LQ3NZ81Xg4JC55q4zFMImc8TjXuorMU2JPrd9NGtkz17MYGsrkZcjijsmi2X5LcwgwvNUjBy2gE49dAhbjt1bacSXK2q5yYziSf+ROxRweVDXS39A48jR7eKqUFWhMtLxfgkEabaBnivhHh7iNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931850; c=relaxed/simple;
	bh=AXF9cdA1CwF93jNh3xMWgaFJkaU8DlZm7oAn0MJOadQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8yFTRv2oMk7Ky9Y02AZuPZhw8DAm9D5M0t5PftciBYkzqJolCEDl48pN7ISc/tJLxz+Tw22sNzNRoFc78ByeTbGs1zAdYw/I3+pMpDP1cGhxk2JeSJtpzw9jsKJ4Mub77azXxSN/JaJed/BoeMxTnuwNuT4qqA4Y046kEBwNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=nfHWT/fe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eWwE7el5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="nfHWT/fe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eWwE7el5"
DKIM-Signature: a=rsa-sha256; b=nfHWT/fehf444A5JOuRIlEcFTUQeBTQEr6YnEOQ0emIaJyFynvzVliVNcZbPiKgjQHoxkOKZD4C4sTrtPhVFmvUgRbs80oNhwshHSCKEfFWFIq+eCphkkLaLN87CyY3/jHQZC/psAtuFVqd2MfM63kaQ0BLYUp4YiiENsI0VH0/kPS48i8/zSo3d0kxC2fCDVttEZhXAp97QSFrEO5uknBfp8hRSm3inaf2RZwmOssXgqOblADbIpxVUDvePEXfM5mR1wk/erY4h9pnqtjRUF/uLMUqVjUuu9FXdM05h0kPoMjbFTUn4fT5Fy5RJRRS8uCHdMWMh5lWnrXrW17YXOA==; s=purelymail1; d=malon.dev; v=1; bh=AXF9cdA1CwF93jNh3xMWgaFJkaU8DlZm7oAn0MJOadQ=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=eWwE7el5Ovg1Olgeg8e5wYIBRWDHYhr6BaGEGIXwtJaju+1sVuF4IPAHRYh9fPJqkB4/5ZSf1GaEDld/bbCeOly3Q2aoLhE24xMWdZbgJ4KmijKerFFqKuEO/1L3/DoBHSN40da70RaAhrrqmQk81mj0TyoRMHIRzk/a8fctYidkLLRq3zFtEFax26kMBJhm0S+Xd6qYdHikbRVYFcZY1CJBalFW6D056XSSvA4SmrIz+X1scKzVfZ8KAIgdxDX+P7OyIla57lewmNOEgTv8/tM8+mMlKooZUGYsYJA1t6EbTBHBcgiRkYUUX+eeKNoB0w9Ak+dqOgr/vFsNArIDKg==; s=purelymail1; d=purelymail.com; v=1; bh=AXF9cdA1CwF93jNh3xMWgaFJkaU8DlZm7oAn0MJOadQ=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1882165534;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 12:10:45 +0000 (UTC)
Message-ID: <286f8e83-1b19-4704-8be1-090772791d8d@malon.dev>
Date: Wed, 5 Aug 2026 20:10:40 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, five231003@gmail.com, hariom18599@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260715011850.3181131-1-cat@malon.dev>
 <20260716072954.582235-1-cat@malon.dev> <anGhtfPaGK7v3NNR@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <anGhtfPaGK7v3NNR@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,

On 8/4/26 16:24, Patrick Steinhardt wrote:
> On Thu, Jul 16, 2026 at 03:29:54PM +0800, Tian Yuchen wrote:
>> The global variable 'fetch_if_missing' controls whether a missing
>> object check should prompt a lazy fetch from a promisor remote.
>> In order to continue the libification effort, move it into
>> 'struct repository' and initialize it to 1 by default to keep the
>> previous behavior.
>>
>> Note that in builtin/fsck.c and builtin/index-pack.c, when running
>> related commands with the '-h' parameter, the 'repo' pointer is not
>> passed in. To prevent null pointer dereferences, we defer
>> operations on the repo until after parameter parsing is complete.
>>
>> Additionally, update the partial clone documentation to reflect
>> that this is now a per-repository flag.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>
>> Change since V1:
>>
>> - Following Patrick's advice, use the_repository whenever possible
>>    without re-introducing #define USE_THE_REPOSITORY_VARIABLE.
> 
> It would be great to include the range-diff compared to the previous
> version so that it's easier for the reviewer to spot what's changed.
> Tools like b4 automate this for you :)
> 

I see, I will include it in the next reroll!

Thanks! yuchen

