Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD681F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0FpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:45:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40649 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0FpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:45:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so4290200wmj.5
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oIN/6LsZGyfJBDziZmiwVxe17+BPA85zfdWHxiOjfI=;
        b=glnGMrb6tsBuXZQsEgxP96SRIicOxViZHJ22PkDmmT36Kr2QbZsVlqvyRi1Z5fGLc7
         dawbhbrl6l6OQ57/8x8L1VB8YYAOIPl8j+scGx+w63fkNEBs/vw/aZJRPvPEdmlUliaU
         QnuBo034sLCpSTp3J6bhO0nB96GZc0Jw6EWvNoSOQN+aKMxvFAc6UflBrF0LX4B5/VfP
         mpiOPPVdNzYRodd2UdbxWu7oLAaw3CV4VxhjoZXzCnxfnBmYe+w98lTC7Kmz1ATC44gV
         z+o55vpXrATzlVxN5tc4ZcTpOnPP/lM/YZCuvNaUCLZ+LeG3FvHNqqrb6AKTe5UgZPK4
         S5kw==
X-Gm-Message-State: APjAAAUI+VKfuwmv2s02QLdbfiMpaAWCqPrg2599wv8AxvznW1seXpGC
        2WMGOzcnHlrrhlk8PtUdSSeAyd5irk/cTy/vSCI=
X-Google-Smtp-Source: APXvYqz0+bKHLl1eMsi6mc79ZB51IepZ6eMVA6vk0lHHqMTL69JqPedEKLEq6wHlMTiI7kCwd49mpjS+cTvm3Zqr/08=
X-Received: by 2002:a1c:f319:: with SMTP id q25mr1606727wmq.129.1561614308018;
 Wed, 26 Jun 2019 22:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-13-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-13-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:44:57 -0400
Message-ID: <CAPig+cTQ3HG6tvWD=7ZqXF-HKTfqUjqmOW95d-LOaGv3T9HpbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/13] walken: count omitted objects
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> It may be illuminating to see which objects were not included within a
> given filter. This also demonstrates, since filter-spec "tree:1" is
> used, that the 'omitted' list contains all objects which are omitted,
> not just the first objects which were omitted - that is, it continues to
> dereference omitted trees and commits.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -45,7 +45,7 @@ static void init_walken_defaults(void)
>  static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
> -               struct rev_info *rev)
> +                                struct rev_info *rev)

Use the correct indentation in the patch which introduces this code
rather than adjusting it in this patch.
