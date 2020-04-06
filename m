Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC5DC2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5AD206C3
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXlrhTLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDFXUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:20:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54611 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDFXUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:20:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CEA84E977;
        Mon,  6 Apr 2020 19:20:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BJS+wvmwyRJBgmXoQAsHJ/ZLgjI=; b=lXlrhT
        LqhizUT+rBM9dmQfIoCJPMlgzqYuwYnV7ozGqK0MVPsQeXYRTGKC9eJLAzeNy3Zr
        s0HQ1Z2te6Zal281jLf+6bZFbKFFsxYzBsTILwiNU5HHmQ7U4bmoQCqAJWPWGBXI
        8qqvExv/BehNXtuRLiEIS/JW4YoGGeP1bgpxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E1erQdljn1LMgiiHp4euo9ZuFENwYf83
        0YJIUNkSA7vi5kBb/WivsbfAieK3H57CvY33GhwBVQj0j1UVnhtkEGTzH7+myUeX
        k+G1d4hVZT1Y78QSxrd09p5r9tZRNuy/q4mkOoZbIB8hUz9H1IMYEkXeZWycC1u3
        6DB72SofOyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32DAD4E976;
        Mon,  6 Apr 2020 19:20:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCAD94E975;
        Mon,  6 Apr 2020 19:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 4/5] bugreport: add uname info
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-5-emilyshaffer@google.com>
Date:   Mon, 06 Apr 2020 16:20:36 -0700
In-Reply-To: <20200406224526.256074-5-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 6 Apr 2020 15:45:25 -0700")
Message-ID: <xmqqa73ourp7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38C3C13A-785D-11EA-8617-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The contents of uname() can give us some insight into what sort of
> system the user is running on, and help us replicate their setup if need
> be. The domainname field is not guaranteed to be available, so don't
> collect it.

Unlike "what's the verison of 'git'?" and "with what versions of
which libraries does the 'git' the user is having trouble with links
with?" I mentioned earlier in my review of [3/5], what this step
deals with, i.e. "what are these properties of the running system?",
is perfectly good to report from "git bugreport" itself.

Looking good.

Thanks.


>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index f44ae8cbe7..17b0d14e8d 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -26,6 +26,7 @@ The following information is requested from the user:
>  The following information is captured automatically:
>  
>   - 'git version --build-options'
> + - uname sysname, release, version, and machine strings
>  
>  This tool is invoked via the typical Git setup process, which means that in some
>  cases, it might not be able to launch - for example, if a relevant config file
> diff --git a/bugreport.c b/bugreport.c
> index 4cdb58bbaa..1a3172bcec 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -7,10 +7,24 @@
>  
>  static void get_system_info(struct strbuf *sys_info)
>  {
> +	struct utsname uname_info;
> +
>  	/* get git version from native cmd */
>  	strbuf_addstr(sys_info, _("git version:\n"));
>  	get_version_info(sys_info, 1);
> -	strbuf_complete_line(sys_info);
> +
> +	/* system call for other version info */
> +	strbuf_addstr(sys_info, "uname: ");
> +	if (uname(&uname_info))
> +		strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
> +			    strerror(errno),
> +			    errno);
> +	else
> +		strbuf_addf(sys_info, "%s %s %s %s\n",
> +			    uname_info.sysname,
> +			    uname_info.release,
> +			    uname_info.version,
> +			    uname_info.machine);
>  }
>  
>  static const char * const bugreport_usage[] = {
