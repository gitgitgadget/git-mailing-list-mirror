Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3E4E0B8B
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009868; cv=none; b=JqmGUDkn6oPNGWzyeY2iYxU7CVdfB5J4CLmg4CCCvlWCuDWPyRI4F7Cy2SaFTFubrwL/LYuK/UDimvTPpKdkPRTNmzxlu5MPw4oFY1DajbUBuTtWFp3HGGU+4aXhudlFaZNIyOqjWyYoB+Y4B2zeWx86ejPbutsYbjM2ZSkncpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009868; c=relaxed/simple;
	bh=0QYmk3FyTw7pUCW5/lVCnTR4M0OSgiwWN/HUyR+fbPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZ/zd8X81ZVNkLdLadvasF1FGPgFFs3eDMqGLr5qNF+NgToeEQnjz/Y2IbEdT9koux784Gl/ZkHhoeo8zw3A3HuMu5WjOnlJlaUTxR+qj13cApkTS7P78e/5aiwNiKd7rBuzdoI5UP/tAQssaAf8xSB7pd5Wk9SVnefo7XYAe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uXTsfxlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9iSqSYp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXTsfxlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9iSqSYp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C25A9EC0249;
	Mon, 21 Sep 2026 12:57:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 12:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790009863; x=1790096263; bh=sZ4DtqhFnS
	FW2Xi0Kpodc7F/DxkOgh2SWFb8Hph+DdM=; b=uXTsfxlLutNxsWxwO5AOUOIifp
	jtHL/oZoEnE/Ug8eyeyeg68EQMBHyB+LRtoqK/2NpQQ1GJqiSdzdgOfRWVOPkfut
	d6RZ0QzDb5aYzsp0pT6ZcXbnxn0WEPyg50X9zFRlTDn+kfcAqhO7RGWCc4c0eH0G
	GVuvWDrkD6fnMSSZKlis8lQ7qWMqjFyY8eqYBnXROvaOZBFNESuBXOUo4mBIqdX6
	EMirU5vLWPQqmVCJ2ZU79Ys6j7W/P7Pd325sqBrxgXsLCeDrz3fjOdFDoIpW3atq
	2W3B6w+MgYnjtIumyBx8VhrFAm3nDkNn4URa0gttH34F3NM079Wn4RKcnCfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790009863; x=1790096263; bh=sZ4DtqhFnSFW2Xi0Kpodc7F/DxkOgh2SWFb
	8Hph+DdM=; b=g9iSqSYpkHpWKkB0I1YEtCzlbsSLqQZ/I5SxSRDWke1Qq7YKYrj
	1UFsP+/+P3ggBuLFT9TZFEBam4P1p+WidoMBobSZ6YV7idpYPb3JTAbYs187eZqk
	w7Nr2C7gf6Xq78X+9aL6ci8AUf02L8GhptRmBlSTZuyWg6vKA+ZOsxQE/8aRcK6y
	rKqD4B4QpecrQ/QJiwADNnYIuCFf9E4vvM4g7iVN7HTOuXGMon41MLahtgCvGlyl
	BNPIESY7QgF4zlN/65EgBVga1ZtxofAtigsiySctgKHQ9mF+LkEIpIV3hjHUXb63
	5O4QUkVvJgWfE3MF1IUvSC9tjSY90cRhPgw==
X-ME-Sender: <xms:B2KxaqcmzfecYYuYou1-ZEd8mkewR0eFlHIqa_b05EnNi1565LROrA>
    <xme:B2Kxarp22fj1eGCG2UA2ZPaRLnPTwQTe5xfHXYZCBEH88VwhOdiatw4c4LgKUo9uy
    BPIMsBCAu3eRKRi7OHmMNOIQGNGdm82PAUY1z_QhZwXBl6_1KdF5-Q>
X-ME-Received: <xmr:B2Kxao6xOEmtJFtr6BjfTG3QuFG-Sts_aU3mPjc3YfYL0lXTtQZSpKfAJHtMGFU0mnr80BCzbczl2_lD7GEV2S08vOFYSbJuEibz>
X-ME-Proxy-Cause: dmFkZTEJmsYJAu4CV7y7bCoOKAWCn3J/4K1+aPJIcJNQ1/EdTUP0PwbWN6XV69NqDxGPFr
    5xi+oD3tRbSfOjRim+CIeU1cf8wRLZ6DtSiIBR24JavdfrTQv5b6qEZ2Jx9+DyZfTXL2gx
    tmQzS+Yitd1/9t33zaghE1W5EEB2Lc9qGLFH/j8SBCtdf9toabMeR0CEj9kFKeMdAZeE7U
    Nfcmq7LUyWAz0hc91Ivixx5e69E6rkn/1JQvyyfao6xj2oVZSTmbLzJLWDo5ipIWQFbb1d
    bXk5fVXkPKzeulx8JEvTb9kP34AW3TmS9hDToqgLhoh6y3iRD9H+Lc2RyxfvycUt/M8/Lu
    169SVJwOIr+QCD8ROIlqULtNis1xD9A7lc6CP433p+o+doJ6PmZzUUcDQytMQO4PK4YeEp
    /k/n2L1Vsku2jrJVI8EyDYSBigmg+2PKMb4OAtan2vi+fpN2FzLprrikbyFt4jw3flWAGp
    e9Jg1C3YrS5aYSQVY35XU8/Slg/mMEBTpPmwN2hp603NWZQXXi3IxNXuHrD2D4QCUrYzKy
    JEJfSOtKbSiyN6vZIoXa8XEp6GaILmS7htFn9c7Tx1GuPQZjuZXwyK5i9nyF99pdcnNI4S
    1ZoyUeYPQNoHYt9ng0XP0hj4bgBrID7w7Ivu2y4S5zWNNrDxe4ItQK9529fg
X-ME-Proxy: <xmx:B2KxahqxW9gFdmFxsx6yUzaFzDwRw-PavUqxEHyJH5JVmiRd7tdQMw>
    <xmx:B2Kxaqg_gbrKJLTUCpp7fWtys9HcWywvI3M3sSbWhHXwIP0KKn-w2A>
    <xmx:B2KxarKLqvFXbAeeThXcSD8KJu16FK0As2OezQZlBNyQ3vEEl5rMoQ>
    <xmx:B2KxaqBwCrEcRdktboVLwHZZnb42DBvs4_w07EGQV8QpILNF8bgEMw>
    <xmx:B2KxanQU07uW-ACbde8Zr67gk2nSVmbju5J29zOthKF31xnfeKKsdurl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 12:57:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
In-Reply-To: <de116c51-b538-44b7-87d9-653b84a55088@comstyle.com> (Brad Smith's
	message of "Sun, 20 Sep 2026 22:10:18 -0400")
References: <aqthQ3u4eW1wHCn7@humpty.home.comstyle.com>
	<xmqqy0d0t2j9.fsf@gitster.g>
	<de116c51-b538-44b7-87d9-653b84a55088@comstyle.com>
Date: Mon, 21 Sep 2026 09:57:42 -0700
Message-ID: <xmqq4ifio83d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> On 2026-09-17 9:45 a.m., Junio C Hamano wrote:
>> Brad Smith <brad@comstyle.com> writes:
>>
>>> Enable Git to resolve its own binary location using getexecpath().
>> That may not be incorrect information per-se, but lacks critical
>> bits.  Natural initial questions that come to my mind are...
>>
>>      Why would one want to use getexecpath() over whatever OpenBSD
>>      ports of Git have been using happily?  Is the old way being
>>      removed?  Is the new way being more accurate?  In what
>>      situations does the difference matter?  Is everybody on OpenBSD
>>      able to use this new function?  Do only certain, and/or
>>      presumably later, verions of OpenBSD have it?  How widely is it
>>      available?  How long has it been available?
>
> It's a long awaited API for such functionality on OpenBSD. Otherwise there
> hasn't really been a means of doing so and one which has been using happily.
> The proper API I would say is one which works and is more accurate. One
> which works the same everywhere where as the pile of hacks has different
> results and not happily either.
>
> The API is new. The config.mak.uname check looks for 8.0 and newer.

OK, all of the above were missing from the proposed log message that
should be placed when v2 patch is prepared.  They've happily been
using argv[0] as an approximate (which may be OK as long as we do
not lie to ourselves but not as nice), and now they are going to
have a proper syscall for the information, finally.  You would also
need to answer the last few questions I asked in the proposed log
message of v2, but I thought 8.0 is not yet released?

Thanks.
