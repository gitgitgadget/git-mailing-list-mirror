Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7F0203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbcGZQ5k (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:57:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752785AbcGZQ5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:57:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CBAC2E188;
	Tue, 26 Jul 2016 12:57:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kDWb0OiUj3Kc7GmEc50dv9X28Hc=; b=qrpnDr
	h/oyhTluzA/J9KL2vdEPx5fp0qdcba9wqPuqyIkFpktvbsAdmmt2PwWDqJ8VeYcG
	ukcTCkA66yYB7hiGHAnxhGDYL2dgEBHnryzfBkSh5Wcf33KhYwRfqbdhyD0f1h0O
	/Klz1yB+agNBpHXZUSPbeFO9/OQ+xMXopplC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZB5WBMO6lMNez+wrbC1aKU+4tw0o3pu1
	xVZ+rmPbGJHfTMv3Ik7xUPGO9UF3BpmdflzRNROWWL1jw0/DUEzp3C1gX9TPD7dC
	pYDK/zSobC5iYILyySFqjlEypX8FeDChH9try7lwUjSsElFAw/UDxxwQQ5SdohyM
	QyqwlwtiGmo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73AFF2E187;
	Tue, 26 Jul 2016 12:57:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5D4C2E186;
	Tue, 26 Jul 2016 12:57:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] i18n: notes: mark comment for translation
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	<1469535400-9242-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Tue, 26 Jul 2016 09:57:34 -0700
In-Reply-To: <1469535400-9242-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Tue, 26 Jul 2016 12:16:40 +0000")
Message-ID: <xmqqzip41gn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E0D21EA-5352-11E6-94C9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
> +		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
> +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));

Hmm, do we really need to make three separate calls?
