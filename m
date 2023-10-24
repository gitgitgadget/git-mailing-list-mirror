Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290B210F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="J6a3qgix"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C6FB9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698114077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vovglcxlXyD+k8Dw2DrJY/Yu+Cag8DGFi7WG3kICmo=;
	b=J6a3qgixQ8EsY5/RnQr2K8gCF6ktp1vOAQvUWHPKL8rxT+t6fUgsh6oC6cd+bAncmPX1um
	xnZxIsiaKmppuufwAwm11ILjtd85cJuo8PWYkVg2iC9U7/G/g5G4HhwTQkhWEI00289Pn/
	rLRJBiDHocOxUmmCcO0gEP8kPeiG6ohstNtDt1Y0ZL55XycHIwUAdaozm1N1D0XqnytQp+
	mIheEVoki0nsGf89BCvCKHegB2kPJNQT3nOqRWQj8TwDkzyQFdE4ccrdbyEjdDKN4d1ioA
	kzsJ0Nsex9RZhX3P+PCsSG0/v+7iEfXWcOnqkNb46U0TpqRWvi3VcrzNK8e6gA==
Date: Tue, 24 Oct 2023 04:21:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <xmqqil6w6al3.fsf@gitster.g>
References: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
 <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
 <62164acf4a787042dbb6e5abe212559b@manjaro.org> <xmqqil6w6al3.fsf@gitster.g>
Message-ID: <8d45763bb4fa4c7d1e1f69dfaf93e647@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-24 04:03, Junio C Hamano wrote:
> I think the "use more verbose report format to help relatively
> inexperienced folks, in exchange for spending more screen real
> estate" is a good direction to think about this thing.
> 
> I am not personally interested in adding such support all that much
> myself, but one piece of advice I can offer those who are interested
> is not to be too deeply attached to the word "table".
> 
> ... snip ...
> 
> So be very careful when choosing what to call this new thing, and
> avoid naming it after the implementation details (e.g., in what
> particular shape the data gets presented) that may turn out not to
> be the most important part of the concept.

Totally agreed, "table" simply sneaked in and remained here as the term. 
  Perhaps "<command>.verbose = extra" or something similar would be a 
good choice.

> [Footnote]
> 
>  * FWIW, "git status -s" is a tabular presentation.  Maybe we can
>    add a more verbose form of "-s" and be done with it for the
>    command?

That's also an option.
