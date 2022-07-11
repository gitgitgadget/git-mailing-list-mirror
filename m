Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DACAC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 05:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGKFM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 01:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKFMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 01:12:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C76277
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 22:12:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EA3C130325;
        Mon, 11 Jul 2022 01:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sbjVYAHDdELu4fs54W61x9wiQvvqrZUp/F6eFb
        Rqj7o=; b=O2bTbOd/AwFteK2O47WXHNsA4VUJay6A7Po6PGOg6oKjOLCXqOKXzv
        NzVn2HACMGN4buulf8xH+qDYGQov/TAvkGVj11bjjf322ZShsdrWuSUJ5CEcQ1wL
        zOd7PBxcgn71QBVgl6BFXfywBnBBE5liNcFkCZiBo7Lbzz7EDUWwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2466C130324;
        Mon, 11 Jul 2022 01:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84E00130323;
        Mon, 11 Jul 2022 01:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: Re: [PATCH v4] gpg-interface: add function for converting trust
 level to string
References: <pull.1281.v3.git.1657341817595.gitgitgadget@gmail.com>
        <pull.1281.v4.git.1657515650587.gitgitgadget@gmail.com>
Date:   Sun, 10 Jul 2022 22:12:21 -0700
In-Reply-To: <pull.1281.v4.git.1657515650587.gitgitgadget@gmail.com> (Jaydeep
        Das via GitGitGadget's message of "Mon, 11 Jul 2022 05:00:50 +0000")
Message-ID: <xmqq35f8p70q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B94F854-00D8-11ED-9EDC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>       -				strbuf_addstr(sb, "ultimate");
>       -				break;
>       -			}
>      -+			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
>      -+			if (sig_str)
>      -+				strbuf_addstr(sb, sig_str);
>      -+			free(sig_str);
>      ++			strbuf_addstr(sb, gpg_trust_level_to_str(c->signature_check.trust_level));

This part of the range-diff is the most pleasant to see.

Will queue.  Thanks.
