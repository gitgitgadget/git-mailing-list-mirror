Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71A021841
	for <e@80x24.org>; Tue,  1 May 2018 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeEAJuJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 05:50:09 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36644 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAJuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 05:50:08 -0400
Received: by mail-lf0-f41.google.com with SMTP id w8-v6so15682396lfe.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FBrm1gOaCjXnNwyKC2Io66cnwOVpy1687bkzSdE110=;
        b=LWGCE/SC/K8ss+78lDI5n3eBogSN5fynOGMO+1QcXR25Tp5G28dIPGv0Ej4xUYUsJ/
         r9J+EvPwZIqK9sfgurWGgyTysMjaen70PdSfM2nckhrsTgVHIC8Pi5aGFFzYjmhOyOOs
         pQtIRqwQg9qq4Q3MDFfTvQVRvZlRHpJSRuS824c2UDON2PPxDypKZHXo9o5oOPA7yzq6
         35EpCJJ3MqxIcNXJpIBGt8OD6Np7zPEm8Fne/x7erKuZfepqwJ4jxVLigWQ98uEgGW+v
         PcwRyumg2lsft5DPULj/iEo7Pdp2d1Z2+LXVYGUDI/5LUX3JtuubLGdlQ/O0OEhj1+zW
         1uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FBrm1gOaCjXnNwyKC2Io66cnwOVpy1687bkzSdE110=;
        b=MM9Sr64hyxsJw/XNTnK0V5MiOMonltxSKZLK3RlQ18i7EYCKiFWNdzVQt05nxqrYwn
         P29feQnquUTJ/IohtUaTjOgc0P2d1IxWoVXf3ECQkcbk81QAwp+OKequZfiCsHMY1nWb
         7RwDiOpLXmiluselMbgWd8OjQMGcL9ACLWA72B3CRCyYsWLumBhyyprzKEPqbYdtHLTR
         7gzyUZ45fMotDUswRfeYqU3+YhLCnBcRk8pjB6FMYNi7cwE9EOnYv7cPg5r/sz7Mfvhl
         DvdHMN19NIqVHzcOBqsldfW+vA/7Avk36UfLOzxtK9/SajD9o1JIvHu0cLQrHH9XaAre
         pJsg==
X-Gm-Message-State: ALQs6tDyupD1m05uyU2ZEf7Ub68jOg0v5q1TgL9KFkzSUkr8FFxK5vLz
        +vIRmftITl5yCYhNnea5hp0=
X-Google-Smtp-Source: AB8JxZplSUXPJStovOPZgKvI0sMu6RpknH1pycAZZ1ooA08iJPnj7oGxJ7h3F086p0uCQtuBXgylcg==
X-Received: by 2002:a2e:7a0c:: with SMTP id v12-v6mr9905900ljc.79.1525168207571;
        Tue, 01 May 2018 02:50:07 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g4-v6sm1829838lje.33.2018.05.01.02.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 02:50:06 -0700 (PDT)
Date:   Tue, 1 May 2018 11:50:04 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/41] Remove unused member in struct object_context
Message-ID: <20180501095004.GC15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-4-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:13PM +0000, brian m. carlson wrote:
> The tree member of struct object_context is unused except in one place
> where we write to it.  Since there are no users of this member, remove
> it.

Yep. It's never used since its introduction in 573285e552 (sha1_name:
add get_sha1_with_context() - 2010-06-09) in 'cp/textconv-cat-file'
topic. I guess the idea at that time was to keep all the information
from get_tree_entry() in object context for future use.

Since it's been eight years and nobody needs it still, it should be
good to go.
--
Duy
