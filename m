Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5911F516
	for <e@80x24.org>; Mon, 25 Jun 2018 17:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbeFYR11 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 13:27:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeFYR11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 13:27:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so14510441wro.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QaBwJvRyI9LcuyNTwp0E6MygWqaXbiC/y9/CFZUvIcE=;
        b=ZLKz7298s18/PRsVxF/TIz68hrj9/Y/woNmVwU1Zk0EaBnecrjNF4YJcYWbeykhf3q
         TMqdXwWrqrpsqlCHRREERm1Rp04Y9sRiNiGgDxXHnea2zpv7ws0SjEawyTir0viMwZus
         Cy0Z5Y+tczuDxmNvzw9TtGz7ZNiXa39kyuQQa6fguz/1Yvt56owey/AogChwiWqfD35O
         +G1PIleNdP7rRqiP/mPjnG8rfrbyOYT0hjFYXUjY432dJnAOdfm2Pl1yBT8Fh90MI97H
         sDLFhmvcycyHWWuTMhL+3uMpvxflGwx4Auz/jGYv/bNP8/XhupIsF2VgZs3qod50NGth
         SqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QaBwJvRyI9LcuyNTwp0E6MygWqaXbiC/y9/CFZUvIcE=;
        b=mxX44yf/BkLbdaqwibe7PPsO9MNZ0niN7cEH4PRQbTTDKvpFB2Ugl8x+Ix90wiRpwc
         eHvouj6Y9xSZ553fGKAdiexZhQTDmg6fSHDWZ5sylui29Ltn1o8qzosMTrXYkQkseYoc
         x4JxvyYbJ3mokNqxfQ/lAqULD2P7bv+6tY4OfVKOr2TGekG0ylHE1K7FUuUfljGEkU8b
         lK12w4aAHZLCDj9xxbZEX9cv1QVAXN6SPq+tubN4Wd8zGckiaV1/7nYbngiawtjQaroH
         Cc8PFzYzNR+pTlf1f9RC1h1OcUxFXqVaRDLghiIULIglxudcOltNyJZW43x/uUB/HiZA
         T2RQ==
X-Gm-Message-State: APt69E3SYEr3O6bdIMgu5On7mhQCzXNXj4R4toAYpVIzGFD7MWL7d6P/
        C7F0HtBhrOy4QB+hNiiuW/c=
X-Google-Smtp-Source: AAOMgpf/CmT8wFL6yIWxwUKPfDkJoZH8C69QBo0cXhrBCXNwVUWxxeooy4aRn8y1MirbQl03Vq6amg==
X-Received: by 2002:a5d:46c6:: with SMTP id g6-v6mr10537844wrs.76.1529947645364;
        Mon, 25 Jun 2018 10:27:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m10-v6sm12717276wrn.93.2018.06.25.10.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:27:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/15] apply.c: stop using index compat macros
References: <20180616054157.32433-1-pclouds@gmail.com>
        <20180616054157.32433-3-pclouds@gmail.com>
Date:   Mon, 25 Jun 2018 10:27:23 -0700
In-Reply-To: <20180616054157.32433-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 16 Jun 2018 07:41:44 +0200")
Message-ID: <xmqqbmbypyis.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  apply.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)

Until all the codepaths that reach these callsites to index_*
functions from cmd_main() are converted to pass "struct index_state
*" throughout, a step like this patch does fundamentally changes
nothing.  The only two issues worth addressing in this area still
remain.  All the lines we see here still depend on the existence of
"the_index" instance, and they can only operate on that single
"the_index" instance and nothing else.

It is true that the dependency has been made more explicit, but it
already is explicit (to see them you just say "no-the-index-macros"
and see what fails to compile).

I see others are enthused with this series, but seeing the changes
like these I am not all that impressed.

Would it become hard to review if we combine this step *and* the
next logical step (i.e. pass the "struct index_state" throughout the
callflow) into a single patch?  The functions in apply.c are fairly
well isolated and there won't be all that heavy interaction with the
outside world if we convert this file (and it alone) without
touchning the other files.  If a division in that direction is
possible, it may make a better orgainzation (i.e.  instead of doing
whole-tree superficial conversion that needs to be fixed up again
later, do a deep full conversion on selected files before going on
to next set of files).

