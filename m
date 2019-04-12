Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D772120248
	for <e@80x24.org>; Fri, 12 Apr 2019 03:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDLDwY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 23:52:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35355 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfDLDwX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 23:52:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so4420905plp.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vq738eLV65bTTrGzgQrnKbqh1KBD4fh9UD1vtvmWjo8=;
        b=edJiie9iVtXGsTpH69jGdIB46u31OW6l/7msTNDPPFMg/Sstja0nnvphRMb2VLXwgw
         fUrPcQmnAOyZNiYxkIKSEuQ0RzUdmWDuycfMTVxQV9bjPXiSNVfWoCEvMhMpG/41ZFez
         Q5mCXEvu9e7TQ0QMdO8SBaiXUDsZrWy5ui+RSOoEp69+5VSO5jZRW68a33Z8eAgykcWH
         Q3iLT9T+9QvkiF6h/iWcZ7WJrFBFgckT81kxYlWOBZGLZHXHGr046O0zkftGNJg8PLhP
         X0JLtQqK4HKMyi8raGCdADhdq//hRchYM/BywBQUKmBh3Ap8pJNhT2Y9xECwdbKqO9w+
         UvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vq738eLV65bTTrGzgQrnKbqh1KBD4fh9UD1vtvmWjo8=;
        b=aj+NX4eNN7z5i48iUNziNrGiEn2t09dwx8WCXN96cccbaHakqXSB160WLELlqjyXHj
         NvVpLNyor8MAqVad+MVJzzQBZFfISbrxMzeYu00LmH7HUU91VtXyYpalhNJXIsPwfMTy
         OMYVSRvQIMLU4+lsLogVczV3PPYZzpaz26La1nmrWfBLCB6MPU/GIIp/+Qq3qT1Giuwe
         N+U1aLEy2ABpVzsiEfNaMvuP2gMdunfn1VjXPpMCZV7huGHPxqW0+cU2kZ9YPD4YQFaU
         kKVaM3pjPAq8YBHvVn1uWGSXcUxXUjxW46WnxMi51S/VXr+uMa+g2sNdtm+MpciVBOBk
         qGhA==
X-Gm-Message-State: APjAAAWzqfuohG+2vD7NHZmkmnEJVe9fOWa6uXqWj6/h1qOiIrqkRGZv
        yNpilqP1ZlflAHEPyzCq9rU=
X-Google-Smtp-Source: APXvYqzJEViTTuA2TNVbbaq0nsddxbfjPY6BWwr77nfSOXfMK0FKHJv9lTsqreHl/Ybws9swRuE08Q==
X-Received: by 2002:a17:902:2bab:: with SMTP id l40mr54498565plb.273.1555041142757;
        Thu, 11 Apr 2019 20:52:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z13sm56435790pgc.25.2019.04.11.20.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 20:52:21 -0700 (PDT)
Date:   Thu, 11 Apr 2019 20:52:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 01/10] config: initialize opts structure in
 repo_read_config()
Message-ID: <20190412035220.GA26967@google.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
 <pull.169.v3.git.gitgitgadget@gmail.com>
 <ea8c199f911a84505b1aba5735a280ffc989e2a1.1554995916.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8c199f911a84505b1aba5735a280ffc989e2a1.1554995916.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> Initialize opts structure in repo_read_config().

Good find.  I wonder if there are some flags we can turn on with
DEVELOPER=1 to prevent this kind of issue going undetected in the
future (or maybe this means we need to get the valgrind or ASan
testing modes to be fast enough for people to consistently run them).

[...]
>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
