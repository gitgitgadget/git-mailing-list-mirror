Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE26B20311
	for <e@80x24.org>; Thu,  9 Mar 2017 23:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbdCIXsP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 18:48:15 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33588 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdCIXsO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 18:48:14 -0500
Received: by mail-pg0-f46.google.com with SMTP id 25so31902192pgy.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 15:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFbhscWM1CUE8JRdQZdsm/XEObuGrzTs+54+G7QdN+k=;
        b=OvrPQbab/bQdb5Spqjm7M8iPMZoPQn42ghbAnec3dEIRhdjckJjj9PHYnHVrb9T0zX
         +iCyvXBylMk+jxlujpPsclClomllj/MwoNj0COM28oViAmJrcMmghOKsqcMN23AGaTHm
         AcQfRcZnfm8e8Z6DY4DH3pcawBXSMlHsovW48p3d5msepPwm3GGW1r6DNfGR/vYPMCnU
         g7/kcvNQHExWtuY+d8TQAUJ8E5U1GyHOmKVnqXZxz0gC38m1R8r+34k5H2GUWhHWMt0e
         3ET4dq5IY97/u4tezyQGHGq0r9pEcT0UxLrz4FmB2ZzY2tgWylSW6WnuJKqIoB1OR0J3
         Xk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFbhscWM1CUE8JRdQZdsm/XEObuGrzTs+54+G7QdN+k=;
        b=ZLtvGop1E7wDvwO38qiTclb1Y8JJKSoz//b0r/Jbh+QBPoOa8gBfGvNjmx5PctwUBA
         kHOsOEe68wCJOSTSN184kVtMXD+qBsDfB0kOU/ZIPyeUyanMVXeHalYgLkeu3AbPyfck
         Y2raKE/DMAc9DOZgY9Xe3istOIEN+Mj6z/a2hZ8xWXfF+mJAfwdWuqVH5q1gL1IR4WlF
         npB7zESPCLy9PQfwh2ZFwZ3z2dviwwp9+bJ3bi1hT47VMr4ckWjD933TunYXdKT8gk06
         IYG7taCNJU/t41X/V2Iflj1bw638BwUuwQ9icpKAjzxp+KQLo3Fakm9arhNkP8h1zM4t
         TZ8g==
X-Gm-Message-State: AMke39mfLaIgYlkyuKedApEhBJ7aRY10pKFaTMJQZSvFcgokgwN4CG4/wVyfIwVGIy35tlZr
X-Received: by 10.99.24.88 with SMTP id 24mr17003201pgy.54.1489102842881;
        Thu, 09 Mar 2017 15:40:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id l72sm14463572pfi.93.2017.03.09.15.40.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 15:40:41 -0800 (PST)
Date:   Thu, 9 Mar 2017 15:40:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
Message-ID: <20170309234040.GE52558@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-13-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309221543.15897-13-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Stefan Beller wrote:
> +static void submodule_reset_index(const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);

What happens with nested submodules? As in can we reach this code path
with super_prefix already being set?  If so we would need to include
that as part of the super_prefix being passed to the child.  Just
looking for some clarification.

> +	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
> +
> +	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
> +
> +	if (run_command(&cp))
> +		die("could not reset submodule index");
> +}
> +

-- 
Brandon Williams
