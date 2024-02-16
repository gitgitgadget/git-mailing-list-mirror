Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8521353E4
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119933; cv=none; b=muJeGTaxUesSwUoYiDDkn5or4e1WFUPvmLwvpV3xm6MnO1Km730FNi89y9C/DiTutEydKuIlL2Pw26c0jtKvMoOlFdrWSeqks+Kcg68StPzxPqYB1fcomx/ubR6y/MQOKvKvXnX6jzOQ/CPge4KVVGLI4jR6eKTlhvOtwLvJ8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119933; c=relaxed/simple;
	bh=qYJE69/lCZX0JVq+71rsUHWvKZv8mv1LLuuEq6EA9Ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1Jo1ZlU8oe5dFe6ZER3Ak5bA9739qBqUCC4Kq+BwHGIM2/gJRanUYwKmkttaCOZ/z7cGs81wo2cDPau8jk1Y4qRPPJymhQtYXnuZNDV3VnY2xxWQEgj3oZVYGi38hSzFKjpIjhMZ7mnopUzaSjNQumtIC8ObuaqMOccvM8hkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=It/Qj/pg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="It/Qj/pg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 05819366B2;
	Fri, 16 Feb 2024 16:45:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qYJE69/lCZX0JVq+71rsUHWvKZv8mv1LLuuEq6
	EA9Ps=; b=It/Qj/pg/MLaRdaIPPB5Kmv4sa2L3zOYqpC5kyTeXl+4/jt1F4fUOa
	sZi9f1qtAV0uQfMbpniNbNCKyprlNS6vl8dpHmf/2hZkL5kMIKKt5nQxh1J/NPU1
	hEidFRBF/zu1S1uCuKit+DZpcY4fvaRh+OERrE3LKiXI3jMwKtMHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F18B0366B1;
	Fri, 16 Feb 2024 16:45:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92548366B0;
	Fri, 16 Feb 2024 16:45:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name,  rjusto@gmail.com,
  spectral@google.com
Subject: Re: [PATCH v2] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <608b4e81d71a95c820f1e4068382d391@manjaro.org> (Dragan Simic's
	message of "Fri, 16 Feb 2024 22:20:02 +0100")
References: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
	<xmqq1q9ci3jt.fsf@gitster.g>
	<608b4e81d71a95c820f1e4068382d391@manjaro.org>
Date: Fri, 16 Feb 2024 13:45:27 -0800
Message-ID: <xmqqh6i8gk20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B34B0430-CD14-11EE-8FD1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> But the halfway modification to the description section in this
>> patch is not an improvement.  It makes some options described there
>> while -m and -c are completely missing now, making the section
>> incomplete and coverage of the operating modes of the command
>> uneven.
>
> If I got it right, you'd prefer this patch not to be accepted
> separately, but as part of the future series that would rework the
> entire git-branch(1) man page?  I'm fine with that as well.

Not necessarily.  If you wanted to this this in multiple steps, we
can first whip the OPTIONS part into a good shape, and then fix the
DESCRIPTION part.

What we want to avoid (not limited to this topic) is to say "this
temporarily makes things worse here, but trust me it will eventually
become perfect".  Removing only -m/-c from the description section
makes the description section worse than before the patch---we'd be
better off leaving the original as-is if we are not revamping the
entire section.


