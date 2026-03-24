Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842E2737E0
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379990; cv=pass; b=ZpmcOC205OcUA17T16nyJDqq9a7jCdcw5MKTfv0G29SC+EFG+UdkBRxDqk6UzQYGlEZTmbrBDiFoTRxeb9KpXi3wLG8ERsSDaLjIVbCfEmuAE6pHRIx5P0WKbmPN6+SxRlc82aNvBWp6PX68z2v6/w2GatiJW+AXzXSfGFN0MMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379990; c=relaxed/simple;
	bh=soKCjUaNEqpWidbPlO4U/XOr/RkC7x/fGS+OZelAKmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GaIdf5Xn17Or4HUnJVQAE8SDqIKAyuXTE5sJRAWQryEHlWAwsFDkQ6bz5g/2ZY34wz3bFEJNdBxPGobjGImGjGyES/VvgmCA9TdY4p1/ZY7JGBIZk2kj7g/PuP10x43h9Tbq6w83aeiZGUBYM81m0hcHtOxtImAQVMqF6i9/tVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GoIa7Za3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GoIa7Za3"
ARC-Seal: i=1; a=rsa-sha256; t=1774379972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0JLsgeS0IYsRcOLWCY189E1pOFLDEpKyqPQqTA7srlpEnDC2RCsrQHoE4oF2OXpTgRi6Qk006VBq52Egai9W05tx1+AQzFi1EggEcaL9HV95Mbe+I6CGp4yObzO+Y+NG8pfUuX1JkAXIkFZouVWe6UQaT0jb2RvlRmZukjgGZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774379972; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aP7vvD7TrpV4ESI9an3LnV3MBmTe+IhuQQPAXpJkpjo=; 
	b=MFqVMnj9XI9QlsH9eKOwe0t4uqNsedwYr1uRWlqEmK+O3bPWGjZo1/GVuz3Q/avtNvGMFc+XiNtZvVoNjoTi1VfGU4YlK4u6fQdApRL3wg4RFFoAp3BMmPmr1aX2GW9p22a1MVzyUJrzuuy2KvcjHTjGpEuZ53XSLgsC5n8T84k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774379972;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=aP7vvD7TrpV4ESI9an3LnV3MBmTe+IhuQQPAXpJkpjo=;
	b=GoIa7Za3bVPadtKHcHnoo6IZFzCZnLGYZVS/yBsx32PEE6cdn6CzrFeSZm/4sJcA
	YEODR9DBrxaa+2hWrT+zyisTyIlRaqbXViMTw5GNVEyuxX1X28kkmpAfk/vKrIbdxAs
	VjiIpxbedST8hUX2HS6AfnCP9GLt74DWkqLhISL0=
Received: by mx.zohomail.com with SMTPS id 1774379970385622.0001661506083;
	Tue, 24 Mar 2026 12:19:30 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] hook: fix minor style issues
In-Reply-To: <acJNW0m2wHfRStqY@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-3-adrian.ratiu@collabora.com>
 <acJNW0m2wHfRStqY@pks.im>
Date: Tue, 24 Mar 2026 21:19:27 +0200
Message-ID: <87h5q5c9xc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 01:52:03PM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 83020dfb4f..e641614b84 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -5,8 +5,6 @@
>>  #include "gettext.h"
>>  #include "hook.h"
>>  #include "parse-options.h"
>> -#include "strvec.h"
>> -#include "abspath.h"
>pp
> Another thing we could address while at it is to sort the headers
> (except "builtin.h" of course). Feel free to ignore though.
>

I'll fix all the nits you pointed out in v3, no worries. :)

<snip>

>> @@ -928,7 +929,11 @@ static int run_receive_hook(struct command *commands,
>>  {
>>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>>  	struct command *iter = commands;
>> -	struct receive_hook_feed_state feed_init_state = { 0 };
>> +	struct receive_hook_feed_state feed_init_state = {
>> +		.cmd = commands,
>> +		.skip_broken = skip_broken,
>> +		.buf = STRBUF_INIT,
>> +	};
>
> Interesting. The buffer here isn't only a style fix, but an actual bug
> fix, isn't it?

In theory yes, it's a bug. I'll fix it in a separate commit.

In practice there is no difference because this is passed to
receive_hook_feed_state_alloc() which creates "copies" for each hook and
properly initializes each copy with strbuf_init(&data->buf, 0);

(The differnce is between .buf being NULL vs pointing to a static array
strbuf_slopbuf with one element containing NULL )

I'll fix it anyway and explain in a separate commit to avoid confusion.

Thanks for spotting this!
