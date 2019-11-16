Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE431F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 02:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKPCuJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 21:50:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKPCuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 21:50:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF1C51A304;
        Fri, 15 Nov 2019 21:50:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tP/xNWZXXsDZPh2PEfwf/MUmNHg=; b=VFu7xg
        9Q7ZjfpWGo5XzYyKimvCbK4/4HKrcUnjtKLpa5CgSIQT9lAu3ksKSpOMJLW11clc
        uf6+1mMFeofboyLSA0/DYuNcpXcQnW6lHGIo435uFMqVEaz7pJj9Ytf2yevefWZL
        pUs9GfsSaKV+G5UrswyUQtYkpYuCqIWSfgASU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=te5f/SwQv317Pi06hIQcpHOf3GMZnixa
        2eOMvTbx17QihloAf+FizmeCxfwa/eOCTezbChieJNh3Xk5xSclMfaL2l5PgsSxm
        5f6FC/LsZ9seY9Fd2iI8gHNAeZ9/qvaBqDqjF564n34s504ize0iIYXISvkxhS46
        DQZGH1AwsbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E348C1A302;
        Fri, 15 Nov 2019 21:50:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F304A1A301;
        Fri, 15 Nov 2019 21:50:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 2/3] Added general variable git-p4.binary and added a default for windows of 'P4.EXE'
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
        <98bae92fda9ca01d01b2e9fb70b04b00470e7bec.1573828978.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Nov 2019 11:50:04 +0900
In-Reply-To: <98bae92fda9ca01d01b2e9fb70b04b00470e7bec.1573828978.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Fri, 15 Nov 2019 14:42:57
        +0000")
Message-ID: <xmqq8sog5ycj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB8C458A-081B-11EA-BAC8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
> Subject: Re: [PATCH v2 2/3] Added general variable git-p4.binary and added a default for windows of 'P4.EXE'

Again, this is "what" you did, without explaining "why".  You give
readers no hint to help them judge if/why it is a good idea to apply
this patch.

Perhaps

	Subject: [PATCH] git-p4: allow path to the "p4" program configurable

	Introduce "git-p4.p4program" configuration variable that can
	be used to explicitly tell the path to the perforce client
	program.  When unspecified, this defaults to "p4" except for
	Windows where "p4.exe" is used instead.

or something?  This is still weaker than ideal as an explanation of
"why", but better than not saying anything as your original did ;-)

The reason why I find it weaker than ideal is because I would expect
any P4 user to have their system set up so that they can say "p4"
and get "p4" without configuring anything specifically (iow, "%PATH%"
would have been set up to have something with the p4.exe you want),
and this change is to help those users, to whom that expectation
does not hold (and in that case, it is better to explain in the
proposed log message why their system would not let them run Perforce
without first configuring this variable).

Again, as I said, you do not want to introduce "git-p4.binary" in
2/3 and then turn around to "oops, that was a mistake and it was not
a good name, so let's rename it" in 3/3.  Pretend as if you are a
perfect developer with 100% foresight and have chosen the right name
from the get-go by using "git-p4.p4program" in this step and drop
patch 3/3.

Thanks.

> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  Documentation/git-p4.txt |  5 +++++
>  git-p4.py                | 14 +++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 3494a1db3e..e206e69250 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -547,6 +547,11 @@ git-p4.retries::
>  	Set the value to 0 to disable retries or if your p4 version
>  	does not support retries (pre 2012.2).
>  
> +git-p4.binary::
> +	Specifies the p4 executable used by git-p4 to process commands.
> +	The default value for Windows is `p4.exe` and for all other
> +	systems the default is `p4`. 
> +
>  Clone and sync variables
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  git-p4.syncFromOrigin::
> diff --git a/git-p4.py b/git-p4.py
> index 6e8b3a26cd..160d966ee1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -26,6 +26,8 @@
>  import zlib
>  import ctypes
>  import errno
> +import os.path
> +from os import path
>  
>  # support basestring in python3
>  try:
> @@ -85,7 +87,17 @@ def p4_build_cmd(cmd):
>      location. It means that hooking into the environment, or other configuration
>      can be done more easily.
>      """
> -    real_cmd = ["p4"]
> +    # Look for the P4 binary
> +    p4bin = gitConfig("git-p4.binary")
> +    real_cmd = []
> +    if p4bin != "":
> +        if path.exists(p4bin):
> +            real_cmd = [p4bin]
> +    if real_cmd == []:
> +        if (platform.system() == "Windows"):
> +            real_cmd = ["p4.exe"]    
> +        else:
> +            real_cmd = ["p4"]
>  
>      user = gitConfig("git-p4.user")
>      if len(user) > 0:
