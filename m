Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15121F829
	for <e@80x24.org>; Mon,  1 May 2017 02:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642163AbdEACEB (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:04:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35079 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164160AbdEACD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 22:03:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id c2so3811654pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G5Xav7WVojjXHlQZxzdfJelRHY4pClW/sDTQbaEvLzw=;
        b=Oqqd7c/AzZCNUnpIKvPgPbEsjX+ZHQyK6+WIcCX62zR+UQ7ywi8rUNuMu3vXX3DD90
         cewlb5hP0gf4NLMR4sOeucbkJxX9Nyas1at3c0OgY8SLbMnWfdwLNeSbbXUjY9WIL+Ib
         s5FVWGTJNYtK+iURnPPA+xQi3cWza55KvunZNKGHc4k1uB7ARZ5/wuSY5s6pOzBbbzgS
         bk8pJwMBj9KvXiz4P7+YM+wOFUTesefZuXnmIYZN5lgAbkHpiw14anxR9JzRk4K+FGUB
         BjjyxdqrMqMPex4fFnIPRev/iYg2RrLbsP8JR58Yvr/eeXRDJHz2ksopuJJx1nJjFYVI
         JDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G5Xav7WVojjXHlQZxzdfJelRHY4pClW/sDTQbaEvLzw=;
        b=REIDlE/rtu5t5/2z0teo086FZZEF2YELsUJCnGdQtyZd3xPgeH+6pR8G096nXhl70z
         ID/XrvO453d+SaIOzfPdovLlIPSVstCYxvtFiNLHXxAnASzNcidthQUwx5PJvui6Rr5W
         GCxYABN60xJhJzpZVoPGJKfkeXBO8gx/FA9/CG/a048awFJzpURecastE+4v8prbWes6
         o58uP/Wr9AGYiM5p6BdmzhrwD2kuDNsGOKqTDze9jk7Bzv5FMwySocuSTY5Z81fNkmwJ
         j7WdM+Cfv13G2aE0WfIIq+fhs+56tfK0lAaBaR9dmkctSewjb5gJRm55svR/VjZRjEL/
         Ziag==
X-Gm-Message-State: AN3rC/4sX/ROPqBnRcNP0nuV2UTpSKbwuJmP0pDvN8P5yfHIl4yIFsRJ
        UeTozyO4PdZk2joIPPY=
X-Received: by 10.84.218.15 with SMTP id q15mr9615893pli.141.1493604239102;
        Sun, 30 Apr 2017 19:03:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id b74sm22016956pfl.58.2017.04.30.19.03.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 19:03:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] t7400: add !CYGWIN prerequisite to 'add with \\ in path'
References: <bd5e3dc3-14f2-da03-4487-a52d3c0b52fe@ramsayjones.plus.com>
Date:   Sun, 30 Apr 2017 19:03:57 -0700
In-Reply-To: <bd5e3dc3-14f2-da03-4487-a52d3c0b52fe@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 30 Apr 2017 18:29:30 +0100")
Message-ID: <xmqqk261ib8y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
> names", 07-04-2017) added a test which creates a git repository with
> some backslash characters in the name. On windows, where the backslash
> character is a directory separator, it is not possible to create a
> repository with the name 'sub\with\backslash'. (The NTFS filesystem would
> probably allow it, but the win32 api does not). The MinGW and Git for
> Windows versions of git actually create a repository called 'backslash'
> in the sub-directory 'sub/with'.
>
> On cygwin, however, due to the slightly schizophrenic treatment of the
> backslash character by cygwin-git, this test fails at the 'git init'
> stage. The git-init command does not recognise the directory separators
> in the input path (eg. is_dir_sep('\\') is false), so it does not
> attempt to create the leading directories 'sub/with'. (The call to
> mkdir('sub\\with\\backslash') actually does recognise the directory
> separators, but fails because the 'sub/with' directory doesn't exist).
>
> In order to suppress the test failure (for now), add the !CYGWIN test
> prerequisite.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> This is the 'v2' re-roll of the 'BSLASHPSEC' patch. :-D
>

Thanks.


> ATB,
> Ramsay Jones
>
>  t/t7400-submodule-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index c2706fe47..d0357f1d8 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>  	test_cmp empty untracked
>  '
>  
> -test_expect_success 'submodule add with \\ in path' '
> +test_expect_success !CYGWIN 'submodule add with \\ in path' '
>  	test_when_finished "rm -rf parent sub\\with\\backslash" &&
>  
>  	# Initialize a repo with a backslash in its name
