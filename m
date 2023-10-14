Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB718630
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJcWNBUP"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C4C9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:45:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 11F3721AE3;
	Sat, 14 Oct 2023 13:45:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EnNAHVXA4wXSrGtlpxMQbrY78P55hffM1ddid9
	ZOO+w=; b=fJcWNBUP6CqguwfVwsuIW1sp8wkElJprWhYLbGZ08AgtRIQBsuY6xI
	WUPL9ZNNEfr+/gE/19elvhxSffP/IAp3MIhTou8/MVIXzjbVNoJLC0DKwy+yxZ6N
	dptyS1wG6j2IuMqJSuCNfY6JnKQ7tHPlsS24XSppZatO4VConS91E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A20721AE1;
	Sat, 14 Oct 2023 13:45:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 941DF21AE0;
	Sat, 14 Oct 2023 13:45:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>,  git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <833da2d05d4b1dfa8e561aa638a927b0@manjaro.org> (Dragan Simic's
	message of "Sat, 14 Oct 2023 18:33:54 +0200")
References: <20231014040101.8333-1-jacob@initialcommit.io>
	<xmqq4jitw4nk.fsf@gitster.g>
	<833da2d05d4b1dfa8e561aa638a927b0@manjaro.org>
Date: Sat, 14 Oct 2023 10:45:41 -0700
Message-ID: <xmqqa5slt7wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F889922-6AB9-11EE-82F3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dragan Simic <dsimic@manjaro.org> writes:

> How about making the filename a bit shorter first, to make room for
> the additional two digits, so the example mentioned above would end up
> being named "git-bugreport-20231014-092037.txt"?

The reason I stated not to unconditionally add two more digits is
*not* that I wanted to keep things shorter.  I wanted to keep names
stable and in the same shape as before for sensible people who spend
more than 60 seconds---only those who produce more than one within
the same minute will be affected.

What is your reason to want to make the filename shoter first?
It would break everybody, wouldn't it?

