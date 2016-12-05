Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B361FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbcLEWX2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:23:28 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35821 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbcLEWX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:23:27 -0500
Received: by mail-qk0-f177.google.com with SMTP id n204so361944618qke.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fXzLmfwLfuTFyXGdcAgjYgpuC33V4gIXSoXjy0Zx+pE=;
        b=jQ//xVrXXFgwlHG8xEUPKJv13CQl2p/ov3e+Oq7clrPFQZhwYsPpqlc7Ug5EicZllL
         X4KRz/TZcN2OP8hPIrqMgnSE5Zrf2ydkC+x5SvPAoNGSdJZiLNguG/wnkonZoH2HtAm/
         uerpCvJ7sWY2n2T1NQh389kMYWjJCrEZ4u57Y2/VzX2V8rxznCB+S9tGEuyD1yv4ivvQ
         iG2FC9i7BZ5PgfUB/AaKLri+NSDvIzLPPtubQCTB4m/IlDSuRYnqYO033J5zA56tY9F7
         qCHNSSth2lO0qfh/FU687mm51rXWpep31vE5NYha/K2RI5eU5yx4aSG006x0LEMTDAzx
         PecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fXzLmfwLfuTFyXGdcAgjYgpuC33V4gIXSoXjy0Zx+pE=;
        b=D1NP0NoFNj5wkQUsXdzf/OJJNNsLkJLSEqxUNbQMcNpOJzLMXD8nPxq2ur4x/O+n9M
         5QlUGVq6gAMEjY8whJvp2DJh1HG/CvFKV+w5lm0tTinmyZHsIO0J6QF1dSF7agG9mIoi
         sbMy4kkDsklj3MQISD9epueee5YFATT30pPmufYQZkL1vTZXIovTFh2aMBjsSbETtCFW
         imMNhnuL5+w89aCUf8PrxstI1tKTLVkW1MbJYR4FD5Fkb43id3jE8ngZCi02XNfEMbws
         SX7C9QvT2jvX2nda/pEhb4BiJTWCIUVaFFvb1pn3bSUHl45D9ujgkqaTkD0/7MR9eSIX
         wkEQ==
X-Gm-Message-State: AKaTC01AJrikHbk7kxpqWMBmG9xue7Uw0YI1E5FZm75acBBWUQ8BHZCXuaE1WXvRpjgfPYx/YHiOC/w97aV7LlH4
X-Received: by 10.55.112.134 with SMTP id l128mr32097710qkc.220.1480976606141;
 Mon, 05 Dec 2016 14:23:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 14:23:25 -0800 (PST)
In-Reply-To: <20161205192918.GB68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com> <20161203003022.29797-18-sbeller@google.com>
 <20161205192918.GB68588@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 14:23:25 -0800
Message-ID: <CAGZ79kaMXmNUaUCZJaTrcodAoSBPSxXr5JPrZGQeg=m-HrN11w@mail.gmail.com>
Subject: Re: [RFC PATCHv2 17/17] checkout: add config option to recurse into
 submodules by default
To:     Brandon Williams <bmwill@google.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 11:29 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/02, Stefan Beller wrote:
>> +test_expect_success 'option checkout.recurseSubmodules updates submodule' '
>> +     test_config checkout.recurseSubmodules 1 &&
>> +     git checkout base &&
>> +     git checkout -b advanced-base &&
>> +     git -C submodule commit --allow-empty -m "empty commit" &&
>> +     git add submodule &&
>> +     git commit -m "advance submodule" &&
>> +     git checkout base &&
>> +     git diff-files --quiet &&
>> +     git diff-index --quiet --cached base &&
>> +     git checkout advanced-base &&
>> +     git diff-files --quiet &&
>> +     git diff-index --quiet --cached advanced-base &&
>> +     git checkout --recurse-submodules base
>> +'
>> +
>
> This test doesn't look like it looks into the submodule to see if the
> submodule has indeed changed.  Unless diff-index and diff-files recurse
> into the submodules?

I took the code from Jens once upon a time. Rereading the code, I agree it is
not obvious how this checks the submodule state.

However `git diff-files --quiet` is perfectly fine, as
we have submodule support by default via:

  Omitting the --submodule option or specifying --submodule=short,
  uses the short format.  This format just shows the names of the commits
  at the beginning and end of the range.

and then we turn it into an exit code via

       --quiet
           Disable all output of the program. Implies --exit-code.

       --exit-code
           Make the program exit with codes similar to diff(1).
  That is, it exits with 1 if there were differences and 0 means no differences.

Same for diff-index.

The main purpose of this specific test is to have checkout.recurseSubmodules
"to just make it work" without having to give --recurse-submodules manually.
All the other tests with the manual --recurse-submodules should test for
correctness of the behavior within the submodule.

So maybe I'll need to rewrite submodule_creation_must_succeed() in the previous
patch to be more obvious. (Well that already has some tests for
files/directories
in there, so it is a little more.)

But to be sure we can also add tests here that look more into the submodule.
I am thinking of "{new,old}_sub_sha1=$(git -C submodule rev-parse HEAD)" and
comparing them?
