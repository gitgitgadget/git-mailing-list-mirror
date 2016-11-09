Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90FC20229
	for <e@80x24.org>; Wed,  9 Nov 2016 09:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbcKIJqT (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 04:46:19 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38717 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbcKIJqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 04:46:15 -0500
Received: by mail-it0-f45.google.com with SMTP id q124so260309413itd.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lp296kcn8x8peP5ceafUFFp1G6c9TLXM59R6fmLcAeU=;
        b=evl5HnYUjPiEdBDND+zABr/QywxEpzvIz3/mk1eZvCANWl/B6Fzd/XBnbLdjWCtWRa
         WsJL/FI7D0vds3Lso15r1lqKMkKoz4CCJ6lMdTkry/iCnzyRWPMSyJ7jInDGEYwv787z
         gqORmFs3U+1of7y7a5UqogP+IyKdOZZxtKsymAuLk/Nr3mlUYwHLZKQqWbYR3dUmyiv7
         7ZUQm6VaKpcjitip17sGCnA5FnM1oeXL1Cb8auFnqrQYApqf6/r4V9BlWDJTUIYHyI6+
         y/Sx8mcQhLmY/O+QKXFG46RXIKb9tnSdZ+T9tkWYyAjNZiKD4YAXKKCH1DJC91yaVbec
         EJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lp296kcn8x8peP5ceafUFFp1G6c9TLXM59R6fmLcAeU=;
        b=G+u/6c2TUJjmfqnN9YOjspLiV99AiV3PIuMU0bvyWuSZHtZyyHEbLof0NovzYAwQI4
         i5YlvNFoZAlYj8I0eEmQzDwpep/4S8Xy/JxUaJ5b50N+RU7+dGcx3FcNrfGfOccX8AeA
         qdjeBHuRY005GZfJu9U5gcWSponBnXEXPPTedXyc6vU0w5sCsJ6XNPknBXAJmHZXQRSg
         KTpRXEGt3pYk62Oh8hWv4ngrcxk/uPilrjmgVmhGeAuC7jvvLq2RljOky01G+2PzgFqr
         9c2dQjjkPzf4y1EaCTOSJBbLYT3xJxzi0aGXM+27RndOwt+Huj4AgMDd3uL/KOlUyIbA
         XPhg==
X-Gm-Message-State: ABUngvdCO/avHQNdo4Lj2c7qlFbLU7T+xMtdKwfUMUTBsWcwQDPxDRIuJo3JFZ7ch/qcqxiEMNSyXfpjIzUa6w==
X-Received: by 10.36.22.212 with SMTP id a203mr12753425ita.3.1478684769845;
 Wed, 09 Nov 2016 01:46:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 9 Nov 2016 01:45:39 -0800 (PST)
In-Reply-To: <xmqqzilp63yh.fsf@gitster.mtv.corp.google.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-33-sbeller@google.com>
 <xmqqzilp63yh.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Nov 2016 16:45:39 +0700
Message-ID: <CACsJy8C2MLg4ncLBXXJGf+=mPF_rRoKs2vN6=+chZeNeXWZsbg@mail.gmail.com>
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 1:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The reason why I am bringing this up in this discussion thread on
> this patch is because I wonder if we would benefit by a similar
> "let's not do too involved things and be cheap by erring on the safe
> and lazy side" strategy in the call to ce_path_match() call made in
> this function to avoid making calls to the attr subsystem.
>
> In other words, would it help the system by either simplifying the
> processing done or reducing the cycle spent in preload_thread() if
> we could tell ce_path_match() "A pathspec we are checking may
> require not just the pattern to match but also attributes given to
> the path to satisfy the criteria, but for the purpose of preloading,
> pretend that the attribute satisfies the match criteria" (or
> "pretend that it does not match"), thereby not having to make any
> call into the attribute subsystem at all from this codepath?
>
> The strategy this round takes to make it unnecessary to punt
> preloading (i.e. dropping "pathspec: disable preload-index when
> attribute pathspec magic is in use" patch the old series had) is to
> make the attribute subsystem thread-safe.  But that thread-safety in
> the initial round is based on a single Big Attribute Lock, so it may
> turn out that the end result performs better for this codepath if we
> did not to make any call into the attribute subsystem.

It does sound good and I want to say "yes please do this", but is it
making pathspec api a bit more complex (to express "assume all
attr-related criteria match")? I guess we can have an api to simply
filter out attr-related magic (basically set attr_match_nr back to
zero) then pass a safe (but more relaxing) pathspec to the threaded
code. That would not add big maintenance burden.

> I am probably being two step ahead of ourselves by saying the above,
> which is just something to keep in mind as a possible solution if
> performance in this preload codepath becomes an issue when the
> pathspec has attributes match specified.
-- 
Duy
