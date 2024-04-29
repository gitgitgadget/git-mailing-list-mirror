Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5F8627D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412536; cv=none; b=HORlKajs/gtLvjSSRTQR9vERyFSszIycz/AlegJfUYD8qzgIg+9WxzGNFMkv27zCiNfaPk9XwRsDRyoL1rYg19PPijXrLyVMHfumCMG5DNH39eWE7sK3ZDlZeyIR1HXYn3cJsnb8+Rq9aLGce5/W+y1e2NFpKAIoY50/OP6dVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412536; c=relaxed/simple;
	bh=opRoQmhkhs8B61aQwP27Zc7Et+BvSD4vUKaduR0pey4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S44Np5eA9jkpvFx5j+j58vj07k8QL2p1QhM/hjMrGYJhKE5k8MhDkS7H1RW9IhlE9N7ub0Kt1JU0PYpOHfc6YslzSKbX2sbKpE9heo3OybNExiFeZZsy2BvZ3ykkaUv9ObJYk7NMtLFMBJ5mGfZVpoP2tuQd/t7yZJXG+O4sOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1s1V11-000000005iu-1dji
	for git@vger.kernel.org;
	Mon, 29 Apr 2024 19:42:11 +0200
Received: from [10.20.10.230] (port=36100 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1s1V10-006i8k-0r;
	Mon, 29 Apr 2024 19:42:10 +0200
Message-ID: <d2d5bbfc-d2bb-4112-a12d-f19950125cb5@drbeat.li>
Date: Mon, 29 Apr 2024 19:42:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
To: Junio C Hamano <gitster@pobox.com>, Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240429164849.78509-4-dev+git@drbeat.li> <xmqqo79sulqh.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqo79sulqh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 29.04.2024 19:23, Junio C Hamano wrote:
> "Beat Bolli" <bb@drbeat.li> writes:
> 
>> diff --git a/color.h b/color.h
>> index bb28343be210..7ed259a35bb4 100644
>> --- a/color.h
>> +++ b/color.h
>> @@ -112,7 +112,8 @@ int want_color_fd(int fd, int var);
>>    * Translate a Git color from 'value' into a string that the terminal can
>>    * interpret and store it into 'dst'. The Git color values are of the form
>>    * "foreground [background] [attr]" where fore- and background can be a color
>> - * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
>> + * name ("red"), a RGB code (#FF0000 or #F00) or a 256-color-mode from the
>> + * terminal.
>>    */
> 
> Good.  Hopefully we do not have such extra 0x in our end-user facing
> documentation?

No, this was the only '#0x' I found. config.txt is fine as per the first 
hunk.


