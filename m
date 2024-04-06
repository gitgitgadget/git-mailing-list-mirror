Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA98A50
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382051; cv=none; b=AYHvI38U+XnAvzZrBK3t/jwScwHDWCdWWarw3MXntiAvpnnIBnByGUqEMt9yUJs7/tDR7YyRJk1hvqiWVxbe1HhU8Y1zcTAQPseE793xIXoITzjbgdXiO3Hc7n0hsA0/6T9ayjY9/FHYuwibs8whx+oa33MpgUcwl9v3ucRTIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382051; c=relaxed/simple;
	bh=K+bopggU+1MUHIWojrP6v/VXi6zfqEUAA05F581iILU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7QtAYMhDFv5BPGNz6U0rS0XLKx2TmfokMdzlfMSdsOPsEgY5G0MAHzK/WVhqjeEIAKr/5Pqy2/9HpxkqnN4htwZVwPpycEO4pw4yqPfPYT8X0Hhh3Io3wXK9BSrN+SaMAhA7n0rUgMfD6lvBX8zZo88qXapTohutCw1twTvRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tLIDJKqj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tLIDJKqj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C97B41F4645;
	Sat,  6 Apr 2024 01:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K+bopggU+1MUHIWojrP6v/VXi6zfqEUAA05F58
	1iILU=; b=tLIDJKqjokTgmqzgHXDv2UGq8RKFXy+pv0w0+7uQ+SkqmSVSuyAsRL
	wTk6WpS2Qzma/dFoci1ACH9DIDSkAYbVgqP6fQsda9aO0nE+tAbv0jsvgPTRFt+X
	Na38ks+U0gqsaTVwYjD4MaJ+6R631kBNr+U+rFI9CD6hptNep5Exg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1C801F4644;
	Sat,  6 Apr 2024 01:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3476D1F4643;
	Sat,  6 Apr 2024 01:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] CodingGuidelines: quote assigned value in 'local
 var=$val'
In-Reply-To: <CAPig+cR8HxO5ZeZrJQ4PtpgsqM__cvieZ6g37F1m_=ng6xvSPA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 6 Apr 2024 01:16:17 -0400")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-3-gitster@pobox.com>
	<CAPig+cR8HxO5ZeZrJQ4PtpgsqM__cvieZ6g37F1m_=ng6xvSPA@mail.gmail.com>
Date: Fri, 05 Apr 2024 22:40:47 -0700
Message-ID: <xmqqsezzm4kg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 388CD68E-F3D8-11EE-A60B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Every other example in the shell-script section of this document is
> written like this:
>
>     (incorrect)
>     local variable=$value
>     local variable=$(command args)
>
>     (correct)
>     local variable="$value"
>     local variable="$(command args)"
>
> Should this patch follow suit for consistency?

Sure.  That sounds like a good idea.
