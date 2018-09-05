Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713FA1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 23:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeIFENb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 00:13:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFENa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 00:13:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so4250840pff.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xLLXXwDpn0U0vQ2fVfMG4J30DuaHKfMypO4pkL14XeU=;
        b=BfODERO5j9d4vmKBzyAhbmjESSHd8PT1xSzy8jkybKW2jvGVbNctGkh9KhyfySpgvZ
         /2w8s+lHpRTXG3868geQHgO0CspFLiAy0Q/NF7cjMpESAeXZyLk7LcA3f77rkHwx4mel
         oXXJbrERsXmpzylzV/wKlVVqrkOKVG335ByJUWpFUt77JGY5oCx+nSZQCuZPTL4ibquC
         q0xxPg0uMK9zM82xWmiKajGVd5yvLuuRj1qrMNef8xxYJSrLXJKdJd4ZtuNTAlsyFIU4
         TvB0VKglSTJ7yvNfD5tOec9CJUzH2WOVF7RDYNTD/tnChNOOQzTF2oBGqU9vJ9Ea5966
         hZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLLXXwDpn0U0vQ2fVfMG4J30DuaHKfMypO4pkL14XeU=;
        b=qUjUEgpN3QZj31VyuMy23nS+5V9FJ/Xj46VDmjPdRBvmc/A216fVTLYOyCtl9kIwvd
         XeB5Bfaa2Wmx75aPUHG2FnwI1RVpVthlA9BQvcnZhHdYzXn+TwxgaDFH2b20MTlfKFJ8
         kzIbDodRPXIaObR46G3A5PW5i3XKm56hh1qmPDuU79wm+kIITqUwwwvn6RyA1tWhjAxX
         v5uxVUeDy6VhnIy6e2S+OWoQ6ibR8KQf3euerdi2/fdrkam70eh5QXv5YR8sIxgUvxJc
         WnNxgfQIcEcSu9Q2WwDN4i5M0qzDWY3AAsk6t3wOZQF2yihV9aPJW+EZh6g1Mm4iS9Ja
         kCQQ==
X-Gm-Message-State: APzg51B5phn8YDQZbRqf0BwcO1/DlrUoZp8RMGkt1zaCxEeMXJqHMXyl
        wSKZ4RqnUBp4gI4RuopqyC8=
X-Google-Smtp-Source: ANB0VdYSYBzTwaMRqQuAlfLo+GhmkTGdcrpvdVwX/Q13D42ek4Jvu2DC7OdFLlI8wbIS4y1d03rDNQ==
X-Received: by 2002:a63:4f14:: with SMTP id d20-v6mr74754pgb.121.1536190860343;
        Wed, 05 Sep 2018 16:41:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a16-v6sm3470776pgv.29.2018.09.05.16.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:40:59 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:40:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] submodule.c: convert submodule_move_head new
 argument to object id
Message-ID: <20180905234057.GF120842@aiede.svl.corp.google.com>
References: <20180905231952.28145-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905231952.28145-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Subject: submodule.c: convert submodule_move_head new argument to object id

Same nit as in https://public-inbox.org/git/20180905233203.GE120842@aiede.svl.corp.google.com/
applies about wondering which subsystem this is in.

[...]
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1597,9 +1597,9 @@ static void submodule_reset_index(const char *path)
>   * pass NULL for old or new respectively.
>   */
>  int submodule_move_head(const char *path,
> -			 const char *old_head,
> -			 const char *new_head,
> -			 unsigned flags)
> +			const char *old_head,
> +			const struct object_id *new_oid,
> +			unsigned flags)

This seems oddly asymmetrical.  Should the old value be passed as an
object_id as well?

Curious,
Jonathan
