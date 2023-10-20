Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462801A71B
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PvZTAx9H"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8810D46
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:28:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1FD71A514B;
	Fri, 20 Oct 2023 19:28:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dmi1BkzlrY+kcbENydkie9IDYLuip0aKhsBziB
	PKDXU=; b=PvZTAx9HSj7n7lKLZ2HbcvmZhf+Abb+5f30P748V/DlNi7yIbvOIVs
	moQyOmTo8HoJ2W2QyA1bN+jERcv+r4UtQC7wPgCjkAYgIxLuSKwe6bBuMuvvjOFh
	4x+bVd2vdhNwrWxc1SZof/daxAjsmS5Q3OW+LZMkjy5QWuRKIBAV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E953E1A514A;
	Fri, 20 Oct 2023 19:28:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F99D1A5149;
	Fri, 20 Oct 2023 19:28:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org> (Dragan Simic's
	message of "Sat, 21 Oct 2023 01:02:46 +0200")
References: <20231020183947.463882-1-jacob@initialcommit.io>
	<fd26df85661d554ced9d8e0445f75952@manjaro.org>
	<ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
	<d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
Date: Fri, 20 Oct 2023 16:28:19 -0700
Message-ID: <xmqqwmvgoovg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5ACFB2A0-6FA0-11EE-85D1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Please don't get me wrong, I understand your reasoning, but again, it
> all comes down to the two categories described above.  IMHO, the
> second category will likely start turning off the default hints sooner
> than turning the table formatting on.  The first category will choose
> some GUI anyway.

You are not alone in feeling the impedance mismatch between the
intended audience the patch(es) try to help (pointy-clicky GUI
users) and the codebase the patch(es) modify (perhaps spartan
command line interface).  I did wonder why this is not made as a
part of sugarcoating the command line interface with some GUI that
shows what could be added, what has been added, and the stuff in its
"git status" equivalent.

