Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD11E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGLTXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:23:44 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42551 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeGLTXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:23:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id e7-v6so3213494wrs.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QkKieubCNW5mUOw73Vwcakki7VvwVo8KEbxndZVnDaI=;
        b=oFfw24woApNoqvi7U3dmqunH6XKdSZmikCo1rjpi0GXk63JTXQfw84lMRGSqzeba+g
         A5QEkacBfYt5nfLygL3YQIXMNwMQRh3Fr/ACTWUKZ9GIHTFrzYSumVxkwJN/ohpEF6o3
         TwW1GiN4kCObVPh57dUiFsY87obgivwJFS5Rulk0FQTG7FuLoXXqvbpn0fgys4kr/eZt
         xRUHtv8QqwN/O8P+1y979mdIglPNd705hKu7D0Fk+ajsBDfOmeIMAhZccqqUZb1zNGci
         FcpPni5lHex6/1iEObr7AHRrY6tBh+JVzbr/aq+Hu2oJPdcl+kNlxytzvVSTaB6NjRTr
         c7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QkKieubCNW5mUOw73Vwcakki7VvwVo8KEbxndZVnDaI=;
        b=eVBhCNmhiB/rq3sfUN2In4ZSDWYdcT+jked2pf1LB1jiYPgGyVkiAVfGCVzgR69+/Z
         XWO7/T7kVxV3czesrD4WXhtHhyiHCrMQw6vsOa1dmUXQhhR7ilDFRTmiRvGImbGAvNx5
         4cdiXxgIVqLL8RUJO67HMVVAYIRTGx2lUYaDPUZhyXEPwHwTEvMUSbBb3U/9uhm7DWGf
         N5O0a59xQanzioiNZ0EQSifRI17zihARV1FC3fYdgXNrc4UeoKPslnS3hnXdzn9lQhdO
         +Id0EqxhoUhppY431ZVp5rPURFVcq7lBqcb66jLSpqyAGucKNc+OL9u0bpvD0lcee4MI
         OhvA==
X-Gm-Message-State: AOUpUlFj3EmxJZ4Bm3jZSOVMPe2YLnsWCQxvMHRPU9ECb9kTh8VEUZZ/
        V3wwTCCpY1MXM3RNku60zbA=
X-Google-Smtp-Source: AAOMgpfMo0SqH/E/xWzui0Gue7TLGeazjShSAfmXdV/DTzVhhTtQwY4UyIWRrui9dZZbYecwfhnyQA==
X-Received: by 2002:adf:9485:: with SMTP id 5-v6mr2844317wrr.82.1531422770326;
        Thu, 12 Jul 2018 12:12:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x124-v6sm5211982wmg.38.2018.07.12.12.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:12:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] handle lower case drive letters on Windows
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <20180712154419.18100-1-benpeart@microsoft.com>
Date:   Thu, 12 Jul 2018 12:12:49 -0700
In-Reply-To: <20180712154419.18100-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 12 Jul 2018 15:44:36 +0000")
Message-ID: <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> On Windows, if a tool calls SetCurrentDirectory with a lower case drive
> letter, the subsequent call to GetCurrentDirectory will return the same
> lower case drive letter. Powershell, for example, does not normalize the
> path. If that happens, test-drop-caches will error out as it does not
> correctly to handle lower case drive letters.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---

Thanks.  Will replace, even though showing the whole Buffer (I am
guessing it is the equivalent of result from getcwd(3) call) and
complaining about drive "letter" feels a bit strange ;-)

> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/1ff8de1b6c
>     Checkout: git fetch https://github.com/benpeart/git drop-caches-v3 && git checkout 1ff8de1b6c
>     
>     ### Interdiff (v2..v3):
>     
>     diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
>     index 37047189c3..f65e301f9d 100644
>     --- a/t/helper/test-drop-caches.c
>     +++ b/t/helper/test-drop-caches.c
>     @@ -16,8 +16,8 @@ static int cmd_sync(void)
>      	if ((0 == dwRet) || (dwRet > MAX_PATH))
>      		return error("Error getting current directory");
>     
>     -	if ((toupper(Buffer[0]) < 'A') || (toupper(Buffer[0]) > 'Z'))
>     -		return error("Invalid drive letter '%c'", Buffer[0]);
>     +	if (!has_dos_drive_prefix(Buffer))
>     +		return error("'%s': invalid drive letter", Buffer);
>     
>      	szVolumeAccessPath[4] = Buffer[0];
>      	hVolWrite = CreateFile(szVolumeAccessPath, GENERIC_READ | GENERIC_WRITE,
>     
>     ### Patches
>
>  t/helper/test-drop-caches.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> index d6bcfddf13..f65e301f9d 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -16,8 +16,8 @@ static int cmd_sync(void)
>  	if ((0 == dwRet) || (dwRet > MAX_PATH))
>  		return error("Error getting current directory");
>  
> -	if ((Buffer[0] < 'A') || (Buffer[0] > 'Z'))
> -		return error("Invalid drive letter '%c'", Buffer[0]);
> +	if (!has_dos_drive_prefix(Buffer))
> +		return error("'%s': invalid drive letter", Buffer);
>  
>  	szVolumeAccessPath[4] = Buffer[0];
>  	hVolWrite = CreateFile(szVolumeAccessPath, GENERIC_READ | GENERIC_WRITE,
>
> base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
