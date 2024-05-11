Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D2366
	for <git@vger.kernel.org>; Sat, 11 May 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462998; cv=none; b=Ub4kICXxDG4V41pRRCBBZ8D8LZbFOzuQRz0FaaiYlE6A1ub1IH56ljJV9N1paOY7qibjiy2WEYKmgMHtDkA9bfVeojQVDvKSPSeSIfD1bWB8AGhN+PToauMxqC9gOYRamK2Vhit9jRiHznlJiWTwTlsa92UJjkKYixXXvER9Xj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462998; c=relaxed/simple;
	bh=pkmrhJoSh+/LE0ykAvQxThM+tNKhgqycYgNOcsK1x5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2qlI+7nXxAjS6a4ceWkFPga3u7N89QADl5CBzkIHvwax5xxbh3wczZHzdy7BL+IenquVt8C1J8nUq6Yxq5O09rYJP7EvijPVCRC7eLg5f1TeYb2vSf/JQet5uvLnn8Wh86zrO/afnAv+1qZkNh9qcvse4/6quChowx6nyG8kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wJweklO9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wJweklO9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DBEF420F29;
	Sat, 11 May 2024 17:29:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pkmrhJoSh+/LE0ykAvQxThM+tNKhgqycYgNOcs
	K1x5c=; b=wJweklO9A4srTkn5jP8mbk4+zIaEPY/ph4TX0f77sXxvaSG7aUVfjf
	zMbhTTmIfth1nnOnEYULa+UeELLhOYyA+90hfrQWgeIfmjR0QOoNFoU8PUDuNF6m
	nnrPU1BUVG1mwnkzaBUkZds1KFwxP+MvLVUXOHn8V5XyFgw3YcX2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D52CD20F28;
	Sat, 11 May 2024 17:29:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 690C520F21;
	Sat, 11 May 2024 17:29:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Git-GUI change of maintainership
In-Reply-To: <01502c68-718a-4fc8-9106-f930b4a24346@kdbg.org> (Johannes Sixt's
	message of "Sat, 11 May 2024 22:53:43 +0200")
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
	<mafs0r0eob610.fsf@yadavpratyush.com>
	<25c0ec11-4b20-4c78-ba77-8d10ca2ef21b@kdbg.org>
	<xmqqbk5c1eqf.fsf@gitster.g>
	<01502c68-718a-4fc8-9106-f930b4a24346@kdbg.org>
Date: Sat, 11 May 2024 14:29:46 -0700
Message-ID: <xmqqh6f4yr3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98053360-0FDD-11EF-A993-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Thank you. Please consider the following as well.
>
> diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
> index e8f3ccb433..f5b02ef114 100644
> --- a/Documentation/git-gui.txt
> +++ b/Documentation/git-gui.txt
> @@ -114,7 +114,7 @@ of end users.
>  
>  The official repository of the 'git gui' project can be found at:
>  
> -  https://github.com/prati0100/git-gui.git/
> +  https://github.com/j6t/git-gui

Ah, that is part of my tree, not pulled from you via -Xsubtree.

Will do.  Thanks.
