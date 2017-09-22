Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBFBC202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbdIVUBf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:01:35 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:55206 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdIVUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:01:33 -0400
Received: by mail-qk0-f172.google.com with SMTP id d70so2080174qkc.11
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q+AIEHSBNOOZMwGNgLuEY8btUVDq0og2an3EHuFg+CY=;
        b=lYxs/WU0mCwAk5JzVJ//7N/yAe4nwR82/1UzTtmCc62bxKut94FRHUvoe0ACNPdFpy
         zrAU4p+CyXDPP0CTIGYJqyuDv5wD3EG1u5Q7ENFAvNL484CMkXFWu7O40MirnjMya/IT
         /9XgZSErBbHCtRzgtX8Pl5aGqvp9figuSTVlw8f75dhAo/+UP3vN/dskUSC0KxbgNaLO
         IRP1aoN3MBzP3592t1z6iDl8z/Vg5CUYDGcA9ma3WT6xCFyY66uxj+k0y8nHAK8izrmE
         aGg9dLB7VdSzgKGnNEbBRQdfJGPZDOdbRTvVuZYHRo/WY83lVoTM8Ox61cA49kHg+M+E
         kcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q+AIEHSBNOOZMwGNgLuEY8btUVDq0og2an3EHuFg+CY=;
        b=L17x5Lt/Ca4RDkm5AUw9eaDjZkRdb8omuEPMKqefviFDrRNXYLO29p8Z691Iw4+9NP
         LpcAc81Y28gVh6Qg/K3RRXwIH6zVe5rtE0OHrjNJ934DncnWNwGRvRz7lgmuwHTcChu/
         vMjqiGMPBQVSDqfuWgeW/gKaMrUL43aB51+cR2T7miGDNUBFelFmEZOdpG1v2CMKFDd7
         jZZ4m4j1eJVtdc1pnPxWxFpFdzuiOkkMTgGTCmA3t2RlRl0KqJwu74YgzY3zS3edaTQy
         HDGDl2L75Gcki0xzydE16uHCFOwbW6ywb3DWXLSVG4aJdIh492oloPYJAufK0NQmOyCm
         TzBg==
X-Gm-Message-State: AHPjjUjCHEOjcr5eifjoO6KzD+RgG3E8BzQl/DfLx8aeoLm8mZ2kMlFX
        SeWAZ9KDGyXoTXMAc8ygn4SY/3cS3FddajhwmFectBBU
X-Google-Smtp-Source: AOwi7QDKpqvMgUE1+uNwhWO5KXcJ+a56PXgNQDHedrrPe+yP6265AljuhQsi+lE+0wpfLXJ/1Ul8zWnwtltZPTxkEGU=
X-Received: by 10.55.52.135 with SMTP id b129mr446683qka.308.1506110492593;
 Fri, 22 Sep 2017 13:01:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Fri, 22 Sep 2017 13:01:31 -0700 (PDT)
In-Reply-To: <381fe8facbbc1667d655572fcff5d6eb5f0e07fc.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu> <381fe8facbbc1667d655572fcff5d6eb5f0e07fc.1506081120.git.git@grubix.eu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Sep 2017 13:01:31 -0700
Message-ID: <CAGZ79ka3Bejmv=hT2xNAzx0K-r7S8SaTKmgeW9MB1FqhrY31pA@mail.gmail.com>
Subject: Re: [PATCH 4/4] t7503: add tests for pre-merge-hook
To:     Michael J Gruber <git@grubix.eu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 5:04 AM, Michael J Gruber <git@grubix.eu> wrote:

> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh

> -test_description='pre-commit hook'
> +test_description='pre-commit and pre-merge hooks'

Tangent: do we also want to rename the file?

> +test_expect_success '--no-verify with succeeding hook (merge)' '

The return value of the hook ought to not matter, so we'd rather want
to test for 'no side effect by hook on --no-verify' ?


> +test_expect_success '--no-verify with failing hook (merge)' '
> +
> +       git checkout side &&
> +       git merge --no-verify -m "merge master" master &&
> +       git checkout master
> +
> +'

I assume the same (unsolved) issues apply to this hook as
to the commit-msg hook with 'git merge --continue'
Do we want a test for that (I am torn on that) ?
