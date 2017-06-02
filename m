Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27A620D13
	for <e@80x24.org>; Fri,  2 Jun 2017 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdFBQpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 12:45:30 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37115 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdFBQpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 12:45:30 -0400
Received: by mail-it0-f42.google.com with SMTP id m47so23656593iti.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=elcs7x3IMqe/gTuBB1WuHtygHNQcBFRRaW6NODT2M64=;
        b=GQ0IhG1CLYWcNNZB3im5RtwwFqodS+E8yAIFXyCbhuYB1DpDXl24CSWqiO8j9Aig8c
         h46S+oYcxs6Idcp18bngzDrB3jTneKNxCy0zBQMN5AHBWVRT7xZXqN/Sr/kpNtUJpIe0
         axJx8VgkzihLx99vTU1v3lidum12IOS9HtEFJbwg8fU/PLMEdTUeuzEiqKlN5rV5cvHC
         D7FHRaHUil6+HBOSsyZFP8J6VIWo8QJ2ifJSG30m4JPYpWb09bKfiiKMnfp5/qaBjZUx
         1ZroLNXhsYJFu3obNkwXnU/gOmgQd5qeV39/hYbLpkV3Ankp37qblUxbAn6HOpU7jAtV
         8VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=elcs7x3IMqe/gTuBB1WuHtygHNQcBFRRaW6NODT2M64=;
        b=gi5B628pyZS9W63SA6ncey/w20GK1N7FfvwqZj2QEO52xYbwmH6uYL23OeaxqCKGrz
         f2yPMMOvkUnGdoa9s2RkRNFmZIUU6U1ZH/leZT8o1szvqisjWSyypy//G2mW5Mt3XbUT
         b/bQeqybXKd2vCEtiCyESWDFsSQKiBCKdVVPQ8jTTquExtnp5pQJ2cMW7s/AQ0uAnsrq
         pSSlP+gh2VXTCPmuPtUkZsqKMgk32KiFKyMKzVFCaITj/fIgWQTJbgGsd8Hb8iBsP7jt
         IRlGp3h+axjkf9xO0VhQkxSLU8RvSntkrpXqQouiODL6Bg0o0J33qqKshcrlnWpGwX+w
         CGUQ==
X-Gm-Message-State: AODbwcBeBTe43Rqimp2wlsA/NNXqJRlDqTF0ZbPS74pe97+bjoHqIYPM
        rKx1LDMrw8mNnsC7KqkvN3pIFExW+Q==
X-Received: by 10.36.29.150 with SMTP id 144mr215864itj.71.1496421929201; Fri,
 02 Jun 2017 09:45:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 2 Jun 2017 09:45:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706021803460.171564@virtualbox>
References: <20170601182056.31142-1-avarab@gmail.com> <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706021803460.171564@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 18:45:08 +0200
Message-ID: <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 6:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 2 Jun 2017, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>> > See <20170525200528.22037-1-avarab@gmail.com> for v3
>> > (https://public-inbox.org/git/20170525200528.22037-1-avarab@gmail.com/=
).
>> >
>> > This is on top of "[PATCH v4 00/31] Easy to review grep & pre-PCRE
>> > changes".
>> >
>> > Changes:
>> >
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>> >   grep: don't redundantly compile throwaway patterns under threading
>> >   grep: skip pthreads overhead when using one thread
>> >   log: add -P as a synonym for --perl-regexp
>> >   grep: add support for the PCRE v1 JIT API
>> >   grep: un-break building with PCRE < 8.32
>> >   grep: un-break building with PCRE < 8.20
>> >
>> > No changes.
>> >
>> >   grep: un-break building with PCRE >=3D 8.32 without --enable-jit
>> >
>> > NEW: It turns out that a PCRE version that supports JIT, but is built
>> > without JIT support will fail at link time since there's no
>> > pcre_jit_exec symbol.
>> >
>> > It also turns out (contrary to what I claimed on list before, my
>> > mistake) that there's no way to detect this through some macro. All
>> > the pcre include files are the same with/without --enable-jit, only
>> > the object file differs.
>> >
>> > So there's now a NO_LIBPCRE1_JIT flag to the Makefile, which is off by
>> > default, but turned on on MinGW. I have not tested that
>> > config.mak.uname change, but everything else I could test on Linux.
>> >
>> > The reason for why it's NO_LIBPCRE1_JIT not USE_LIBPCRE1_JIT is that
>> > in practice pretty much everyone who builds pcre builds it with JIT
>> > (I've looked through various Linux/BSD distro build files), it's MinGW
>> > that's the exception here. Given the performance gain it makes sense
>> > to make it the default.
>> >
>> >   grep: add support for PCRE v2
>> >
>> > Almost no changes, just:
>> >
>> >  * A trivial change to stop redundantly assigning to pcre2_jit_on,
>> >    mistakenly left over from an earlier version.
>> >
>> >  * Updated commit message / perf numbers for the extra patches in the
>> >    series both here and in v3.
>>
>> Nicely summarised and matches what I received; thanks, will replace.
>
> For the record: I spent the entire development time I had today on trying
> to get PCRE2 to build and to figure out which PCRE2 tests fail and why.
>
> I hoped to get to the bottom why the JIT is disabled in PCRE1, but ran ou=
t
> of time.
>
> I seem to have gotten PCRE2 to build and figured out why the tests failed
> (spoiler: all of the failures were bogus and no indication of an
> incorrectly-built PCRE2).
>
> I barely had time to build `pu` (forcing PCRE2) and to run the test
> scripts whose file names contain the substring "grep". Seems to work so
> far, but this is by no means comprehensive testing; it is more like hushe=
d
> and rushed testing on a Friday night when I should have stopped working 1=
0
> minutes ago.
>
> Will continue with testing Git for Windows using PCRE2 next week and keep
> you posted,

Thanks a lot for testing it. Great to hear that it (definitely almost) work=
s!

If the grep tests it's very likely that all of them will pass, the
only tests I run when developing this series (outside of the full run
for list submission) are t[0-9]*grep*.sh t[0-9]*log*.sh tests, since
those are the only ones impacted by it.
