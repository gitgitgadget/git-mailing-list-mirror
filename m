Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE08220987
	for <e@80x24.org>; Thu,  6 Oct 2016 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756013AbcJFS0r (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:26:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754254AbcJFSZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:25:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98D5244555;
        Thu,  6 Oct 2016 14:25:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lgSvHnkHIjryjn5iSlbc+UICXG4=; b=LtNcB+
        nqhM840kLDA+EE0fB2YdDIwFFM9yALMfOczUUPMWYsW/10caUrGxGXgfLBAGXTFK
        /A/kWoeIl0iXC5ezhyWFskoOjQfq5Oo3O+C47/9//vEc8xDI7TOJ1vMn8RBfqG+l
        PIxMyB4vL3uXPz/XSFvWvHWQY9nudf3pQLTtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wjKCnbXlYIQRzX9BNN7gsBD9rnJ3uWJT
        ub+VBquLTpBP5AhNpH96VJXMP9mOmYCOgBF7Rknc6mafH/ABZXdRr+UaekmTlnmp
        BEr6kAZQzaZKMlchTGYv9wHqtx9Hjc8cA5Xv+plwq4symMiITAcXjIc7VdzaQOvi
        UMXKnERW38Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9183644554;
        Thu,  6 Oct 2016 14:25:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB73044553;
        Thu,  6 Oct 2016 14:25:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
Cc:     git@vger.kernel.org
Subject: Re: Systems with old regex system headers/libraries don't pick up git's compat/regex header file
References: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
Date:   Thu, 06 Oct 2016 11:25:48 -0700
In-Reply-To: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
        (Richard Lloyd's message of "Thu, 6 Oct 2016 10:15:49 +0100")
Message-ID: <xmqqeg3tl4gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F4712AA-8BF2-11E6-AD11-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Lloyd <richard.lloyd@connectinternetsolutions.com> writes:

> git ships with a compat/regex tree containing a recent regex
> release, presumably with the intention of allowing systems with
> either no regex or an old regex installed to use the newer compat
> version.

Quick question.  Does NO_REGEX help?  cf. Makefile

# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
# feature.
