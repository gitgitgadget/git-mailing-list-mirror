Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77D51F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941066AbcJEWJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 18:09:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941034AbcJEWJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 18:09:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8B744847;
        Wed,  5 Oct 2016 18:09:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i+/2pU+OiLaxPSU7HebP3VNHxZM=; b=wiytHL
        4+b7kMye4ITS7B/MxgTAbPw10JHiS8nIzlzI+iSyrb4CHlb6deu01pC/D+UJz5/Y
        ZbSeVTxWo39mBA8xVcwW4PsAKTED7EKDrroIZXplQlsFge4mVb21j7i5ITtGYWwT
        UaTd/sdOi/dmf9Q5hX5RPBWRPPRRwIaDwYAsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+j0EG6FCP4QZIBAbT5MIpU/nLzOOP78
        jwWAT9Mkh5+D4hEm/odPLM9Zrn2cxT9U4lcANRRXrb0WL45zgcu1ATdGOVJkK1xi
        cpB4lFmRSTgP7R1OrG/Ru0AfPYi9v2z5h+XeWRnWNaTZtlX/FwQVYxp6EUaMJLb+
        OU4DzrPRyvA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D4F44845;
        Wed,  5 Oct 2016 18:09:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03AB444843;
        Wed,  5 Oct 2016 18:09:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC/PATCH] attr: Document a new possible thread safe API
References: <20161004221433.23747-1-sbeller@google.com>
        <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaFx++yipGmq=D2EPN4Gw9JhRXf_i4pFivTnkJmJXjFfg@mail.gmail.com>
        <xmqq8tu2ras4.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ7zNkXBVUFq5aLSup9xsdCbZpy_x8z5=uAQqftmOq26A@mail.gmail.com>
Date:   Wed, 05 Oct 2016 15:09:49 -0700
In-Reply-To: <CAGZ79kZ7zNkXBVUFq5aLSup9xsdCbZpy_x8z5=uAQqftmOq26A@mail.gmail.com>
        (Stefan Beller's message of "Wed, 5 Oct 2016 10:04:43 -0700")
Message-ID: <xmqq1szuo3bm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 705B0FBE-8B48-11E6-AEF0-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I think so, instead of resending the documentation, maybe the header
> file shows that we're on the same page, I converted everything except
> attr.c to follow this header attr.h:

OK.  The function signature of git_check_attr() looks suspect (it
does not match the "typical case" illustration in the message you
are responding to), but other than that I think this matches my
expectation.

Thanks for taking this over.
