Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23EE1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbcGLT0j (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:26:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbcGLT0j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 15:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D55AF2A7D2;
	Tue, 12 Jul 2016 15:26:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GNm4h3CjfZ4M
	bdiNwW7eAzElsyU=; b=OMazfk37G19PyXaVTJIbj6tAtBNwjoJr1VX5F28pVVKV
	Ju87WDGxNfwlrqZ2wzYi7+bJq32rde82/zPDEbZu/6g5VL1gMiNJ7INlkvVCizQt
	xbDyDAOzyk3JRsGCfs3a1ETh6KdPE6qvS6ikYWLMcU48sDCk4VaM9ZBrXIbT4KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xUEdDX
	MX7+CKQoHyO7ZgG8X8KlQSP5KKHXfNHKGnKFUVTuCuA+LKi0x86t2WNkTmb6FvVV
	hg07L1VufxNFTnq8NIPFDOefQ9GyC0jcxB+gWizqjWK2W7XueADnoiPMtRR7DEqd
	B9GKzJPWeS5JjmCXHBFpmdjZD59lQj9q2a1MI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDB862A7D1;
	Tue, 12 Jul 2016 15:26:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 576112A7D0;
	Tue, 12 Jul 2016 15:26:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 2/5] sha1_file.c: use type off_t* for object_info->disk_sizep
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-3-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 12:26:35 -0700
In-Reply-To: <20160705170558.10906-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:55 +0200")
Message-ID: <xmqqr3ay4pzo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D2B97E6-4866-11E6-A935-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -			strbuf_addf(sb, "%lu", data->disk_size);
> +			strbuf_addf(sb, "%"PRIuMAX, data->disk_size);

Subject: [PATCH] SQUASH???

---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 58ad284..13ed944 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -184,7 +184,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
 		else
-			strbuf_addf(sb, "%"PRIuMAX, data->disk_size);
+			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
 		if (data->mark_query)
 			data->split_on_whitespace = 1;
-- 
2.9.1-500-g4c1e1e0

