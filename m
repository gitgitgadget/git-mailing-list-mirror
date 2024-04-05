Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552816C690
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339228; cv=none; b=MN2GN5HoAL/fIyzyhcRD4vKkdLSEBMoUdQP/NHDSMlK5ok1mxMGj8n8ggqQe/HZWw1QP13iRWmtGDyr0FufGAUVYe+h/qTaWUG4Oq0yg6oHNOOVCmMzyvIBpRITURI44jCTDzAzLMSk99PHCFIKC439Hcs2vegESrmMaZecZmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339228; c=relaxed/simple;
	bh=rUkCIT73Y4FyflEpJlQtV4jNf7fIz71LSZvPZObtH+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SS37LcO+aQQftHW7HYC9GNSeyGHQuvy32kkt2ncHKBA30v6Y4/ZgBeMMO11pgufGfb7DA8mNVlkbTjAz7mBAb0+pZrsTlXtKcXRMCN5eK3JUWQHZ8Slfd+M3wo9KULQ618vsCF8GnEkDcJxSjDtWG4bKMate2MGb0HkbMKxFL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wBtFz7Fo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wBtFz7Fo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 279D021A8A;
	Fri,  5 Apr 2024 13:47:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rUkCIT73Y4FyflEpJlQtV4jNf7fIz71LSZvPZO
	btH+o=; b=wBtFz7Fo+64QWvVB/dTz7q2E7pWpmkv5HVYrcZvnnbOEQ++fbhgW0G
	cVx4fotWpAMg7aeV6i10NfENWkY/CDbI8EUaS6FicI70nQwyq9NVmsUlm52HQsw8
	dTcqfvL/dNDwd2qLqHRHtbwQPsTltgv4xe7a1hpTHFpz12Q6Pk82M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BE7C21A89;
	Fri,  5 Apr 2024 13:47:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A46621A86;
	Fri,  5 Apr 2024 13:47:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] userdiff: add builtin driver for typescript language
In-Reply-To: <20240404163827.5855-1-utsavp0213@gmail.com> (Utsav Parmar's
	message of "Thu, 4 Apr 2024 22:08:27 +0530")
References: <20240324174423.55508-1-utsavp0213@gmail.com>
	<20240404163827.5855-1-utsavp0213@gmail.com>
Date: Fri, 05 Apr 2024 10:47:01 -0700
Message-ID: <xmqqa5m7vh0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8278F5DE-F374-11EE-AFB5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Utsav Parmar <utsavp0213@gmail.com> writes:

>...
> diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
> new file mode 100644
> index 0000000000..19605fec4d
> --- /dev/null
> +++ b/t/t4034/typescript/expect
> @@ -0,0 +1,33 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index e4a51a2..9c56465 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,16 +1,16 @@<RESET>
> +log("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
> +!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b
> <RESET>

There is a funny line-wrapping around here that corrupts the patch.

> +<RED>a<RESET><GREEN>y
> <RESET>
