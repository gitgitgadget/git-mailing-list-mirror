Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C9C20D0A
	for <e@80x24.org>; Tue, 30 May 2017 01:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdE3Be6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 21:34:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35112 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdE3Be5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 21:34:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so14300758pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C7CdfzMsRyCVa+ANCvCNdcTxMR20U9hzL3AKkKu4id0=;
        b=H1Y8zeVl99RjIlSIeuuppb8NMTSVKRBDnVRDpHcUtFfRDIMHLpfyT82DqQ/zF82LbK
         jhG5jLhnj88oAa09DCG6LhswUwoNvlZYwmbAdZj3p+qlyuWGEcj4IWzV2f7hSpdPDo4l
         +0QvEazI1PMjmIGWMD4PPN7yAQimOjBzysAxF97FiA9l/3OEHRyyddKBLg+yR1D6N5rf
         /ggqUNe6cQDyMDSB4l9F42oeW+VtlP+QTX4WKfgknAwly7Dh4MAW4iHvvfdMu3sM67ff
         RNUj43EV4Nqrvkd7Qv+VaKD1R3cg8XDktr0j+fdqXSgDJvUcr7fAyTJuBnA30zTI22Ch
         1G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C7CdfzMsRyCVa+ANCvCNdcTxMR20U9hzL3AKkKu4id0=;
        b=j4A9B176Qqk2jmpz7ARSOU16oiL1vawwCxPqjgrlDe4IBuK+fXekfV8YOMhkvTEIJl
         4xS9/nEm7uC9iagchFy2wgkEEGEK7KcAvDao+qStEX5VuqL6LRGrgEHyvhOkKbs/EYrw
         qrFrAfFgahpWuHw/SDBUEwGxGBIIDHArcBhchZZyI0WPEHtjqka0XumjEMECPS8FhmQP
         cXH9Sx1I89/5lqsv714Cfn/fd3IR9BAwz+rSARPbF5bK+f2a5sQ5kBFdhq/SIhVboZsy
         8jr0RoEmC8RJztjsPXnFZ9TS+OUCPwpmWuISYQgnVVn2JYyyOTYDhuPCxSIypCjoqLR4
         FbVQ==
X-Gm-Message-State: AODbwcCrqoXbyraRju+5wqG1bcgsLh/8GOHJiZOPEatFTYQhS4cg91Ad
        4dTQpSTgnE4NDg==
X-Received: by 10.98.211.87 with SMTP id q84mr20954404pfg.126.1496108096426;
        Mon, 29 May 2017 18:34:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id u67sm16634574pgb.24.2017.05.29.18.34.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 18:34:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: FORMAT_PATCH_NAME_MAX increase
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
Date:   Tue, 30 May 2017 10:34:55 +0900
In-Reply-To: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com> (Laszlo Ersek's
        message of "Mon, 29 May 2017 10:49:59 +0200")
Message-ID: <xmqqh903dt4w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laszlo Ersek <lersek@redhat.com> writes:

> would it be possible to
>
> - increase the FORMAT_PATCH_NAME_MAX macro from 64 to, say, 128?
>
> - Or else to introduce a new git-config knob for it?

It's open source, so both are "possible", but you are interested in
learning if these are acceptable project-wide.

> I have a small review-helper / interdiff script that matches patches
> from adjacent versions of a series against each other, based on subject
> line. (Using the formatted file name with the patch number stripped.)
> The project in question uses long common prefixes in subjects, and the
> current limit of 64 does not always ensure unicity (again, with the
> number stripped).

The original motivation of the design is that leading numbers are to
ensure they are unique, and munging and truncating of title are to
ensure that they are safe on the filesystem while being identifiable
for eyeballing.  And the current truncation limit may not work well
for certain projects, failing the "identifiabl" goal.

But I do not think that is true only for your custom script.  For
example, with such a project, output from "git shortlog" or the
labels "gitk" gives to commits would not be very useful, because 2/3
of your display are filled with and wasted by the same long prefix
to the left.  The real issue is not that one particular "length
limit" used by format-patch is too short; it is that the project
convention wastes too many bytes for common things that can be left
unsaid, and if we come up with a general way to address that, we'd
make all of Git that summarises commits more useful, not just
format-patch.

So I think lengthening FORMAT_PATCH_NAME_MAX, whether it is done
unconditionally or conditionally, is rather an ad-hoc hack than
a real improvement.

I cannot offhand guess what other places would suffer from such a
project convention, because I do not work with such a project, but
you may be able to come up with a list of various places in Git
where the commit titles are used, and that if there were a mechanism
to take these commit titles, pass them to your cutomization script,
which abbreviates these "long common prefixes" to a shorter string,
and to use the output from that script instead of the actual commit
title, it would help all of these places.  The list of commits "git
merge" records when merging a side branch may benefit from the same
mechanism.

For example, if the titles of your commit title look like this:

    Subject: RedHat Kernel Maintenance: ipv4: add reference count
    Subject: RedHat Kernel Maintenance: net: llc: add lock_sock
    ...

your custom script may be

    #!/bin/sh
    exec sed -e "s/^RedHat Kernel Maintenance: /RHKM-/"
	... there may be more common patterns to shorten ...

and the resulting output from format-patch might become

	0001-RHKM-ipv4-add-reference-count.patch
	0002-RHKM-net-llc-add-lock_sock.patch

while "git shortlog" output and "gitk" display may also be helped
by the same mechanism.

It's OK for the _initial_ application of such a mechanism were to
affect the names of files format-patch creates and nothing else.
Interested parties can then use the same mechanism in other programs
(like "gitk" and "git shortlog"), as long as that mechansim is
designed well.  And then the end users need to learn that mechanism
only once.
