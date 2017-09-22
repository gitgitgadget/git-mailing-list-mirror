Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE85B202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdIVA7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 20:59:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37338 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdIVA7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 20:59:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id e69so3111579pfg.4
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPDWFcRW/tfIpLmGyqnt96d7tZq/0Q6bmlY4LnRPgNc=;
        b=jDSxuVbsqlmepO0oUs1TjwfKgpBK/dd4BX6dyrlz7WO0ZhEjYvDOGdY/Nhzzt4txGy
         wIjeSWVvOWM1+lwaxtJPj2sRf/gm242YskeI+OfxllT2W3OCFOw93I5ngJ1dOYLPLFED
         51J7YutSHCVwP4v3ecOIPjwgXYSEJzruq9q/bxwFilfhYlE5JcPd6X+/HYqUQxqhbd4N
         5HjbwakW+FiI97HV7vxtKvGhcmgF2TLQhbjlAvBfYfV91+j9uGuYwWqJgU4EWrx5FgYc
         eFVi2EIXriKcy4nIcnBQ3DHGEMQvWzH8Gi3SsZo0pYYCmNOOrDJGkjjSiINPUQhXCG8g
         4N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPDWFcRW/tfIpLmGyqnt96d7tZq/0Q6bmlY4LnRPgNc=;
        b=aGscDqIJuRc86l8waaNCWRbN3m482LbPRojpsmk/ZjU60Hj46X9E1QMwyEoNR+vZpg
         tkECcSX4+XDNR8qWzNpAMx54T60Jdo6Kg16fdL5+3KdI8d6Fs0N3/PrLa3N7toDV67iB
         82dVkrLTH/EWWTCpdiXbi5zRZbGfQm3otE4jJMD+1/z+yLj/vgbTsi6+Omrn0yZy4Irj
         QNhk/w3BCkGioLjbyVKruHccRPhJJMReQq0E4kTWoWQjfH7FbVUM91GUxv7oQmo+PR56
         Ew9N0QIG+PhotnlLGDXstQDzdFxOuLmv6cU3Gok42hzl6FK5PaOiESvfdekqQbUkLnYt
         noxA==
X-Gm-Message-State: AHPjjUh/CfNBrXtdoKvSaP7ETNjZFwF6b5A2y/oNPfxbw0EsRHvG43Ij
        bOcoD7dfX5Q+VUtWnVbfrfU=
X-Google-Smtp-Source: AOwi7QAgWCA0v6AHsdSKdGzRlfsKVW9SHE6LTCD/GkXUlqnIrTT2Gid9ZiNgdA2I5VZ4lHEGEgCypg==
X-Received: by 10.99.42.72 with SMTP id q69mr7403635pgq.379.1506041940456;
        Thu, 21 Sep 2017 17:59:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:217a:913b:5a28:6f69])
        by smtp.gmail.com with ESMTPSA id b90sm5430009pfm.17.2017.09.21.17.58.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 17:58:59 -0700 (PDT)
Date:   Thu, 21 Sep 2017 17:58:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] cat-file: handle NULL object_context.path
Message-ID: <20170922005857.GK27425@aiede.mtv.corp.google.com>
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
 <20170921062140.cyfjv7rfuppqpblh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921062140.cyfjv7rfuppqpblh@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Commit dc944b65f1 (get_sha1_with_context: dynamically
> allocate oc->path, 2017-05-19) changed the rules that
> callers must follow for seeing if we parsed a path in the
> object name. The rules switched from "check if the oc.path
> buffer is empty" to "check if the oc.path pointer is NULL".
> But that commit forgot to update some sites in
> cat_one_file(), meaning we might dereference a NULL pointer.
>
> You can see this by making a path-aware request like
> --textconv without specifying --path, and giving an object
> name that doesn't have a path in it. Like:
>
>   git cat-file --textconv HEAD
>
> which will reliably segfault.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c          | 4 ++--
>  t/t8010-cat-file-filters.sh | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)

Yikes.  Commit dc944b65f1 even touched this function, so we reviewers
have no excuse for not having found it.

Technically this changes the behavior of cat-file --path='', but I
don't think that matters.

Do other GET_SHA1_RECORD_PATH callers need similar treatment?

* builtin/grep.c appears to do the right thing (it stores NULL in
  list, so it passes NULL to grep_object, which calls grep_oid, which
  calls grep_source_init, which stores NULL for the grep machinery
  that is able to cope with a NULL).

* builtin/log.c is correctly updated as part of the patch.

Those are the only other callers.  So we're safe. *phew*

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
