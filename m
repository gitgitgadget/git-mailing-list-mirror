Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94859C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGUPob (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGUPoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:44:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1058BABE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:39:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w29so1515578qtv.9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVNAkVqc1N5VjtpNwBIkU4FBAY+b11W1Ir4htMDRDyc=;
        b=FlLrunSAYrc8D0Urct3ZBhbSnp/ia4elbre3lXbeflirTVtOkH0m4+y4ZAaAm2wVVe
         QPlF9+W8qcQpUry47B2yydW4tUPH1wc9iTZiktcKIj7G60QJvpX3pzFPLgaMa+EcbEdJ
         vRhqQHRMb5t012vww0tFhzGA13CW1jyxxwrpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVNAkVqc1N5VjtpNwBIkU4FBAY+b11W1Ir4htMDRDyc=;
        b=1dCu+n+vXAXd9t9s3gKEcoQYWeAFK8Nb/GfWBQo7hJRbSQfiqtiEekAWks0NIJjCjp
         ZTbIiK/yivqUsgXRnnvfvdF3LnFuvAOPqk0bKhphZI5Mm8wD1vTcYJsZK5Iip1p5VBOJ
         7jIYerJ+2zD7cIxRwqZ2sdJDDHdBBlNX+v+DOVSGdAyniP3VGqlhFI17w/aXKry06mzi
         rvHBGv/2wgP90Dv26S0QhcTH3F3mKYhuUyQ3LEQ9qyBzx63tSFgxQlbiQcJWQ9Ph/Q+T
         HMR5IRhNNz7L1ibezl95oh+QZt0wshgNh+ASCu2XGGK+CcoWe6j+CNpFtwsCvoHALNSY
         G+SA==
X-Gm-Message-State: AJIora/elloGm202940+Hj6HklbRL6yhoW3hSNsC/4b91NBzuXQpTXti
        Q1Ztg5F/xUNCxb6eIj7p+3V7rA==
X-Google-Smtp-Source: AGRyM1sGMQk8yiGdfJ7tFkdZjsSk8X1JE5pqy8+fPDkHRz4p2fdAUQ3y/Sl2x6izibkXJzB8vHYs6w==
X-Received: by 2002:ac8:5b56:0:b0:31e:fa8c:852e with SMTP id n22-20020ac85b56000000b0031efa8c852emr12126595qtw.503.1658417997471;
        Thu, 21 Jul 2022 08:39:57 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id fu24-20020a05622a5d9800b0031b7441b02asm1362286qtb.89.2022.07.21.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:39:57 -0700 (PDT)
Date:   Thu, 21 Jul 2022 11:39:55 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <20220721153955.lnfqfilri24i2yw6@meerkat.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <xmqq35eumrp8.fsf@gitster.g>
 <010101d89d16$a97184a0$fc548de0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010101d89d16$a97184a0$fc548de0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 11:29:20AM -0400, rsbecker@nexbridge.com wrote:
> I might be missing something here, but could not a description follow
> similar semantics to how git describe works on tags? Anchor the description
> on the commit where the branch was spawned, then determine the appropriate
> description based on things like --first-parent. Again, I'm probably in the
> weeds.

I think the trouble is that "commit where the branch was spawned" is not
reliable due to:

- rebasing the work on a different branch
- reordering commits (including the first commit in the series)

This is the main reason why I actually want to stick the empty commit with the
cover letter not at the tip of the branch, but at the start of the series, so
as to clearly demarcate where the series of commits we're interested in
starts (at least while the author is working on them -- when it sent off
upstream that commit can get removed/moved).

-K
