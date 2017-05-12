Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B95320188
	for <e@80x24.org>; Fri, 12 May 2017 06:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755742AbdELG1I (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 02:27:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33385 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdELG1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 02:27:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so6420541pgc.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lMJUHD7sc6ByCKFntlpYoALEgimT5+szB6CSGjqng2Y=;
        b=pEQ4ywxsnTGTvh0w0HgTAmBX8C3scwEKJwIg5/vVJvF7HZBs8vXLhejRcoQUM1ovqQ
         7bh62e/zgAClBkILh4qFMfZAiy8TM3KGdnkMV82MK4cAf2pPsG+8CLGlN7RRTL5piB4J
         0M1chIl5LPKtytcln+GLqGz9rKSHWi8YpptULem6+NGRP4ULjGQGCFoW97ivEWNiVRLy
         xqnJEEgxQtDOIo9W53gcg/6Vig7Wdi3v/z6BcKbVjhxfVxqUNGCdsqqoY7VJmx3AiDyU
         UkEVo/9b9lOcsljxxEvZrUr40M0jW/8WG+0dtOUY7wJwbOJnpjWhBCZb8eHs3TyoP9Ny
         XJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lMJUHD7sc6ByCKFntlpYoALEgimT5+szB6CSGjqng2Y=;
        b=GCpIOfKHm+78cym4uHLlvLLzf8UuU2SO6ldhsRpmsj7UzRsloZXmf5Q9fQCsB546AR
         Edall+3Fp5vNnIflrL/eJ7aeyu4ZqgYN4RocarpqHmCdXOiI+A/AZ9FPmcNKXSyegE6V
         lVWWG4mvw6f1l9uBiasACDz99rDOsC3JD6Fb+bzyj15dyxFm4+2hmHJeFadk+wi3biG/
         ks0jBWtGK74JBMCp2e2xGw92+lUWI44qQoqWbPX/s1k2IZChaHyROoUTzH9EJ/vJI448
         rI2ZZvYKCXxyzvLYmVHmordp6EQj7rj0Ybk6UDxnEPNi8kJmI56sOe6gphmDhjamy+aZ
         bJrA==
X-Gm-Message-State: AODbwcBn/P5BTZcywV9CJuHujY6WddEQpWWtBioZmq2YMXHNLea6a0GE
        JxL8xjJAIexZKg==
X-Received: by 10.99.157.138 with SMTP id i132mr2701377pgd.87.1494570426535;
        Thu, 11 May 2017 23:27:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id r14sm3877991pfe.9.2017.05.11.23.27.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 23:27:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] git-filter-branch:
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170511120634.17683-1-jn.avila@free.fr>
        <20170511120634.17683-3-jn.avila@free.fr>
Date:   Fri, 12 May 2017 15:27:04 +0900
In-Reply-To: <20170511120634.17683-3-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Thu, 11 May 2017 14:06:34 +0200")
Message-ID: <xmqqy3u26153.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> Subject: Re: [PATCH v3 3/3] git-filter-branch:

Forgot the body of the single-liner summary?  In the meantime I'll
queue this as:

	Subject: git-filter-branch: be more direct in an error message

>  test -s "$tempdir"/heads ||
> -	die "Which ref do you want to rewrite?"
> +	die "You must specify a ref to rewrite."

Sounds OK, even though this (both the old and the new phrasing)
makes me wonder if the program can rewrite only one ref, or it can
accept more than one.

Thanks.
