Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05513D87
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hESefiD+"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1206D53
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:48:21 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2641B1C8ADA;
	Mon, 13 Nov 2023 19:48:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SyNlT/Utny+v2fH6Yodlh8mt8Ls5dLTht3o8ss
	Ow7jk=; b=hESefiD+QbPzDBsY52O+bohs8JOLDHotVZAX1hq4z/Z7jAE/nZ5k26
	IkbcsUoW63axpM2/spLqN/PrRXT6aZ9XWgP/4Wcop2D5I8tK0KKHwMXtS1a09Zxl
	amxFot4zcKnsuXgSvJnQYqABHsMZTf4xJcILzpTmUA8oNpGIwZOwE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D6D91C8AD9;
	Mon, 13 Nov 2023 19:48:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66A8E1C8AD7;
	Mon, 13 Nov 2023 19:48:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  pclouds@gmail.com
Subject: Re: [PATCH] checkout: add config variable checkout.autoDetach
In-Reply-To: <0e37ee23-922c-4bbf-82c3-8f44e9216ab0@gmail.com> (Phillip Wood's
	message of "Mon, 13 Nov 2023 15:07:15 +0000")
References: <20231111224253.1923-1-andy.koppe@gmail.com>
	<xmqqbkbzo6ba.fsf@gitster.g>
	<0e37ee23-922c-4bbf-82c3-8f44e9216ab0@gmail.com>
Date: Tue, 14 Nov 2023 09:48:19 +0900
Message-ID: <xmqq7cml2m98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 81C49AF2-8287-11EE-993D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> and good thing to help new users.  I do not know how others react to
>> this kind of proliferation of configuration variables, but I do not
>> mind this particular variable existing.
>
> I'm a bit wary of having a config variable that could break
> scripts relying on the current behavior of "git checkout".  As far
> as "git switch" goes I don't particularly mind this config
> variable though I'm not sure it is that hard to type "--detach"
> (especially with tab completion) and

I do not have much sympathy myself to scripts that are not being
defensive enough to write "--detach" explicitly, but I do understand
and share your concern as the project maintainer.

> ... I do worry that we're making the UI more complex each
> time we add something like this.

Thanks for saying this---this is exactly the kind of reaction I as
expecting to see.

>
> Best Wishes
>
> Phillip
