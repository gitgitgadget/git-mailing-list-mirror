Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE58C1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfBLR1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:27:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40244 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfBLR1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:27:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so3602187wrp.7
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JcgHhrLoWvn9c+to0qpnVE+voTyi9e2z1/vOcaB6Ups=;
        b=U+d0SjtSl6HYQvA84tcXA0J75RVMqVQug7Va6WpJwRBmIyLKHni8mT1OKo0QPQ6qKV
         decmk3Qh/vsMwNe43ipKIynslv/mpAclpfqQeUJTL6VcprDDd0FAo2xq8jK1BTXjAMNn
         JfphDwK3y4yVplaW7dPR2yXBEKQUropwti6nbz+eskmAXRx8AG5AVGR7cHtWYZMKtZKD
         bXTJSdR+nkoz99kLofFwejKTfqzNIGsPtyVda1JLaIRWJvq7Wc8pZwwinNY4BsfJkxKH
         6xsBleGjbQn6ys0FTa/TQDsTpfQu3+raZcKNAU4z5TF+7MPBvJGU7G0ONDAfQeu9qn0x
         uGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JcgHhrLoWvn9c+to0qpnVE+voTyi9e2z1/vOcaB6Ups=;
        b=Ld9tAXVSmnziiluounVKFXv/IjAihtCcOIhutDtZOEqEiZnxnUcUMQnWWFKEIryai2
         rR9AEA8hlrNTvvYiz9cvC7dvNtpVRVtdpAgsYYZ/8OMGMXIaZY+5CS5Uc+3tYuEaXk2T
         CX7khPVwbERqupgNLpeYlvQ2vuaBLXN3gl/GvwXVzjmEwq7b0P8XpJ1nhprwfhEo45i7
         8YFKlUs5R5LdmGV/EaiU+lS9FNZ8020p/l7u8gccFNXsV5tGNWXxN0gxlqR/H1sIzvEm
         ToVtkLYVpK08uaHgpcA/YWgjz1bSpRL6NlTKSl5AalSL/LaRJWKwz8fvnWWOm6Ne3EnN
         FhJA==
X-Gm-Message-State: AHQUAuZ8oFXYEV6di4dktsKmbuh2Fz/W6S9gd0mtYBizGuJXsuFiH9hQ
        /xPwYQzmxh9ItRbi0VZtCSXXONfu
X-Google-Smtp-Source: AHgI3IZsGK+Ex5GFmaKScdZATHQTOhdP1ViM3PcPqLt1nG3ElKICpOK9BFFHLSD8ONhgg7e1VThMHg==
X-Received: by 2002:a5d:4b07:: with SMTP id v7mr3646741wrq.281.1549992433419;
        Tue, 12 Feb 2019 09:27:13 -0800 (PST)
Received: from evil.localdomain ([5.90.75.130])
        by smtp.gmail.com with ESMTPSA id z18sm7687920wml.36.2019.02.12.09.27.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:27:12 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:27:09 +0100
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     git@vger.kernel.org
Subject: Re: git can't add ignored file if GIT_ICASE_PATHSPECS=1
Message-ID: <20190212172708.GA506@evil.localdomain>
References: <20190212171952.GA343@evil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212171952.GA343@evil.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to mention that the issue is present both in maint and in the master branch.

On Tue, Feb 12, 2019 at 06:19:52PM +0100, Giuseppe Crino' wrote:
> To reproduce, apply the attached patch and run at the project root
> 
> 	cd t && ./t3700-add.sh --verbose-only=13 --debug --immediate
> 
> Relevant part of the output is
> 
> 	expecting success:
> 		export GIT_ICASE_PATHSPECS=1 &&
> 		touch a.if &&
> 		test_must_fail git add a.?? &&
> 		! (git ls-files | grep "\\.ig") &&
> 		(git ls-files | grep a.if)
> 
> 	fatal: pathspec 'a.ig' did not match any files
> 	not ok 13 - error out when attempting to add ignored ones but add others
> 	#
> 	#               export GIT_ICASE_PATHSPECS=1 &&
> 	#               touch a.if &&
> 	#               test_must_fail git add a.?? &&
> 	#               ! (git ls-files | grep "\\.ig") &&
> 	#               (git ls-files | grep a.if)
> 
> As I understand this, it's a bug.
> 
> Giuseppe

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 37729ba258..62557e6a3d 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -91,6 +91,7 @@ test_expect_success 'error out when attempting to add ignored ones without -f' '
>  '
> 
>  test_expect_success 'error out when attempting to add ignored ones but add others' '
> +       export GIT_ICASE_PATHSPECS=1 &&
>         touch a.if &&
>         test_must_fail git add a.?? &&
>         ! (git ls-files | grep "\\.ig") &&

