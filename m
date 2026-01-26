Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D951A3178
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455056; cv=none; b=RjnVt93WFNgWYi25JALF8SN/dL+Ov9s/4PU3MYBXsDBfu5+tWjDH8qxULY3D56/5jkT2wsmq+48DoTdBh9K1IxGrOzwVmgAnfT2c2ANlfrRlVRADHZHI7hykZEPwCWs6TFGVEsMAHv0UHM9z0T4jZP2R6OCIVzF4VRhQaN3mE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455056; c=relaxed/simple;
	bh=XJbtPyEQ3w0W4aIk9P99Q9Hlyz4o7yIPQPS8mZPvUqI=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=utzQu21s6stdJ+pBB0U3+RIHGM5lmkDKiwgmzdFOQ+XzQQnfYFu3hrQPKkO6cD6M8/YU5epFq9m4V/FLUghuI8I+du3RyS1Xja1wfL9bQFxHyjEgm6/Np+H6CGvpvDwLfs7nzfho3sQZ7oteK67YVygewsXQfe8PfnO+7kD4lXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1vkS0e-0009Gc-Hn
	for git@vger.kernel.org; Mon, 26 Jan 2026 20:12:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] u-string-list: add unit tests for string-list methods
Date: Mon, 26 Jan 2026 11:12:18 -0800
Message-ID: <xmqqldhki3xp.fsf@gitster.g>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260125201500.63904-1-amishhhaaaa@gmail.com>
	<xmqqpl6wkftw.fsf@gitster.g>
	<CAPvEtrcLrrRhOi2OCaQzD6xNSHbyv38cr5-WLRPg_HGW5UKzAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:2pOrBKnzVs7sl8/U8QGjnPVu4i4=

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

>> > +     for (int i = 0; i < strings_to_insert.nr; i++) {
>>
>> As strings_to_insert.nr is of type size_t, even though int is plenty
>> large enough in practice, the compiler will complain.
>>
>> > +             string_list_insert(&list, strings_to_insert.items[i].string);
>> > +     }
>>
>> Also, lose the {} around a single statement block.
>
> Done, Thanks for the review.

Heh, that wasn't even a review but a knee-jerk reaction to compiler
warnings.

