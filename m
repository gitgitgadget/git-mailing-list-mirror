Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9C1B7E9
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515637; cv=none; b=OktjdxEjL6rhM8Dj8VX28cuByrx6UUJGJbrOWQVayGYXV2KxIWAqz8NW+RBR7x8MExOR9vtVep6b0Y27FpWkpuBJui5lEuVn1RHQmRWES6PR+svMl/Rma67oUVDiyDUsKyGu94t5OgzWR9w7LmeuWl1P7J8bYTX68w6t5uiRmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515637; c=relaxed/simple;
	bh=FRGVAzuJW2To48AGnC+BUpyaZSUDHDjvl6aDJdYMMaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N4iStEb2dRPPvZx4LXh4z7/07M4ya5rSB1CGdtRAomGGGWEpvc6Fgcdu/9xz8+NSssU/MRdHrOu9tqxgBEVHBPnPHbUbPTaz4Ve3hB5L5dTDCa4KoGTjtGA6irRim/TOL34A5ly/343lk1AFZG+d+t0C/Qs6V3Yc/zVacTwCoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=idvSria4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="idvSria4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 086891DC270;
	Fri,  9 Feb 2024 16:53:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FRGVAzuJW2To48AGnC+BUpyaZSUDHDjvl6aDJd
	YMMaA=; b=idvSria4oQrMMxcR5FV3Pe2dcKTaa3xQ8ztWey2de0TozWdBumLtlG
	YnKEXCrUdTU2c3R2W518gDtdSSze4wvrdAG1vlPTQcRPbzTa/UrOuqoXwNVl5/zm
	52gknrGvAdoXw/VAttF5bO3SXBd4SPpk3IgZK1l58heB/4JuIRENA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F172F1DC26F;
	Fri,  9 Feb 2024 16:53:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EC251DC26D;
	Fri,  9 Feb 2024 16:53:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 16/28] trailer: finish formatting unification
In-Reply-To: <31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Tue, 06 Feb 2024 05:12:16
	+0000")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 13:53:52 -0800
Message-ID: <xmqqeddle233.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B73DC05C-C795-11EE-AB0E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Rename format_trailer_info() to format_trailers(). Finally, both
> interpret-trailers and format_trailers_from_commit() can call
> "format_trailers()"!
>
> Update the comment in <trailer.h> to remove the (now obsolete) caveats
> about format_trailers_from_commit().

Nice.
