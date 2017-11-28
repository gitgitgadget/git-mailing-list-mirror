Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A95320954
	for <e@80x24.org>; Tue, 28 Nov 2017 15:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbdK1PDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 10:03:08 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34139 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753506AbdK1PDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 10:03:04 -0500
Received: by mail-io0-f174.google.com with SMTP id s19so146574ioa.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l+a0VYCKmQ9IQoMBsBNbQMmCPTYvpzmgCdhnZkDNuS8=;
        b=fXLYaa7gUFe5R24HQ5OChLPsrkTBaPrGsLBmkhbOSzCc57YZvzjjpFToj/9B7kcYTn
         zQuqwVLwMdgDJgMN5iERz1Jy7EEaW7BL9WlSUNOZz9zv1bBOvRz/U/1tb0VgI9XcVdAs
         CRbsRuIF6sDAVM8cUUpwjL/nJIZXa2yKh9tBrLWoT4BjNVdNeuXN+5+kxxNG9pLKN++0
         pFrXDsGOf3tZclexsXNkUQBm9ACj10mebPxz7VIefOj+EdP6t+E2yk2EgZZgr6hsGjHW
         tHrkVxuJHrgmLpMC0de6CVQl6uONWcPS3ByYd5pxlLXsLdjMSjpzE90BLSGtREW43+wm
         6hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l+a0VYCKmQ9IQoMBsBNbQMmCPTYvpzmgCdhnZkDNuS8=;
        b=DRv4ssSiB1YrGDRuijvyw9o4P4y/OHrbvEKeqG0ORC1HDlH6X0T1sb3SoT3Cj1ig19
         FVyjubWVoqznjlLmqsYiPY6mVo/yu903dtv4/xppKW7nza8IycIsIpEAkIri4JENgpEt
         hTfgAuE8IPfo8XQU24p3hSfD7cuxiqdedpmhIeq/bqCdM82n7o9RyRoClh9+FTQH5UbD
         3uPb5c6h5taZ54Cs1qsT5IvSVh22VzjfWCrSNfQvNL3df9MKoQ2xpW3jM/YWlbzHJILT
         9XRqa3dTY0G0Egj5TrgluQefa9LVuXHadnTMHNhfYOXTQ3Oo4jzbndeBSC+9WmQujvlH
         5FpQ==
X-Gm-Message-State: AJaThX7rFd6PvnWKprngJLkDzVoiKhN8wEcOASHdYauTySwFzGcUILDV
        YNoFk6uEZHrAPCLafmrhDKMOGyMDINhHYc90vzM=
X-Google-Smtp-Source: AGs4zMbFS9p6t42FZ+Lddwn5LF8nnjXhNID2Us1Q7n3ZxHP9G8/q+1oWEjMzFO477SR7068nrf/HK3+TyOlhw93Kt0w=
X-Received: by 10.107.39.207 with SMTP id n198mr44942587ion.180.1511881383040;
 Tue, 28 Nov 2017 07:03:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 28 Nov 2017 07:03:02 -0800 (PST)
In-Reply-To: <20171128143718.3748-1-tmz@pobox.com>
References: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com> <20171128143718.3748-1-tmz@pobox.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Nov 2017 16:03:02 +0100
Message-ID: <CAP8UFD1Y_7FcARFoqNKTpDLRxKW1+jCBGAy5+TxL33ui0Hyb8w@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: avoid new tcl/tk build requirement
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 3:37 PM, Todd Zullinger <tmz@pobox.com> wrote:
> A build requirement on tcl/tk was added in 01c54284f1 (Makefile: check
> that tcl/tk is installed, 2017-11-20).  For building and running the
> tests, we don't need tcl/tk installed.  Bypass the requirement.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> Junio C Hamano wrote:
>> It seems that TravisCI objects ;-)
>>
>>    https://travis-ci.org/git/git/jobs/307745929
>
> Interesting that the main builds passed.  I don't know what the default
> 64-bit linuxinstall looks like in travis, so I presume it includes
> tcl/tk or something.

Yeah, interesting. I am cc'ing Lars who perhaps knows.

> In any case, perhaps something like this is what we want?  We could use
> NO_TCLTK or ensure that tcl/tk is installed in all environments.  I used
> the BYPASS_TCLTK_CHECK option since the tests have been running without
> tcl/tk previously.  If they become required for the tests, this can be
> adjusted.
>
> I have a travis job running with this change here:
>
>     https://travis-ci.org/tmzullinger/git/builds/308452464
>
> So far the only failure is (what looks like) an unrelated one in the
> GETTEXT_POISON build.

Yeah, I can't see how test failures in the t/ directory could be related.

>  .travis.yml              | 1 +
>  ci/run-linux32-docker.sh | 1 +
>  2 files changed, 2 insertions(+)

The patch looks good to me. Thanks!

I wonder if it would be better to squash it into my patch or to keep
it separate. I am ok with both ways.
