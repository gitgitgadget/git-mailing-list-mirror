Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3C12023F
	for <e@80x24.org>; Thu,  3 May 2018 17:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECRvi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:51:38 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:39909 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:51:37 -0400
Received: by mail-pg0-f44.google.com with SMTP id e1-v6so2301198pga.6
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSpaEMh3NBagJbyIma+qr3WFh7XdBbfmMA66vGXRnNw=;
        b=jwlL5TmS+aQam9IHyeFJSZznLpc+UtaAHQXH325R2EVagCCu2jMFMgis3ZdBBatbGP
         0WesZrGIYmUr4qqMoDYnzYfRyvX/45HGv3yFEWT3qLe9mT81RhZ4uMP7C5uBIPAMx6M/
         FV4Zd1gyQVYrjGOrxgTVT02fPfsTdoO3mNfhETFYdOqtG6+y1VNR9FtN3sM7glXD+t9h
         vfwAkVS82SOY9xpOm9HkzneXQmpYVCSw4MJZWW7KgLF88FOYkGa0VMgepiNRovkjWO01
         vYnxSXk7lLS76KbD/WYWxNardS3eU0jeqiXQ42iGMwvBk+bo7DlJrMuB7DbQyrgd0oJ4
         hHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSpaEMh3NBagJbyIma+qr3WFh7XdBbfmMA66vGXRnNw=;
        b=IMEaWitBTwWMzxFHIcOZBt4NofmQSNxKVuGQGqtI0gy662QKcXzwB4c6tJ3G+BUS3O
         MnbWIklrgDeF99QEOCacorsbUgcQJQLLcFLrUP3f2pI01A1VkfVNt7K4zldnYX7UkZsg
         DHm0C98veThgyv1fggdxEX0vnZHsapivhzz721GpE48r6RfZVXRSCX5p9QTsbVssJd0j
         Xnk9ld3JRqKh9lcmJDN7XjKeW2lp68rw5PPqXU4Gbo3n8caGSP2hYCVetrwKbVUxg3+v
         G6EmItBttFydGHEeJREoz0pUzTfiqK5mVsB6+671wY/x1q2P5RMTGBN/h1K6akv2IRwR
         ktmg==
X-Gm-Message-State: ALQs6tDl7dvVnygYfyjQmnRdYC5hC7rZpMGVk+TqIVcfLd6M7Iybxk2d
        mYotdjfHdBr17nZ3iqzjMK0DGYN40GQ=
X-Google-Smtp-Source: AB8JxZpZ0n5bv6vNcQ1Q6RLWQcv5E8Kcos7uXt6TNBqQgnT57OL4jjT/nd9T3bW3YjAc81yxqkZi6w==
X-Received: by 10.98.171.16 with SMTP id p16mr23683918pff.211.1525369897399;
        Thu, 03 May 2018 10:51:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id w7sm26356646pfn.83.2018.05.03.10.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 10:51:36 -0700 (PDT)
Date:   Thu, 3 May 2018 10:51:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        pc44800@gmail.com
Subject: Re: [PATCH 3/5] submodule foreach: clarify the '$toplevel' variable
 documentation
Message-Id: <20180503105135.5fbb2b85e2bdbc117a08b627@google.com>
In-Reply-To: <20180503005358.89082-4-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180503005358.89082-4-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  2 May 2018 17:53:56 -0700
Stefan Beller <sbeller@google.com> wrote:

>  	$name is the name of the relevant submodule section in `.gitmodules`,
>  	$sm_path is the path of the submodule as recorded in the superproject,
>  	$sha1 is the commit as recorded in the superproject, and
> -	$toplevel is the absolute path to the top-level of the superproject.
> +	$toplevel is the absolute path to its direct superproject, such that
> +	$toplevel/$sm_path is the absolute path of the submodule.
>  	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
>  	variable is now a deprecated synonym of '$sm_path' variable.
>  	Any submodules defined in the superproject but not checked out are

Ah, I commented on patch 2 before reading patch 3 properly. I think that
if you follow my suggestions on patch 2, it will be obvious that
$toplevel/$sm_path is the absolute path of the submodule, so that this
patch is no longer needed.
