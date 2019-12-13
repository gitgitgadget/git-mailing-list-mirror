Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75623C79DCE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9821246B3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtLcj7MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfLMRMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:12:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfLMRMw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:12:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40774A6AC6;
        Fri, 13 Dec 2019 12:12:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B6hXrrP6SC5fF1S8U0Fp3pkuoiY=; b=NtLcj7
        MG3uq8625Y8hJ4vmiWiPVyvvf5AZRJYGbYoZ4gD7dhkVLxz3LmUttlWUN0RJfen/
        IY0qItfacQ5iazDcwG5vxQFuPkkNOl/gax0CMNJ683TUgA3IbmlQAuHnnIplJ7VL
        HOYOjEM1nv+fANeq3+n9xuA29uhvhQMHLIgDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G2+4T+FEPx4C2JWAON6nBur7vfXCQW07
        f+wiasm3gO3WS84VlGoSLIa9AYhom0AKYr/qrqFEamiB82ZWdkQFJBMu8miAtd1L
        U+ZG2NrOgTSrys2dkMfVzOf2SazZgIBA3Ug66nzGPXT9CTFZVCnoCfYrKGHkEkMw
        OMIy7uZ4TV8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39FFBA6AC5;
        Fri, 13 Dec 2019 12:12:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA719A6AC3;
        Fri, 13 Dec 2019 12:12:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/2] gitk: rename "commit summary" to "commit reference"
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
        <cover.1576197846.git.liu.denton@gmail.com>
        <8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com>
Date:   Fri, 13 Dec 2019 09:12:43 -0800
In-Reply-To: <8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 12 Dec 2019 16:44:50 -0800")
Message-ID: <xmqqblscm9o4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7F4050A-1DCB-11EA-9FC5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> From: Beat Bolli <dev+git@drbeat.li>
>
> Now that the commit reference format has a canonical name, let's use this
> name in gitk's UI and implementation.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> [dl: based the patch on gitk's tree]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  gitk | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I think this one makes sense, even though I am on the fence about
patch 1/2.

Thanks.


>
> diff --git a/gitk b/gitk
> index d07e3302de..17346b4c5c 100755
> --- a/gitk
> +++ b/gitk
> @@ -2640,7 +2640,7 @@ proc makewindow {} {
>  	{mc "Diff selected -> this" command {diffvssel 1}}
>  	{mc "Make patch" command mkpatch}
>  	{mc "Create tag" command mktag}
> -	{mc "Copy commit summary" command copysummary}
> +	{mc "Copy commit reference" command copyreference}
>  	{mc "Write commit to file" command writecommit}
>  	{mc "Create new branch" command mkbranch}
>  	{mc "Cherry-pick this commit" command cherrypick}
> @@ -9426,7 +9426,7 @@ proc mktaggo {} {
>      mktagcan
>  }
>  
> -proc copysummary {} {
> +proc copyreference {} {
>      global rowmenuid autosellen
>  
>      set format "%h (%s, %ad)"
> @@ -9434,10 +9434,10 @@ proc copysummary {} {
>      if {$autosellen < 40} {
>          lappend cmd --abbrev=$autosellen
>      }
> -    set summary [eval exec $cmd $rowmenuid]
> +    set reference [eval exec $cmd $rowmenuid]
>  
>      clipboard clear
> -    clipboard append $summary
> +    clipboard append $reference
>  }
>  
>  proc writecommit {} {
