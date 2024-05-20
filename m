Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DB17BAF
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238003; cv=none; b=lzeRLPS2VYhpw5OF+UH/LYnxIpb/kXD+AWZfIN/bp0odtaknrZlycwa5OpPacXIPhNIPc51GsyjYnMbY/lZ+xWr7K8U0GfIUFcCGcDT03g4OoAUVmYfyyFH9HxL/G1TqkT3bmHvZ0zaQTJrIbf8WtE+K2JatJu5ig9fPz63jzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238003; c=relaxed/simple;
	bh=qgOHw6oYL15zwCBSKq9zMwr07tBs2D1wYBxoFLEN3Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TdZ1vqps86uaK3WjMqegDsXaS5kY3WIWem6eyCDXGlu++HaBqUFIArJlXHaXonJL5LTK1vhLJPMroGe7KnbfuSNiYTC3WXPw7YHbBqXCtnuJUPL2EKjMl2qxEje9YuvjT1C6116XAinLZMOT2l7DiNo6kR7CnBAU9660fxN+BtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V/h0I2eP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/h0I2eP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FDEB19FDA;
	Mon, 20 May 2024 16:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qgOHw6oYL15zwCBSKq9zMwr07tBs2D1wYBxoFL
	EN3Is=; b=V/h0I2ePhnt8Y08HiTiFGaJA7YUMXEuUhnZGVOMG/eWyQtfh2pGrbf
	AZNKGpZOngMW/M5xQlzpAq7un0NJI9E1A4GEQ6zx076x0wPYdW8Jly2JFp3n/vOU
	2LrurcYL5eAQWXHU5IrKMLB+1A17DcJLpogKbsynqPZMtG+R11ANI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6698F19FD9;
	Mon, 20 May 2024 16:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8B2719FD8;
	Mon, 20 May 2024 16:46:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,  Christian
 Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Achu Luma <ach.lumap@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: port helper/test-strcmp-offset.c to
 unit-tests/t-strcmp-offset.c
In-Reply-To: <xmqq1q5wmpqh.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 May 2024 09:07:18 -0700")
References: <20240310144819.4379-1-ach.lumap@gmail.com>
	<20240519204530.12258-3-shyamthakkar001@gmail.com>
	<xmqq1q5wmpqh.fsf@gitster.g>
Date: Mon, 20 May 2024 13:46:38 -0700
Message-ID: <xmqqseycdxe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0ECFDB54-16EA-11EF-9B8D-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Please do not base a new topic on 'next', as I will NOT be applying
> it on top of 'next'.
> ...
> Unless the conflicts are severe and is impractical, in which case
> see Documentation/SubmittingPatches and look for "Under truly
> exceptional circumstances".  But the conflict in Makefile about
> UNIT_TEST_PROGRAMS in this case hadly qualifies as one.
>
> Anyway, thanks for a patch.

I've backported the patch to apply to "master" and queued it on its
own topic, so that it no longer has to wait for all other topic in
'next'.  The Makefile looks like the attached, which is just with
trivial difference in the context.  We only need to remove
strcmp-offset from the TEST_BUILTIN_OBJS and instead add a
corresponding one to UNIT_TEST_PROGRAMS, and that does not change no
matter what other test-*.o are added to the former or t-* are added
to the latter.

We may want to sort the UNIT_TEST_PROGRAMS list alphabetically at
some point, by the way.

Thanks.

diff --git a/Makefile b/Makefile
index cf504963c2..1afa112706 100644
--- a/Makefile
+++ b/Makefile
@@ -839,7 +839,6 @@ TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-simple-ipc.o
-TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
@@ -1338,6 +1337,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
