Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E061F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC0Vp2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:45:28 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:34180 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC0Vp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:45:27 -0400
Received: by mail-yb0-f180.google.com with SMTP id e3-v6so126094ybk.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjtJgBJJ/QxmBnzl94LrLPMDd0SYeSfuKdAXEdFm5nA=;
        b=Qxf7Zt+KDVtPt9yjZI/E8s6LWfDnfuxf7kqXlgXh+eDCCXVxXCnQQoIwj0bAl3ftjm
         H73vgI7T7OnjkZHC50+khMNPF3icztPPrOUTQL962WC0BLIWKyKPQzp7bW6GYxml1a7+
         i/FsN1V8AG0XeH4iPKGK82Iad1mQKyUcltJrWARr+5XnHHET1cucv93AIqtHShUgiMzx
         kkl8U5qY8OMr9YgUOH1pEJN8WolCUvA/DVkj5VuUbGFCvAQZcPG3Puh1oQFQWAC5oe+5
         KRLjnkHQaW2mGDB3ToHJhKEIOHQbdVvSSh8yig1kvO3mYvWGFp9BCRwadiWdKd9pO5aH
         6OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjtJgBJJ/QxmBnzl94LrLPMDd0SYeSfuKdAXEdFm5nA=;
        b=W+exWYz31MXb5ZjybXt/kvt8zmTSRt1Eb3d6TWbPA6mqBQlAnnl4fbTwJmHYP8NuGr
         7A9SnwwU/O598x3Ls6jBI41TiywPNGL0kWXJTfngeSOskjr5cd3HONdUqlVrBZgRTv41
         M+ohKvIf5KRtlWWFrsJNQZa2DboOVICSpvfPeys76EvCJQxTqtJi09IyFesf84H+cg+C
         WmUl8VypUNEBoDEQ6nC8LGBpeUtpi2Y6wcAN3M1psqk8lkSlLYIxTZYRUN9gSxo6UI2c
         cdcArEqLA4AXOxibk3rI0ppgmikJapfiIwak5X8pIa7Dx4Z/mzPblLcziznWaTKVRxLE
         SBVQ==
X-Gm-Message-State: AElRT7GzxY4x3AKNVM/ZjLWICWKVGBPpbBeCzrGg5jldwXhav4K1EGE6
        XANjMrS3lN6GQcTkh5Em4ruQpn91zDeVY6xxJTAb4w==
X-Google-Smtp-Source: AIpwx48XgNcOur5fP3EXIlZF0xgq2uGx8dy/fhMxyjLy3raRz6fAyhBDYVJ0P1rR7T/PoxmJYq1gIDsA11xNBbIvE74=
X-Received: by 2002:a25:c713:: with SMTP id w19-v6mr689558ybe.515.1522187126115;
 Tue, 27 Mar 2018 14:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com>
In-Reply-To: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 21:45:15 +0000
Message-ID: <CAGZ79ka_dd=4-EVmoKrBVC_y4+eVPSz959BVNmzZkOwiZh_24A@mail.gmail.com>
Subject: Re: Bug: duplicate sections in .git/config after remote removal
To:     jfrey@redhat.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 1:41 PM Jason Frey <jfrey@redhat.com> wrote:

> at which point you can see the duplicate sections (even though one is
> empty).  Also note that if you do the steps again, you will be left
> with 3 sections, 2 of which are empty.  This process can be repeated
> over and over.

I agree that this is an issue for the user, and there were some attempts
to fix it in the past. (feel free to dig them up in the archive at
https://public-inbox.org/git)

IIRC the problem is (a) with the loose file format (What if the user put
a valuable comment just after or before the '[branch "master"]' line?)
as well as (b) the way the parser/writer works (single pass, line by line)

(b) specifically made it a "huge effort, but little return" bug,
so nobody got around for a proper fix.

Thanks,
Stefan
