Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D8156E3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKk5p1/M"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEE9B
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:59:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B67222C95C;
	Sun, 29 Oct 2023 19:59:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ydcTV0CZX/btRwB1hF9HzC1Y9aywAUOkRMKSB5
	OkGrk=; b=EKk5p1/MEYFD1mtPbp2xGI7KuxBwROdw4W0OpFvqW0SMXXTB4Uaw+K
	wjEpUN3wfcm4n47vzbAU8RIvwzZttOq+9jrPPRHkldu6oXqWWJozqDQ8e/0jcKwz
	CMA+aE+hhVYF0fztxg7U6C4I3qmSXwi7bTaRVuDygujlLOMlPJfXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B030D2C95B;
	Sun, 29 Oct 2023 19:59:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F6732C956;
	Sun, 29 Oct 2023 19:59:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: emilyshaffer@google.com
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH v4 1/2] t0091-bugreport: stop using i18ngrep
In-Reply-To: <20231026182231.3369370-2-nasamuffin@google.com>
	(emilyshaffer@google.com's message of "Thu, 26 Oct 2023 11:22:30
	-0700")
References: <20231026155459.2234929-1-nasamuffin@google.com>
	<20231026182231.3369370-2-nasamuffin@google.com>
Date: Mon, 30 Oct 2023 08:59:53 +0900
Message-ID: <xmqqleblgeti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41FF587A-76B7-11EE-BFE2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

emilyshaffer@google.com writes:

> From: Emily Shaffer <nasamuffin@google.com>
>
> Since e6545201ad (Merge branch 'ab/detox-config-gettext', 2021-04-13),
> test_i18ngrep is no longer required. Quit using it in the bugreport
> tests, since it's setting a bad example for tests added later.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---

Makes sense.  Thanks.

>  t/t0091-bugreport.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index f6998269be..e1588f71b7 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -65,7 +65,7 @@ test_expect_success '--output-directory puts the report in the provided dir' '
>  
>  test_expect_success 'incorrect arguments abort with usage' '
>  	test_must_fail git bugreport --false 2>output &&
> -	test_i18ngrep usage output &&
> +	grep usage output &&
>  	test_path_is_missing git-bugreport-*
>  '
