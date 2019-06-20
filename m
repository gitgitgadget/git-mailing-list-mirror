Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF341F462
	for <e@80x24.org>; Thu, 20 Jun 2019 01:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfFTBRt (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 21:17:49 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:35621 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTBRr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 21:17:47 -0400
Received: by mail-io1-f47.google.com with SMTP id m24so299519ioo.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+W2ehOIUm6Giua7l5PDoCXDD3kuWgyplRxZ3yed6Bpk=;
        b=HCyra2LI7frMjqknhk8T6/RiD/NEJX+ihukjevHF3xcLCNo22iv14e8Z0JtFBb4kRU
         1JMHapJW+fsjUzcS5/oAEZrJklYEBW5O3VMX3kNqk0tGQNzuwg5w5gB36TgfgdGhOPhg
         Q7lYJWV+aMRYOV0b+2LqR0xVNxkzglDQbjdovX/yr+b63QKztcfR5dM3bjlU9EG3qKE0
         GU6uLXywBvn90fzoc2s7Tu4th9jHPZQcKgfyIOesqm/wD9W+fu3dDsK3V0UT/65QHlY9
         dAxZHJsGjknA+WGCoi2QXo/PTVueu1f2MCWLe47qEqN2NPcv1qq9lbjCUrzsqdcIDKXm
         xqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+W2ehOIUm6Giua7l5PDoCXDD3kuWgyplRxZ3yed6Bpk=;
        b=n3Ouy9DnFaE0yqUPxZnBHct26rrA56BVYZR5W4ntLIrzfA2W0MZS3gnc/tH5givMmm
         vSt6H3/0Jy0qSlV8ypB32WVLkx9fWE+FPz1FxIwmS1PxG5CyvThfDBc4Let42cIw6u/b
         UG7cdcxMskkbL3i33QUhfJnvZd74y4NlaeKPWmqfacPjHLj45Yn8/LYvAp0/fnVRSo+K
         f4oT77t7isjC0tVbr5uYQqCQtNvTXOdn+Ayfi3qVWmNQRvcik/nAzBomb3/pZA/NmafN
         uohixdazwvxZsi11nxrfgn1kGY+9s3n7yhoP50sboovIZXA9/Fsjr382avwbbsT1qq2f
         xvNg==
X-Gm-Message-State: APjAAAUzxswx4hkAnMmzWQj+15RqCUP+WYUCWjHx1OuwpPoUZynHf8t1
        YUl/Yn/njwddA5P/eXuvdBg=
X-Google-Smtp-Source: APXvYqyaYkm4Be90nqFYnkk+4bCbkhZCYkDELDqw0HmUUmOpC8Mbd7/ZrlaqRJJEVu2dXU3P2IKqzg==
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr15894027ioc.76.1560993467090;
        Wed, 19 Jun 2019 18:17:47 -0700 (PDT)
Received: from archbookpro.localdomain ([192.159.178.206])
        by smtp.gmail.com with ESMTPSA id t4sm15530351ioj.26.2019.06.19.18.17.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 18:17:46 -0700 (PDT)
Date:   Wed, 19 Jun 2019 21:17:44 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Message-ID: <20190620011744.GA3696@archbookpro.localdomain>
References: <SN6PR09MB3248331E45EED2DD26CA55528AE50@SN6PR09MB3248.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR09MB3248331E45EED2DD26CA55528AE50@SN6PR09MB3248.namprd09.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Logan,

On Wed, Jun 19, 2019 at 11:54:22PM +0000, Pugh, Logan wrote:
> Note: This issue was originally discussed on this StackOverflow thread: https://stackoverflow.com/q/56675863
> 
> Prior to Git version 2.22.0 I was able to use git difftool without configuring diff.tool or merge.tool and it would show the diff using git diff.
> 
> E.g. with Git 2.21.0:
> 
> ~/gits/src/git$ git difftool --no-index color.c color.h
> diff --git a/color.c b/color.h
> index ebb222ec33..98894d6a17 100644
> 
> In Git version 2.22.0 an error message about diff.tool not being configured is displayed:
> 
> ~/gits/src/git$ git difftool --no-index color.c color.h
> 
> This message is displayed because 'diff.tool' is not configured.
> See 'git difftool --tool-help' or 'git help config' for more details.
> 'git difftool' will now attempt to use one of the following tools:
> kompare emerge vimdiff
> 
> The following commit is thought to have caused the regression: https://github.com/git/git/commit/05fb8726cccc74908853c166248ff9b6abdafae5
> 
> Please let me know if I can provide any more info.
> 
> Thanks,
> 
> Logan

Thanks for the report. I'll take a look at this later today.
