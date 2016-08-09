Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D20C1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbcHIQmC (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 12:42:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932817AbcHIQlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 12:41:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 544F63170F;
	Tue,  9 Aug 2016 12:41:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ms9xe5+u0+XbM6Mj+CK9We7CFY=; b=bx3TTe
	CO3QrAgTOlLQaZo48QHd2yMLiAXZ2SKdzdBCgNwiBzGQQZYOLKFEP+5AcAX4MKo8
	Huq9pHXTM7H2RhH4Qk4QXayaB/vXU7I0KTP1aRlXvS+u2LAI8utCo/GuaL29ll8C
	ymH76yO9MMzrkNhPzcCN5azcWIz03tH/XuZwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQfbShGrWLIbx9VfCrhKwSlMJIZP5ozy
	g37atOO5xmnqD6kn/oH1+quCgO87cFUMjTYMhpFDv70yXXuSNz/Iw/wfs7MGy2if
	2arWXHw3ou53ocZQ4raiWHJ0VDBMqje4vdNFjPC5GtOTd+52586EdZg+cbHbFN/o
	pb1JtuOvxj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44DDA3170E;
	Tue,  9 Aug 2016 12:41:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7BC73170D;
	Tue,  9 Aug 2016 12:41:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com
Subject: Re: [PATCHv3 2/9] t7408: merge short tests, factor out testing method
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-3-sbeller@google.com>
Date:	Tue, 09 Aug 2016 09:41:51 -0700
In-Reply-To: <20160809040811.21408-3-sbeller@google.com> (Stefan Beller's
	message of "Mon, 8 Aug 2016 21:08:02 -0700")
Message-ID: <xmqqy445c2sw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DA5F5AA-5E50-11E6-A6D9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +# The tests up to this point, and repositories created by them
> +# (A, B, super and super/sub), are about setting up the stage
> +# forsubsequent tests and meant to be kept throughout the

s/forsub/for sub/;
