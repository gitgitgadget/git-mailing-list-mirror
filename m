Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBF71F403
	for <e@80x24.org>; Sat,  9 Jun 2018 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeFILEU (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 07:04:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42068 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeFILET (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 07:04:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so23751141lfa.9
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ry/HemQtbLhD06EiCKz3S4dCvVqbsLkEPHDD9ik+FRw=;
        b=kr8oH4cNWnTWnOJQEkUmNKtdierWPVwotHtnifYhTQyJfGthLqnzjI3Ngfu7LkAVtH
         9yn5BJQoFQvYgBUzNJPoS0cmKneFa+639SLmtuJt3e9cSezdtuy862bdFftca73A7CYo
         hO9YNf+CxlK6FSLE4lrfZNgT6ZO9ir22nubdKUiASv4QopO109yUBq3KB6Wc2KodziXa
         0oYCOw6S4ojatvcVrewrEdL/UpO2nfS0k01g0Yke7NizVa5kk1aUsIs6NY9hlNM50C+5
         1MlWL2XBt+WjAu8V/vDRI2HFMfv7UAh4hjtPqnFiA0v0VEEcbxSYGuQ8atoQdacfd8Yi
         qQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ry/HemQtbLhD06EiCKz3S4dCvVqbsLkEPHDD9ik+FRw=;
        b=YE8uDT9qWj8F+ojoUrvHri/pT8kZnNHtsamsFgTSdrYSYZhd0mZHtTpOeP7JIXG4fz
         G5i8NrmV7aG47rfKHsVSrMEl/oh36MAdvOz3JxBh/QMYmJrw7mrVN4xdqD7/Sj+JL5kP
         O6OCrYKJMYfN+6liRMKzvAvijiqxI1nIeYL6fo6Ju2orhMcXmDb0dmyzk3eTH2icJbQo
         JtAk4lCmWzDeirMHWV4Ak9Evn4ZV/AySPWgsFmWo7pWF31GiwzacAmqPbIzV7VgZLYUe
         V9L7JIEShZlhEOqtM9961clrRZuMY9zf4ikuZmIId7zONKiW0OTuXoDpwOk+X4TUiii8
         D+Xw==
X-Gm-Message-State: APt69E3vXlWxG4x0HSdCCJ6VvOfxrHB/1G+JQZoqToFlgo+QR1OTbj91
        4UhsCKk0jUiWuqB3mQngHApiIw==
X-Google-Smtp-Source: ADUXVKKoYKcelO2Ed2RQoCc+WH9UYVzI2uqSubMUV6+siS2jsNwZzQvKpzLz5/+9L0nQYA3Vb7/bxg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr4580057ljj.49.1528542257603;
        Sat, 09 Jun 2018 04:04:17 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a125-v6sm5425070lfb.61.2018.06.09.04.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 04:04:16 -0700 (PDT)
Date:   Sat, 9 Jun 2018 13:04:15 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
Message-ID: <20180609110414.GA5273@duynguyen.home>
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 05, 2018 at 05:31:41PM +0200, Duy Nguyen wrote:
> I do not know how to reproduce this (and didn't bother to look deeply
> into it after I found it was not a trivial fix) but one of my "git
> fetch" showed
> 
> warning: Submodule in commit be2db96a6c506464525f588da59cade0cedddb5e
> at path: '(null)' collides with a submodule named the same. Skipping
> it.

The problem is default_name_or_path() can return NULL when a submodule
is not populated. The fix could simply be printing path instead of
name (because we are talking about path in the commit message), like
below.

But I don't really understand c68f837576 (implement fetching of moved
submodules - 2017-10-16), the commit that made this change, and not
sure if we should be reporting name here or path. Heiko?

diff --git a/submodule.c b/submodule.c
index 939d6870ec..61c2177755 100644
--- a/submodule.c
+++ b/submodule.c
@@ -745,7 +745,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 				warning("Submodule in commit %s at path: "
 					"'%s' collides with a submodule named "
 					"the same. Skipping it.",
-					oid_to_hex(commit_oid), name);
+					oid_to_hex(commit_oid), p->two->path);
 				name = NULL;
 			}
 		}



> 
> I think it's reported that some libc implementation will not be able
> to gracefully handle NULL strings like glibc and may crash instead of
> printing '(null)' here. I'll leave it to submodule people to fix this
> :)
> -- 
> Duy
