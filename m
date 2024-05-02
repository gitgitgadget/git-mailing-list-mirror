Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787757C84
	for <git@vger.kernel.org>; Thu,  2 May 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714686364; cv=none; b=Wedcm82udCNGhg15fDYW5NAhtHTcAo04iVWqVdI62XKhuP8TggoqR/jTsh0XoRQCBLYedzwhQQdmsxIJpgMBnyUHFYrAEBNsZQX03vPuJNbjvh/plpZYIt9pkbJn+15Z/BCwqjBzpPYtx5N9BgGbHJNH3ZRLo6JCx9WJi2Nx+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714686364; c=relaxed/simple;
	bh=Te96EarYsfDlgJwsC98bresNZ62i7YWZLUeWqFTRgcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dV3FJ9TW+6xfokX58Wu1Mrt45maXtdFDs9UBcg9HnHmc6WCIl9oJREmBIrBCXOhXclZsvLv0MzNay2xsoA2OFHGkD7mwGZFiELCIoKKACwIBeSKDadJeJr5AuRAhhXgRHwK54cnsf8VHR8ZKWoNzZU9Ep7VioBWwfbIGYkjQEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZtMEiNhR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZtMEiNhR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 824ED32816;
	Thu,  2 May 2024 17:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Te96EarYsfDlgJwsC98bresNZ62i7YWZLUeWqF
	TRgcw=; b=ZtMEiNhRkeiWzoN4BFNAY7edU0cOy/FXE6FcZrLoMtIAnoUQmXgJUw
	WDfUKXI7Ylm2XbMfNTL7mEgpL8zIBqRoGJExX4sb190PTTmICo7eFFvP38q0XYVE
	ekCb5SdgZpqC1/uDzo27crBw3I0GtAe48CKf2b1Bs5tV9+4HqW8Js=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C29A32813;
	Thu,  2 May 2024 17:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFD68327E7;
	Thu,  2 May 2024 17:45:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/5] Add GitLab CI to check for whitespace errors
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 2 May 2024 14:38:34 -0500")
References: <20240430003323.6210-1-jltobler@gmail.com>
	<20240502193840.105355-1-jltobler@gmail.com>
Date: Thu, 02 May 2024 14:45:56 -0700
Message-ID: <xmqqzft7c2gb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C1F3452-08CD-11EF-86A6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> This is the second version of my patch series to add a GitLab CI job to
> check for whitespace errors. The main differnece with this version is
> that it first generalizes the existing GitHub whitespace check CI job
> allowing the GitLab one to reuse it.

Will queue.  Thanks.  The extraction and reuse of a common script is
excellent.
