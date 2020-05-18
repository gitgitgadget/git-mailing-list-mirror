Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB56C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6473F20657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hHM+MgfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgERTxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:53:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52507 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgERTxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:53:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7403FC01C6;
        Mon, 18 May 2020 15:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dZgt8PYMrZL3I215aqAGj9eofhg=; b=hHM+Mg
        fB0f1JRD8sZwbAbmyt8xBXz27H+C/3KbjPFWx1Fk830GKYQq4izBG+rggFAFF4+0
        DozCelXImHEdCMbudPt3n4jf1UhsMlSTKMr5A8Epv3KWBLDCCBmgn8tJgdfgIoni
        LIqLyBQcGyD0lBa2rFHobgv9e2weKY8erbebY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d6MvwkADryVJWEfCB68G0FsmTpUlATiS
        ro132UKFIp9awS9/8qj2DlHuZw7teTlueqi2X6UV4HC0hM4WmPnRZlCXxSNl1Fza
        /wQRUFyubUi/iZmyiXHBl9PxRmczbP4zUCXcj0bYJZJeMUU25owrerxi+JcyuzXj
        TFCSTYZSR+s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AA7DC01C5;
        Mon, 18 May 2020 15:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADD65C01C4;
        Mon, 18 May 2020 15:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] git-bugreport.txt: adjust reference to strftime(3)
References: <20200518193736.19320-1-tmz@pobox.com>
Date:   Mon, 18 May 2020 12:53:34 -0700
In-Reply-To: <20200518193736.19320-1-tmz@pobox.com> (Todd Zullinger's message
        of "Mon, 18 May 2020 15:37:36 -0400")
Message-ID: <xmqqa7252f5t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 432E9500-9941-11EA-B39C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> The strftime(3) man page is outside of the Git suite.  Refererence it as
> we do other external man pages and avoid creating a broken link when
> generating the HTML documentation.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> Hi Emily,
>
> While building 2.27.0-rc0, I noticed a broken link crept into the HTML
> docs for git-bugreport.  I believe this change matches most of our
> existing references to external man pages.

Thanks.  This was noticed elsewhere in a different thread but let's
take this as a patch independent from the other documentation topic.

> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index 7fe9aef34e..9edad66a63 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -46,7 +46,7 @@ OPTIONS
>  --suffix <format>::
>  	Specify an alternate suffix for the bugreport name, to create a file
>  	named 'git-bugreport-<formatted suffix>'. This should take the form of a
> -	link:strftime[3] format string; the current local time will be used.
> +	strftime(3) format string; the current local time will be used.
>  
>  GIT
>  ---
