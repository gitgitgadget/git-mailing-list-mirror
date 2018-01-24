Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18791F404
	for <e@80x24.org>; Wed, 24 Jan 2018 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeAXNOP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 08:14:15 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38234 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933467AbeAXNOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 08:14:12 -0500
Received: by mail-ua0-f193.google.com with SMTP id e25so353989uan.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RT4TE52hPceqthhTESjNaiDMbJucK0d0EZG9furWw9k=;
        b=oh6DuA1ffY1i278TksvHgETq0xNDjwzfqtlnvCEpvah2zhi4V5GnSV3CXLICrz5o5D
         erxkdk8cZbTird3Y+wMbJ3LpzQj8pbwsy/LyA6p2AwxUCoWQorTEE/7FZeaJxGQlKpew
         IoUk2dpPRntON46YcJUf2+mJRyvbOclXVdu4TYWt8moqhjSsLbFzhZzJ6YP3VmHis9Mj
         U6lNQ1RQ1NXIUgCbHQwTS8VJDqhO8rVRfzF5S7xWiWv2crPlAEd39erxtRdEiZxNwMgJ
         wAjmcCTpMyq/hj+FxeCdvIzDRUuL180I0ixvVMhB4KB/pO+HDIcQhW2wcUH3ru424tuz
         aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RT4TE52hPceqthhTESjNaiDMbJucK0d0EZG9furWw9k=;
        b=XokSC5obz7nZS450dNp2DX7Wc6G3tSP3hVFcloB4lxfC9B/h7JRXznsDDXW9WW8tON
         tl88oLMSvm632MIeQqKEMhdtkJCLeCWESXJjGipJskfAKTsS+n+fP1ittk+FF3CDNcyQ
         mwexWMohbCBcRrhGu4/TzRjPqfmQakexY3SD3PK5T4RYdQj5tnIGkhwRNyL+xqORY2Dm
         1R1QFsf76eXg/4c2gKtXBNCEDtF+8iSlSzb1DyCWnQPpFgsR+WOUEVk2Dysw/el/55IP
         YhrbOUWOJFfHVrEwBDp1vxr2GGiygd3MWyqGxCmG5ir/Gw/KTKW/xuScLXr9kBirDXtN
         B+JQ==
X-Gm-Message-State: AKwxyte6SoYz7friNi2iGCz/GwJHd7fZHgCqt6MVcEg/GiFxWzN+2mLj
        ZRzQC5YbrW42L0nTFkFR1NLOlHvmccnDznILThw=
X-Google-Smtp-Source: AH8x227SUIl4/3xOljL+2EZ9A3UFB618KWo1R15cOBQ2/rx6gH2A1i/5y2vtJDiybnl6JGKwSNLeTjvW+wCF7VaKpBw=
X-Received: by 10.176.96.4 with SMTP id j4mr4400235ual.180.1516799651811; Wed,
 24 Jan 2018 05:14:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 24 Jan 2018 05:14:11 -0800 (PST)
In-Reply-To: <20180123163038.GF13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com> <20180122133220.18587-4-szeder.dev@gmail.com>
 <20180123163038.GF13068@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 24 Jan 2018 14:14:11 +0100
Message-ID: <CAM0VKjmS1QMj5=rSnsPBh+49JqChYTZb=LPXhFCH57KVSApS6A@mail.gmail.com>
Subject: Re: [PATCH 3/5] travis-ci: don't repeat the path of the cache directory
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 5:30 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 22, 2018 at 02:32:18PM +0100, SZEDER G=C3=A1bor wrote:

>> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
>> index 248183982b..c9476d6598 100755
>> --- a/ci/run-linux32-build.sh
>> +++ b/ci/run-linux32-build.sh
>> @@ -25,10 +25,10 @@ CI_USER=3D$USER
>>  test -z $HOST_UID || (CI_USER=3D"ci" && useradd -u $HOST_UID $CI_USER)
>>
>>  # Build and test
>> -linux32 --32bit i386 su -m -l $CI_USER -c '
>> +linux32 --32bit i386 su -m -l $CI_USER -c "
>>       set -ex
>>       cd /usr/src/git
>> -     ln -s /tmp/travis-cache/.prove t/.prove
>> +     test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
>>       make --jobs=3D2
>>       make --quiet test
>> -'
>> +"
>
> This interpolates $cache_dir while generating the snippet. You've stuck
> it in single-quotes, which prevents most quoting problems, but obviously
> it's an issue if the variable itself contains a single-quote. Is there
> a reason not to just export $cache_dir in the environment and access it
> directly from the snippet?

Right, that's my conditioned response to single quotes kicking in :)

We don't even need to export the variable, because Docker has already
done it (that's what 'docker run --env VAR' does).


> Probably not a _big_ deal, since we control the contents of the
> variable, but it just seems like a fragile practice to avoid.
