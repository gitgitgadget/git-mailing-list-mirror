Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5ABE4A
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iPoAmrTc"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A111C
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 20:49:51 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F2A91BB3B;
	Mon, 13 Nov 2023 23:49:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MkrTg1ChA3YL9L/tdhG4fXJQ+37/3QjwlHScKT
	mAFiA=; b=iPoAmrTcfQsvr2BU99H3unbWCKBIlnVHpoyJ+1a1q3S6sns5UxtGoe
	ztul+UP26BZ4tKqzAmVhC+6t5SE4crd4YB5btXyBPQYgrli0GiyIZGPeclhqwxV8
	KlCJID0XIFMeKNbevRYGl3J4aA7OuMbWxNEIOKNxCLA7Qvu4RXmWM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 383F41BB3A;
	Mon, 13 Nov 2023 23:49:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC71E1BB33;
	Mon, 13 Nov 2023 23:49:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] glossary: add definitions for dereference & peel
In-Reply-To: <pull.1610.v2.git.1699917471769.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Mon, 13 Nov 2023 23:17:51 +0000")
References: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
	<pull.1610.v2.git.1699917471769.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 13:49:45 +0900
Message-ID: <xmqq1qct0wie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3C57C684-82A9-11EE-9B14-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      * Removed references to "peeling" a commit; the updated definition
>        discusses "peeling" only in the context of tags.
>      * Added a cross-link from "dereference" to "peel" (one already existed
>        for "peel" to "dereference").
> ...
> +[[def_peel]]peel::
> +	The action of recursively <<def_dereference,dereferencing>> a
> +	<<def_tag_object,tag object>>.
> +

This was a bit surprising to me as I thought we would say "peel the
tag once" vs "peel the tag repeatedly", but upon inspecting the
existing code, documentation, and messages, we seem to mean by "to
peel" to dereference a tag repeatedly until it no longer is a tag,
which the new entry above exactly is (although "until the non-tag
object is revealed" is missing).

Thanks.  Will queue.

