Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AF42082F
	for <e@80x24.org>; Sat, 15 Jul 2017 16:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdGOQV6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 12:21:58 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:39656 "EHLO
        elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751079AbdGOQV5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Jul 2017 12:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1500135717; bh=pJ+Db1ya7iU7cy01mF9mmQvoHFpeJoXy+8he
        47uLSkk=; h=Received:Received:Date:From:Reply-To:To:Cc:Message-ID:
         Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:X-ELNK-Trace:X-Originating-IP; b=ZsAFE00EFILL06mgtQgQfTbK
        96I0hnqxlRqK1pIAtH656GkVx/fi+AjFAhhgxN0IcXApzPPKu0YdUuISlp2UiyYCGMu
        l6woYn1m1xXa3sGBhYKT7IGN9G9r0VI1HhODFe753Lba9SEfg87mPC6IB6CfDldCDw8
        q1zywQhpRRVxNAFO5kVc7lSp5pC306UNThyks/YzMkW4OnBERb3fj7aConuCNVZEGFb
        B9E8NRwCqRGhmObhg3Zc53GW6x4m5TO0/y+Yp0GnvFFlqaR5XwaYrvQsaMNNS4+Bbqd
        MWJv0INE6mElZ12j8e8Eaj2STLFttdE/OnhyDsAwB9ggNLIDdg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=F15OrS2T4ZOuD5ghO8VbPouSQuggxkGCy69LWvsgCimC5J0WqkycjlRMjUWxnoBpjxcMjc7R1ZBAZQWMx19kkQaO0IT4zGEAkgUKFqfL5Mxp9PVCa36wy73+z3qQz1vVxb7A3ZaBnsEqI30suOagujC62IzLOQGS7ct+Q/W3oKvXmzz5thSpiMvubUKLW5QbMG7f1YRVQp/weM+DvHpdZQQV20Xr7gdtrHq+oqkZ5Qm0Tx5WNkoiBRn9+qbY3ENgksG7kk5d5eJdhHz4pSC0CV0+gkI/ooWY4bdFdvV5ThtZZZmYDnqATfDF2XcSc+NO9IAjNSI+8TcGnGG894qg3g==;
  h=Date:From:Reply-To:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:X-ELNK-Trace:X-Originating-IP;
Received: from [209.86.224.37] (helo=elwamui-karabash.atl.sa.earthlink.net)
        by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4.67)
        (envelope-from <jjfoerch@earthlink.net>)
        id 1dWPpN-0005gJ-0n; Sat, 15 Jul 2017 12:21:57 -0400
Received: from 98.250.1.226 by webmail.earthlink.net with HTTP; Sat, 15 Jul 2017 12:21:56 -0400
Date:   Sat, 15 Jul 2017 12:21:56 -0400 (GMT-04:00)
From:   John J Foerch <jjfoerch@earthlink.net>
Reply-To: John J Foerch <jjfoerch@earthlink.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Message-ID: <19245062.3672.1500135717004@elwamui-karabash.atl.sa.earthlink.net>
Subject: Re: [FEATURE] git-commit option to prepend filename to commit
 message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: EarthLink Zoo Mail 1.0
X-ELNK-Trace: c53e46bc05df04c91aa676d7e74259b7b3291a7d08dfec79fe9b6d2647db47ae03495118f072d045350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 209.86.224.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




-----Original Message-----
>From: Jeff King <peff@peff.net>
>Sent: Jul 15, 2017 12:05 PM
>To: John J Foerch <jjfoerch@earthlink.net>
>Cc: git@vger.kernel.org
>Subject: Re: [FEATURE] git-commit option to prepend filename to commit message
>
>On Sat, Jul 15, 2017 at 10:19:34AM -0400, John J Foerch wrote:
>
>> The feature would be a command line option for git commit that would
>> automatically prepend the "<filename>: " to the commit message.  The
>> different cases of its behavior could be:
>> 
>>  - commit affecting a single file, with commit message given by -m:
>> 
>>    : prepend "<filename>: " to the message given by -m
>> 
>>  - commit affecting a single file, with commit message from editor:
>> 
>>    : pre-fill commit message template with "<filename>: "
>> 
>>  - commit affecting multiple files:
>> 
>>    : use common base directory of all affected files for <filename>, behaviors as above for use with -m or editor.
>> 
>> Anybody think that this or something like it would be a good convenience?
>
>Johannes already pointed you to the prepare-commit-msg hook, which I
>think is the right solution. I wrote a rough sketch for fun (note that
>you could write it in whatever language you like if the mix of
>perl/shell isn't to your liking):
>
>-- >8 --
>#!/bin/sh
>
># only kick in for vanilla commit, or "-m"
>case "$2" in
>""|message) ;;
>*) exit 0
>esac
>
># common prefix of all changed files
>prefix=$(
>        git diff-index --name-only HEAD |
>        perl -lne '
>                if (!defined $prefix) {
>                        $prefix = $_;
>                } else {
>                        chop $prefix while !/^\Q$prefix\E/;
>                }
>                END {
>                        # trim trailing slash if present
>                        $prefix =~ s{/$}{};
>                        print $prefix
>                }
>        '
>)
>
># now stick the prefix at the start of the message-in-progress
>{
>        printf '%s' "$prefix: "
>        cat "$1"
>} >"$1".tmp &&
>mv "$1".tmp "$1"

Thank you for that!
