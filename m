Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07C11FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbcKQUDn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 15:03:43 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35579 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcKQUDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 15:03:42 -0500
Received: by mail-qt0-f181.google.com with SMTP id c47so142438698qtc.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6v6hEYE5Zu3JAYC2KtMMRru/S6NuS3yIY8qaWJwPkwI=;
        b=Jbz+iwH7AxOjsAO7knX7xDtcfZ4yNZp0TUUHAFhTC9EjygsOA+J4snTGYDYeOuV9aR
         scwhXDPXZhGkuzgKDD0tB2qZdlCsm6M7PXdPoKukE4+ihX8paGC1VuoxkgQywPmK71dV
         2HzfJD+RXop8oFLleYz3wCqO2qPIFG6814ob2WsjqDCA7qso41eqP4Ic946h9Y82DucH
         AjCrtLZKu29pbhPuYxTFhR6d6ljJTAzJnwbyBxzsKzVi6D1sLcPFnlKCnP8qTIzLyEZS
         JeWZSfZHccObnFxihb0ElZQqdaEcdAT1zBK1wo01WvW5vndOFLzTFrvsS0vWLLsW/91R
         ovOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6v6hEYE5Zu3JAYC2KtMMRru/S6NuS3yIY8qaWJwPkwI=;
        b=Qs/DitCoR4MvD1up3lhPx5mR24HXg7kDMpQZuTrSpV6GNIwZ+/dtuLEI08KHl9n8FM
         0UmRcr2ph+UEHCQvfgGxTxdpgv9VNvo5+HJ42kjIg5bLK3AtY1Qx02fyzDxYg4ZDJa6u
         EVMImgjYI0iaImALnNP6CIFUAqz7J1UvqWoQ4Fp6KzCPnFB39cGYq/cExrg6YlxJ2+hP
         b+WP41lBKrsRuzzR6iyOEt+aW90Cs24bsjX11i+W8/frNd3eTbgDVmHn+7O5keOljarA
         eKaxsf0tPDH7OhDsHkdhYI1XvgZt2vdYjxLuU+ETnDFRzvRkmWjYMVSuUSfmePQewxM/
         F+bA==
X-Gm-Message-State: AKaTC02WWwfKyleXqpoieLQcJ/RWLpVheDAJNBdSJzI/XHF2kMCQIb0Hu0Scap16dBY+C5jrXy+2cNOYJ+VpWSVt
X-Received: by 10.200.37.221 with SMTP id f29mr3872020qtf.123.1479413021514;
 Thu, 17 Nov 2016 12:03:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 12:03:41 -0800 (PST)
In-Reply-To: <e748abfad8b04a8eaaa10797d9324891@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-8-sbeller@google.com>
 <e748abfad8b04a8eaaa10797d9324891@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 12:03:41 -0800
Message-ID: <CAGZ79kbs1ymw7mE6ctGt2_wgHoFSYMbuhcFK_3vGR9tYZzJxOg@mail.gmail.com>
Subject: Re: [PATCH 07/16] update submodules: introduce submodule_is_interesting
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 4:14 PM, David Turner <David.Turner@twosigma.com> wrote:

>> +int submodule_is_interesting(const char *path, const unsigned char
>> +*sha1) {
>
> This is apparently only ever (in this series) called with null_sha1.  So either this arg is unnecessary, or there are bugs elsewhere in the code.

I was torn when writing the series, as I initially had submodule_is_interesting
with no sha1 argument and it turned out to be buggy in my first
initial implementation,
which lead me to thinking the sha1 actually matters.

The line of thinking was similar to loading the submodules from the
submodule-config cache as that also has different values for different sha1s,
e.g. a submodule is only interesting if submodule.<name>.update != none,
which can have changed with different sha1s.

I refactored the series since then to call the _is_initeresting method
at different times
(before and after the actual checkout), such that we implicitly have
the correct sha1
while calling it.

So I would argue the sha1 argument is not needed. I'll remove it.
