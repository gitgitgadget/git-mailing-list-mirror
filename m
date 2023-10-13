Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73222B5EE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BzO6USXx"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FE83
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:32:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B92571A984;
	Fri, 13 Oct 2023 16:32:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J4gG4MOWMvTBcZCVDbneMv5hLqjQhC3XOjUybH
	kHAzg=; b=BzO6USXxcJeSEquq58xWOz6jJHvv2lV31C9+uOuSPU7dqxujp8Qe4G
	bOmCifa5lq6eZaYMWXrpO2bO1/sCXECyAGtQhFV5T7U3Ak7fN89JzQ6vmOOR9TWx
	0sPqQi9yNVj5d8zYu0fd/fmEGXEkMkagEAyoKOUYBhHLqNYyT0cCc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B14C01A983;
	Fri, 13 Oct 2023 16:32:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D57141A982;
	Fri, 13 Oct 2023 16:32:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jason Hatton
 <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
In-Reply-To: <ZSmmD5sz7TPWCGRd@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 13 Oct 2023 20:18:23 +0000")
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
	<20231012160930.330618-2-sandals@crustytoothpaste.net>
	<xmqqsf6f312s.fsf@gitster.g>
	<ZSmmD5sz7TPWCGRd@tapette.crustytoothpaste.net>
Date: Fri, 13 Oct 2023 13:32:21 -0700
Message-ID: <xmqq5y3az2ju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D25FA0E-6A07-11EE-814A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-10-12 at 22:52:59, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > +	fd = open(argv[1], O_WRONLY | O_CREAT, 0600);
>> > +	if (fd < 0)
>> > +		die_errno("failed to open file %s", argv[1]);
>> 
>> contrib/coccinelle/xopen.cocci tells us to write this simply as
>> 
>> 	fd = xopen(argv[1], O_WRONLY | O_CREAT, 0600);
>
> Sure, I can do that.

Unless there are other changes needed, I'll handle it on this end.

Thanks.
