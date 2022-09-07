Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF22ECAAD5
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 02:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIGCTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIGCTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 22:19:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE156901B4
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 19:19:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d12so13095028plr.6
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 19:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MxkWwRIzA/Ld+uKsQtIBh8QQ9Ofu5rCb6fh3Rn/cKc0=;
        b=XDYqG3TGuzhTEE5Rbuz782+4yEgnKFDsa5hYrmbayt010wMm5pnpNMsI8GqL8ktaLK
         m7QGQUrwl6BqLg62FYN6RYQRPB6W/yJc+ZiahJIgZjU5Z+TU6j1fUfSf44Wbfn6Qj+mB
         oo8ul+ejbi2oJuVZDyRD1Xs+e/QbM/S1DuV5jGhoMkmj9+tbk8TGhFD9J4NSw7fs9YuJ
         KU62s0o6QzuNAESuRey0rGd6rrNnyYWdI2IllXvZ4WLt39Zob1poHXjfcBu5zE0y/Dq0
         hpNQ+Vf8kBh0RaZw/gbnh0T0ypcIr4fBWPJGSV6o3BeuasOeRL0zoKbb6xFgpp0mKPox
         mnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MxkWwRIzA/Ld+uKsQtIBh8QQ9Ofu5rCb6fh3Rn/cKc0=;
        b=esfVaVe/QIlkJPIrWIy0R6naB8Etr3fCwMCTPwFrOfO+J5oP0g3JdFE1fdzkOTdhiS
         13sL42csVXS6dd/DPcZnGuV+EMsSLwikucE6bm9GVswQIRq7ucLDo/Lj7Ugh0Vx6vF4B
         tJTIk5xpjt/45KXt8O1IwNckAnsRLAUat5OgXgTZK2zeLcW9exGmBQ1EeccpfoJNdOrI
         1kZmBSBsKo6Z4lLoqXRNW4aZn8mj6ZUpJplACZaaKnIioeNABRXHkwHzUQLUq+0fW70F
         sutVp35+y5/rK+Rrdr1KUyZBW59Hi40Z2m3Iabxeg0ubiVS5rEUfrT1tJD2foVK7fJ3M
         fwxg==
X-Gm-Message-State: ACgBeo3/3My8KJDZ4ldruWUwAYAbV7+bLufNnjwFZi/ynnUwT4QvKgrs
        sVbcyljPY27WlCd+TKoZc1DIhR1WlGg=
X-Google-Smtp-Source: AA6agR76neINVSPmCA+aLiUqW8sc4nwuaER3pa1OfhXLt2G96Mb5kppB5AOnOM5sZe0UxSPk2541uA==
X-Received: by 2002:a17:903:110e:b0:171:3afa:e68c with SMTP id n14-20020a170903110e00b001713afae68cmr1640628plh.12.1662517157319;
        Tue, 06 Sep 2022 19:19:17 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id z8-20020a170902ccc800b00176ea6ce0efsm94742ple.109.2022.09.06.19.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:19:16 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:19:14 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Oliveira Carvalho <felipekde@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Patches produced with format-patch under specific config aren't
 applicable
Message-ID: <Yxf/opwDZb/dLp29@danh.dev>
References: <CAOC8YXak_QfPgxc=JWvzpaPGe9ZnFhDnR-36PrMG16qXFkQmsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOC8YXak_QfPgxc=JWvzpaPGe9ZnFhDnR-36PrMG16qXFkQmsw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-06 10:45:41-0300, Felipe Oliveira Carvalho <felipekde@gmail.com> wrote:
> Patches produced with format-patch under specific config aren't applicable
> 
> Inbox
> I have diff.noprefix=true on my ~/.gitconfig
> 
>     [diff]
>         noprefix = true
> 
> I generate a .patch file from the last commit with
> 
>     git format-patch HEAD^
> 
> Due to noprefix=true, I get this line in the patch file
> 
>     diff --git src/filesystem/PhutilProcessQuery.php
> src/filesystem/PhutilProcessQuery.php
> 
> instead of the default
> 
>     diff --git a/src/filesystem/PhutilProcessQuery.php
> b/src/filesystem/PhutilProcessQuery.php
> 
> So when I try to apply that patch, I get
> 
>     $ git apply --check ./0001-my.patch
>     error: filesystem/PhutilProcessQuery.php: No such file or directory
> 
> In trying to remove the a/ and b/ that apply expects, it removes src/
> from the path, then fails to find filesystem/PhutilProcessQuery.php.
> 
> As a mitigation, I'm setting diff.noprefix to false, but a more robust
> solution would be for the format-patch command to ignore this setting
> as patches are expected to work on repos configured by different
> people.

You can use "-p0" with git-am or git-apply to apply such patches.

There's a RFE in the past to add log.noprefix and/or format.noprefix
but it seems noone interested enough to work on it [1]

1: https://lore.kernel.org/git/xmqqr1auvs7m.fsf@gitster.g/

-- 
Danh
