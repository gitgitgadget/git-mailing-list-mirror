Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA44202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936334AbdIYQwS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:52:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38081 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935739AbdIYQwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:52:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so3822825pfj.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLd4IpD7scxdQCd/OTFk38avXsN1JV46GPw0ijSz0w8=;
        b=JWQXRkxsRALLQ9y6XQ6Nv+g6jvXibOoNq0gQbfa3jhwSVVvyUbZHgoAt1CWmpNSipy
         43trH0S8DCxv9v6BrNSboB5UJdG02e66ew8NnFp1VyCR08DGrRvZqU/TNWA9VWHRHpZL
         1iO6925AtC498MpJ69h6yWkrPCTpN81joaLq19KiXSujxP6TDYMjOmSxNQ89ovC/nmt6
         5QggmSfQp1r/83F4z+Kz8N1vP8p8qXpR60zmiUR/AO5AUQvMBNKC5AxSbReYEC1g3TLW
         5r7XM8NpzgLGiE4G1O9BQy/zZEi981qnpffDlsiHNCBJRhOJTWMyKCu6X1H1tLCa/WQc
         NCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLd4IpD7scxdQCd/OTFk38avXsN1JV46GPw0ijSz0w8=;
        b=gDsnO9jUHLXYMl6h40usctO9vO0B9cgASCNXPThYhe5QcSux5Eh0tebVhAb7X3FI5L
         GHl9MpqcDZ7bwZR/zytGq2ZS4poAAJ5kVDEjwy71a0DyZveITTV0ECZaNu6jjW7FmaUC
         CaiEQbdsN1tQIQogkmBIVQbUddKKVio/TIO1QD3jc4D5o+FN4E6r5n/7+lU+nVSK2AW+
         y9OhOSd/WRG59oDzj4ote6AhqcpWDSRDd5sL3iJRhIg0l/7zNkmeJLS+PS4VmNAFGmCw
         y7/+CqcbjAQnkCf3FSNedRIeUur6C3njnlJynJ3C8VD9T6JahSi/m6GaE3YLTxoIuqN7
         E2zg==
X-Gm-Message-State: AHPjjUhpaJDfx56E7QT8rtPAfTlT7JF1YW7baTXGb06cLbtHchSBCoY+
        e1TJAsg+FswOhZ+FixGE/Bc=
X-Google-Smtp-Source: AOwi7QCgQHO9IuzrD5YfOn6YEqw3gR31KSd6gQdFwE6staPn0ib3vHUjUrlEbHbCN/Wf0eRu+HVLaQ==
X-Received: by 10.99.126.84 with SMTP id o20mr8248326pgn.129.1506358336138;
        Mon, 25 Sep 2017 09:52:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id y4sm11578952pgs.19.2017.09.25.09.52.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 09:52:13 -0700 (PDT)
Date:   Mon, 25 Sep 2017 09:52:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v2 1/1] Win32: simplify loading of DLL functions
Message-ID: <20170925165211.GN27425@aiede.mtv.corp.google.com>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
 <cover.1506355545.git.johannes.schindelin@gmx.de>
 <177d34742e603aabb57046a0d5f9a5c6e40696ca.1506355545.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177d34742e603aabb57046a0d5f9a5c6e40696ca.1506355545.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> Dynamic loading of DLL functions is duplicated in several places in Git
> for Windows' source code.
>
> This patch adds a pair of macros to simplify the process: the
> DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
> ...<function-parameter-types>...) macro to be used at the beginning of a
> code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
> using the declared function. The return value of the INIT_PROC_ADDR()
> call has to be checked; If it is NULL, the function was not found in the
> specified DLL.
>
> Example:
>
>         DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
>                           LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>
>         if (!INIT_PROC_ADDR(CreateHardLinkW))
>                 return error("Could not find CreateHardLinkW() function";
>
> 	if (!CreateHardLinkW(source, target, NULL))
> 		return error("could not create hardlink from %S to %S",
> 			     source, target);
> 	return 0;
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep, this is indeed

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> ---
>  compat/win32/lazyload.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 compat/win32/lazyload.h

Thanks,
Jonathan
