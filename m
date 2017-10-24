Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D50202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 11:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbdJXLFF (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 07:05:05 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43711 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932148AbdJXLFE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 07:05:04 -0400
X-AuditID: 12074411-f95ff70000007f0a-5d-59ef1e5f6184
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FE.BC.32522.F5E1FE95; Tue, 24 Oct 2017 07:05:03 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCBEA.dip0.t-ipconnect.de [87.188.203.234])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9OB50qD021471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 24 Oct 2017 07:05:02 -0400
Subject: Re: v2.15.0-rc2 ref deletion bug
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ea715dae-b410-d4fb-77c7-2e61b764a343@alum.mit.edu>
Date:   Tue, 24 Oct 2017 13:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1I2Xex9pcGmXikXXlW4mi4beK8wW
        P1p6mB2YPZ717mH0uHhJ2ePzJrkA5igum5TUnMyy1CJ9uwSujDszXzAXvOCq+DB3D1MD4waO
        LkYODgkBE4krq6y7GLk4hAR2MEn8vdDIAuFcYJJ4u/cLkMPJISygKbFn3jUwW0TAUeLCliNg
        NrOAuMS6uefZQWwhAWeJyec/M4PYbAK6Eot6mplAbF4Be4nFzcvAbBYBVYn707YzgSwWFYiQ
        2LCRH6JEUOLkzCdgIzkFXCRuXVzDDDFeXeLPvEvMMKtuPZnPBGHLS2x/O4d5AqPALCTts5C0
        zELSMgtJywJGllWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIeEsuINxxkm5
        Q4wCHIxKPLwN5u8ihVgTy4orcw8xSnIwKYny/nsPFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
        e0T4faQQb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mC10QWqFGwKDU9
        tSItM6cEIc3EwQkynAdouAZIDW9xQWJucWY6RP4Uoy7Hs5mvG5iFWPLy81KlxHmtQIoEQIoy
        SvPg5sDS0CtGcaC3hHlrQap4gCkMbtIroCVMQEtk7d+ALClJREhJNTCu9dBa7bxYztb2d8uP
        JEmJKwJaHZq+Xm3FM838Wne0K/eGGu97bLV/QdbK4/mxa/et3/d+3bw+3lLdi/NWz36hk/vv
        5IHUU/oMiqYqISsuv95TxDph3ecoHhkByevf2T7OTix9NvEbj9XTCbVXhYMPX3J2T4tUFqxe
        8PJsTdaLrhYLdj6hFBklluKMREMt5qLiRACMZmlQHgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2017 10:24 AM, Jeff King wrote:
> I found a potentially serious bug in v2.15.0-rc2 (and earlier release
> candidates, too) that we may want to deal with before the release.
> 
> If I do:
> 
> git init -q repo
> cd repo
> obj=$(git hash-object -w /dev/null)
> git update-ref refs/tags/foo $obj
> git update-ref --stdin <<-EOF
> delete refs/tags/foo
> update refs/tags/foo/bar $obj
> EOF
> git for-each-ref
> 
> then at the end we have no refs at all!

That's a serious bug. I'm looking into it right now.

> I'd expect one of:
> 
>   1. We delete "foo" before updating "foo/bar", and we end up with a
>      single ref.

I don't think that this is possible in the general case in a single
transaction. The problem is that the code would need to take locks

    refs/tags/foo.lock
    refs/tags/foo/bar.lock

But the latter couldn't coexist with the loose reference file

    refs/tags/foo

, which might already exist.

It is only imaginable to do this in a single transaction if you pack and
prune `refs/tags/foo` first, to get the loose reference out of the way,
before executing the transaction. Even then, you would have to beware of
a race where another process writes a loose version of `refs/tags/foo`
between the time that `pack-refs` prunes it and the time that the
transaction obtains the lock again.

> [...]

Michael
