Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B294A2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 16:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBOQvL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 11:51:11 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33528 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdBOQvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 11:51:10 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so38319544pge.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7kKQS2TsBVtwW95kcMN0PGyRyGxZXudMYBcPqITwl1I=;
        b=YKj2pwZrIaViSa0rIs4TD0/nK5Fczz/CH8YlgKHLP1QzjnGVWa97es+sUnifkbGv1T
         NW9GjiqRjG+dlvK4XAnQYNUD2dFG4PX7MAp6mOfAkagOVrMF022IuUb9EYJKjUXxJyHQ
         euc9IWAWAUKkoI89ClaF437YXdL4adiL0FGzT317wa0rjqBQOdqna1NrrzMwZf4gVPrw
         JG+uoGEFTyp+GjcNuhrt8lL46MMMAIlHvmPjjqZz0iVptYqW6NR0o7VCzaRqutph9i6t
         qiyerG6lwQdQ/T+LIcjjBJCMmidvde4GxwILVwWEjA90DULhsLDMfUdD868FhMlCQwa9
         FnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7kKQS2TsBVtwW95kcMN0PGyRyGxZXudMYBcPqITwl1I=;
        b=fCvPKYNkhe9WURMoNjwQK3vMjWJ23ryaA5tGf+bt/6Oi6Uggo4kphd0dypdkfZtWjB
         XB9RdCoqT79qdFXQbZ2TLntdJcPVYsccjiWV/L1uPkUD3+8PanbENURO0EWVDtpbuV5O
         UcJKBo7Rd8wRLq1J2dB0Iq+4Y8OiimBt01SZMAq8ecaVpU3xQRwcTYNmH/fLAn3Qt/V8
         0dBi7TpBk1/oxdm0QgnGYGKjCjW4GttP0bRGvliKUugOmYNt9uIc/hyR7uLB6/8lgSd+
         Bjhu6m/tcm7jG8qnzqwssfRcChGAGyx+INhdjj5jdDcaISKjp0uiVUhMigZFgsODFqzK
         1N6Q==
X-Gm-Message-State: AMke39nGYX3ZtIcC7NvMk5Xtaa33FADf9qRXYjdYvTCPUv2k87aQS7UjspGfcFPvIupJUPAM
X-Received: by 10.84.232.1 with SMTP id h1mr13670487plk.95.1487177470138;
        Wed, 15 Feb 2017 08:51:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:78f6:794e:151:8624])
        by smtp.gmail.com with ESMTPSA id m15sm8520428pfk.104.2017.02.15.08.51.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 08:51:08 -0800 (PST)
Date:   Wed, 15 Feb 2017 08:51:07 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com
Subject: Re: [PATCH 02/14] lib-submodule-update.sh: define tests for
 recursing into submodules
Message-ID: <20170215165107.GA29448@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
 <20170215003423.20245-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Stefan Beller wrote:
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 61c54f2098..7c8c557572 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -4,6 +4,7 @@
>  # - New submodule (no_submodule => add_sub1)
>  # - Removed submodule (add_sub1 => remove_sub1)
>  # - Updated submodule (add_sub1 => modify_sub1)
> +# - Updated submodule recursively (modify_sub1 => modify_sub1_recursively)
>  # - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
>  # - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
>  # - Submodule replaced by tracked files in directory (add_sub1 =>
> @@ -19,8 +20,8 @@
>  #                    /    ^
>  #                   /     remove_sub1
>  #                  /
> -#       add_sub1  /-------O
> -#             |  /        ^
> +#       add_sub1  /-------O---------O
> +#             |  /        ^         modify_sub1_recursive
>  #             | /         modify_sub1
>  #             v/
>  #      O------O-----------O---------O
> @@ -73,6 +74,14 @@ create_lib_submodule_repo () {
>  		git add sub1 &&
>  		git commit -m "Modify sub1" &&
>  
> +		git checkout -b modify_sub1_recursively modify_sub1 &&
> +		git -C sub1 checkout -b "add_nested_sub" &&
> +		git -C sub1 submodule add --branch no_submodule ./. sub2 &&

I thought we were trying to avoid './.' when adding submodules?

-- 
Brandon Williams
