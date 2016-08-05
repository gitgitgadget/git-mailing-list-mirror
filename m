Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E84D2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S3002123AbcHEVrj (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:47:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S3002103AbcHEVri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:47:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ED0F33671;
	Fri,  5 Aug 2016 17:47:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+WtQ9dl3La4PDauVKWticQmkXGA=; b=OcW8bq
	T9bI12cFt0E8pSTyxkc8kC6p+rw9Pj/ifcqzQLMdNFwxcnM6N8/iIr9nKB37jT1N
	5T/HuI8z8u35xOzF0vexFrI6KEIwZHula+HKBRz3HD4L6+5kTTcl56jJTb4acp0H
	wTSSuOqMw/3R9RlQnSE6uF1e5ZZxn4QfMvvFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vIrrziPpOy1VmdIYN78M9K7uzovIE8Tf
	mO0vJmD4OHQUwMnorgKH9CFlaccHhf49vbA6mZWrZwfVz6XoVxZ/1QOCWm8a/i+5
	MckHr56312Dm6LWd+rNSI6dGVYrzVK9L//xhgvopBqZ/4TnMHqFV4BVdMt5Q42CA
	fDtPFAxfmaU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96E583366F;
	Fri,  5 Aug 2016 17:47:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 198B13366D;
	Fri,  5 Aug 2016 17:47:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/6] git clone: Marry --recursive and --reference
References: <20160804195159.7788-1-sbeller@google.com>
	<xmqqoa57vvzl.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY9Wry-vu9ByzW7Qc37SSkKf3doyWuzGzQeMTy4NfLMhA@mail.gmail.com>
Date:	Fri, 05 Aug 2016 14:47:34 -0700
In-Reply-To: <CAGZ79kY9Wry-vu9ByzW7Qc37SSkKf3doyWuzGzQeMTy4NfLMhA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Aug 2016 14:23:49 -0700")
Message-ID: <xmqqoa56vqfd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38E492E8-5B56-11E6-80F3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The plan for other layouts might be
>
>     git submodule update --reference-dir /var/cache/

That is not a plan for "other layouts", but a plan for "the other
layout that was mentioned as a possibility".  As I said, both
layouts are equally plausible, and I do not know if we need to plan
for layouts other than these two, but we should consider if we want
to add one new option every time we find a new layout we need to
support, or we want a general framework that is more flexible and
allows us to make the "borrow from the $GIT_DIR/modules/ of the
repository the superproject borrows from" a mere special case of it.

Thanks.

