Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55BC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C96C207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QiC+OKVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407165AbgE1UPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:15:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60088 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407117AbgE1UPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:15:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 455E87E3ED;
        Thu, 28 May 2020 16:15:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OWjDJGPdBpCqLnuGU17J3bNByXA=; b=QiC+OK
        VlurqhGfK6F5jQXR5xJczE5/HynBlZNusIyXwahXpyYAtKlyfkFUX2RD8nzUNCdl
        xeGwR/6c2DgWtxkkGIqSyGvD1/MGWiLAYn0YnAvaJiPg67Q4EfTj2IJbvsXSlw1I
        joU9EUexXXIenwxk24TQ/IGhOc5fa+tI2OtDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yo0jBbKTwReYt+LbRpB7OmdowyWJKeBb
        MBk2vrl43yfXoSUAQo319M8YFgghTjjNGtFqiUPEAADmHj4FN2/IAAt6w9PBsH1J
        HA0Cy72eamGs8JK5qP0mXtwGfnB2U5fRdwZaruhXkhCSgogTFEJkVEhvd1XX6Lo3
        G/PuCNk6PDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A64C7E3EC;
        Thu, 28 May 2020 16:15:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8CEC7E3EB;
        Thu, 28 May 2020 16:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v15 00/13] Reftable support git-core
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 13:15:20 -0700
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 28 May 2020 19:46:36
        +0000")
Message-ID: <xmqqh7vz3jfr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F495F4C4-A11F-11EA-8DD2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I refrained from saying this but perhaps I should have in the early
round.  Next time, can you make sure the patches you are sending out
apply cleanly without need for fixing whitespace errors?

This is what I got.  Thanks.

$ git am -sc ./+hn13-v15-reftable
Applying: Write pseudorefs through ref backends.
Applying: Make refs_ref_exists public
Applying: Treat BISECT_HEAD as a pseudo ref
Applying: Treat CHERRY_PICK_HEAD as a pseudo ref
Applying: Treat REVERT_HEAD as a pseudo ref
Applying: Move REF_LOG_ONLY to refs-internal.h
Applying: Iterate over the "refs/" namespace in for_each_[raw]ref
Applying: Add .gitattributes for the reftable/ directory
.git/rebase-apply/patch:137: trailing whitespace.
    
.git/rebase-apply/patch:6784: trailing whitespace.
# Remove unittests and compatibility hacks we don't need here.  
.git/rebase-apply/patch:6787: trailing whitespace.
git add reftable/*.[ch] reftable/LICENSE reftable/VERSION 
.git/rebase-apply/patch:7558: indent with spaces.
        left = *destLen;
.git/rebase-apply/patch:7559: indent with spaces.
        *destLen = 0;
warning: squelched 16 whitespace errors
warning: 21 lines applied after fixing whitespace errors.
Applying: Add reftable library
.git/rebase-apply/patch:1865: indent with spaces.
	        return 1
.git/rebase-apply/patch:1876: trailing whitespace.
	test_line_count = 0 output 
.git/rebase-apply/patch:1892: trailing whitespace.
		print_ref "refs/tags/test_tag^{}" 
.git/rebase-apply/patch:1950: space before tab in indent.
 	git rebase source &&
.git/rebase-apply/patch:1955: new blank line at EOF.
+
warning: 4 lines applied after fixing whitespace errors.
Applying: Reftable support for git-core
Test number t0031 already taken
.git/rebase-apply/patch:385: trailing whitespace.
	(cd files && GIT_DEBUG_REFS=1 test_commit message file) > files.txt && 
warning: 1 line applied after fixing whitespace errors.
Applying: Add GIT_DEBUG_REFS debugging mechanism
Test number t0033 already taken
Applying: vcxproj: adjust for the reftable changes
Applying: Add reftable testing infrastructure
