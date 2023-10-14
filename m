Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7118630
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YTqwm0jR"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF10AD
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697305952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUk0bE/VQkw43x5aRCD5nbT2qHkCz0XLnd4JEVYv5S4=;
	b=YTqwm0jRPNepb26eflJUk03f1opYa5s9o30ZW8HuwaOZ3U6ue/Dt3/tK4H9kSDAGJu2An9
	K4wPz4qT/Qu3Z9hPr8voKZB0SEadEhu29r6+xLs99QOIwKMSbpBV8E77Jj0kYqQN38zD8t
	1VwfeXDC1s/7pvNDfy0r7UPE1T6pnpGjGu8IvyYcOuknkRhVB4jQ89ExTGjD8l1Vmlibqj
	mi2gulM59CVQ2gVHQ3/MqUqvTqoQoGJ/js08/JZePsiEF0Yc35VcZfUXm4CI9ESoVspYL6
	t0SFFeKrQ0SvKtcwSTOuK1t9oP2wIbA8RjnXoxL7Vez6zDodc/XNPZstvdA5Dw==
Date: Sat, 14 Oct 2023 19:52:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <xmqqa5slt7wa.fsf@gitster.g>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <xmqq4jitw4nk.fsf@gitster.g> <833da2d05d4b1dfa8e561aa638a927b0@manjaro.org>
 <xmqqa5slt7wa.fsf@gitster.g>
Message-ID: <438a5edf1a17ffac201436a950ce50fa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-14 19:45, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> How about making the filename a bit shorter first, to make room for
>> the additional two digits, so the example mentioned above would end up
>> being named "git-bugreport-20231014-092037.txt"?
> 
> The reason I stated not to unconditionally add two more digits is
> *not* that I wanted to keep things shorter.  I wanted to keep names
> stable and in the same shape as before for sensible people who spend
> more than 60 seconds---only those who produce more than one within
> the same minute will be affected.
> 
> What is your reason to want to make the filename shoter first?
> It would break everybody, wouldn't it?

Please note that I haven't researched in detail what else depends on the 
current filename format, which presumably is a whole bunch of stuff, I 
just suggested this filename compaction because I understood that the 
filename length was becoming an issue.

Speaking in general, I somehow find "20220712" a bit more readable than 
"2022-07-12" as part of a filename, but that's of course just my 
personal preference.
