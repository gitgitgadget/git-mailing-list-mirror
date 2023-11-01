Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613A12B6F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/Cqx8NP"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06045A6
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:19:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 154031CB712;
	Wed,  1 Nov 2023 19:19:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xGtzVCqlzRTjcpuajRRD9pO5wfEc6l67I8l4SN
	EA5Rw=; b=R/Cqx8NPbJXfVRNADod4YoW5NhK8UTMY/vTqRERl+0sJAUuQ0uJn7f
	4hHaERUTukApb48D/aiCsFGJ991btR0PQourdG+V4TjWJkZYpdq/MM4Kvu0vi7bP
	tT5Ej+Y1jQ3Rd66kHrA59kEVsa3aS5s2Tt+/DP2jrNvJHQcQ5AEC8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CAEC1CB711;
	Wed,  1 Nov 2023 19:19:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 731601CB710;
	Wed,  1 Nov 2023 19:19:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: teach callers of test_i18ngrep to use test_grep
In-Reply-To: <876dd6fc-b57b-479f-8ffe-fbd2a6979034@gmail.com> (Phillip Wood's
	message of "Wed, 1 Nov 2023 14:44:11 +0000")
References: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
	<20231031052330.3762989-1-gitster@pobox.com>
	<20231031052330.3762989-3-gitster@pobox.com>
	<876dd6fc-b57b-479f-8ffe-fbd2a6979034@gmail.com>
Date: Thu, 02 Nov 2023 08:19:53 +0900
Message-ID: <xmqqr0l9oycm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2A37D278-790D-11EE-BDFB-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> additional t/lib-*.sh files. Grepping ce56983dd3 for "test_i18ngrep"
> shows there is one instance of test_i18ngrep that has not been
> coverted in contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh.

Thanks.  I'll tweak the patch to update that instance.  As we are
not removing test_i18ngrep with this series, any test_i18ngrep left
unconverted should not break anything, but that is primarily to deal
with any new callsites that is added on other topics in-flight, and
I should make sure the ones that are known in my tree are converted.


