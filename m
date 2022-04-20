Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiDTGTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359497AbiDTGTt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 02:19:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D7D39B87
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 23:17:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 2so1015653pjw.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BIZSp7IVphnnhMDYjeqbU8PeOS1U0bg0nk24l8E/M1Q=;
        b=jATRqtZsbC4GdENGrsE1AbC8xiPreUzCdJxQ+ElcUKavCS8kDD/svKaIBC09/agfOm
         qEsaq4xWTSxhcBAtdMIWZdgTUrg50Hgt3HNpY0d569wT8gFeFAAnF8ynqNs0gR1PmbJ4
         pUH0UjQBRHEB1/qR853PLZtnauZ8VqlhBMqfQCKV9im9iZg/FPZZ1liczjpPgg7onK1n
         WcypqInMDKALs7J22PCUS6+WzD9jXd6X75EzbwXrTQ4Dpw6XoRQgfk+Qp90g2/YPvWtM
         gwktN+pDY4PzZQxxyPQ81vK8ZCPjsdQT0UfWCFhzNSVD9t0mx3KH2F3eGQsoVD+drW6/
         TlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BIZSp7IVphnnhMDYjeqbU8PeOS1U0bg0nk24l8E/M1Q=;
        b=4MM5+NzAxOOq8Bqpf8iaUinJsT0jdJQsWiDxfFKXH+S3gmk77fomi9f3H95xMuqLua
         HcjWzNLfu96180Mbupz76Ele+hh9+9tD4ebJxe+NciP4TSlb0Ll4jxdOPA25377U57lt
         8GU6gL2QY8xJQgKVhgw6R96hPJVhzzy8ZpORJnzxIYGQ04mxXiJYmVhOplQlfeEN3pyH
         ZYzAaIXQe+L+D/+9XXpRjxkrma7IiCnDD4TzCVx1LsraRuhtzToczEj+4Vbo3/EekBPJ
         FPOP1PBRxI+cdw8LUo8w0rHjQgK6/yb8kYGR3X1zlwbjnih2S/pa/Gi5CKp6S4gtIQkz
         Ldeg==
X-Gm-Message-State: AOAM530dlPAYl7UB4cNBlpXllvQGhvpYWpfbNy+xp2VjrFssapFjZ4HW
        BnQgb6NusjEAsJs9mpyyByD9ZgqGBBI=
X-Google-Smtp-Source: ABdhPJznTxf9guYOpURg3Wlw5RGm2GfDxWntiUqE1i6tRX4liD+SCUGbPjyA6k71c2UldWNec+eXlQ==
X-Received: by 2002:a17:902:bd05:b0:158:544d:6557 with SMTP id p5-20020a170902bd0500b00158544d6557mr19629526pls.70.1650435421315;
        Tue, 19 Apr 2022 23:17:01 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm21529594pjn.14.2022.04.19.23.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:17:00 -0700 (PDT)
Message-ID: <e689bb30-dc7f-6e3d-a8d5-864e00de59d4@gmail.com>
Date:   Wed, 20 Apr 2022 13:16:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Recent changes for the unsafe directory handling - TINY
 improvement requested in error output
Content-Language: en-US
To:     Nathan Neulinger <nneul@neulinger.org>, git@vger.kernel.org
References: <ec588ff7-b300-bc3a-b51c-67d190b27e9b@neulinger.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ec588ff7-b300-bc3a-b51c-67d190b27e9b@neulinger.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/19/22 18:26, Nathan Neulinger wrote:
> However, if you do a 'git diff' - such as what you might naturally do right before attempting a 'git commit' - you do NOT get any useful response:
> 
>   root@SERVER:/local/APPNAME/bin# git diff
>   warning: Not a git repository. Use --no-index to compare two paths outside a working tree
>   usage: git diff --no-index [<options>] <path> <path>
>   ...snip-long-diff-help...
> 
> Please consider a small improvement to have the git diff help output (if displayed due to the repo exclusion warning) - ALSO display the 'git config' suggestion at the end of the output, instead of me having to remember - oh, go issue status to get the command hint to go set the exclusion. Would also be useful to have the git diff output do the same 'unsafe repository' message about ownership.
> 

I assumed that you have /local/APPNAME/bin shared by users (maybe via
NFS or something else), right?

I agreed with your suggestion. Also, I think usage help for git diff
in this case just add noise.

-- 
An old man doll... just what I always wanted! - Clara
