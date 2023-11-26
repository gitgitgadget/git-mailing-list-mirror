Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/hVlN1c"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D7119
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 00:44:41 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B5CE32E427;
	Sun, 26 Nov 2023 03:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K3uiZOEIXQHnELZ1v+7zm9YJhImtt3VhmKrrhF
	wPD/Q=; b=h/hVlN1caNInGENh7+d2wpRhwXAMP6ScUU+0O0mEtDPJBFsn+vFb2U
	XK4polJQnLffbsuV0V8yojB7YQZtx4BCzzJ1fx7by57JAvPVInt5QVjFejZCl7bQ
	c1Ky3oySpJalLbbidsUduv5TNZzCHL53tk/kUgjWcYMNZH/QXrF84=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AED912E426;
	Sun, 26 Nov 2023 03:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C0A82E424;
	Sun, 26 Nov 2023 03:44:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Brobst <josh@brob.st>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/reflog.c: fix dry-run option short name
In-Reply-To: <20231126000514.85509-1-josh@brob.st> (Josh Brobst's message of
	"Sat, 25 Nov 2023 19:05:14 -0500")
References: <20231126000514.85509-1-josh@brob.st>
Date: Sun, 26 Nov 2023 17:44:33 +0900
Message-ID: <xmqqleak6gzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06AF559A-8C38-11EE-B58D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Brobst <josh@brob.st> writes:

> The documentation for reflog states that the --dry-run option of the
> expire and delete subcommands has a corresponding short name, -n.
> However, 33d7bdd645 (builtin/reflog.c: use parse-options api for expire,
> delete subcommands, 2022-01-06) did not include this short name in the
> new options parsing.
>
> Re-add the short name in the new dry-run option definitions.

Perfect.  Thanks for spotting and doing necessary archaeology.
