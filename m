Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F7720209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbdGARfw (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:35:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35703 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdGARfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:35:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so20801919pfs.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7wHeeUOAV79r6f0iAUvh7Go0BFPZOgo0nEsWzN68Pzs=;
        b=DSOyAJK8rHDHmI7GKNHuEvQiV1I/uiDFHCvxBdIxovbTwnmk1CIGKBp39gDq49rvs/
         NpNV7MlyjmFFb0+SJAdCAfY7SCg03glzeEsWxsAsH2HsDVIXCD8smAFumY8UyBOYXIns
         Ibrnd9XAb2dBOAmPk83/P85YSV1RtA7e064qnT74zJBUyMzqD96QwdyVyxQlHwE18evG
         qdj4iOroA/ZI/wQqTzjnHPs6V2RtN0YnXrzrDq/o6gTNHAnih7cHB8sL3bvkkl86Hwea
         T3P7fMPOFdWZPIzgCCHdHmJ2RXzTcCBh2gQIrmTsIrnGIIB1uSUHZB8X3xqBggNqnj54
         vlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7wHeeUOAV79r6f0iAUvh7Go0BFPZOgo0nEsWzN68Pzs=;
        b=GfwQH2IxxIsuvkwF3VQKHjjqpdsbS2QEe+T2e8dJIuRlJzL/oHSuNREibfrqw5d2me
         r+LiG//WE+m9CbnP6G57VAPgHcdARB1FzgeijN1a6DTHAC8LObk+X43E0FDixxrgFwae
         bOI0ayjJjp0HE8HEWeV0Snlp4gb27i/c3Btym3RCbz6Qozl/oXy+bGgr0vAvPR2CvcKj
         /+tlkS/Iea1Cr5siuMBm/r4mlW7E3EwET/r+LwTx280Z1QP8tCC9SoccHX5xvY92v7AE
         OLbqqQgh4uUWDg+/kJBmhfidiYuiy9gmnhd8dJUPnLPtou4p6cA9pDkZoODeGncAdToQ
         Fd7w==
X-Gm-Message-State: AIVw113nCJHsyaFU/Txhbs1rf4Nt52ktVT4cHykJAEPMNcTnAEZyOFW7
        WVDHC79ZBVm0SQ==
X-Received: by 10.84.224.133 with SMTP id s5mr1684940plj.93.1498930550961;
        Sat, 01 Jul 2017 10:35:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id v8sm23059413pfa.10.2017.07.01.10.35.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:35:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     s_shestakov@playrix.com, kostix+git@007spb.ru,
        Matthieu.Moy@grenoble-inp.fr, tboegi@web.de, git@vger.kernel.org
Subject: Re: [PATCH] status: suppress additional warning output in plumbing modes
References: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de>
        <20170630162826.27711-1-sbeller@google.com>
Date:   Sat, 01 Jul 2017 10:35:49 -0700
In-Reply-To: <20170630162826.27711-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 30 Jun 2017 09:28:26 -0700")
Message-ID: <xmqqk23snjpm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When status is called with '--porcelain' (as implied by '-z'), we promise
> to output only messages as described in the man page.
>
> Suppress CRLF warnings.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Maybe something like this?

This looks to me like a stimulus having enough time to go to the
spinal cord to induce a knee-jerk reaction, without giving a chance
to the brain to think things through.

Surely the reported symptom may have only been about CRLF, but who
says that would be the only kind of warning that would be seen
during "status --porcelain" codepath?

I tend to agree with Ævar's "output for the script can be read from
our standard output" should probably be our first response.

The patch _is_ a good start to document that we may want to do
something differently under _PORCELAIN output modes and one location
in the code that may be a good place to make that decision, but if
we are to squelch the warnings, we should make sure we do not give
any warning, not limited to squelching the safe-crlf warning, to the
standard error, but still diagnose errors and show error messages,
or something like that, I would think.

>
>  builtin/commit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 00a01f07c3..3705d5ec6f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1126,6 +1126,11 @@ static void finalize_deferred_config(struct wt_status *s)
>  			die(_("--long and -z are incompatible"));
>  	}
>  
> +	/* suppress all additional output in porcelain mode */
> +	if (status_format == STATUS_FORMAT_PORCELAIN ||
> +	    status_format == STATUS_FORMAT_PORCELAIN_V2)
> +		safe_crlf = SAFE_CRLF_FALSE;
> +
>  	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
>  		status_format = status_deferred_config.status_format;
>  	if (status_format == STATUS_FORMAT_UNSPECIFIED)
