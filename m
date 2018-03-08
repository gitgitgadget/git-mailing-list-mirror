Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C327F1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCHWBl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:01:41 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36396 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCHWBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:01:36 -0500
Received: by mail-qk0-f196.google.com with SMTP id d206so1497630qkb.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gyF0ZrydYK+gUmBu43d8nufFe805xmklM8SXhJ1JzzE=;
        b=ey2GgoPL6txn836OjUCYSJl1mXvzeUIyOANGWi4WSCPY9FipgP6IrQZPXmv8ChnASE
         Surz2/nrW4FYDlK1CcC16Sv2nuI3cIsEHLXrceJelUE7hSmjNjpLVNdBSNRoI+/iO27g
         UgRVPaUUeHVkd2qME0zKRnm2NIcRMNwMdHXhgd0ZwowQaaoOm/zhf335CrUwOKM6Zr6M
         sc0yWm3iCgabxi0+4BHhTOj9Bky7h/UfNE6yVJpujEkFAeDoE3ahy2J4J47h8FqkCCjR
         fVgKoQJnEzL8fY811jafRES4cFeRuu0owMxzDrD0dfIM3EJ2V/5mZK54RszL3UDt/Tia
         HvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gyF0ZrydYK+gUmBu43d8nufFe805xmklM8SXhJ1JzzE=;
        b=uQCUlmX2iEms9wCo2HlBGJjLr+0cIAhrBPD1s+Rd8mPM9S4lG+1akEMioQ0yX+v3C4
         euCUe/BmbZ0rXngipWKaXJRQDanM0v/AQwh/n2RGgiqr8aYXlvO12kg0UaB5B06RCpgj
         ZDe1fOQOk/ZN+pMf/PAJuXGNn7zPRNLhGr2YNrNWi62eQoEZGJOViksp5i1mRqj63iSr
         Kr+n8skU0t/g8L0riebwuq3w/XWQhJMbPTsDuCH6FjCIeYOm13+NtctiE6/mqjUsNTZo
         sb8zNFTtMo8TLo06B1pluz24QJu5uY/T1op6x/mg5CCVv1tih9CACpKDMK5j0l54LAi2
         oNXw==
X-Gm-Message-State: AElRT7FZfPzf8HCBBTYQx1i8K8rMYEf1HsICiWlHRAxWzWvVFLXxoXDK
        n5/oRQu1K8r+dxtqz3DChFAek6TcKKOrDTnTrnw=
X-Google-Smtp-Source: AG47ELtdUm7wPe9ItV6YuXBawvoUWLwAXGbUnuat1IFz4c2K69gJwLF+ke7mSBW9nMHWv+SMbFzWdVDLiUbXQSj0mng=
X-Received: by 10.55.203.67 with SMTP id d64mr39814974qkj.210.1520546494908;
 Thu, 08 Mar 2018 14:01:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 8 Mar 2018 14:01:34 -0800 (PST)
In-Reply-To: <CAM0VKjmKcFVOLA-fFnSm=tVapa5qgUoU3Sa7RjSrqoHp5qXZiw@mail.gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com> <20180308123844.15163-2-szeder.dev@gmail.com>
 <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com> <CAM0VKjmKcFVOLA-fFnSm=tVapa5qgUoU3Sa7RjSrqoHp5qXZiw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Mar 2018 17:01:34 -0500
X-Google-Sender-Auth: JuPB6sw4jQVrpontaOyidqKkpsE
Message-ID: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output
 of 'test_cmp'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 4:49 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> On Thu, Mar 8, 2018 at 7:51 PM, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>> An alternative approach used elsewhere in the test suite[1] would be
>> simply to 'exit' if test_cmp fails:
>>
>>     for i in merge no-lf empty really-empty; do
>>         GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
>>         test_cmp $i.out ../$i || exit 1
>>     done &&
>
> And it's right: 'exit' terminates the shell process it's invoked in,
> i.e. the whole test script (well, unless it's invoked in a subshell)
> without executing the remaining tests and the usual housekeeping and
> reporting.
>
> Consider the following test script:
>
>   $ ./t9999-exit.sh
>   FATAL: Unexpected exit with code 1

Sorry for the confusion. I meant "return 1" as used elsewhere in the
test suite[1].

--- >8 ---
#!/bin/sh
test_description=3D'return 1?'
. ./test-lib.sh

test_expect_success 'return 1' '
        return 1
'

test_expect_success 'second test' '
        true
'

test_done
--- >8 ---

$ ./t9977.sh
not ok 1 - return 1
#
#         return 1
#
ok 2 - second test
# failed 1 among 2 test(s)
1..2
$

[1]: For example, the "setup" test of t4151-am-abort.sh.
