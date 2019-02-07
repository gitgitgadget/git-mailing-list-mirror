Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDDE1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGW0X (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:26:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGW0W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:26:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id z18so1611568wrh.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8MPx5QAr2LGDQuba6/9pSUuDbmsJK9nmDAcuPz3Q3e4=;
        b=iTuSFDYN3wlWaARQrwU5IBPkWt+sT0kDCU4QDFuYYIDN7sx6QBYYDbTtpXe1cO0nYQ
         SiWIYy6mcSctwBQVc0NM5ySFt9DHgPhPDRpT65lJSuyj8U4Hsgl+y7dmL+nDVNkBvtjA
         csOX2MkbmdddBoGtncSOhX6tJzJJ0itkuj6sfjKbA55eIXMKrnoCbVJqJFCQ8X+kbEz7
         3Gx9z4tUwEiDq7LcgA84+JNq6WwuZETzbDbUrTw2FG8A+Nv0fOYfBEwAtddKoZGN0JGe
         4ATXxpb5vMMK/zfZwxCI6T4/783UTKjj+x+rswSY0u59/Aoh4M6T0+Qb4ieQ1HbulmvZ
         UJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8MPx5QAr2LGDQuba6/9pSUuDbmsJK9nmDAcuPz3Q3e4=;
        b=qKBQILjgUJlqbFmtxcmVGZrm/wxDQSdS0ZFi8qAoGiOxXtCJtyuEb6yPod7V87FD9a
         IxebOwijFmnPYv+JMX4gwZ2AnfnnQPsoWDDYJYVX5v0fxhnJlG3wfQrwZyYoRyFLagXZ
         yMmij+2t7H5FVfNEwmLPDRHUO3nR1ucSMTHmxK6nBiuRfb0lzUL+Gx+1sjjTcKZ6vlTP
         om3LjKjs4ojOWHx9RgXzODw4mxB21XTKAhSbYL1wFZYujH2k+X92Z1UqTO5M+KWWhJ1D
         pYn5sY/kjA01ZqhS0LqqEtNhx/04Mn6xQKlNaykS8pVr/Het4f1pRP0fQfGjXeTWwXpY
         JRUA==
X-Gm-Message-State: AHQUAuYt1mxWFE3d1YQmhBhJvRz8126tkv/26JAm2J6IdFuoaTbCrdox
        Rqs7ON+nLVFicfio9zuzpJ6VuXrC
X-Google-Smtp-Source: AHgI3IakVGhjSuGVHsxmQHAmujC2hhoESKFU8um2ggZ6Qs4f9rAH46gLuHvgLFxINczAjpmeGe0plQ==
X-Received: by 2002:adf:900f:: with SMTP id h15mr13917792wrh.18.1549578380538;
        Thu, 07 Feb 2019 14:26:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l20sm193547wrb.93.2019.02.07.14.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:26:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] submodule: teach set-branch subcommand
References: <cover.1549521103.git.liu.denton@gmail.com>
        <cover.1549534460.git.liu.denton@gmail.com>
        <91bb634dfad7f6a17bbed9eaf27f668326fca54e.1549534460.git.liu.denton@gmail.com>
Date:   Thu, 07 Feb 2019 14:26:19 -0800
In-Reply-To: <91bb634dfad7f6a17bbed9eaf27f668326fca54e.1549534460.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Feb 2019 02:19:00 -0800")
Message-ID: <xmqqy36rme0k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -168,6 +169,12 @@ submodule with the `--init` option.
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
>  --
> +set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
> +	Sets the default remote tracking branch for the submodule. The
> +	`--branch` option allows the remote branch to be specified. The
> +	`--default` option removes the submodule.<name>.branch configuration
> +	key, which causes the tracking branch to default to 'master'.
> +--
>  summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
>  	Show commit summary between the given commit (defaults to HEAD) and
>  	working tree/index. For a submodule in question, a series of commits

The double-dash line you added must be replaced with an empty line.
The existing double-dash is *not* a separator between the previous
entry (i.e. update) and the next entry (i.e. summary).  Rather, the
body for 'update' is enclosed in a pair of double-dash lines as it
has many paragraphs.
