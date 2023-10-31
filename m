Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475862F
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iO/6Voso"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB861C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:06:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE86B1C2165;
	Tue, 31 Oct 2023 19:06:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bSCDQPPGRPCBwNFUP/MV/nKePafRCtg/DTD0eM
	vuZKg=; b=iO/6VosoeqhvGfT/cOSOdVckps6+UUN805OW+eNv+wJgIDthpX905o
	7vCihVEXaVYgFXJeRuzBV3QlTcRy+LFx+FoRZJNlOfyYijwVylkMCCnAEBgc8qtA
	ZcBw7uWaESm3BbKSxhLJTK4YUfqhKOFjee16GGqwSZN/HwffsPLQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4D421C2164;
	Tue, 31 Oct 2023 19:06:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3139E1C2163;
	Tue, 31 Oct 2023 19:06:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/1] Object ID support for git merge-file
In-Reply-To: <6a8f3a6c-c3b0-4aff-ab36-be980ec6bbe0@gmail.com> (Phillip Wood's
	message of "Tue, 31 Oct 2023 11:05:12 +0000")
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
	<20231030162658.567523-1-sandals@crustytoothpaste.net>
	<6a8f3a6c-c3b0-4aff-ab36-be980ec6bbe0@gmail.com>
Date: Wed, 01 Nov 2023 08:06:22 +0900
Message-ID: <xmqqo7ge2xzl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C4099DC-7842-11EE-94CB-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi brian
>
> Thanks for the re-roll, this version looks good to me
>
> Phillip

Yup, competently done.

I briefly thought about suggesting --blob-id instead of --object-id
simply because you'd never want to feed it trees and commits, but
the error message from read_mmblob() the users would get mentions
'blob' to signal that non-blob objects are unwelcome, so the name of
the optionwould be OK as-is.

Queued.  Let's mark it for 'next'.  Thanks.
