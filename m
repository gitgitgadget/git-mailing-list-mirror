Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFCB11F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966409AbeCSRWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:22:51 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36495 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968003AbeCSRVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:21:45 -0400
Received: by mail-ot0-f182.google.com with SMTP id 108-v6so18197846otv.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4fKef4VXX0+ujDE0GyO9cPxOfZmBj366LTy96cJTcM=;
        b=IWxj2E3PYT4jBY+QSqWdVSgkPkg+3xaWDqS4BUKvLVUmWb8w1nJQ1Fivg9zKr2GuLF
         Um6N1ZGUxUmUdXJEzyydv4Q9gNjABVDYVjntr5zm/9MwMCbWWdHFl0J+19gFl6v2Rraw
         i5gbE6ft1ofNtYl9QCOTc4PUkb5LhAJNSyHO1kINt45dyz/Wg6rbNW0L6xYJZcIPo0cr
         9+m8o2tKVZV0YHsu2m4eT9s4k3asL2HCugHQeW+jGm0ZYZAp+vLvt5w3QiscFeaezQF6
         6QV2CukNtxxmDgvq/vd5WoEmVdOiG6J8bdCvhirtXK6CYGsquPqD5rhny4QwXUVOl1q7
         wFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4fKef4VXX0+ujDE0GyO9cPxOfZmBj366LTy96cJTcM=;
        b=Jd4qoXYiU8az+tyb0BiaOvkDp48J4UF0UxftuKaxH36KxjgtEod8XGHS1e2vRmX4F5
         p7j6gxTQOhDG8fmYLr5Ppe6yshBOjP0hFuhLtCF0L83iFOwK5hDP3TgpV4wDQ1B9Ibty
         naqfG+Yxv9H4OzkdE1Fc9LTZPBsZlSwZgkVRpkmHgw83/jbvKK3O5T/fTPTWjfL1aISv
         PFKhv618NJ9hbo7fLycQ6wuuYLaePddMf5Ud3VKN4VkvmYMlqNbVAhQhmYcG7lrMHIiA
         F2f7nAEIhvvJwrX4F5qCvhAmDJlh/ujzvYPm9lKjsDY5WE5zZ/8WoaVmE27tzm09lz2j
         hATg==
X-Gm-Message-State: AElRT7EIV0UgzgtZvNRaf6ytIWayqWZ1ko+92xjgZZ6AL/YhwNVQ8TcQ
        c3Gwf3KTwaAFYhRllyxEgKBOtQ3//6kz7ciUGPc0sA==
X-Google-Smtp-Source: AG47ELtYc8dxjagNYEAueQP525eGGGH67B9WHZp9SHgZqM2b63NDGstltdzhcK0VQNyp/xmjqCDOTxrsVqBz+031ucA=
X-Received: by 2002:a9d:3364:: with SMTP id u33-v6mr8780270otd.26.1521480104711;
 Mon, 19 Mar 2018 10:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
 <xmqqbmfkvvhc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmfkvvhc.fsf@gitster-ct.c.googlers.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 17:21:34 +0000
Message-ID: <CAD1RUU9R5xfGghQP-A=yU0RkmVDaS0hPGMHVieCyb-DRg97SnQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 1:14 PM Junio C Hamano <gitster@pobox.com> wrote:

> > +# RUNTIME_PREFIX's resolution logic requires resource paths to be
expressed
> > +# relative to each other and share an installation path.
> > +#
> > +# This is a dependnecy in:

> dependency?

Oops, this is the second typo that has been pointed out. I'll release one
last series after a small review period with these fixed.

> > +# - Git's binary RUNTIME_PREFIX logic in (see "exec_cmd.c").
> > +# - The runtime prefix Perl header (see
> > +#   "perl/header_templates/runtime_prefix.template.pl").
> > +ifdef RUNTIME_PREFIX
> > +
> > +ifneq ($(filter /%,$(firstword $(gitexecdir_relative))),)
> > +$(error RUNTIME_PREFIX requires a relative gitexecdir, not:
$(gitexecdir))
> > +endif

> I see Dscho is CC'ed so I won't worry about "is there a more
> portable test than 'the path begins with a slash' to see if a path
> is relative, or is this good enough even for Windows in the context
> of this patch?".  It won't be a show-stopper issue as long as we do
> not error out with false positive, though ;-).

OK sounds good! There are other places in the Makefile that use this method
for this purpose, so hopefully the worst-case is that this is no more
broken than they are.
