Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513516D337
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716051; cv=none; b=CHfK8C3fzv7vTzM9DJrMeGwNiKNI5kafvQAlHb9/RdAoSBwU1BSGwyUYjOgkaWBDWB9uZhZvfIcc+nbuNmdBKjLuDvz1OCLLwOcObiUmiugpDwv1BLWwITPDjWENHU93AgLC9M84Gm6yqTB5jMGsENo4ZwVdGtexZ8LMOR2LpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716051; c=relaxed/simple;
	bh=W1ryXYY6i/32JrUr/VZQHrAm+5PDE1ZMrdKBIwGomhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E43OXs8kfa8eywbp8aK7z1zl6R63js9dwle9baNM9U4c5/lXisa7qDZc1ED7HiXFytODrdQM9USVL/GOwcqLPdGtQ0WFhPHxgk+K8asBEPGBkeE3cQihfxxk36c2BEh7mYaPe6vVAMSu9Aoo/+QxzfrcXp4KnxS4sXqAp5qKWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jnZ4KJRc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jnZ4KJRc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 272D61844E;
	Thu, 11 Jul 2024 12:40:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W1ryXYY6i/32
	JrUr/VZQHrAm+5PDE1ZMrdKBIwGomhw=; b=jnZ4KJRcNjc5Ce5xNiwfYIy2pjwE
	S7PyxG//8dFipRYRHd2YkYSFpVCnHT+GFnx+JKnYOIwMZrnNJVD1UVjKQgrX7B+8
	hp4V+PEMdNrBf+4SngMPjFLITuiTF4sumbQPr7J7oEdy1pIGQx5A0iyKdU0MwxQJ
	4zMqehOM4TNGMnQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F4BD1844D;
	Thu, 11 Jul 2024 12:40:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37EB01844C;
	Thu, 11 Jul 2024 12:40:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 5/8] clang-format: avoid braces on simple
 single-statement bodies
In-Reply-To: <20240711083043.1732288-6-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 11 Jul 2024 10:30:40 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240711083043.1732288-1-karthik.188@gmail.com>
	<20240711083043.1732288-6-karthik.188@gmail.com>
Date: Thu, 11 Jul 2024 09:40:44 -0700
Message-ID: <xmqqcynjswz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 527684B0-3FA4-11EF-832F-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

>     Setting this option to true could lead to incorrect code formatting
>     due to clang-format=E2=80=99s lack of complete semantic information=
. As
>     such, extra care should be taken to review code changes made by
>     this option.
>
> The latter seems to be of concern. But since we only use clang-format t=
o
> verify the format and not to apply formatting, we should be okay here.

Hmph.  Could you tell me where I can read more about "we tell
clang-format only to verify but not to apply"?  If that is truely
the case, perhaps I shouldn't be worried to much, but it is not
clear to me how we enforce that this is to be used only for
verification with non-zero false positive, and never for
reformatting before submission.

The senario I was worried about was this.  We aadd to .clang-format
that is in-tree, and not just CI jobs but our human contributors may
use it to check what they newly wrote before committing and they may
even take the differences as suggested fixes (which may end up
breaking their working code).

Thanks.
