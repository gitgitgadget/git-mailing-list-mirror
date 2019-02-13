Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA5D1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfBMVJg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:09:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfBMVJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:09:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so4093038wmj.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bo5a7PjlVAdNeX1bv+r1JuTUY82ouJPlkdLq1PttIiU=;
        b=MW2QYuLHwT7Yc3NjC8h02qZv9cvYxODWPoREBt656LCBYYjnz0MfYcs6vbIdab4qgG
         xMUwjW5tDLCxIKLxRMCa7HKoGmZAD5XFbMsUU8VRy5gMISWc7j8FQH+qljPy1veqvByl
         HZIs4EcUW5yAZsrzmZ+W1dOjdfOIp9DX66GnC2KWwH5utcYQIEirGp6WasNGF/Wn8sJR
         q+VTYvQ1Wb0oOO7EAz4BPTOifN2Y164oCAdDAbGL9lAX8f6ca1FiygDNV+FlmTyJQwxC
         ybTsxlsPd0wbgNX5QbtkaB2c+BWvymWeGNVVOe+y2QqUbJ3fIxyL9XG3L+9bZMGAeIWI
         fT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bo5a7PjlVAdNeX1bv+r1JuTUY82ouJPlkdLq1PttIiU=;
        b=XI25P6LJxEL+sBm1vt7REgtZvmwWX3hqtAPZfHQGHcFK8orgEo6bghbsEPAY0+NP7H
         1XkjQltmhhpyTNqERwqXp/O772nlz3PgO2AZ47WUD54PkrsUW1g5zb/y6ALOhkAN3ks9
         q/qZD/Tnja9ET1VtkkuOry91nIzvtG7GrF9XHrJqjLZFkNkOUCoejhIzbjJJhnJnsOGp
         2lb7AQvmqygdjCE9dbWwNu3DWi6FCrq2Tgkb0vE95RQzAcQUV8/d2NS94lQykiLj8ZCO
         BfOkd3mRPRP/RaVO5eR5auKaPLiiiJLqG0851/V6vTfefClOH7xjrJzdbJmbLpkz3INo
         bF0Q==
X-Gm-Message-State: AHQUAubyhU+S0H3O6hH2KXbltVXr8syDykpsBVlT2vEhDe9SpbEJX3xO
        ooq/yaGLRPaA4VQFDUCq5jQ=
X-Google-Smtp-Source: AHgI3IZF1o3BmKXfjtyfpE5mBVdZqP1IPyZFFAtZQgGTkMzGEO4MHD4tdEBilB+CYKiBYyDNngM5eQ==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr70363wmb.125.1550092174653;
        Wed, 13 Feb 2019 13:09:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z15sm575411wrh.18.2019.02.13.13.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:09:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Petri Gynther <pgynther@google.com>, git@vger.kernel.org
Subject: Re: Feature request on git log --oneline <revision range> -- <path>...
References: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
        <87k1i4j8aj.fsf@evledraar.gmail.com>
Date:   Wed, 13 Feb 2019 13:09:33 -0800
In-Reply-To: <87k1i4j8aj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 13 Feb 2019 11:24:04 +0100")
Message-ID: <xmqqmumzbdki.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> What do you think such an option should do when it finds negative path
> specs, e.g. this on git.git:
>
>     git log --oneline --stat -- ':!/Makefile' '*Makefile*'
>
> Should it only render positive matches, or distinguish between
> matched/blacklisted/not-matched, your example (with no negative
> patspecs) just shows matched/not-matched.

Another thing to consider is what this would do to the merge
simplification.

If I understand it correctly, this is sort-of like a reverse of the
"--full-diff" option, where the pathspec *is* used to limit and
simplify the history, but for the purpose of displaying "log -p"
output, the pathspec is widened to show the entire change.  This
instead makes the traversal ignore the pathspec and uses it only to
limit the "log -p" output.  I do not think I would be fundamentally
opposed to a feature like this.

