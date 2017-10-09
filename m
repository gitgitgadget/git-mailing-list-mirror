Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAD320372
	for <e@80x24.org>; Mon,  9 Oct 2017 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755174AbdJINiS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 09:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbdJINiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 09:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB35B4A6E6;
        Mon,  9 Oct 2017 13:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com CB35B4A6E6
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (ovpn-116-123.ams2.redhat.com [10.36.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC4EB67CEB;
        Mon,  9 Oct 2017 13:38:14 +0000 (UTC)
Subject: Re: Special strings in commit messages
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
References: <f54bea17-c245-c644-f974-ca2ac84901c6@redhat.com>
 <20171008213053.GA8568@starla>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <6a036339-d57d-4cc8-acfc-4e1786763a80@redhat.com>
Date:   Mon, 9 Oct 2017 15:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171008213053.GA8568@starla>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 09 Oct 2017 13:38:15 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2017 11:30 PM, Eric Wong wrote:
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 6e64d40d6f..14c50782e0 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -53,6 +53,7 @@ else
>   
>   	git format-patch -k --stdout --full-index --cherry-pick --right-only \
>   		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +		--pretty=mboxrd \
>   		$git_format_patch_opt \
>   		"$revisions" ${restrict_revision+^$restrict_revision} \
>   		>"$GIT_DIR/rebased-patches"
> @@ -83,6 +84,7 @@ else
>   	fi
>   
>   	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
> +		--patch-format=mboxrd \
>   		$allow_rerere_autoupdate \
>   		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
>   	ret=$?

My context is slightly different, but I added the mboxrd options 
manually to both commands, and it fixes my test case.

I'm still wondering if I have to be on the lookout for similar issues 
with different strings.

Thanks,
Florian
