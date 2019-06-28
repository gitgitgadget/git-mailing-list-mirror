Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46BA1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 02:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfF1C0J (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 22:26:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53489 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1C0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 22:26:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2E1D15A014;
        Thu, 27 Jun 2019 22:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2VuFIGm7q8ho7I+gEyuDMxD5O6g=; b=FPPKFx
        sHcf8vYf2GEDpeqIkgdyYZP2N0CuUSLimwknRQEUNpcImTTvmFnIbMn5vNU8FM9i
        xWW+LxcviUaVyM6Vp6bBxCj1mxVQ0X+k6qVe9Rz5gmsB+gg85sih6sViFFz+MBoJ
        s80ttlb/5/cSNF3A9dakuqYr2NogL3g9UcfWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OZBEmUGZTJ61jsyZLeVeA5+X2snzmdTX
        9n4g4AGCCZkWMIM7kY5h1kafG5t+YsmHZpfxGuiGjfhXQUH+XGEzND5Bm014wBGh
        5CwWxJr9Yulsk6MeAqT+h8+WiSIA/fZ4OZ4Gw/8bd+fr7w0SqIrFmQRGNPEqaSMY
        hZdxjYOO5VQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB76B15A012;
        Thu, 27 Jun 2019 22:26:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E22F15A011;
        Thu, 27 Jun 2019 22:26:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
        <20190627194809.GA54617@comcast.net>
Date:   Thu, 27 Jun 2019 19:26:05 -0700
In-Reply-To: <20190627194809.GA54617@comcast.net> (Matthew DeVore's message of
        "Thu, 27 Jun 2019 12:48:09 -0700")
Message-ID: <xmqqef3ea1j6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 152308B2-994C-11E9-BD7C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:
>> * md/list-objects-filter-combo (2019-06-17) 10 commits
>>  - list-objects-filter-options: make parser void
>>  - list-objects-filter-options: clean up use of ALLOC_GROW
>>  - list-objects-filter-options: allow mult. --filter
>>  - strbuf: give URL-encoding API a char predicate fn
>>  - list-objects-filter-options: make filter_spec a string_list
>>  - list-objects-filter-options: move error check up
>>  - list-objects-filter: implement composite filters
>>  - list-objects-filter-options: always supply *errbuf
>>  - list-objects-filter: put omits set in filter struct
>>  - list-objects-filter: make API easier to use
>> 
>>  The list-objects-filter API (used to create a sparse/lazy clone)
>>  learned to take a combined filter specification.
>> 
>>  Will merge to 'next'.
>> 
>
> Great, thank you. I do want to apply jonathantanmy@google.com's
> readability/textual suggestions. Can you wait until the next roll-up before
> merging, please? I'll send it out today.

TAhanks for stopping me.

Also please be sure to address https://travis-ci.org/git/git/jobs/551523578
(scroll to the end of the log).

commit ebcfc8579f827d952b39bb930123671ab5c5b208
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jun 27 19:24:04 2019 -0700

    fixup! list-objects-filter: implement composite filters

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e19ecdcafa..f17d33f29b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -146,8 +146,8 @@ static int parse_combine_filter(
 	int result = 0;
 
 	if (!subspecs[0]) {
-		strbuf_addf(errbuf,
-			    _("expected something after combine:"));
+		strbuf_addstr(errbuf,
+			      _("expected something after combine:"));
 		result = 1;
 		goto cleanup;
 	}
