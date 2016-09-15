Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F302070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbcIOSPU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:15:20 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36848 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcIOSPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:15:18 -0400
Received: by mail-it0-f54.google.com with SMTP id o3so109504653ita.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MaYFjBwWQzO1VhyEdONOFnqVxaG1/XZbLA4DUVx9u38=;
        b=pMYMClDWB+Xnli4mk6ns1ITYbmRpgEweltdYbrmxXXhytmf7PZY8qQDdY2akQUdv0b
         DAPWEjy0LRS3fxIeSxml+ztzZkLa2i6v4PCKY/5138oSWpefGgf/4TLfGu0McITAB7Ew
         St3mVCO1gBgmxVsKWlNdBusArAK4fHBGFEzZ8jysYqf3XnRCN9HNMhMTfu1o3d3TRzYU
         b6+CIq/hU+5qwom8eAWCGgKhxeBNINnFIigN5OuIdtaxV2RWIF/D3hJWSTjcyR0gX0WS
         9r4dY3QzXDbVxEQ5IZiCd3A31rwLXse19GzRRNAGHF9Z1IwFEuFe+2vkeuxEYrJHRR7Y
         SXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MaYFjBwWQzO1VhyEdONOFnqVxaG1/XZbLA4DUVx9u38=;
        b=AKz66EzfX/yVLLZ8BRedi2/sqv5HaNzzmNTMT9hNYkM0zh/KXTTZyjhmAprfAQW/UV
         h7itU9SqSjLJLFyrNgO81pM9fU6uBxGQ4aPa6+z440XeDUUZYAZyibJ5cYmIxsLBta2F
         kKDZU1/1IHRbiio0Suvhqrt/41tZxB+dsgGYx98VFlBsXPym8mqj2UNKpjVzyXZXynjO
         wgK8h+0dAQuu5yMbHI2ULnU/87QPOqk4u56EliECedRGXdR+WSnj8WFsGimU0pXiwd/4
         jVd5Cn0ELIZbEMArFjhaQWx8aPgbb+vPCW2LnjaWLEv8uheNa2gH14m/pmVICWqTkqI5
         i5cg==
X-Gm-Message-State: AE9vXwMFAldNvIYbNfZ/fZ/XzpL2i2MDHEUpPrpSEfT6W6Co/wkBO0t6Cv7S9/lFIKP416T93O6/5hzoCKfxGET5
X-Received: by 10.36.141.129 with SMTP id w123mr937975itd.65.1473963317435;
 Thu, 15 Sep 2016 11:15:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 11:15:16 -0700 (PDT)
In-Reply-To: <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
References: <20160915130233.GC9833@onerussian.com> <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 11:15:16 -0700
Message-ID: <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I think that is a more pressing thing to address.  Once we make it
> easier for the user to bring a half-initialized submodule properly
> into the world view of the submodule subsystem, we would have to
> worry about the reported failure case even less and you do not need
> to pile on workaround options to let things continue in a state that
> is half-broken (that is, in a state that is perfectly sane to the
> core layer, but is not liked by the submodule layer).

Heh, I see.

    When searching around the net, some people use half
    initialized submodules intentionally, e.g. I'll store some private keys in
    sub and I publish the superproject asking for collaborators to my new shiny
    webbased thing. The submodule containing the private keys never leaves
    my hard drive, hence no .gitmodules entry is necessary.

Not sure I agree with such a setup, but people use it.

So how about this fictional work flow:

         $ git init top
         $ cd top
         $ git commit --allow-empty -m 'initial in top'
         $ git init sub
         $ git -C sub commit --allow-empty -m 'initial in sub'
         $ git add sub
        You added a gitlink, but no corresponding entry in
        .gitmodules is found. This is fine for gits core functionality, but
        the submodule command gets confused by this unless you add 'sub'
        to your .gitmodules via `git submodule add --already-in-tree \
        --reuse-submodules-origin-as-URL sub`. Alternatively you can make this
        message disappear by configuring advice.gitlinkPitfalls.

         $ git submodule
         ... similar advice goes here...
         fatal: no submodule mapping found in .gitmodules for path 'sub'

         $ git submodule add --fixup-modules-file ./sub sub
         Adding .gitmodule entry only for `sub` to use `git -C remote
show origin` as URL.

         # user is happy now.
