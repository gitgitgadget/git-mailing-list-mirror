Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hh2vGJHV"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00A90
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 15:19:20 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D43461CA6EC;
	Fri,  8 Dec 2023 18:19:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i0N0UJTI6fSw8lM/GCzTf1olKy/Wo4XJcBIe8/
	St/AY=; b=hh2vGJHVM+kCe0X4e8f0mD3AjCJapV3X1YoaT/oT0oqYCPMvIJ6Eaf
	bro4hT4g3112vM916b4Bsls6c1WXYzWaNT4i7A9Kp3A1c5DZ+76rNIUEmrTM5jCl
	5oyrhhhDEENnsQRIhI2qp3muMFuWLMfbU6lkeuZTFUFF2fSEfF7ww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB7CA1CA6EB;
	Fri,  8 Dec 2023 18:19:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 402991CA6EA;
	Fri,  8 Dec 2023 18:19:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: What's the recommendation for forgetting all rerere's records?
In-Reply-To: <m0y1e7kkft.fsf@epic96565.epic.com> (Sean Allred's message of
	"Wed, 06 Dec 2023 16:37:23 -0600")
References: <m0y1e7kkft.fsf@epic96565.epic.com>
Date: Sat, 09 Dec 2023 08:19:18 +0900
Message-ID: <xmqqcyvgz3ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36837F2A-9620-11EE-A121-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> When outside the context of a conflict (no rebase/merge in progress),
> what's the intended workflow to clear out the contents of
> $GIT_DIR/rr-cache?

You could "rm -fr .git/rr-cache/??*" if you want.

The "intended" workflow is there will no need to "clear out" at all;
you may notice mistaken resolution, and you will remove it when you
notice one, but the bulk of the remaining database entries ought to
be still correct.
