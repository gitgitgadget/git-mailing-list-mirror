Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397AF20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 01:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdFABua (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 21:50:30 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34685 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdFABu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 21:50:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so23092698pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VhOPcppXPSjj6QfsFJGVoivLbMMfMk095bvliPfNNBE=;
        b=El4Ryxk4NHwMOiz/CpLwZrdBXmfVGU2Da5Z+NglLzwfhLP8+e+KkQebNhWcSrnRduF
         dfMANTCKZ83hND/0HIMNnebusiFcKRLyDxBqDUPS0gWkjgW0x8Au4XJPvxJuTw0mlJV0
         4lWBsOQm14Eassim2QiUH/isYvb/coDtZU1IWjDj3XAscsDBx9Up94/tainIQyaSrhti
         d4uYLAzV2W3LIZIeJstBdBDKBl0iqQCRKDSNBLtInAG1YiSlUsduSyPjrNVjw0x5E/Y3
         b2QsrdV+opLdXuvjB/WCszlNIAfM9eu5Miania/vskA4cwTJJ82HzxJv2YpDJos9vtUn
         wVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VhOPcppXPSjj6QfsFJGVoivLbMMfMk095bvliPfNNBE=;
        b=PcXzSDYimmWdvtXtHYVT9vqTX+3NVnbM71bVCol0Ht2ioPNYfbKy2O5fNXUlKxuX6L
         GylS71t8fi0aORPHDOFpAv84sBIKyuRGgL6EPq1NsyUmzm4pn+jD2Z1Oc8AkaneUUCLP
         FJlT8MqSZY/UgXm/MGTzVlzb1igV+NjugTjJ8wxpsFgUmt9NdtWHY3mzkCYdWhCPDwsU
         tgjJ546vnMEYPuyUCRicSs+OBYFLQ5qb8hYI3AYXD0zYZk5bZVz39C2Ag/etwjY0aMDx
         i1/XOd79SD8NSUhSmhVyI7bcEWQg0vu6ESy7OF8/6QzP9cSN86RFjHP0tvAX2belOPOW
         uazw==
X-Gm-Message-State: AODbwcC3HtAarShdpT2SPT2AN+a7HWM+XSqInUUrdZKf/YDSNkwAi+h5
        kLSueC4uXomfvQ==
X-Received: by 10.99.117.26 with SMTP id q26mr35909688pgc.21.1496281828518;
        Wed, 31 May 2017 18:50:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id y22sm33232444pgc.13.2017.05.31.18.50.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 18:50:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v2 2/6] branch: add copy branch option
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
        <0102015c60dcf680-4a036e9e-c152-41d2-a932-b44c1a5bf68e-000000@eu-west-1.amazonses.com>
Date:   Thu, 01 Jun 2017 10:50:27 +0900
In-Reply-To: <0102015c60dcf680-4a036e9e-c152-41d2-a932-b44c1a5bf68e-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Wed, 31 May 2017 23:35:12 +0000")
Message-ID: <xmqqfufk8oik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Adds copy branch option available using -c or -C (forcefully).
>
> Includes a lot of function renames and their signature changes in order
> to introduce a new function parameter - flag 'copy' which determines
> whether those functions should do operation copy or move.
>
> Additionally, this changes a lot of other files wherever the renamed
> functions were used. By default copy=0 is passed at all those places so
> that they keep behaving the way they were, before these changes.

Things like rename_branch() that is narrowly confined inside a
single program (i.e. builtin/branch.c), if renaming and copying
shares a lot of logic and there is only a single caller to rename,
it may be OK to rename the function to rename_or_copy_branch() and
pass a new "are we doing copy or move?" parameter, but for lower
level infrastructure like config_rename_section(), I am afraid to
say that such a change is totally unacceptable.  When the current
callers are content with rename_section(), and have no need to ever
copy, why should they be forced tocall copy-or-rename with copy set
to 0?

When the original code looks like:


    == caller (there are many) ==

    rename_it(a, b);

    == implementation (only one) ==

    int rename_it(src, dst) {
	... logic to create dst by copying src ...
	... logic to remove src ...
    }

You could introduce a common helper

    == implementation ==

    int rename_or_copy_it(src, dst, copy?) {
	... logic to create dst by copying src ...
	if (!copy?) {
	    ... logic to remove src ...
	}
    }

but to help the current code (and possibly code somebody _else_ is
developing elsewhere), you can also do it in a much less disruptive
way.

    == implementation ==

    static int rename_or_copy_it(src, dst, copy?) {
	... logic to create dst by copying src ...
	if (!copy?) {
	    ... logic to remove src ...
	}
    }

    int rename_it(src, dst) {
	return rename_or_copy_it(src, dst, 0);
    }

    int copy_it(src, dst) {
	return rename_or_copy_it(src, dst, 1);
    }

Existing callers of "rename" that are not interested in your new
"copy" thing can be left oblivious to it if you did it that way.

