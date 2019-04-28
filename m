Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6DA11F453
	for <e@80x24.org>; Sun, 28 Apr 2019 08:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfD1IrX (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 04:47:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfD1IrW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 04:47:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so3814430pfi.9
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIVkSo1ryc43PN8Nmiu4Ey8Gy10ouUh7/aANNJnMe9w=;
        b=Q1EqIyvWrdwU2IMR5KxyrbfNw+zKSb4hg0OnKRM4tOypx00THbM+Qe5dVCMwyeqFPR
         7mcU/PwEmfXqIhF16PmPJec4JEQ250OIc5bobewyva4EsJEbFa/WEaXUE3Fp2uq1e1NO
         2puAOeqs1UV3poeKLI1Eh06ybsb2Ccv53LG/WbDhQ0RsEWV8Ubgz/OyegHOhrw6sbSCD
         YH2H2klfIqhdkvnxtQZQT8uVhpXasC4HSyrJqjzHbh1AxxzjT74zpKfgwCSU6ijXyoOw
         F8kwfluo8MVs5Y95V7IIU8rkEIsTII7UQjsnJW3/njx2BXd/vnUHyqS3D1yPchRJQXJR
         p/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIVkSo1ryc43PN8Nmiu4Ey8Gy10ouUh7/aANNJnMe9w=;
        b=p7WvKSlepEUpNb/xM51V3CE5dkC8WjkY6GVT5XoOzkPKAg5Hlo0Lm4EYRv9PbQ395O
         61jShpqlfFBUMmfmyqx6aYr+OcOlgs2Es4HRBL7lOhB7Rzg+ejqcKtNtihwFQE67HA0Z
         E+5UntON7rxjvCS7u+UQI3OJSLvtfHFmGGE7dXEJVz8AMhsuOqZd4AdI7Fh9hN4RTbQU
         U11fmfqFjlv7tN3CfNTM+Q8RnStSBsXymJbU2SaAodHft8UNOeN6Zaadp5I8R7w1YsH0
         Lt4pvvZc5XlMybvY0JxauyeGCOdjWyJRc2G1gHqzp6Fd7cc7rjCp/Nt2DE6u7wsGSLb1
         OPMQ==
X-Gm-Message-State: APjAAAV2XscPlk7TOQFT4F6zq9TOtAUgWCkMym6fmvjMSqNq1VEsdsj4
        QV37cFgPOg63BaWJgKPNpm3E5Exn
X-Google-Smtp-Source: APXvYqw5EFvXGieANZzgQ1Mzbiw+1HXeQWvlH2h6wbrOypjrh63PUkBC25snDLw/aolPyIA4j7X5fg==
X-Received: by 2002:a62:1881:: with SMTP id 123mr56266652pfy.25.1556441241824;
        Sun, 28 Apr 2019 01:47:21 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id v12sm3577101pfm.186.2019.04.28.01.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 01:47:20 -0700 (PDT)
Date:   Sun, 28 Apr 2019 01:47:18 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Cameron Steffen <cam.steffen94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Stage or discard a hunk at a time?
Message-ID: <20190428084718.GA21060@gmail.com>
References: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 01:09:03PM -0600, Cameron Steffen wrote:
> Hello,
> 
> I have this feature idea for git. There should be a command that
> effectively combines git add -p and git checkout -p so that I can
> navigate changed hunks and either stage or discard them.
> 
> There is already a SO question asking about this exactly...
> https://stackoverflow.com/questions/11538650/simultaneously-git-add-p-and-git-checkout-p
> 
> Has this been discussed before? Is this a reasonable request? If so, I
> might look into contributing the change myself.
> 
> Cameron

Install Git Cola.

It's a powerful Git GUI with a keyboard-centric workflow.
You can do this completely through keyboard shortcuts
(or a mouse if you prefer).

Typically:

	$ git cola

	ctrl-k: focus the status widget
	j,k: navigate up/down the file list
	ctrl-s: stage files
	ctrl-u: revert files to index

	ctrl-j: focus the diff widget to operate at the line/hunk level
	j, k: move the cursor up/down lines, hold shift to select lines
	s: to stage selection, or current hunk if no lines are selected
	ctrl-u: revert the selection, or current hunk, to match the index

https://github.com/git-cola/git-cola

https://git-cola.github.io/downloads.html
-- 
David
