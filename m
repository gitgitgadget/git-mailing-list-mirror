Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718E1428A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="t0cH8bPM"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687FB7
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697227978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLDa1VU6sX3zrukVOBB19BNH6lBVcU1C0UGmTTwth2c=;
	b=t0cH8bPMU9+3H4BtiWtFCTqP+fgphhlTis0bY+mgX0OjPhuiQgFhg7vSRvd7GMvsq3wj6W
	ny8R/TuArUqyjpabPJhMOK9d3rWI1Npy6OSUDP+KncV4zqeoYUBTYV0ddU2Lx9YOyYolAe
	zh/UM/mAJe+2Tz0UykPb9zEFVZnVeAnaZmYmLlpQc25cjkCfcFcc1nMNEFKjhFNwcmq+yh
	SYKGdrmw+j5W82uI9zRolqmULa7agItGxmLZe9tW5MdwuC8jclBP7pBHQNk7NynKzgneVI
	5kVBYjT2EnC3Z44GAkVSEDW/+kkxJ+ZOb+67y+PDrP/4bnU+spWa2okoV6e1zQ==
Date: Fri, 13 Oct 2023 22:12:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Christoph Anton Mitterer
 <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <xmqqr0lzhkzk.fsf@gitster.g>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g>
Message-ID: <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-12 18:19, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Please note that dropping "-X" and leaving "-F" would actually
>> introduce the inconsistency that I already mentioned.  To reiterate,
>> short outputs would then remain displayed on screen, while long
>> outputs would disappear after exiting less(1).
> 
> Good point.

I've been thinking about this, and a rather elegant, backward-compatible 
solution is possible, but it requires some improvements to be made to 
less(1) first.  I'll reach out to the author of less(1) and propose that 
new feature, and I'll let you know his opinion about it.
