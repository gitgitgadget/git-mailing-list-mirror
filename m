Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA17C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 09:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiFDJp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 05:45:25 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05A1B7B9
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 02:45:23 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39492341"
Received: from unknown (HELO [10.28.4.153]) ([109.190.253.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 11:45:18 +0200
Message-ID: <88e41596-d369-958f-f75c-c0b2cd86c2b5@univ-lyon1.fr>
Date:   Sat, 4 Jun 2022 11:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/4] error message now advice to use the new option
Content-Language: en-US
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     "cogoni.guillaume@gmail.com" <cogoni.guillaume@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
 <82beb916d9c44a069f30ec4ff261e3be@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <82beb916d9c44a069f30ec4ff261e3be@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/22 21:55, Jonathan Bressat wrote:
 > Subject: Re: [PATCH v2 4/4] error message now advice to use the new 
option

Commit messages are usually written with imperative tone. The "now" 
doesn't add information, the reader can guess that the commit message 
describes the new behavior.

"suggest --overwrite-same-content in error message when appropriate" ?

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -760,6 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   				       &new_branch_info->commit->object.oid :
>   				       &new_branch_info->oid, NULL);
>   		topts.preserve_ignored = !opts->overwrite_ignore;
> +		topts.overwrite_same_content = 0;/* FIXME: opts->overwrite_same_content */

Why not use opts->overwrite_same_content in the code rather than saying 
you should in a comment?

Actually, doesn't this hunk belong to the previous commit?

The rest of the patch looks good to me.

-- 
Matthieu Moy
https://matthieu-moy.fr/
