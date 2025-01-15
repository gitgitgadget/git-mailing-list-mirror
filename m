Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1824A7C4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956238; cv=none; b=DPKrNMVTR9GzUEmIAsTVaFME/LQbaHkYXFb7X7gLCNgpP4dX7LFWV2unghCmxoip3dKdGRfST7wW2N/DHwUecGlFNmLTz15uXNRDMO0c3fjZUo60ntvxnqkdOtA/Qrk9AE/msuDleDYi9k+RR2lOY35aTOPivZaUzGlGUI/pf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956238; c=relaxed/simple;
	bh=hI8rRZPzqMJ1aTyzIhkGKaSYTR+4uhxuGUKTJL+wdcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dixzcyhWLShXMoQeGEi2suY+qBsBGnZ/JjQ8okvUajUUZ4gxRLMNXDdOQ2ZJHJ4sCsWUpRcLVclj02ZV59H9Mae1OrlOVEkJuLQCYgzop5YfuWNWy8RCEcqFyY61mbDvOEdxlLe1Pg/QLZlODENjCzlQtJ4zM9XPMoPL4B9QHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U7Lr1Xez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U7Lr1Xez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2BFC4CED1;
	Wed, 15 Jan 2025 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736956237;
	bh=hI8rRZPzqMJ1aTyzIhkGKaSYTR+4uhxuGUKTJL+wdcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7Lr1XezRAgqLd60kFCUUYhMAyhUNLl1cmcIQTOZL4Z5bqXEzwYX34SGltq6VrDwt
	 dMjUBQY08yzmCdYeGPNjgaGfaGjiPCgy6mCu55lk14DNodJyjR8bNKB8t2Tjpu57dK
	 a/dKduS+xklw10AS18nV1T1nJp+Z8APJbvQkxK6c=
Date: Wed, 15 Jan 2025 10:50:36 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <20250115-eccentric-zebra-of-hail-c22ba0@lemur>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <xmqqjzax2nqw.fsf@gitster.g>
 <xmqqa5bt2jc8.fsf@gitster.g>
 <Z4dLeyF8N8PhYAZq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4dLeyF8N8PhYAZq@pks.im>

On Wed, Jan 15, 2025 at 06:45:31AM +0100, Patrick Steinhardt wrote:
> I have in fact started using b4, as it makes most of the tedious
> housekeeping around patch series go away, and it indeed uses
> `--full-index` to generate patches. There isn't any way to change that,
> but I'll send a patch upstream that gives us an option to do so.

This was done as part of this change:
https://git.kernel.org/pub/scm/utils/b4/b4.git/commit/?id=23a9ddba10a057bfa9c438c0b50ac36d278ae022

I'm not sure why --full-index was added there -- I don't think it's needed for
--binary? Please feel free to send a fix for that.

> My last patches haven't gotten any feedback though, so let's see how it
> goes.

I had to focus on infrastructure needs over the past few months, but I'm
starting on my b4 backlog soon.

-K
