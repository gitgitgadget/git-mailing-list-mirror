Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF3C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1140B2078A
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgGARlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:41:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53561 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgGARlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 13:41:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id j18so23298757wmi.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fv1jcXCPgLgSUbByoUBBDSRYTTS0UVfUVhROKQaang=;
        b=nSlc0IjPd3wcXcO8M69tNWy53ayfYl7zlxlrV6YJQXUO7NiZuHx6nX5Dz3szqXzhmw
         KYbWNAT9BAdc3rEizcHfN+IQwNIri9J1rMqqO+TzaZ9oyZekDL7jeBpnwHsKHolSd36Q
         yGJavGrojg5E59988ydEqdqg2Log80NFEaKOmp0WvOx8ybXi53oAhFkQwQYd3EDa5uWj
         IPbYyjBLu5fwvx2rrl0xsZszehcbUx0CRYyTstjWYz5fbNb+ed9O/aiomYGhFFqyhTPv
         6yH6hZ0bGL+hZzWkpr8Z6evXNDruIvq2LN/MG371Dqes8t9NBtdgs2NL6mIGViyD9PkW
         VjRA==
X-Gm-Message-State: AOAM532OMtjSQr6gb4j387ky4YZv/mFyshYiHejK3yhzq1qR8sPsxwgg
        7l66HGWVPPfzFLe2KBjSUZqTU3OCIjgGJhJbcxk=
X-Google-Smtp-Source: ABdhPJzxONsefyPce8hW/bX5GEpprVhshUPAbL/tQ5AbQ2C+5HS9cpAruGWgMMskM/DEcM+k+0lF2wDxgs9wbObHA8M=
X-Received: by 2002:a7b:c406:: with SMTP id k6mr26696901wmi.130.1593625261133;
 Wed, 01 Jul 2020 10:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200701093653.3706-1-ben@wijen.net> <20200701093653.3706-2-ben@wijen.net>
 <CAPig+cT+cXuM3Asu6+Z25pGV2uRm6K1iAeYVhic9kqk1mS84-g@mail.gmail.com>
In-Reply-To: <CAPig+cT+cXuM3Asu6+Z25pGV2uRm6K1iAeYVhic9kqk1mS84-g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jul 2020 13:40:49 -0400
Message-ID: <CAPig+cRj6p4tdDhQOeoXpoqp+Wb94rKaVim-Yddj_Gz13phQpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git clone: check for non-empty directory
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 12:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> [...] For instance, we might do this:
>     rm -rf dst &&
>     echo foo=bar >realgitdir/config &&

I meant to use '>>' here, not '>'.
