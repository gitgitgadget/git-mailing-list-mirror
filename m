Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ab+sk+XN"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA61A9
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:13:12 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AA7F1C1F0;
	Fri,  8 Dec 2023 16:13:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qCVkO/dToR1YZ3WSGMFri+kzMWUFISZrzEFPw1
	CfEDA=; b=Ab+sk+XNVWv7B8X2/eNsfzJWgwpCyZBfD79MAi1ip2HVX89FfYU/04
	RoBlrLEc0NfXU+t7mQsusKIb/ZVwi+YUUxQXX4IRYvglq4GWzyMbYXT5bAVJrtdT
	REpj7iuCoJ1jom/EK2I2TGWFrNAr2iAx6GNpM9O1LVZqhE650aLR4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 62B3A1C1EF;
	Fri,  8 Dec 2023 16:13:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 049481C1ED;
	Fri,  8 Dec 2023 16:13:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Joachim B Haga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Joachim B Haga <jobh@simula.no>
Subject: Re: [PATCH] gitk: add setting to hide unknown refs
In-Reply-To: <pull.1619.git.1701695899635.gitgitgadget@gmail.com> (Joachim
	B. Haga via GitGitGadget's message of "Mon, 04 Dec 2023 13:18:19
	+0000")
References: <pull.1619.git.1701695899635.gitgitgadget@gmail.com>
Date: Sat, 09 Dec 2023 06:13:07 +0900
Message-ID: <xmqqil581jq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 964C3E90-960E-11EE-B804-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Joachim B Haga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch adds a setting to gitk to exclude all unknown refs - which
> is considerably simpler than trying to honour the `excludeDecoration`
> pattern.

"This was simpler to implement" is a one-time cost savings for the
developer who added the feature.  For that one-time cost savings,
all the current and future users will pay the price of inconsistent
behaviour between "gitk" and "git log".

It does not look like a good trade-off.
