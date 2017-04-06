Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97C41FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdDFXFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 19:05:22 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35409 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdDFXFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 19:05:21 -0400
Received: by mail-pg0-f45.google.com with SMTP id 81so48598006pgh.2
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=44pPcJKMKLp+ZFHD6IpzTlqos5TFQilm7SzSQ0mpCGc=;
        b=Juo8Ab+uYKakOOIAjYkSmY6WOGAtsU3xkAduUHrixVMel8x+N368NTD6yPCVwLA0SU
         cD9/X6t4+J3AHyZI0SBbPL2MNWWYmTenfi0Uy8pNZvrbo5AW+Y61DTCn5PUfI05GrqnL
         +6KFfOJ+l3tEcNyFqJ3Yj624FyyNGFpQKPXbVgaQ07QC0rMaEbR4y0z22uuRls2IDmVO
         cd6VR+V8mu5hVQZNCVgFeL2wVDnKFXUIKEVXa2HprZWmE4zzWXe81bscgyYNuTcYd5TQ
         s+qjy8WQHeuDSaRnRFZB1zca9+XaJkh+naXZhyZ5tc04lZILA6y2kj3FAX7iR2x8tJz5
         l2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=44pPcJKMKLp+ZFHD6IpzTlqos5TFQilm7SzSQ0mpCGc=;
        b=C7gkDBkbr8Zu3Mrw31LSkJKOWPL4VU/IA/84bfJzsKruoDeWzUKjuc7QBLgOZfUiiq
         NpzBM9V8Qetug8WwEXDrbmvpNVNsme15N6bdVBugAHZRw+KQv6TZxsrKJyW06TuCMQ1Q
         ZLz/lxc+u6GJIG4W0L1DvNVPVQ0L53mV9YoMiOH6H9Nu7n31F6bJpvfDNy83A6rJoY3w
         iKvP75p3Y4TVBOIFORDq5j88U1/8D6LGfiZyIJrvzO7HRtBdtD4Sewgmbk2/Afr6OJCq
         n2gnnPjAQws8RayyCKLKx6YBtWPckB82caBmRKPIpLAyZczq6vS34IIdV9rkyLq+VMiM
         KZpA==
X-Gm-Message-State: AFeK/H0f+msRe/KWLHTUMNYpObzBpVmf3XqVWaI3Pm/7iciUkM7xTFRctzapgKzQnEDVTeuUWied75wJlvJ1N9XT
X-Received: by 10.98.193.69 with SMTP id i66mr37183402pfg.35.1491519920577;
 Thu, 06 Apr 2017 16:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 6 Apr 2017 16:05:19 -0700 (PDT)
In-Reply-To: <CAA-fqg2EwfMQ-KoAMHDFca1c7jpQgihhqsLejEK3Zs8O1D4DLg@mail.gmail.com>
References: <CAA-fqg2EwfMQ-KoAMHDFca1c7jpQgihhqsLejEK3Zs8O1D4DLg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Apr 2017 16:05:19 -0700
Message-ID: <CAGZ79kaGQHvGv-ZpfppbATucrJWVdS8Lq33CKs5AbV7qDGE3BA@mail.gmail.com>
Subject: Re: [BUG?] Issue with merging from another branch after replacing
 subdirectory with submodule
To:     Ben Nason <bnason@netflix.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 11:10 PM, Ben Nason <bnason@netflix.com> wrote:
> Hi,
>
> In git if you replace a subdirectory with a submodule in one branch,
> every successive merge from another branch without that change will
> cause a conflict. To reproduce this please see below (DOS batch file).
>
> Is this expected behavior?

Yes.

"git submodule update [--init]" only (creates or) updates existing
submodules. It doesn't take care of removing submodules that are
no longer recorded in the tree.

"git merge" currently also does not touch submodules. (we may have
git merge --recurse-submodules soon, though). So as soon as there
is a conflict between the submodule (or an unrelated repo, who happens
to live inside this other repo), and new directories/files that would appear,
the merge errors out.

Ideally Git would be smarter than the current behavior.

Stefan
