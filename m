Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC50D20189
	for <e@80x24.org>; Sun, 19 Jun 2016 03:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbcFSDQu (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 23:16:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291AbcFSDQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 23:16:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 048A9269A4;
	Sat, 18 Jun 2016 23:16:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I7GEoUuVHO2K85F4jeVaGGyt88g=; b=xtLko/
	ZVtMcX0/CPLVBPihvi8wFtbGHTH2bCr16pOAvpg8xd2aSHTqXN4Ebs65ElQbHCHP
	jTHmkUY8Afm7JXkifbYdh8N1qLGjYRu6yE+vkJRYGWv0nqlApC18AEy621SQZEMj
	7DRl6146upY9uLUmIFITxKl03RWueV4c0YRK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LbeI+gAb8lFP9StGX73WKufu+QZwhe+q
	evoDstif9oueJa8aeqWE8Obu8wS5016UM/B/yjNxx6Q8CPcbNRMAbcrs6/dwWEx3
	CjtjwjrI7aG6w0F5Q85S0eKXh6rOXYbIbYjtW9NEKQzTpX3egUvHFT2RYbfAd3ZX
	UsEZkwcY1h8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F0F46269A3;
	Sat, 18 Jun 2016 23:16:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B462269A2;
	Sat, 18 Jun 2016 23:16:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
References: <xmqqshwax8ah.fsf@gitster.mtv.corp.google.com>
	<20160619024554.2983-1-cuong.manhle.vn@gmail.com>
Date:	Sat, 18 Jun 2016 20:16:45 -0700
In-Reply-To: <20160619024554.2983-1-cuong.manhle.vn@gmail.com> (LE Manh
	Cuong's message of "Sun, 19 Jun 2016 09:45:54 +0700")
Message-ID: <xmqqinx5yijm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41DA48D4-35CC-11E6-B36C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

LE Manh Cuong <cuong.manhle.vn@gmail.com> writes:

> It's not only people shooting their foot, but also from malicious user.
> Given that `curl url | sudo sh/bash` is often found in many instructions,
> an end user may not be noticed about the environment variable injection
> from their side.
>
> IMHO, it's better if  git can protect the end users in this situation.

Huh?  For those who run `curl url | sudo sh`, I do not think the
incoming script setting and exporting LV to an arbitrary value and
runing Git is not the top thing they need worry about.

While I think enclosing the string in dq is an improvement (as I
said already), I still do think your use of the v-word is making a
mountain out of an anthill.
