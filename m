Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C435200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeECRuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:50:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34722 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeECRuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:50:05 -0400
Received: by mail-pf0-f174.google.com with SMTP id a14so15324608pfi.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIGRtZKmLdroX0UFKkIojv5NBNFdtr7mwxkQuEm2EVE=;
        b=qEDX519kHN2+yiV6eS7H8gjtMQSp7c9ci0DjIqHkK247OvJp93I9e0nB06vr+qcqj6
         t0faNtkyk741qlD+G3bh8vEQHnKUHuiHv+LqbFEgM6lx2RqlVZUP7bSYn79I3gtXw6WS
         kyHrInQ98V3/E0/yCK7pwNmeD3el9m0899243IHQPPM35t2K4wEw3wAbgVCNs/264QL4
         Dk7S68pF66R+2UXvwmpDguYrnFjhZHrT6ycbf+nHvJPKbKMbXVeUe5pQ3/83yvuyFRBP
         FsWqNkAXYyqFx+jGGe4IbJQeGbu52h6ZoMcvhmtklEIYkOixn8Jkcc0Don5wr64X8ihy
         YUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIGRtZKmLdroX0UFKkIojv5NBNFdtr7mwxkQuEm2EVE=;
        b=uSCHPNnxcEKeY8oxtNoB1XJCZ13eClUxv2N/7FZEsITAGYCsUTJMViCxQMKmU8IfnB
         udnzA73t5Ckvlueva+huYRf29wEmxNwfSZ3xzPOddOA5puCg2xax7bmA2n7J934L5DPb
         dXSQFK0GkkGRoz9xKaXntc5q9GjjGvUhWwNHLM9ZGPfwJi5XDGCWGr3gu7tb+mcbdfQk
         LwgwlXtcisfxmCKaw2m2NDJVG3a2N5kg3h2FhTDsadxRzxzvSdFJ4t1Zl9FolgBd7PmS
         pdFifReA9z3sLP0QoD5ygQu659MgVoeriRakBctAMk1de1A4u5M/d6p94f4BDowIflO1
         vjBA==
X-Gm-Message-State: ALQs6tDX9nRN2ROdDzfgy6XJGSBsOi9jbB06JOV40X4NvFUP1+ke1KIt
        2yC6ISY4HytwcguhmR67fvSkLg==
X-Google-Smtp-Source: AB8JxZpGmG+t8Xq/SRnr15ESrrdHgIkby1lJ7tWyFV+PiGikMk4Al4+kVyd/XYQYVrMHwDeK4RfxQg==
X-Received: by 2002:a63:b105:: with SMTP id r5-v6mr19339685pgf.186.1525369804603;
        Thu, 03 May 2018 10:50:04 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id v14sm18892436pfm.132.2018.05.03.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 10:50:03 -0700 (PDT)
Date:   Thu, 3 May 2018 10:50:02 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        pc44800@gmail.com
Subject: Re: [PATCH 2/5] submodule foreach: document '$sm_path' instead of
 '$path'
Message-Id: <20180503105002.d59dcfc0600878f2ad1a7daa@google.com>
In-Reply-To: <20180503005358.89082-3-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180503005358.89082-3-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  2 May 2018 17:53:55 -0700
Stefan Beller <sbeller@google.com> wrote:

>  foreach [--recursive] <command>::
>  	Evaluates an arbitrary shell command in each checked out submodule.
> -	The command has access to the variables $name, $path, $sha1 and
> +	The command has access to the variables $name, $sm_path, $sha1 and
>  	$toplevel:
>  	$name is the name of the relevant submodule section in `.gitmodules`,
> -	$path is the name of the submodule directory relative to the
> -	superproject, $sha1 is the commit as recorded in the superproject,
> -	and $toplevel is the absolute path to the top-level of the superproject.
> +	$sm_path is the path of the submodule as recorded in the superproject,
> +	$sha1 is the commit as recorded in the superproject, and
> +	$toplevel is the absolute path to the top-level of the superproject.
> +	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
> +	variable is now a deprecated synonym of '$sm_path' variable.
>  	Any submodules defined in the superproject but not checked out are
>  	ignored by this command. Unless given `--quiet`, foreach prints the name
>  	of each submodule before evaluating the command.

This patch is fine as-is. I would go further and replace all mentions of
"the superproject" to "its immediate superproject", but that is
optional.
