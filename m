Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0914B978
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874028; cv=none; b=hhV5yTGw/fBi3xH4oIbFtsjSQpd9v9DANML3JFFAC2OznNB/RxkOiiuru/uGmimPRnXmU3LmajXvGJUsG8Kez9BuCxTLKYrgALcHwDZzFxqlW2MXATyWKhcCGSu3WliiATvMPZdGX80H8Hq03MTrXdvnxu+PgLCorwWSabEdnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874028; c=relaxed/simple;
	bh=Ahw96fQ5reafwv6dzL++z8SQddniB/JOBhjb3CM6s+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hz1i3LXii+S6/kWoV0r9MXJLGxKLZDRD7kCBrmhs9g9b8nOEoQv6J9LlXQSOhDpLfXPvrX+3Aq5dPuuXLU0AjBnE4Q+incFg9y9Zkz+LUINAmOyA/mT9HcwGdM4R5WpjfKRBOGuGtAK9hl86fvq++P2VbbJYAQYyQH3ESVwP5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YefRyNJg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YefRyNJg"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A9F2E268F1;
	Thu, 16 May 2024 11:38:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ahw96fQ5reafwv6dzL++z8SQddniB/JOBhjb3C
	M6s+M=; b=YefRyNJg8jNyXu281AvjZCoxL/hCmMUZSUucvJQ+24/B9Fcy70GEdP
	i9a0GglQxalbV0sjj6viRHu5Tq6Uv4cTmxLwMZxJyVt0Era58D46tzw9SexU5Y1j
	6BGGR/sbT1VBSx3n8VBdg0gLMWX/9EOZbdx6dC+bc3vSBADPUo8QY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A231C268F0;
	Thu, 16 May 2024 11:38:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30C50268EF;
	Thu, 16 May 2024 11:38:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Marcel Telka <marcel@telka.sk>,  git@vger.kernel.org
Subject: Re: [PATCH] t/t0211-trace2-perf.sh: fix typo patern -> pattern
In-Reply-To: <ZkWI9--gMH0Xgv3f@tanuki> (Patrick Steinhardt's message of "Thu,
	16 May 2024 06:17:59 +0200")
References: <ZkU8VAUnKx_SXU5U@telcontar> <ZkWI9--gMH0Xgv3f@tanuki>
Date: Thu, 16 May 2024 08:38:23 -0700
Message-ID: <xmqq34qhu5qo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55806242-139A-11EF-8422-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 16, 2024 at 12:51:00AM +0200, Marcel Telka wrote:
>
> Thanks for the patch, which looks obviously good to me. It would be nice
> to have a short explanation in the commit message that explains why this
> issue was able to sneak.
>
> Patrick

A good piece of advice.

FYI, I have the following since last night, as the original report
was whitespace damaged and did not apply.

-------- >8 --------------- >8 --------------- >8 --------
Subject: [PATCH] t0211: typofix

Marcel Telka noticed that one test assigns to $pattern and then
uses $patern in an invocation of "grep".  Of course, looking for
an empty string will succeed, so the test succeeds for a wrong
reason.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0211-trace2-perf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 0b3436e8ca..37a51e6449 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -233,7 +233,7 @@ have_counter_event () {
 
 	pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
 
-	grep "${patern}" ${file}
+	grep "${pattern}" ${file}
 }
 
 test_expect_success 'global counter test/test1' '
-- 
2.45.1-190-g19fe900cfc
