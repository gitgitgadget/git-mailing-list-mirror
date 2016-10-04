Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4185120986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbcJDQMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:12:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61552 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752915AbcJDQMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:12:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBAA541E96;
        Tue,  4 Oct 2016 12:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5jb3XNwOgKTG4lKbdB4IVMznges=; b=XRiAMa
        L4TsMkE+IRNBahl97VKZPGxYF1f88M+KhB7JYdCu7doUPhQEYPinwv6qm8pYMOpF
        08T1Z1dEFsgWkuSXPcXQFCqLVo2EGep4MwB8orWOH3imt5xSHDSuKgPffVSoUgFe
        s21OLlu5aPdaW5EKCzrIWu2hhnobkji+T+vqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P52WeOODae5eOyrV2N26MHhKq7pIJ57v
        Ww78kzW8ZchB3ic6Rthdap/fXv81aoBZ378MWPPsebFnW30ZchFopxEvWSzluEXU
        6WvGRifOBuTsXrvglqvFo+P5iStjNnEuEIENqCd88SxWdLnKpP+E6jJI0ZfX2JpV
        dur+7nDAvq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C178D41E95;
        Tue,  4 Oct 2016 12:11:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42A2941E92;
        Tue,  4 Oct 2016 12:11:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
        <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
        <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
        <xmqqh98t5c69.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY+yB-AxRUt0rArGw6DaLDsMZDjKt2jQh9B=P-79T+qYQ@mail.gmail.com>
Date:   Tue, 04 Oct 2016 09:11:56 -0700
In-Reply-To: <CAGZ79kY+yB-AxRUt0rArGw6DaLDsMZDjKt2jQh9B=P-79T+qYQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 3 Oct 2016 15:17:30 -0700")
Message-ID: <xmqqh98sw0tv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4697F3C8-8A4D-11E6-BB79-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So how would we go about git_all_attrs then?

I think you arrived the same conclusion, but the use of
git_attr_check_elem[] in the original implementation of
git_all_attrs() does not translate to the use of struct
git_attr_check in the new world order we have been discussing.  The
latter is about "here are the attributes I want to know about",
i.e. the question being asked and then we would need to separate out
the answer from it to prepare for the threaded future.

The question git_all_attrs() asks is quite different. The caller
does not even know what set of attributes it is interested in, so if
you ever want to allow more than one callers pass the same callsite
to the function at the same time, they need their own copy of both
<attr>s and <value>s.  I'd expect they'd ask about a path and then
receive an array of (<attr>,<value>).  This is essentially what
happens in today's "array of git_attr_check_elem[]" interface.

That is fundamentally different from the normal use of
git_check_attr(), where <attr>s are part of questions being asked.

> int git_all_attrs(const char *path, char *result_keys[], char *result_values[],
>                         int nr, int alloc)

Or wrap each (<attr>,<value>) in a struct and return an array of it.
I do not see a reason why the above cannot be

	struct { const struct git_attr *a; const char *v; }
	**git_all_attr(const char *path);

which returns an array of struct's with an sentinel element at the
end (e.g. the 'a' field set to NULL or something).
