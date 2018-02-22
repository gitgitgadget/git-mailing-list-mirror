Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EEF1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBVAla (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:41:30 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39574 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVAla (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:41:30 -0500
Received: by mail-pl0-f65.google.com with SMTP id s13so1932917plq.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXiiUyCtsm9a4rwZslYOJUiEIQobrjdmGToeIopKpVk=;
        b=cPwMBjerJl8jDDTBRanxXWkbRvapsy4r8dNvPi8V1Fs/mid49BqSEjAVAW4XLRgQIv
         VmqsnL1LyKIW1K78RqMniCEVMeiudF3KmijR92k7VBazug6DCMRsF5PX2+P7hafDB3Zm
         QGZY4X+AC4lGKIHHnDIwFuD46B1R2dnFdaGF+Vk2Iw09a6LT7zNS3DeG36i3wU/UCDFP
         CufylShYgpXkB7UoUlaZoqVLHndSWK3/0d9ishEvqyJwfozbDteFdFSREMl3hXRhMdiS
         ryvI8xwAaW4lFDAfkC4XIZkOY+MUMWuLURV7U8Av2mk8D8oKJ4mUUEw5Sg/aDZ9Od4My
         2n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXiiUyCtsm9a4rwZslYOJUiEIQobrjdmGToeIopKpVk=;
        b=Ot9Jlq2qx3DS5RRJmI/KB1mTuCbqRUaZu37Vq51CZWaiiH2IEb3I1ek145D31GUoc8
         LuWq1Ryard0kuYjzigVMmreWwzaHg9LjVIiE8DZ+FYVcF9pxLF2RRRxeDCO663c+g6hz
         vU6c/LBkMm1a6fN4gm0G+DXiNXtQ4a/+sXiQl0Iuz3j/qYua7xTNC8xZ17tqDkxATb7q
         BHQ5XQbcXBtgrWAIHlvsJoirGauOxeiXCclqKri82yRlfDwEfxOGunVnboAZRXfdtEHV
         An7zxgE5MzPEp65YDcU/m7J2O1mVYtaO4FZdWus6L1tsbMKbo4rNzIEaOrtZVO2j9qma
         yBKA==
X-Gm-Message-State: APf1xPCmWNSd94jTMXAlaoRPS7rJvdDFVOMYqYPp/suJ3/m4UefyP8cI
        bb5J6wZKASSGOSO2RN7xfutjCVeL2jk=
X-Google-Smtp-Source: AH8x225nU4EnFoKLdQm2ZPxY4OuCLeCh+drH6PwDKuymAWGl8WN4+3QaBWecA8NuN1MteXdauHSYQw==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr4589620plb.28.1519260089370;
        Wed, 21 Feb 2018 16:41:29 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r28sm17097008pfl.9.2018.02.21.16.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:41:28 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:41:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/27] object-store: move alt_odb_list and alt_odb_tail
 to object store
Message-ID: <20180222004127.GC127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-4-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> In a process with multiple repositories open, alternates should be
> associated to a single repository and not shared globally. Move
> alt_odb_list and alt_odb_tail into the_repository and adjust callers
> to reflect this.
> 
> Now that the alternative object data base is per repository, we're
> leaking its memory upon freeing a repository. The next patch plugs
> this hole.
> 
> No functional change intended.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good aside from the one spacing issue (though it's not that big of
a deal).

> ---
>  builtin/fsck.c |  4 +++-
>  object-store.h |  9 ++++++---
>  packfile.c     |  3 ++-
>  sha1_file.c    | 25 ++++++++++++-------------
>  sha1_name.c    |  3 ++-
>  5 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 7a8a679d4f..908e4f092a 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "repository.h"
>  #include "config.h"
>  #include "commit.h"
>  #include "tree.h"
> @@ -716,7 +717,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  		fsck_object_dir(get_object_directory());
>  
>  		prepare_alt_odb();
> -		for (alt = alt_odb_list; alt; alt = alt->next)
> +		for (alt = the_repository->objects.alt_odb_list;
> +				alt; alt = alt->next)

Indentation on this line looks odd.


-- 
Brandon Williams
