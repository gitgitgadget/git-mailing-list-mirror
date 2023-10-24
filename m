Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCE208AB
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="szQZe7fp"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459F109
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:17:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A8392D16B;
	Tue, 24 Oct 2023 15:17:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=74WJsuBxB0GOiM5dfvvHDVL8e8uFkLY3goB1+z
	IFCjk=; b=szQZe7fp8TFCPn9wAqiaJgY33ldFILfW25u7Iqq8YErpOB9H80IRkQ
	ICjraAJjgn5NhAwM5oI0sDXkALrDRDAFitt1dhxDXG26ODm5v9DmPPn7ajfwLW1B
	IdQ7XWiSRQGNhIjGkp1jEH3QwFDcGPTbJTvH74u4uVTd5KStYYcD0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 247772D16A;
	Tue, 24 Oct 2023 15:17:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4B802D162;
	Tue, 24 Oct 2023 15:17:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Han-Wen
 Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
In-Reply-To: <cover.1698152926.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 24 Oct 2023 15:10:36 +0200")
References: <cover.1698152926.git.ps@pks.im>
Date: Tue, 24 Oct 2023 12:17:21 -0700
Message-ID: <xmqqttqf3k5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5672AEC-72A1-11EE-8242-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces a new `--exists` mode to git-show-ref(1) to
> explicitly check for the existence of a reference, only.

I agree that show-ref would be the best place for this feature (not
rev-parse, which is already a kitchen sink).  After all, the command
was designed for validating refs in 358ddb62 (Add "git show-ref"
builtin command, 2006-09-15).

Thanks.  Hopefully I can take a look before I go offline.

