Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD27EA
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1qHRdc+"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A93199
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:48:53 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D765E3336A;
	Tue,  7 Nov 2023 20:48:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hOQYmlzLGkVV
	EisQhiVGDylS8bcXAbtIjoyXI+GZ9OE=; b=l1qHRdc+AN0scLEpdq1yfR6yxRNk
	kcf0BdQlxhn6bLnxlGm8fkIofymOtMk9GqmbXxXEqxrkX+mo/CXX8C26AVKTeYnJ
	7Bbz8ldT/09vl0yxwZhmtys2kizMF0QyJxcdAwGtAKjMIfeWtVckMwq6+WcR5OuT
	kc9Znoklu/L4hQo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B6633369;
	Tue,  7 Nov 2023 20:48:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A66533368;
	Tue,  7 Nov 2023 20:48:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: chengpu lee <okuxxo@gmail.com>,  git@vger.kernel.org
Subject: Re: issue unable to commit file and folder name to upper lower case
In-Reply-To: <20231107173557.GA29083@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Tue, 7 Nov 2023 18:35:57 +0100")
References: <CAHv3AeCOoEXxpNh=gzjNcKbVyZFaYZ5BzSf3FGL1=pdheNebZw@mail.gmail.com>
	<20231107173557.GA29083@tb-raspi4>
Date: Wed, 08 Nov 2023 10:48:46 +0900
Message-ID: <xmqqleb9816p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F645ADFC-7DD8-11EE-A2AB-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Yes, that is a restriction in Git, call it a bug, call it a missing fea=
ture.
> Unless someone fixes it, the recommendation is still to use a workaroun=
d:
>
> tb@pc:/tmp/ttt> git mv Abc tmp
> tb@pc:/tmp/ttt> git mv tmp abc
> tb@pc:/tmp/ttt> git status
> On branch master
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         renamed:    Abc/.keep -> abc/.keep
>
> tb@pc:/tmp/ttt>

Correct and very helpful suggestion.  Or get a better filesystem ;-)

Thanks.

