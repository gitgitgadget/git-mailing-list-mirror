Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600751F404
	for <e@80x24.org>; Wed, 14 Mar 2018 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeCNQIC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 12:08:02 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51208 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCNQIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 12:08:01 -0400
Received: by mail-wm0-f53.google.com with SMTP id h21so5099068wmd.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KY03xd8FMNSLZZXUxJKEQU3r1mPEQqZN6nqeuf4mnc8=;
        b=baMnRIuAGnAcwGPI43Q09gpNoIfHSCXyJj04T+ch0LJe6X4XoIS7eRPfyFeFOWOZr7
         NX3rYGVFDbLCXdgLuCuBUvaoxr4ZWOAsIMhGU8/IpxaeN6NrJpsncAxaEoK85foDP/3q
         jhe7OEqNdOx2eh3DO5ydIWmzJjG3y/z+BhoUTKtsF95X3zGIjYbbEdbrOjzAk38Hhtdd
         oBS03nNTTQjEsO/zXVEeS/DXLM3lSjs6dl3ZAP9rxEZ+qWKgV4W29DPWjYYlhRknymtK
         XoXypbTwVzKO71sS269XXx7YlKqE+xfx/4f6oHWuGk2+ejLJRwPsfD0m1SiAxafnvl/e
         buuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KY03xd8FMNSLZZXUxJKEQU3r1mPEQqZN6nqeuf4mnc8=;
        b=d1hCWGCppPA/RNieXlwNrOuBYz1NwK2nJ/+pcCAQrNXjuOwB+h4qBfD/SNy0XN4lC+
         ZIvCR+ULWX0R1LU5skFHkgDRuSbMtyQb1dOJJ2TXuORv6M4n7ONQrtBlOqvEMyXi5BOc
         MkM7KUFwdRD2XvFYkf4CLB1uBq3QZm08ymeIwwvoB98gDB03jySIuHkD3vWShZdac/B9
         3BHQxNNrycXmnmNKfFFxa6dkQ/km2onvMrBDL5UXQztBTq/s1F1WurfLu/Ph11LBaoBI
         fDs6ogDRqqRdWJS9sa9Nd/fm3460ULhPkM3jNyVY8vOJ/kx+0H4QQ1xUzXrA1DzFDcYZ
         IUJw==
X-Gm-Message-State: AElRT7G/0BOJyZ2dtsJzhUGWxteeGmJ13W9dx0i/q/SBchnTWu253nWk
        EO9hZ9/lj42gq5YnwQs9FOk=
X-Google-Smtp-Source: AG47ELvH2qGvA0olD0/i47wR25nT7tYqH/PexoMqeXUPcm+tJhrbuybdfMKqgrSqyvyE2EvATXmlWw==
X-Received: by 10.28.24.207 with SMTP id 198mr2338644wmy.113.1521043679516;
        Wed, 14 Mar 2018 09:07:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f23sm3564908wra.51.2018.03.14.09.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 09:07:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sguorb5.fsf@evledraar.gmail.com>
        <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
        <87y3iwp2z0.fsf@evledraar.gmail.com>
        <87woyfdkoi.fsf@evledraar.gmail.com>
Date:   Wed, 14 Mar 2018 09:07:58 -0700
In-Reply-To: <87woyfdkoi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Mar 2018 11:18:53 +0100")
Message-ID: <xmqq37121vz5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Is the only reason we're still installing these binaries like git-add in
> libexec for compatibility with some old installation where that was
> added to the $PATH, shouldn't we (and I can write this patch) also have
> a toggle for "I want the modern install method" which would not install
> any of these binaries like git-add at all?
>
> Then the libexec/ dir would only contain things that we really do need
> the bin/git to dispatch to, like git-svn, git-bisect etc.

Removing them by default was proposed and failed; see this thread
for example:

  https://public-inbox.org/git/7vr68b8q9p.fsf@gitster.siamese.dyndns.org/#t

If a packager ships Git without these copies in libexec, that is not
the Git that promised users that prepending the $(git --exec-path)
aka GIT_EXEC_PATH to your $PATH is a valid way to preserve their
older script.

I do not think anybody actually minds to have an option to omit them
as long as the users understand the consequence (i.e. old promises
broken) and know they are not affected (i.e. they do not have
scripts that rely on the old promise).
