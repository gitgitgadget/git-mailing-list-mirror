Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A960C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 21:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382497AbiDTV0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbiDTV0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 17:26:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A548881
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 14:23:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECF33118237;
        Wed, 20 Apr 2022 17:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=utaKdbpE+qEMUk7BxZNnpbi+qW7Pt/PbHMpFqq
        KMqPE=; b=cK88q2TYBdLODlknygpwg3k4GxjK5aX2SJuQvsWB1Sh9PrOT3iYkID
        cYM8qExtDAxeuxWxvCSo3BWi9cxqh2LiPzUtblXtvbbQhGeVUT1UJ83oLQEUdXnZ
        PBxCgcSjpnS75D634UiGZJeO2xR+3rhk2NwmnW0F8JWTE26ZhqheU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3B79118236;
        Wed, 20 Apr 2022 17:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50B6C118235;
        Wed, 20 Apr 2022 17:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     matthieu.moy@univ-lyon1.fr, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, shaoxuan.yuan02@gmail.com
Subject: Re: [PATCH v3 1/1] Documentation/ToolsForGit.txt: Tools for
 developing Git
References: <c6b48fba-c950-bb3a-3fdb-6d420a4cdfbc@univ-lyon1.fr>
        <20220420130617.41296-1-cogoni.guillaume@gmail.com>
        <20220420130617.41296-2-cogoni.guillaume@gmail.com>
Date:   Wed, 20 Apr 2022 14:23:51 -0700
In-Reply-To: <20220420130617.41296-2-cogoni.guillaume@gmail.com> (COGONI
        Guillaume's message of "Wed, 20 Apr 2022 15:06:17 +0200")
Message-ID: <xmqq35i7o3dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D2230FE-C0F0-11EC-B9F0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

COGONI Guillaume <cogoni.guillaume@gmail.com> writes:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index b20b2f94f1..509cd89aa2 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -492,17 +492,6 @@ For Perl programs:
>  
>   - Learn and use Git.pm if you need that functionality.
>  
> - - For Emacs, it's useful to put the following in
> -   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
> -
> -    ;; note the first part is useful for C editing, too
> -    ((nil . ((indent-tabs-mode . t)
> -                  (tab-width . 8)
> -                  (fill-column . 80)))
> -     (cperl-mode . ((cperl-indent-level . 8)
> -                    (cperl-extra-newline-before-brace . nil)
> -                    (cperl-merge-trailing-else . t))))
> -

Moving this out is OK as long as it is clear to readers of this
document that they can refer to the other one for tool specific
tips.

>   - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
> @@ -733,3 +722,10 @@ Writing Documentation:
>   inline substituted text+ instead of `monospaced literal text`, and with
>   the former, the part that should not get substituted must be
>   quoted/escaped.
> +
> +
> +Documentation/ToolsForGit.txt:
> +
> + This document collects tips, scripts, and configuration files to help
> + contributors working with the Git codebase use their favorite tools while
> + following the Git coding style.

This looks strangely out of place.  The preceding "sections" of this
document are 

 - general coding principle
 - specific guidelines for each language.
 - how output should read
 - how error messages should read
 - how configuration variables are named
 - how documentation pages are written

The name of a single document and explanation on what is in it does
not make a good new entry in that existing list.

If we must mention the existence of this document in the guidelines
doc, I have a feeling that a better place might be near the preface
of the second item, e.g.

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 509cd89aa2..64ff734ce7 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -43,7 +43,10 @@ the overall style of existing code. Modifications to existing
 code is expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
 
-But if you must have a list of rules, here they are.
+But if you must have a list of rules, here are some language
+specific ones.  Note that Documentation/ToolsForGit document
+has a collection of tips to help you use some external tools
+to conform to these guidelines.
 
 For shell scripts specifically (not exhaustive):
