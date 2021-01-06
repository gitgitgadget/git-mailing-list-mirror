Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F6C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A7C2313A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbhAFWCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbhAFWCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:02:05 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8AC061757
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 14:01:25 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 81so4138185ioc.13
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xx2Q/POqkb54vvg5pNGawlICpb68rde3WGHmVPTLNw=;
        b=qRRtWZsgrAur8xtak1wihPQG9wD8IgTdYj4Y1/Sj6JMenWL9/pTDCJEdb2n2DnjEvz
         qoejs578z/N2UJMugkFF81VmDtw8QIrPpxNF2qUP8WXGVkPCzPhfM+tHMKIpRmWbQwpd
         AZY/7+X0LTk867J3waUvb+QhxaY6DUELY/WHBUVe3fKG7sYBPklBqQGnJ6lfTGeqbzox
         Fehb6nG/LsThOp3MSwbzDk/cbxFssL3i5wG7swBjzX4dDOlVTALclDC1Jn0OjOa0nAA8
         qLAQ0guR6272sPv3BdV616a7XsPbHtZWvUV0S06TpZBvZvtzTFbFzxZuwKaW/pPD5y4E
         XeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xx2Q/POqkb54vvg5pNGawlICpb68rde3WGHmVPTLNw=;
        b=aw1cRmLB0AvCU/m9u3+hAwl8SVz04zXrDO0V1pnnBzfAn5wvjhAinyh7oq+XEubHak
         r7NuZ5n9PLfFkQ56v86YLP37GbrMONZb18fB0jzU0GIvgADVcS9Qk2l1t7ZwFhgpAeTi
         +KUXsCUvQ0Uv8Vh2uae3Ar+O+9w1lKP3SIrfJDTne8dopOUzSj5WrNZOgriA0kzdouh9
         6N130gIMbC2MpnUB3XnxfAo9VhWjC0MEr7epqTECjMt8wvkOGL6lQjwJRz8HbWuvLo0m
         Sii30RopOpjypcYu2lnPM/IiIFkoi0yepKjXcrrn8gSqq0BBRZBWOWEhO3xlsfhs8vec
         rGCw==
X-Gm-Message-State: AOAM530hoMUTa+QNF8xgyxbaeK+P70wApJKvO0wdOmMHb9AajYEkDn9i
        sOaSqkO5xM+VwmPYT7nuDiVAnnDXgEKiy9XgE3Y=
X-Google-Smtp-Source: ABdhPJy7+S4rEhFBNjE+8QFXNIBIcs5Ns3PyFOlvujkumRwC5UXSCCRlfPEtA8rQG1M26jXjrwt0D8Pos8m1STR+MCE=
X-Received: by 2002:a5d:9cd0:: with SMTP id w16mr4524226iow.2.1609970484762;
 Wed, 06 Jan 2021 14:01:24 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com> <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
From:   Jim Hill <gjthill@gmail.com>
Date:   Wed, 6 Jan 2021 14:01:13 -0800
Message-ID: <CAEE75_0e4_m_7hQXycVK1f=4LOb82U2DYveAvcF2XKKNgmfpNw@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> a need to have multiple unrelated line of histories in a single
> repository may not be there, even though a desire to do so might
> exist.  What is done with these unrelated histories that record
> unrelated contents [*1*]?

Git itself is an example of other reasons for carrying disjoint dags as a
set of related histories.

Also, I've taken to carrying submodule histories in the main repo, the setup is
very easy, just a submodule init and worktree add. I think the pair of flows
shows disjoint dags can be on a spectrum of relatedness.
