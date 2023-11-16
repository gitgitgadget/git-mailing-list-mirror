Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pbVI4xHL"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E6A4
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 18:53:07 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A4811E2C4;
	Wed, 15 Nov 2023 21:53:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jzC4Wjn1mmeVF8LOY3Z4UKvabRtvD+oqLCnbAo
	KBqkQ=; b=pbVI4xHLPrN0GPkvuaLwnApmUePYpxVGDK7z4XER14fKJYCXqDGhmk
	BBMiT9dQQlMFnxoPcyBYHniWWL4YQVAZZ6VQmRFrcYoEoJR5HVKcYs4nOe6TGiuU
	18qnJVcVtPC98fv7VmYTuHZpvLsPZNvj8gJZRNzUXahUIMiEPpqT0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 224DF1E2C3;
	Wed, 15 Nov 2023 21:53:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B37831E2BF;
	Wed, 15 Nov 2023 21:53:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Joanna Wang <jojwang@google.com>,  git@vger.kernel.org,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <CAPig+cSyrD71NMnfVCTHEf+K8vop9QHLet7uyOerrq=v9SVbFw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 15 Nov 2023 20:37:11 -0500")
References: <xmqqbkbx11x2.fsf@gitster.g>
	<20231114214934.3484892-1-jojwang@google.com>
	<xmqqy1eytrns.fsf@gitster.g>
	<CAPig+cSyrD71NMnfVCTHEf+K8vop9QHLet7uyOerrq=v9SVbFw@mail.gmail.com>
Date: Thu, 16 Nov 2023 11:53:02 +0900
Message-ID: <xmqqttpmtnn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42FEB7E4-842B-11EE-A93A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> A bit more idiomatic in this codebase would be:
>
>         git update-index --index-info <<-EOF
>         100755 $empty_blob 0    exec
>         120000 $empty_blob 0    symlink
>         EOF
>
> No need for `cat`.

Aye, of course.  We should not cat a single-source datastream into a
pipe.  Thanks for correcting me.
