Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1363A8EA
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="diCAtogL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C9D22368CC;
	Tue,  9 Jan 2024 12:16:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iEvOL2dtCjNHq/NuFEg5qCULHMD56XJ3jxCqi0
	0rPEM=; b=diCAtogL6nDtmK6wNgBc+X9hFBM/8Hq+8YEm4FrdkqAao9uqjxa55u
	6L0Y8Xr4lXq6Wwcri9kxIUs9J9RpcPgHyAq0OJPuy4fXahxF9Izb3ENhUWR24hSo
	88rbiUU8dN6JaQ7nWrjPKevrr0jyIslk+xaQKd8RvM8IL/MbS1Sf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2506368CB;
	Tue,  9 Jan 2024 12:16:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E529368CA;
	Tue,  9 Jan 2024 12:16:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nathan Manceaux-Panot <fresh.tree3651@lemon.garden>
Cc: git@vger.kernel.org
Subject: Re: Analyzing a corrupted index file
In-Reply-To: <29D15110-E308-475F-A722-1CDD448CACDA@lemon.garden> (Nathan
	Manceaux-Panot's message of "Tue, 9 Jan 2024 15:42:13 +0100")
References: <B38C5D82-33E3-4D10-8119-7E0D59DD3DA2@lemon.garden>
	<xmqqh6jnk3i8.fsf@gitster.g>
	<29D15110-E308-475F-A722-1CDD448CACDA@lemon.garden>
Date: Tue, 09 Jan 2024 09:16:43 -0800
Message-ID: <xmqq1qaqjukk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD7319CA-AF12-11EE-BB4D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Nathan Manceaux-Panot <fresh.tree3651@lemon.garden> writes:

>> On Jan 8, 2024, at 20:51, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> "git ls-files" with its various options is probably the closest, but
>> even the command is not meant for "debugging the bits"
>
> Thanks for the pointer. In the meantime I've started to make sense
> of the binary representation, against all odds, so there's hope
> for me there!

Documentation/gitformat-index.txt may be a good place to start, of
course.

https://github.com/git/htmldocs/blob/gh-pages/gitformat-index.txt

