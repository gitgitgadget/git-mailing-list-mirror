Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15827E
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcHmo4WP"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D791
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:29:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CF1302EE6E;
	Fri, 13 Oct 2023 20:29:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=px56WSs+ODlgeOCN1yFId7A5xGiJsxxLj0MqTb
	QrSL0=; b=fcHmo4WPuyYKnbKhgFr/rE7WTNSR6pMLDBrE4QLjSuI6HDThMk4PmJ
	dc0zrPxjjuxM3d2RBNvTQlO7WUQ6SpkyDR1gFvVXKAJ2wFzFH75s/uPqdR4Tn5Uj
	J3luaJ+TSwkyTRf7xGdhx6qhdsHsswDQRLrKNMPqNdoDaoRNhgN4A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7A832EE6D;
	Fri, 13 Oct 2023 20:29:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 021672EE6C;
	Fri, 13 Oct 2023 20:29:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Feiyang Xue <hi@fxue.dev>,  git@vger.kernel.org
Subject: Re: [PATCH] Add x64 SHA-NI implementation to sha1 and sha256 in git ?
In-Reply-To: <ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 13 Oct 2023 21:05:26 +0000")
References: <20231012200447.3553757-1-hi@fxue.dev>
	<ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net>
Date: Fri, 13 Oct 2023 17:29:47 -0700
Message-ID: <xmqqil7axczo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C881EA48-6A28-11EE-9EAF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If we ship the code, then someone has to maintain it, and I don't know
> if we have any assembly experts.  We might also have a bug that produced
> incorrect results, which would be pretty disastrous for the affected
> users.  It's much better for maintainability if we push that off onto
> the cryptographic library maintainers who are much more competent in
> that regard than I am (I will not speak for others) and let distro
> maintainers simply link the appropriate library, which, as I said above,
> they're already effectively doing.

Thanks for a well reasoned response.  Very much appreciated.
