Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FC3D8102
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227418; cv=pass; b=MRyuT5HK4ju1Po4NQSK6DxuhpUekjokc2CXNi6UCxYy03g23Mj75I+fEBs9pCUyTAouHHkKx8EuXc89zi565GXez8bPuXeAQUndQLgukJPlwJ6YjDCWrfs6e6CtRfzh4khTJPKkwTsH3TQ8YTQ/CaQdEaXvO6ae2qHYnCU5/dtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227418; c=relaxed/simple;
	bh=Y629LDa8oHkaHI+KZKjk8r69tG9dRQpdii+64HB/Mok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhibaDMqd3nO5KG5FhqGPqmPKg7nigl0Ib26+8p+oHzgLvvElTyLZZ7tXZERhQNDGGTbkOS6s86hty96C/wMMM264hqeo8f1zZJcesgW+Clt1RFie5ywRyYH3PlQPwUaRNNq3KXSvCtZH850Aa9gtmiX5ZUI+26nMc3nvMk2x38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XWwCXAtR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XWwCXAtR"
ARC-Seal: i=1; a=rsa-sha256; t=1773227403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I0qBw4QwOCelQUUco96rnWnylfRlQ0Wz2L92pA7g3B0pCQRzRbNgyeLHDSXRLa2bznD4jrBywgmy7tUh7yLKPfsdCA06rZxc8rE/GgF8D2gF1SsOvaoui8Ce0v+HmF1cARfFmEIHbxLAg2MjgvsxY7z4o5O0xbHjq45eNU46pGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773227403; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A667y2/bRzdJBZQUgf8Gubpg9AMDTL7RBN98IIa+SY8=; 
	b=mSDkEy5/Nd4V16YEw1KKBpIwn4svVerGz/BrPLyY5WCp1rkRs5efnOsrhgDRiIHv5emE+ITCYOKHwu1lUNAsho7xT20vy828pjdX37rO0Wt123QO8CZkdhQMAyHrYy+EQ5OfLiT1uEEskbtyKQMu73cxkxhDoAhFPtjnx9TSiy4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773227403;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=A667y2/bRzdJBZQUgf8Gubpg9AMDTL7RBN98IIa+SY8=;
	b=XWwCXAtRislbjGuAnBN0FcIm+ct0M+ujjjNiDtMCwmWVovU+RMzVATQrZIjEhaiQ
	mljaFMYj16qFysVj/N3WY5GuCvPRmPp9jn/Y+NEWmFCgFHsXwtu/Rk/kNblR7yPqo+c
	pU8U1P7n8sn78I9XIo6BffCXfaro8J5x4S6vU1f8=
Received: by mx.zohomail.com with SMTPS id 1773227401620685.5255693575348;
	Wed, 11 Mar 2026 04:10:01 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 03/10] hook: rename cb_data_free/alloc ->
 hook_data_free/alloc
In-Reply-To: <abFC3ToqvzCZ25h4@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-4-adrian.ratiu@collabora.com>
 <abFC3ToqvzCZ25h4@pks.im>
Date: Wed, 11 Mar 2026 13:09:58 +0200
Message-ID: <87jyviaagp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 11 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Mar 09, 2026 at 02:54:09AM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.h b/hook.h
>> index e949f5d488..e514c1b45b 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -43,8 +43,8 @@ struct hook {
>>  	void *feed_pipe_cb_data;
>>  };
>>  
>> -typedef void (*cb_data_free_fn)(void *data);
>> -typedef void *(*cb_data_alloc_fn)(void *init_ctx);
>> +typedef void (*hook_data_free_fn)(void *data);
>> +typedef void *(*hook_data_alloc_fn)(void *init_ctx);
>>  
>>  struct run_hooks_opt
>>  {
>
> Ah, this here is also a small style issue that you may want to fix up in
> the preceding patch. For structures, the curly brace goes on the same
> line.

Ack, will fix this in v2 together with the rest of style issues pointed
out. Thanks!
