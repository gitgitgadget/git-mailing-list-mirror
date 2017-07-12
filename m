Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541102035A
	for <e@80x24.org>; Wed, 12 Jul 2017 00:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbdGLAAr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 20:00:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36443 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbdGLAAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 20:00:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so876955pfk.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6BodWflJzC3rvjZd9c08Suvl0FbOVp36qIdtPz4HlQ=;
        b=N359DNeaHERmYnf0nUK8ETSS4Ze58F4xoFE2lOSI547qOJ5O3MGaFCHg86d4QmOJLQ
         RSQ+P6415Qu9MChsMHh9aT7jblCgWTR74AjPSupm+1bCZXHnetd4HfbRvxdRLvjwKQhc
         A2wNozKGt/OeEMSqoSMJ4bJ5F8rkpKa506JzXeBDwPjG9hOhGeJGniUsuJpQehyBAipI
         5zIG8eylkTrbwU+N6Kg2N/xjjPbxr6SFk3gJj14MNZDbuioSfUvYfUgfgBPUpP9nA25F
         HOj5mqyc0jS3McYNQ31fq1jK82xSjXB2uo1fWmks81y3PtzEamfPoaE0aJvyIq2CiH23
         cv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6BodWflJzC3rvjZd9c08Suvl0FbOVp36qIdtPz4HlQ=;
        b=eOObAwAZdyIhTmmTYbOu6PSl+ZD76j5wtMCMowGwxS0vJrBb11LDKBhY8VJXHgyQsT
         PkMZObeeWZjTg+1XhronK6reRmEcd3E/nyEwnJ6HxXaMNnLPKe2/fWCT6YiSeolJJvkA
         cdIwMHfmuxGOUwe1y+9pHcLNpiWtG5r9TJ7Y/APCJepmiSue1IDg56rp4Pqbtt3P7iQJ
         n458u0gz3Ejn5pLFvS36cTAN9oTnZX0brHrOTN1kyRIgWN3eDCFmBgG84cgKUkC14sFK
         U/pcbIqZor3jqPv5g+yoNwfqUVvjiTSszrlxLw7PAls3BooAXEtu2AfjJ6M4toc0TEY/
         lk9Q==
X-Gm-Message-State: AIVw112kxBZXxiC5ppnUjfDoLHgwVQ+SjzPdbh+D3CNQYxIQ0ePfsK2j
        nDJAGHg6A7KcV2OTN5g=
X-Received: by 10.98.204.23 with SMTP id a23mr53043673pfg.59.1499817645794;
        Tue, 11 Jul 2017 17:00:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:114c:7a1:940:72cc])
        by smtp.gmail.com with ESMTPSA id n71sm813523pfi.95.2017.07.11.17.00.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 17:00:44 -0700 (PDT)
Date:   Tue, 11 Jul 2017 17:00:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
Message-ID: <20170712000042.GC93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711220408.173269-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Have the index state which is stored in 'the_repository' be a pointer to
> the in-core instead 'the_index'.  This makes it easier to begin
> transitioning more parts of the code base to operate on a 'struct
> repository'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/setup.c b/setup.c
> index 860507e1f..b370bf3c1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1123,6 +1123,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			setup_git_env();
>  		}
>  	}
> +	the_repository->index = &the_index;

I wonder if this can be done sooner.  For example, does the following
work?  This way, 'the_repository->index == &the_index' would be an
invariant that always holds, even in the early setup stage before
setup_git_directory_gently has run completely.

Thanks,
Jonathan

diff --git i/repository.c w/repository.c
index edca907404..bdc1f93282 100644
--- i/repository.c
+++ w/repository.c
@@ -4,7 +4,7 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = { .index = &the_index };
 struct repository *the_repository = &the_repo;
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
