Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FB37153
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318114; cv=none; b=uAMU0gm+kwdK41pzHA423nPpJoesUTa2dHWPXuAR8IClQ21/K/YyWFptO9GqJ8BJA1gwIDjGdt/bLFlbaeNn6i6Xp8/pZoOux8TusZbVZVjr0/APnwSbKVEHsIthZ52K18OUPM4oOfFrkUhK+RJC3qzubK+6fwwwD5YYq7VBKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318114; c=relaxed/simple;
	bh=3K7IMstfNXgi8scFUc0PS+WyTNRUhZO6GuaBNtNka/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pg+Xk8eVyv3ZKRpVVclG//SlCWjYeQFE2TfvsIAlPfrEyvGLClrPguFZdxPcsvE3bBGkEIAi+5933SyBx9IWn+fJaBfcYEyK0ayDcU5cCGTfNWcEZwwgxeu5I++WAvo7FMkM3GnZYO4w8dsjP93YM5cS/BX5zuKrrnvTR043CVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mmu1V/nV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mmu1V/nV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C10241E2B8;
	Fri,  1 Mar 2024 13:35:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3K7IMstfNXgi
	8scFUc0PS+WyTNRUhZO6GuaBNtNka/A=; b=mmu1V/nV2CL3zRhapCHC+Pzpvbs9
	d+700wey1yj1GBfCQkchGu501KXgUr6RWm2e3k6MnC0+UmxUxqUjp4XrmoBFu0b4
	CscaxzQDZ9YLfifwBc7FXX9YVLuTegcKfYsLmM6s6aF1+jzeKqaqR9ewdKBnEjlD
	uCvi3bsaywOYdQo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B81BC1E2B7;
	Fri,  1 Mar 2024 13:35:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5F8A1E2B6;
	Fri,  1 Mar 2024 13:35:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] gitcli: drop mention of =?utf-8?Q?=E2=80=9Cnon-dashed?=
 =?utf-8?Q?_form=E2=80=9D?=
In-Reply-To: <5b34bc4e22816f7f19bd26c15a08fe4c749b72f8.1709316230.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Fri, 1 Mar 2024 19:05:53 +0100")
References: <5b34bc4e22816f7f19bd26c15a08fe4c749b72f8.1709316230.git.code@khaugsbakk.name>
Date: Fri, 01 Mar 2024 10:35:08 -0800
Message-ID: <xmqqy1b14x7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6EFCB0BC-D7FA-11EE-858F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> ... These days though it seems like an irrelevant point to make to
> budding CLI scripters=E2=80=94you don=E2=80=99t have to warn against a =
style that
> probably doesn=E2=80=99t even work on their git(1) installation.

It is very true.  It is still technically correct that you should
prefer spelling "git cat-file" instead of "git-cat-file", as the
latter may not work for you at all ;-).


