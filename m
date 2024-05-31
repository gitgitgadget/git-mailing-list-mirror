Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7355E4C
	for <git@vger.kernel.org>; Fri, 31 May 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176219; cv=none; b=J4bwrgTmZuIJH7Ox+8sdzM7D5PylokSeG2Xi6Q8YvdLL8tngRoEJ1p4DO6rh4fPA+2GKTPQRW07N5uJ9EXi1enG/KJ5nudMn6ZjUicC185RpL91wyQlzhOaUK/HzfKUIMYS6oB8hB9EzGBAaZdpjfJQKBMVsv7b8c9yxynhZDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176219; c=relaxed/simple;
	bh=05ou7BMG5xrqgwUIXvKjpB/BSZRzrtFEgytjo2CfHu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHzXj0TyWNkjM3q16rROay+GSkNDmJzQWGfwvAhjywL+3efYTOYRlI+4fW263deX6blgfR4mv/idPp3RFiWAkzwdOjxmXNaqdmXJoPfveDgzODbUxEvrqZRVI/XEBiKYOJ0d+0rsdMsc3hSdofr5E7En1FVSiVib1AZjAh6pkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e36WtuQI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e36WtuQI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 12F4C1B5A1;
	Fri, 31 May 2024 13:23:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=05ou7BMG5xrqgwUIXvKjpB/BSZRzrtFEgytjo2
	CfHu0=; b=e36WtuQI0Z0BB66NTSKR/7i5C4rObtI0YHMwOiCe4sOlNwIEtfTlNo
	JT9h4CDDXAKkefLylUbQWd0FTufXCmCp5+fd9hmEluDBJowH4mTS6Ilv0K9rgXNk
	ucFgEK81xhJPNDLVNNwV/L/gOo3xOKzOXSN6fAAP9xV9QXC1wkqGQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B6AE1B5A0;
	Fri, 31 May 2024 13:23:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B60071B59F;
	Fri, 31 May 2024 13:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rjusto@gmail.com,  sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <35f5633ebf263ec743d673770eb86487@manjaro.org> (Dragan Simic's
	message of "Fri, 31 May 2024 02:49:55 +0200")
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
	<xmqqy1811qkx.fsf@gitster.g>
	<673887a14c4f74deb4ef7771a331689b@manjaro.org>
	<35f5633ebf263ec743d673770eb86487@manjaro.org>
Date: Fri, 31 May 2024 10:23:31 -0700
Message-ID: <xmqq5xutgajw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8149C39E-1F72-11EF-B771-8F8B087618E4-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-05-22 23:34, Dragan Simic wrote:
>> On 2024-05-22 23:31, Junio C Hamano wrote:
>>> Dragan Simic <dsimic@manjaro.org> writes:
>>> 
>>>> 1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that
>>>> interactive.singleKey is disabled by default
>>>>     @@ Metadata
>>>>      Author: Dragan Simic <dsimic@manjaro.org>
>>>>       ## Commit message ##
>>>>     -    doc: note that interactive.singleKey is disabled by default
>>>>     +    doc: imply that interactive.singleKey is disabled by default
>>>>          Make it clear that the interactive.singleKey
>>>> configuration option is disabled
>>> Heh, "note that" would probably be better, as we are going to say
>>> "Make it clear" anyway, no?  That is stronger than just to imply.
>>> Keeping the original version of the log message probably was
>>> sufficient.
>> Yeah, but I felt like it needed some adjustments, because the patch
>> itself was actually changed.  I hope I won't have to send the v3
>> because of that? :)
>> 
>>>> +	When set to true, allow the user to provide one-letter input
>>>> +	with a single key (i.e., without hitting the Enter key) in
>>>> +	interactive commands.  This is currently used by the `--patch`
>>>> +	mode of linkgit:git-add[1], linkgit:git-checkout[1],
>>>>  	linkgit:git-restore[1], linkgit:git-commit[1],
>>>>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>>>> 
>>> The resulting text reads well.
>>> Nicely done.
>> Thanks.
>
> Just checking, is there something left to be addressed for this patch,
> before it can be considered to be pulled into the next branch?

Thanks for pinging, as these small things were on the back burner
while preparing for updates to maintenance tracks.

Apparently v2 cannot be pulled into the next branch, and I forgot if
I saw v3 already.  In general, unless I explicitly say there is no
need to resend (sometimes with conditions), I'd expect an updated
iteration sent to the list.

Thanks.

