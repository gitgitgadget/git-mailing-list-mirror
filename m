Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB5381B8
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779474; cv=none; b=E0ZrVIuOJrqZZInVhNmsVgmQtRMJmixkNviM8h3b56bO4Glg9cZp/AvRAJRNrAwNpYKLdJAFGb+lpuX9eezAJXpebgK3voseSfmU98TRUtqmk0Chu+ccp/iFBhNxh02KZIzYH2QTGp9rn46MJkngn+YdLyF90sNwa/IBHXRJAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779474; c=relaxed/simple;
	bh=/LNKNqovqgIAarapV2ieM+hwdpMHXSq4Af+Dub/PW1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVTeHH0YRwN/2bjdbQ6yMZ32NlPKP6tVu2Ug2DMW6b8hq1l1vtPdBsLr+yGP9QUp81HV5o4+g8bj8IfVryCuRqM5FuFHqapaV7aSvdkBKzzOhNi9+XmvZX39OtSAk5Wo202JkIs722dMZipkAXuM3OGH65hbRJGpzkjOCztP3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELFm3wUx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELFm3wUx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EB3D2C099;
	Thu, 19 Sep 2024 16:57:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/LNKNqovqgIAarapV2ieM+hwdpMHXSq4Af+Dub
	/PW1g=; b=ELFm3wUxcjcepjBfP7C7YkhzkXl7/720Jh8L/ry3HNvJ5cEgFsWLm/
	vjIRcPp6wYdtj/hkdEtPiwjqGFJNXsnfdyZ1BRwncjFQaAxDKaZpQy0AbmOjsbO1
	YqUC+q33J2ivfszGITKAHK6PobWTlT3WVOmTvBbuGyG12b2+QGj/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 370A62C098;
	Thu, 19 Sep 2024 16:57:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8137A2C097;
	Thu, 19 Sep 2024 16:57:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Andrew Kreimer
 <algonell@gmail.com>
Subject: Re: [PATCH 00/20] Fix typos
In-Reply-To: <CAPig+cTnB-aHLX8BhYk8sYgRF6S5XgsVmmJAji1oRRac+MLbtQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 19 Sep 2024 16:54:48 -0400")
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
	<ab9213d5-fb1b-482e-854b-4f5d4e82821a@app.fastmail.com>
	<xmqq34lv74us.fsf@gitster.g>
	<CAPig+cTnB-aHLX8BhYk8sYgRF6S5XgsVmmJAji1oRRac+MLbtQ@mail.gmail.com>
Date: Thu, 19 Sep 2024 13:57:50 -0700
Message-ID: <xmqqy13n5pkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D5934CDC-76C9-11EF-BE28-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> For what it's worth, I found the submission easier to review as
> separate patches because it allowed me to review a small batch, do
> something else for a bit, review another batch, do something else,
> etc., without losing my place since I deleted the ones I had already
> reviewed, so I knew that those remaining in my Inbox were still
> pending review.

It is a very good point.

FWIW, all except for one apply cleanly to both v2.46.0 and 'seen',
and one fixes a typo introduced between v2.46.0 and 'master'.

Will queue.
Thanks.

