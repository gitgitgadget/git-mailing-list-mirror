Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E33D65
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bJtxThLU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED8731DFDFC;
	Wed, 27 Dec 2023 00:28:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3AXpx7urNG/ZDsx1vRDrqVXDwXNfQYFERcNgJR
	BPzLI=; b=bJtxThLUuJ4YdqpYRk+d+Ae+eSmF4vphw+/GRkbz7lk492Q/SCSM5g
	chSdbH6srOqa6eWYg/CKtKRRR6j41gg7BuGMcMLko/NNBkyVxqQ7K+KwsyapPaPH
	3TxVorHTylNc2QjcyCi6GB9xbfLdDQwpwDZqYUd4/wpc4/q7kccmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E861DFDFB;
	Wed, 27 Dec 2023 00:28:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 594051DFDFA;
	Wed, 27 Dec 2023 00:28:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sebastian Thiel <sebastian.thiel@icloud.com>,
  Josh Triplett <josh@joshtriplett.org>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
In-Reply-To: <pull.1627.git.1703643931314.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 27 Dec 2023 02:25:31
	+0000")
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 21:28:32 -0800
Message-ID: <xmqq8r5gfc3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6D378EE-A478-11EE-B575-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> We have traditionally considered all ignored files to be expendable, but
> users occasionally want ignored files that are not considered
> expendable.  Add a design document covering how to split ignored files
> into two types: 'trashable' (what all ignored files are currently
> considered) and 'precious' (the new type of ignored file).

The proposed syntax is a bit different from what I personally prefer
(which is Phillip's [P14] or something like it), but I consider that
the more valuable parts of this document is about how various
commands ought to interact with precious paths, which shouldn't
change regardless of the syntax.

Thanks for putting this together.
