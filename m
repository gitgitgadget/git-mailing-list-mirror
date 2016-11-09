Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB03206A3
	for <e@80x24.org>; Wed,  9 Nov 2016 13:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbcKINwU (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 08:52:20 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34267 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbcKINwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 08:52:19 -0500
Received: by mail-vk0-f54.google.com with SMTP id x186so176086978vkd.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=argoday-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cskv/e035z645TOpRnkRu418yBsIbByj1L4ODmJUaGg=;
        b=xIRInkuZa1ufUxg10AzdC4inoHD1di2DH+NrjWtfgoQaDGIUcGTFUljqBpVkdhCS5C
         cjElaE05ZTC8tFks8+eWFoKUYhIgT4AkCrZ6gMQXzThc1TYlgCv6zpZvz8YHiIRmPvcK
         +CW59jRQ56tbe8r4Oda+vtgz3AS1KLwdHRzxrFVH2VwZKFjFD6WjtUBb9qIH13BoKwYk
         2ErSz9P+KnEtOoFwemqi4sIXqyin85O09ArpgpLvdzPeUM5PWjjK9znYUjDiTDcM4bdO
         zHviSuUJ88yGb8oW9tHGT6ePDDuLuexcy8IvrPQivpQnJNnSuJnC2bBnlTsgqh6VmTvd
         hMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cskv/e035z645TOpRnkRu418yBsIbByj1L4ODmJUaGg=;
        b=MSdP6xlX45b19IWJpB+n0KwNBRv6pWfAMtMqXN2LrvzzmY1nYeo8tF637HREWZGQi1
         TaYsOAdn8vN0P3w+tBX/QB1OTyQDqtqot023xi9McV47qtcOIfq0IrscQRmIgRQFMO9C
         5cncMNUqoRbuPMEFP/8O7NI+n7VEgPKTQQwyDba6DNN4ajbG8rsleCL4oyaSSMJOwpWL
         g4kIFDrc5mp+/nfiIHrTFAJYEOJMjRbp+nvHlAy4V7jcxvDxEX+Zfh1soQ3ZpduQ/5tA
         WbqHnRealhDbSKyNLtfOeZym04NfyNFfZvDD/CyKlkh0TZ42TzUPaB4vn5dvrY88JlbZ
         rlIw==
X-Gm-Message-State: ABUngvfQTODobcZxtBDMHDi74cCc5AYLWC6dQe8B+RLoeTCcqJYT3EDanCFFkv3A+cE565mfpEzvcp4c7u+Opg==
X-Received: by 10.31.58.84 with SMTP id h81mr12226440vka.15.1478699537998;
 Wed, 09 Nov 2016 05:52:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.128.70 with HTTP; Wed, 9 Nov 2016 05:51:57 -0800 (PST)
In-Reply-To: <xmqqk2cdbg5v.fsf@gitster.mtv.corp.google.com>
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
 <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de> <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
 <20161108200110.zvqdm2nlu5zxfyv5@sigill.intra.peff.net> <xmqqk2cdbg5v.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Word <argoday@argoday.com>
Date:   Wed, 9 Nov 2016 08:51:57 -0500
Message-ID: <CAD9aWCi5m_eJ==yC6_X-O_Xc+nyFczKkiEmqFSEAHKyNt2g-ZQ@mail.gmail.com>
Subject: Re: Bug: git config does not respect read-only .gitconfig file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Markus Hitter <mah@jump-ing.de>,
        git@vger.kernel.org, jword@bloomberg.net
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is unreasonable to drop the write-enable bit of
> a file in a writable directory and expect it to stay unmodified. The
> W-bit on the file is not usable as a security measure, and we do not
> use it as such.

The point here is not a matter of security - it is of expectations.

When a user drops write access on the global ~/.gitconfig I think
a reasonable user would expect future `git config --global` calls to
fail by default. The possibility of an override is a different matter,
and my initial proposal included the details of enabling direct
override. I don't think there is any presumption that this is a
security related discussion.

> I do not offhand know how much a new feature "this repository can be
> modified by pushing into and fetching from, but its configuration
> cannot be modified" is a sensible thing to have.

I agree that per-repository files almost never run into an issue with
this. Our problem is strictly with the global ~/.gitconfig which in our
use case is owned by a shared system account and used implicitly
by many developers. Thus any one of those devs can call
`git config` without any signal that they are changing something
that ought not to be changed and should think carefully.

This would be equivalent to dropping write access to a file that
your account owns so that vi / emacs / etc.. will warn that the
file is read-only before modifying it (useful for any number of
sensitive files). Obviously from a security perspective you have
a number of means of potential override, however all require additional
steps that surface the initial intention that the file should not
change - or should only change rarely after additional confirmation.

> perhaps the lock_file()
> function can have access(path, W_OK) check before it returns a
> tempfile that has been successfully opened?

That sounds ideal

On Tue, Nov 8, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Probably converting "rename(from, to)" to first check "access(to,
>> W_OK)". That's racy, but it's the best we could do.
>
> Hmph, if these (possibly problematic) callers are all following the
> usual "lock, write to temp, rename" pattern, perhaps the lock_file()
> function can have access(path, W_OK) check before it returns a
> tempfile that has been successfully opened?
>
> Having said that, I share your assessment that this is not a code or
> design problem.  It is unreasonable to drop the write-enable bit of
> a file in a writable directory and expect it to stay unmodified. The
> W-bit on the file is not usable as a security measure, and we do not
> use it as such.
>
> I do not offhand know how much a new feature "this repository can be
> modified by pushing into and fetching from, but its configuration
> cannot be modified" is a sensible thing to have.  But it is quite
> clear that even if we were to implement such feature, we wouldn't be
> using W-bit on .git/config to signal that.
>
