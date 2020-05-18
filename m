Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C84C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62242204EC
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="QvgvAfLA";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="UAZTwF8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERRZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:25:07 -0400
Received: from mail.spkdev.net (unknown [IPv6:2001:41d0:8:e379::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25691C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:25:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 4BE024034B;
        Mon, 18 May 2020 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589822705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2HuQBwYkobZoDmOwDk+F9GA9nvkfy8zZUlMm+4gqCw=;
        b=QvgvAfLALv2M+KnmGYFE1bCZ7L09Puk+EjkG4v2hU8L6GbUKRW4cjO+Fom4jrA53FZD6q0
        /TGEQDRY/kzF1WcSkRe5s6AI+2LkKPdwvYkW4LtPkMRsSXy7EQiTeTDdL3gTezebslWlyX
        oshdgWddYI1bfS2cSJsneU/EOcBTegQ=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id BD1B540158;
        Mon, 18 May 2020 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589822704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2HuQBwYkobZoDmOwDk+F9GA9nvkfy8zZUlMm+4gqCw=;
        b=UAZTwF8FLaDkYv0LpVREMFUAODH39De6ESP30RN05B2Y1SDgFRTDXWBhkWDcx9qdiVBmcG
        PZoahnDkonOBICZDp/IciA9KU59YdQVGWfZIlFZk2GEelWkdHzBH5VSoPnMu5wUFBA1vYE
        t/zgkO8/Uv3yq4eo7Sjj1R94pNA3r9Q=
Date:   Mon, 18 May 2020 19:25:04 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     congdanhqx@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518172504.GB2110@spk-laptop>
References: <20200518094021.GA2069@spk-laptop>
 <20200518114630.GA30622@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518114630.GA30622@konoha>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Mon, May 18, 2020 at 05:16:30PM +0530, Shourya Shukla wrote:
> I think the message can be written better, maybe something like:
> 
>     The `diff.relative` boolean option set to `true` shows only changes
>     in the current directory/value specified by the `path` argument of
>     the `relative` option and shows pathnames relative to the
>     aforementioned directory.
> 
>     Teach `--no-relative` to override the earlier `--relative`

Thanks I've applied your suggestion to the v6 patch

> > --- a/Documentation/config/diff.txt
> > +++ b/Documentation/config/diff.txt
> > @@ -105,6 +105,10 @@ diff.mnemonicPrefix::
> >  diff.noprefix::
> >  	If set, 'git diff' does not show any source or destination prefix.
> > 
> > +diff.relative::
> > +	If set to 'true', 'git diff' does not show changes outside of the directory
> > +	and show pathnames relative to the current directory.
> 
> In the second last line, it would be better to write is as:
> 
>     ... does not show changes outside of the current directory/the path
>     provided as the argument in `relative`?
> 
> Even my version of the above line seems very crude and innaccurate, but
> I think that we should take into account the `path` passed down to us
> by the `--relative[=<path>]` option.
> 
> Moving on, what I wondered was that maybe making it a `true/false`
> option would be better? Something like:
> 
>     git diff --relative=false //override the diff.relative setting
>     git diff --relative=true <path> //works like the usual `relative`
> 
> And by the usual, I mean :
>     git diff --relative[=<path>]
> 
> What do you think? I think it would be better than adding a new option.

I think this would be complicated to check if true/false is a directory of not;
it has been mentioned by Junio on another thread for a patch alike

Cheers

-- 
Laurent
