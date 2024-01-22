Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2033DB9E
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938904; cv=none; b=mElfaUxkh0ysrPhK80eaKblaWA8wDupOfNsUO1ePX2jazfFkZrtqxT9O1Wp9gI6/7RUsVMRuQOZzMpgZ9RVF6MuXkiIuThbVHTk5s/Io8MCZF6VKfztaKi/MvkQz+PSRdhEAneo4rkab99eWM1vMzsx3slIMAxRLISeyAQFsp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938904; c=relaxed/simple;
	bh=rwvP2LvqA9xnopzJ3/CPMyGdt2g9Lq8dLbW5++ctSgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPLY0dZe118ZuZHxN15X13c7ffarzRoYf9fYEN8Cumt/TdacevXGyXnO2H7Cshs9I/IzH8ul/yjzK0YAZ04qAIepzOR0SbyAfAR8FWOtxzQBOJyfTe8CbEVnXv1oG3DPBii3Cte4i4SlbGuTVxfmClhEZarWiSXRBmVz1ax3w1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i7M+Kr3N; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7M+Kr3N"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8396728EE8;
	Mon, 22 Jan 2024 10:55:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rwvP2LvqA9xnopzJ3/CPMyGdt2g9Lq8dLbW5++
	ctSgU=; b=i7M+Kr3Nm60LtL8jVfgueSghSn3m1Tc6lnXioAortcjsKt1lG5ta9/
	u8Uuzwkpcsh3nxiUgM5J8Gek9TnnGHjzpFGLzgHhea9LGT2EOYP4WaR9/GDPiD+k
	FbY3WMMFZcw+n3T2owsg/GkEnU1ijnmT8sQUSW3T4Bh3qOqC5qMNU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D2A928EE7;
	Mon, 22 Jan 2024 10:55:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE3D528EE4;
	Mon, 22 Jan 2024 10:54:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Git List <git@vger.kernel.org>,
  Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v6 0/6] support remote archive via stateless transport
In-Reply-To: <owlyy1cifwur.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Sun, 21 Jan 2024 08:57:16 -0800")
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
	<cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
	<owlyy1cifwur.fsf@fine.c.googlers.com>
Date: Mon, 22 Jan 2024 07:54:55 -0800
Message-ID: <xmqqwms1cqi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9724693E-B93E-11EE-9138-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Linus Arver <linusa@google.com> writes:

> This v6 version LGTM. Thanks!

Thanks, both of you.  Will queue.

