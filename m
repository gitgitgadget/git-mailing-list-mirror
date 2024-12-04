Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F92F22
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290304; cv=none; b=GNP3l/eazyacrtFlfITlLgBcEBUlR/aj9TjGKW8880mYldw9bTEK+9HcnoSwSf1PaiECRVh7oIPUU+15HUGwxRkaf8DlkF+EsrU6Ka6cBNIygu9PW7PPjbBbJT27Y0pkKl0szMrX83o75oEHgrgoLBNXcEpzZDBSTqSSZIkEN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290304; c=relaxed/simple;
	bh=Y30Qj3wik2aDkKM/aKcbdTM6XOTC4S2+KN59TSPYa80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTqajoWPw73mFQMYvLlcHuwh3yJr+6aA9cOYYx5plbDQrHEGZgQKsT6DdP1eMvvAJ6H23Ng3yxcXMKt3hKqWPBMbGi0jwsxmD3E5s8HHW5T1hghRl7TJ/IjuBw1StCKDr1QbZT1neu+bbZ0ugArDod1iaClyJ4SERcgMMA8GZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSGhFcpi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSGhFcpi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CDFCE1380282;
	Wed,  4 Dec 2024 00:31:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Dec 2024 00:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733290300; x=1733376700; bh=zeuOArgwvJavrMKHsX7CuZGT+ikKpHimx2u
	Y3wRXlzs=; b=MSGhFcpiz9K/boc61UXMCH0Y+C2sodefFxFBgqv7wDag1BS7yAG
	UDCbbeFkWT4kZSp8/jj8sNztrRp9Im+q6vWndtWM69wNO96snK9/5fzFAj46tL15
	F4LQW8IZFiyqwYnkPKDBPAIYCD+9mAvFoXOZf9s11lnlbgAhex1mumIfCJgs7Mk/
	6snNZLsDufObRAH6yrrt48bdwL0MRkw017dhuBbSbP2F9veHq2lmmT5PUPtnmucP
	STKxpOATXI9GkG1G5r+Yq0l6tuvfhZ3Rke04j0wsq+pcL9IVxF61nDTwcvsW3hD4
	BgcmAil6x5KIKqUb40zTOwH5Bm8sI0GVeYw==
X-ME-Sender: <xms:POlPZ-zA0XiGx6XND8pe2oeOwkkk0wXWVeQU0FPCERW3jrI-9WfekQ>
    <xme:POlPZ6RIKa63_i_iwzKwaimwxY2pt9BorrRSgEcK0cDYdBLJfmD_XIeKzSlBv4_hF
    5B8-blPbEiPkFRuZA>
X-ME-Received: <xmr:POlPZwWeZ2Xjh-KJ8lbjaSQXHajCAtXHR_NCX1E4OuI_d5XJy13ZiGYWzN8A9zhhuOTo7BOkw_pREEEFxfIMXmUIyaXVYX-j3G2CT9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeuleeuieehfeelveefveeutdeuveeugfdvjeek
    geevkeejudektdejgeehvddugfenucffohhmrghinhepphhkthdqlhhinhgvrdgtfienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:POlPZ0gylozfQWmhGZ6ZUz_eAH7FQOHOYnu7E10bpP0hOk1SKArmMg>
    <xmx:POlPZwDdw9Phk-3INS2FH-mK4WWksP_ha_xM9WR1gaKN4CsM4ZYZyw>
    <xmx:POlPZ1K12V8OIPJPaMcm49d91cD6pmkhh9VczyWUbb5rJ09Oe9ALDg>
    <xmx:POlPZ3Bxzx5X5n33np3tUCJCMG4mlPSKyXYaOZOpVr7JMzT9aaaWDQ>
    <xmx:POlPZ_6Q8apyJckD6ShzJxXGSzQ7857o058IgiFeFckYvr3i3f6_QmZX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 00:31:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 07/14] global: trivial conversions to fix
 `-Wsign-compare` warnings
In-Reply-To: <20241202-pks-sign-compare-v2-7-e7f0ad92a749@pks.im> (Patrick
	Steinhardt's message of "Mon, 02 Dec 2024 13:04:39 +0100")
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
	<20241202-pks-sign-compare-v2-7-e7f0ad92a749@pks.im>
Date: Wed, 04 Dec 2024 14:31:38 +0900
Message-ID: <xmqqcyi83tfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/pkt-line.c b/pkt-line.c
> index 90ea2b6974b1d0957cfdc5e2f9a2c30720723f12..1c7e8d826d10b3125962e14476c24771d82888b1 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -1,5 +1,3 @@
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "git-compat-util.h"
>  #include "copy.h"
>  #include "pkt-line.h"
> @@ -41,7 +39,6 @@ static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
>  
>  static void packet_trace(const char *buf, unsigned int len, int write)
>  {
> -	int i;
>  	struct strbuf out;
>  	static int in_pack, sideband;
>  
> @@ -74,7 +71,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  		    get_trace_prefix(), write ? '>' : '<');
>  
>  	/* XXX we should really handle printable utf8 */
> -	for (i = 0; i < len; i++) {
> +	for (unsigned int i = 0; i < len; i++) {
>  		/* suppress newlines */
>  		if (buf[i] == '\n')
>  			continue;

This unfortunately is not enough for 32-bit architectures.

As the helper is limited to handle only 64kB worth of data, "size"
being "unsigned" is more than sufficiently wide even on 32-bit box,
and a variable of type ssize_t is still wide enough, but the
compilers would not know that.

I do not have a 32-bit box handy, so this is not tested in the
target environment the fix aims at, but at least I tested to
make sure it does not break 64-bit builds.

It seems that csum-file.c has a similar issue, but I haven't had a
chance to take a look.

 pkt-line.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/pkt-line.c w/pkt-line.c
index 1c7e8d826d..d08d46a99b 100644
--- c/pkt-line.c
+++ w/pkt-line.c
@@ -339,7 +339,7 @@ int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 			   void *dst, unsigned size, int options)
 {
-	ssize_t ret;
+	size_t ret;
 
 	if (fd >= 0 && src_buf && *src_buf)
 		BUG("multiple sources given to packet_read");
@@ -351,12 +351,13 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		*src_buf += ret;
 		*src_size -= ret;
 	} else {
-		ret = read_in_full(fd, dst, size);
-		if (ret < 0) {
+		ssize_t num_read = read_in_full(fd, dst, size);
+		if (num_read < 0) {
 			if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
 				return error_errno(_("read error"));
 			die_errno(_("read error"));
 		}
+		ret = num_read;
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
