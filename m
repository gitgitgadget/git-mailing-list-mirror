Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0F02018F
	for <e@80x24.org>; Wed, 13 Jul 2016 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbcGMUdK (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 16:33:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750904AbcGMUdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 16:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF65F29FC5;
	Wed, 13 Jul 2016 16:33:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vwTHcF6TzHKw
	Sxe3V7JNzw8gyco=; b=qZ4vb6zt3WN5MMN6q2CB8OxqZoc4r7XvdfPOlhY1IiQo
	rqER7Anaw9GjT8rn6coRKhwEoJMphPZ77BDCrYqXP5Bk5T0JlpuHKjte9FjcLNUA
	XPacoYJMJvjqCFowAr1AZJecVYkgfPhlE4CzdCh/I39rASU3qF+cx8p7K7gdB5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ossn1e
	n38Bi9PG6eGMBVeixZ+E6AC2K8vpwd0zApUco1rOLzYJzUv6YsI0bGFfAyTB7Qp1
	lK8v6yu68n92v8QguWOoSWAWvzGkr5PJi3Ti6Qiq/6XXOuheYsUQPiUyqezxoAfJ
	1OCiDBWJo5y48lsHWy5MH9XmkAqQc8nfoEM+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B728929FC4;
	Wed, 13 Jul 2016 16:33:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41FFB29FC3;
	Wed, 13 Jul 2016 16:33:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jehan =?utf-8?Q?Pag=C3=A8s?= <jehan.marmottard@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Bug report: --invert-grep and --author seems to be incompatible.
References: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
	<xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com>
	<CAFgjPJ-E=eW_ZiAUf2jKu6z3WfW_p+BMbEJwf=OSGUXQB78kwQ@mail.gmail.com>
	<xmqqlh151lst.fsf@gitster.mtv.corp.google.com>
	<CAFgjPJ_er6QCaYenU=10_935HoKbc=8hqbJku5p6kF2BYkSrjw@mail.gmail.com>
Date:	Wed, 13 Jul 2016 13:33:04 -0700
In-Reply-To: <CAFgjPJ_er6QCaYenU=10_935HoKbc=8hqbJku5p6kF2BYkSrjw@mail.gmail.com>
	("Jehan =?utf-8?Q?Pag=C3=A8s=22's?= message of "Wed, 13 Jul 2016 22:14:09
 +0200")
Message-ID: <xmqqr3axz3b3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 012939F0-4939-11E6-994B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jehan Pagès <jehan.marmottard@gmail.com> writes:

> ... A better naming should
> have been called --invert-matches, or even just --invert.
> And the man description should definitely be completed, IMO.

Renaming the options would not work well without harming existing
users, but a patch to update the documentation is certainly very
welcome.
