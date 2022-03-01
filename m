Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09474C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiCARom (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiCARoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:44:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974615F8F4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:43:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m6so4495574wrr.10
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1/gApM/2l5Uuj3UtU7EAU53fbvI+GOqe2USXylFcrA=;
        b=nXyUM/zFhFrtHXq9Y0Q+wYVpuaInmlSAVOjmvSB+lkFkJwMSsK4DPwSjXLwapxDBiv
         BqKDxa+D7dp8wL1dS/L8UWdqzRYv5Wstf7D9WI7CHz6Nfa/aRxMthMcD4QsptLmFztVq
         kHsJW+n3UhS1hyJdThO5WebhfDXhjifmQ5VlFtXP5tfLIlGlTFvIvchfvLKBo+WUVpu0
         xquVqsUOt/stfW6yvOCpa0dxmrejIDdT1NSOT9aYJg7wXKf1fA2j2M+lOHCQdlpRB1r3
         J68XGYayBqqv+bsD6Hb0VvyvXi2iLUAlsoMQ9T9hi+/30tttoQdeE3wvjGn2IAfaUHyG
         F9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1/gApM/2l5Uuj3UtU7EAU53fbvI+GOqe2USXylFcrA=;
        b=zmGZhcCVPtqBdKE4oSOddQFibtCndmqlnG3I/MkGRW5436/X+++21uScSyNtr1/5Pk
         v+xSIbV115wKYpVk/kXtouZWJDVMbLFEm9z6oq3Ad19GBYl9L3WsORJLNZcPm7Cx2n7D
         +6hDDZ7sKswIg6msX/pns9wEemAJoZY0dWN+SZQjQwfDR0HNlgow0/M/THOGohv5wXW2
         CffP73VGLuSaCCb7gthwAfogjgD+LyBzBYynJ9Z5MEl/v3ZXsrdaoKQb0txqt3nlpYhp
         08pFNcNwscEg8+Mwse3RF0CqKHMItdKmn93nJwM48+68fLjiPKRTqhEwLQyBUr9ODH+B
         uI9A==
X-Gm-Message-State: AOAM530rkEqAxXs93cBSBJ9VlJ35jcRXu0TX7ONK+1B3fO2FTDklx7YH
        S1SkifKcsD6ObFkQ5ieyXUYfRg/YzkUu8Xwnl8ibTIWNQDKuJw==
X-Google-Smtp-Source: ABdhPJz+bji8X35muRlzNY+7UxAAnVmcE8uxbHrgXytKPp3AYrBqpoCvb3Ntt4ZJ15cA1r8l32UYPIR9VVtBCvkN/eE=
X-Received: by 2002:a5d:6c68:0:b0:1e8:9827:b978 with SMTP id
 r8-20020a5d6c68000000b001e89827b978mr19289670wrz.633.1646156634687; Tue, 01
 Mar 2022 09:43:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
 <xmqqy21tr2pg.fsf@gitster.g>
In-Reply-To: <xmqqy21tr2pg.fsf@gitster.g>
From:   Ed Warnicke <hagbard@gmail.com>
Date:   Tue, 1 Mar 2022 11:43:43 -0600
Message-ID: <CAFVSqg2GEs7QXQvHmhxgxFAy35yN5GgDGwAZ1bPm-gfmCPzqRA@mail.gmail.com>
Subject: Re: URI Scheme for git object ids?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

That's the kind of feedback (and pointers) I was hoping for :)

So is it fair to say you are suggesting:

1. Talk to 'torrent or something' folks to see if they have a scheme in use

and

2.  If not, 'gitoid:${hashtype}:${hashvalue} - like:
     gitoid:sha1:261eeb9e9f8b2b4b0d119366dda99c6fd7d35c64
     would be a better choice

Ed

On Tue, Mar 1, 2022 at 11:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ed Warnicke <hagbard@gmail.com> writes:
>
> > Has there been any discussion of how one might represent a git object
> > id as a urn or uri?
> >
> > It's clear that 'git:' is registered with IANA as a URI prefix for
> > locations of git repos.
> >
> > I was wondering if there was any existing use of something like:
> >
> > 'gitoid:${type}:${hash type}:${hash of git object}' ?
> >
> > So for example:
> >
> > gitoid:blob:sha1:261eeb9e9f8b2b4b0d119366dda99c6fd7d35c64
> >
> > which could be used to communicate generic git object ids.
> >
> > Ed
>
> I do not see why the object type should be there.  Once you locate
> the object whose object name (in sha1) is 261eeb..., the object
> should be able to identify itself as a blob (or whatever type it
> is).
>
> Aren't there already folks who are exchanging git objects over
> torrent or something?  What do they use to identify what each node
> offers and what participants want?
>
