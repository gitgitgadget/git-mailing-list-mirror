Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD1F201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdEPE7G (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:59:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33015 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEPE7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:59:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so8159118pfe.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k1J2ycBWAbXx3FbhThkOB6KGVyk8YWgSyua1P7Uw3Jg=;
        b=Z51AVagLX/ltSeOw87dyp8vyCZa1b2P7vira3MvTTWqu4flHqjXhqCyfjuBYBakNnL
         HriIfA7PvI67IGRT5NdQBk5K0MzFxjQjvyUKiYWlLifuRys9vFSB91Bmotefhhhzu67z
         S+JSW3zkhuVQAOeaQxTbEuBe1kHs4nfhZwSB1LMkKEVEKa5yoJtbrxogrbVZkl6GkznU
         mbcPwqT0dVG/eAWMPjc/gPaDVUPVSP3Z3yOscxVM20XY1pkmUczDp7WU3dH7c16KZtpk
         TN6XUjR7n+woTTAz0ErnUpXIgkwp1+kYV869qsPyY8xKXNkYur+O3GQnh/GtIYfRXYih
         VlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k1J2ycBWAbXx3FbhThkOB6KGVyk8YWgSyua1P7Uw3Jg=;
        b=jE1xmfJuj5W8SfYbvAHXOyIQ16xtgFdgb2QqOyR1bEbdP+9AtqmtvyZlG1ZT9rtUZb
         LeoPK++AiIPOmN+R74GygXNk4jVcaEVTCLOdF7s2d2GXlYWZkO8+9tBr8OQvQb+khNdb
         PL9XUSV17EXGXYw/vuy4tQFJKvxF0QkSM7gkAbiOlYBkndKTyNQB6rkui+DG8nPbER3x
         R3FkGJ8Zm26LoCB12m7+jdssR8XInN1syGYTfzWha7nvufidQeP0svS9VvE5hI2/mQk/
         rIwgemOCAzK3FHtFxPBjODAS7OKnxMp8KnJghCpmWgEfctY4+grVvE9n3DtQmUOlSjl0
         jLDA==
X-Gm-Message-State: AODbwcA+U9TLiQ+457exjgZHEWh9eFlgWgS2zN35yRNlW2+tYtgOiezL
        1BRnzEwu1hK3Ug==
X-Received: by 10.98.112.134 with SMTP id l128mr10029022pfc.161.1494910745042;
        Mon, 15 May 2017 21:59:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id r69sm23544127pfi.33.2017.05.15.21.59.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:59:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: Re: [PATCH v1 3/5] fsmonitor: add test cases for fsmonitor extension
References: <20170515191347.1892-1-benpeart@microsoft.com>
        <20170515191347.1892-4-benpeart@microsoft.com>
Date:   Tue, 16 May 2017 13:59:03 +0900
In-Reply-To: <20170515191347.1892-4-benpeart@microsoft.com> (Ben Peart's
        message of "Mon, 15 May 2017 15:13:45 -0400")
Message-ID: <xmqq60h12y94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Add test cases that ensure status results are correct when using the new
> fsmonitor extension.  Test untracked, modified, and new files by
> ensuring the results are identical to when not using the extension.
>
> Add a test to ensure updates to the index properly mark corresponding
> entries in the index extension as dirty so that the status is correct
> after commands that modify the index but don't trigger changes in the
> working directory.
>
> Add a test that verifies that if the fsmonitor extension doesn't tell
> git about a change, it doesn't discover it on its own.  This ensures
> git is honoring the extension and that we get the performance benefits
> desired.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  t/t7519-status-fsmonitor.sh | 134 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 t/t7519-status-fsmonitor.sh

Please make this executable.

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> new file mode 100644
> index 0000000000..2d63efc27b
> --- /dev/null
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -0,0 +1,134 @@
> ...
> +# Ensure commands that call refresh_index() to move the index back in time
> +# properly invalidate the fsmonitor cache
> +...
> +	git status >output &&
> +	git -c core.fsmonitor=false status >expect &&
> +	test_i18ncmp expect output
> +'

Hmm. I wonder if we can somehow detect the case where we got the
correct and expected result only because fsmonitor was not in
effect, even though the test requested it to be used?  Not limited
to this particular test piece, but applies to all of them in this
file.
