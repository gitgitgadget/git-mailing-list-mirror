Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3D7207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S976714AbdDXWpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:45:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34658 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762235AbdDXWps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:45:48 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so51754520ioi.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcptEgXwBwee6lAclnsYpLu6GcYDwOvFO1WErgjWwkY=;
        b=oeK0/kTQObjDTkLAV61FuKoEO9NUIQeLswFic9rbrIbSI1gPrGrK4lhBGgIBhh4TW1
         3jo7pwqkRQQCLt+2nLVHzvC6NfQn/gFGY3BWsD8n7xvtqdngkxh7x/oAzxw77Ohz27sR
         DcYZLlj7joIkRAbm0047cJ7f5CNPJidiol8jB+juMaPPOlYhL6N80UJrp5WEPlaLgpNe
         bwtIx7MP/AOERB5TxKdST7JQhRukMPEZGzqx+qBCnhhCNwOKNYpSiqteFt1Zvu43Ej2G
         NQhhVS7eR5MX9MpbwP9feC/UXaqhtu3SpqxJr7wPZOnk+6f58VyAOsDk5E+RlqmPfgn4
         mFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcptEgXwBwee6lAclnsYpLu6GcYDwOvFO1WErgjWwkY=;
        b=gobocAZkJdFPtEmrZNnHERyH8U7bhh7D/WIlJ+VNlAZalIYOS22emZ16tcrvspxDoj
         AVnRVH37aAJ6LF71kHEtFCSoCBtsP9tb+U48ySm+Oz0nVEOvrw3j6GuX4PfQ23RYXtrp
         3Wff4fbv2sRMmd9xzvN6U4B2ChNesYOOZY1C8Bbx6APFgeSo40E9tubE+EktzAFCaqKd
         d8kADs8e/Oqp265PnjNNTK2i3iwYVV4TkALeoQVHxJMLjhfclC8cLDpn0t0MJtDX09F2
         Re5AJPKPB86yZjTYCsOw5Q1dlGPaqKojF3ZleO35/xJ+DaNOCmiZ5c66LaZBy7NzilWo
         0oCw==
X-Gm-Message-State: AN3rC/56D8XYX27Torp7q5eHxIlboA92DveDVbcu0e3vaspHBNceR0ZV
        hP0XQIoounIeaRl/stHqyrop5IlzYA==
X-Received: by 10.107.35.200 with SMTP id j191mr11856012ioj.33.1493073947841;
 Mon, 24 Apr 2017 15:45:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 24 Apr 2017 15:45:27 -0700 (PDT)
In-Reply-To: <20170424213428.GA105623@google.com>
References: <20170424211249.28553-1-avarab@gmail.com> <20170424213428.GA105623@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 25 Apr 2017 00:45:27 +0200
Message-ID: <CACBZZX60f9aSOEcjiJpd2uXM4JHgye3F5bZHpA=6RDfMEiv+yg@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf: show that wildmatch() regressed for
 pathological cases in v2.0
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 11:34 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 04/24, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>> Russ Cox just published an article about how various glob()
>> implementations suffer from pathological performance when fed certain
>> pathological patterns like "a*a*a*a*b" given a file like "aaaaaaa...":
>> https://research.swtch.com/glob
>>
>> I was curious to see if this impacted git. It turns out it does. This
>> used to be a per-platform issue with git, since globbing was
>> implemented via fnmatch() by default before v1.8.4, and support for
>> using the OS fnmatch() was removed entirely in v2.0.0.
>>
>> This performance test shows the regression:
>>
>>     $ GIT_PERF_REPEAT_COUNT=3D1 GIT_PERF_MAKE_OPTS=3D"[...]NO_WILDMATCH=
=3DYesPlease[...]" ./run v1.9.5 v2.0.0 v2.12.0 p0100-globbing.sh
>>     [...]
>>     Test                                                       v1.9.5   =
         v2.0.0                    v2.12.0
>>     --------------------------------------------------------------------=
----------------------------------------------------------
>>     [...]
>>     0100.7: fileglob((a*)^nb) against file (a^100).t; n =3D 1    0.01(0.=
00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
>>     0100.8: fileglob((a*)^nb) against file (a^100).t; n =3D 2    0.01(0.=
00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
>>     0100.9: fileglob((a*)^nb) against file (a^100).t; n =3D 3    0.00(0.=
00+0.00)   0.00(0.00+0.00) =3D         0.01(0.00+0.00) +inf
>>     0100.10: fileglob((a*)^nb) against file (a^100).t; n =3D 4   0.00(0.=
00+0.00)   0.01(0.01+0.00) +inf      0.02(0.02+0.00) +inf
>>     0100.11: fileglob((a*)^nb) against file (a^100).t; n =3D 5   0.00(0.=
00+0.00)   0.20(0.19+0.00) +inf      0.24(0.23+0.00) +inf
>>     0100.12: fileglob((a*)^nb) against file (a^100).t; n =3D 6   0.00(0.=
00+0.00)   3.03(3.00+0.00) +inf      3.08(3.05+0.00) +inf
>>
>> And here's a one-liner to do the same:
>>
>>     $ time (rm -rf test; git init -q test && (cd test && touch $(perl -e=
 'print "a" x 100').t && git add a* && git commit -q -m"test" && git ls-fil=
es 'a*a*a*a*a*a*a*b'))
>>
>> Add or remove "a*"'s to adjust the runtime. With 6 that executes in 3
>> seconds on my system, 40 seconds with 7 etc.
>>
>> I don't think this is something we need to worry much about, if you
>> have a file like this and feed Git insane patterns you probably
>> deserve what you get.
>>
>> The real concern is if we have behavior like this and ever e.g. expose
>> globbing over the network, e.g. in some future upload-pack protocol.
>>
>> There are probably some web-based programs built on top of git that
>> are vulnerable to DoS attacks as a result of this, e.g. if they take
>> user-supplied globs and feed them to ls-files.
>
> I was taking a look at wildmatch a few months ago and have an unfinished
> patch to do some cleanup there.  I noticed this was inefficient but
> didn't expect those kinds of numbers.  I wonder how difficult it would
> be to rewrite it so that we don't have this issue.

Something I've started hacking on as part of a post-PCRE v2 series I'm
working on, which I'll submit after PCRE v2 support is merged, is to
replace various parts of regex / matching machinery with PCRE under
the hood if it's available, even when the user doesn't ask or care
that we're using PCRE.

The thing I'm working on now is to replace fixed-string grep/log
searches that we currently do via kwset with PCRE v2. It's quite a bit
faster than kwset, and allows us to fix a bunch of outstanding grep
TODO items.

It would similarly be interesting to replace wildmatch() with a shimmy
wrapper for PCRE that translates glob patterns to regexes. Not that we
need PCRE for that, we could probably just use regcomp(), but PCRE
would almost certainly be faster than wildmatch().

Of course the use-cases are different. For the kwset replacement we'd
just use PCRE under the hood because it's faster, whereas the reason
we integrated wildmatch() in the first place was to get consistent
behavior across all platforms, and PCRE is currently an optional
dependency.

I think it might make sense to solve this general class of problem by
eventually making PCRE a mandatory dependency of Git. Right now we
have copy/pasted versions of whatever the last GPLv2 version was of
kwset/wildmatch, which we then have to maintain.

Between kwset/wildmatch/various code in grep.c & diffcore-pickaxe.c we
probably have 2-3k lines of very tricky string matching code which
could be replaced by relatively trivial calls into PCRE.
