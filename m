Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175FA49
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="saKHOIP9"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC39184
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 19:04:44 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56C551D064F;
	Mon,  6 Nov 2023 22:04:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dUWedqtl1N/g/4qRDzFl3P+oQwKllalC6DN4PY
	GszqI=; b=saKHOIP9UW/xiukY3cx5t/H3QLXbOgdZy9JnTs9s+wx1dFb6jT/Mrn
	KJG4k2E0VlwhYjdOCVE6kKFrWZgawo4Yp19HNqOFTzXVwKyhZKXDml6pMWFpJExq
	FXj5mYypyDV2lPxqwg6FVL4PkU19yzFsD8278nL7cEugbpce1M5mw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F17E1D064C;
	Mon,  6 Nov 2023 22:04:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9AF61D064B;
	Mon,  6 Nov 2023 22:04:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/9] for-each-ref optimizations & usability improvements
In-Reply-To: <dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com> (Victoria Dye's
	message of "Mon, 6 Nov 2023 18:48:29 -0800")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<xmqqo7g69tmf.fsf@gitster.g>
	<dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com>
Date: Tue, 07 Nov 2023 12:04:41 +0900
Message-ID: <xmqqedh29sc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65EE0998-7D1A-11EE-A09C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Victoria Dye <vdye@github.com> writes:

> Ah sorry, I over-edited my cover letter and accidentally removed the
> explanation of what this patch does! Yes - the new behavior is that
> '--no-sort' (assuming there are no subsequent --sort=<something> options)
> will completely skip sorting the filtered refs. 

Makes sense.

And the way to countermand "--no-sort" that appears earlier on the
command line to revert to the default sort order is "--sort" that
uses "refname" as the sort key, which is also nice.

