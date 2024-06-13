Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682112CD98
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301685; cv=none; b=CdI3CHFAIEvOynmBipDYdrEpsmITw87ybp0TakfuYGFmGkmSliS0sPLSSg1pQy/Tf8+m12zOEP//On8sT6Z2CAwxBBoGNACFhq08ytiDF90d8d7Y9FBugSG7hVJh5q8tq131Jb+TlqEK8S7OiWjtnYZbH5k7eRMoKpxWfpl1mxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301685; c=relaxed/simple;
	bh=JlQ3kLTE8H7SVTED4Ys6NNqSYKOh9/+Lx0EAWzMLKCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Isfck+b8jsrwdeP0a/HLUGzIwfjhe7jcmzXCl/L3BO5PrdirfuSGS+Nd4yAZwFiKzvy++Z7LjRpZU6sd4bTu+IxdVsk55XJChluozvnZmCkFuAgd70+yR7zcUCl5jr9HDZjJgNJf16EFTpNyfkQ4e903oAxrtK5ucXeg+c+sxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=winfTIDR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="winfTIDR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF3EB1AEAD;
	Thu, 13 Jun 2024 14:01:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JlQ3kLTE8H7SVTED4Ys6NNqSYKOh9/+Lx0EAWz
	MLKCU=; b=winfTIDRjBGBRez9P00cg6LRpX9u+aehL3gZ2EU4jHQ3aGDL52zNBN
	Qz9GtSqnsqOvo4jgPT0kRNqnZk/7HY9Nwcmzij+jUkY4rFHcSM2swSBHA5XCplYJ
	OrfOIjIgahUzk8Exr5i0rkWY28kJDlPilNI7vAk2XGHGmiQW6DyaU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1E401AEAC;
	Thu, 13 Jun 2024 14:01:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B4BC1AEAB;
	Thu, 13 Jun 2024 14:01:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <cover.1718259125.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 13 Jun 2024 08:13:21 +0200")
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
Date: Thu, 13 Jun 2024 11:01:21 -0700
Message-ID: <xmqqcyoklo26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F16CCFC2-29AE-11EF-B39B-965B910A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that introduce a new
> `USE_THE_REPOSITORY_VARIABLE` macro. If undefined, then declarations
> like `the_repository`, `the_hash_algo` and a subset of functions that
> implicitly depend on either of these are hidden away.

;-)
