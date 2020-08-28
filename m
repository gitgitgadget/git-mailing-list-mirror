Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC34FC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA33D207DA
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vC+GrfmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgH1Uvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:51:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54943 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgH1Uvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 16:51:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55EB9FE908;
        Fri, 28 Aug 2020 16:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XVwX6TQIMVe9d3wAsfMYxTJjvAY=; b=vC+Grf
        mOHbupzih+uF9xqB2vhQP0HsvfZplkl+RZT/tVe5QI0a1YW7/qSVedSzrauDD76d
        TOMEnV1qUrf285rZPeYkgcoE4OckvQ9ywsBoBEgqL/y6Ai+k8qNdJ4ynsQYAsfRP
        op7rI6ejW8K4ZMWjYq7hiFfan2aUAhB91UXuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wx7SY7ZwRlbUmShlHpkdDFMlvT51eiCW
        DKi1b6VSzozhkrXG3+Qlekgne67eSFpeOmEtoxfWj8YLUNjHlFFP7HksgsmgbRFG
        cRWAQtwJlzeImzTutCdmGgb2dSU4DOQGVHdzuROJKWsYQSk8KBb+NEKpyhFvQuKX
        ATSmALJizts=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F3A5FE907;
        Fri, 28 Aug 2020 16:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94346FE906;
        Fri, 28 Aug 2020 16:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
        <CA+CkUQ_=qm2x2zKvgHnvKLLA_A23gTNm8Q8CeWxLFGSBi=9gKw@mail.gmail.com>
Date:   Fri, 28 Aug 2020 13:51:34 -0700
In-Reply-To: <CA+CkUQ_=qm2x2zKvgHnvKLLA_A23gTNm8Q8CeWxLFGSBi=9gKw@mail.gmail.com>
        (Hariom verma's message of "Sat, 29 Aug 2020 01:39:07 +0530")
Message-ID: <xmqqo8muo5nt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 437EC14A-E970-11EA-B51B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

>> * hv/ref-filter-misc (2020-08-17) 9 commits
>>   (merged to 'next' on 2020-08-27 at c015fa6b0f)
>>  + ref-filter: add `sanitize` option for 'subject' atom
>>  + format-support: move `format_sanitized_subject()` from pretty
>>  + pretty: refactor `format_sanitized_subject()`
>>  + ref-filter: add `short` modifier to 'parent' atom
>>  + ref-filter: add `short` modifier to 'tree' atom
>>  + ref-filter: rename `objectname` related functions and fields
>>  + ref-filter: modify error messages in `grab_objectname()`
>>  + ref-filter: refactor `grab_objectname()`
>>  + ref-filter: support different email formats
>>
>>  The "--format=" option to the "for-each-ref" command and friends
>>  learned a few more tricks, e.g. the ":short" suffix that applies to
>>  "objectname" now also can be used for "parent", "tree", etc.
>>
>>  Will merge to 'master'.
>
> I sent an updated version of the patch series addressing your comment
> concerning new file format-support.{c,h}[1].

Yikes, my mistake.  As long as you plan to vastly extend what would
be in format-support.[ch], I do not mind to have a pair of separate
files in the end, by the time when we have, say, unified "--format"
support for for-each-ref family (e.g. "%(token)") and log family
(e.g. "%x" fixed few letter combinations).  So the step that moves
some from pretty.c to format-support.c does not bother me all that
much.  It just felt unnecessary within the scope of this series.

But other stuff (like format-sanitized-subject having unnecessary
allocation and unnecessary special casing of LF) are worth fixing in
the version queued above.

Thanks for stopping me.

Let's revert the above out of 'next' and start afresh using v4.
