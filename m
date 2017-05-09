Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1916320188
	for <e@80x24.org>; Tue,  9 May 2017 11:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdEILNE (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 07:13:04 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36698 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdEILND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 07:13:03 -0400
Received: by mail-it0-f52.google.com with SMTP id o5so3018973ith.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L85uD4XcYPEaLTE/T2kwgMPxvrmRu4WePkA6Vw3Kljc=;
        b=IfjN7cDhSWhXZSZYVS5UoZ5IbFsdvMF5b0AWxI5H9u1I4S19o7LrAxBEjBkgVP3+8A
         XBKIbf0M8U74q0zXYPB4TvDCED7vlkdbYR1XwTSjQGexAPCjufqlzSYTCdl27rcKab5v
         bxAkHEt0p9QeXnjxdzogc39Y09D0f/xxn7+SYI18nlisaihPDoksNflUjkaymLVwfGpZ
         YmuEisbxutOFdNJYnWYj0+3oxUlzyx8I6Xg2bs4fs9QpwGLd/JezjN3xw7ja+nt12Y0i
         o0bnNmTF/4Bd6l02GwI+etWEdqsU+qzmqe6YsbtSb66vGXXy6T5UNzGa/u2xazChneN7
         XpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=L85uD4XcYPEaLTE/T2kwgMPxvrmRu4WePkA6Vw3Kljc=;
        b=KFViV+2vPjBsv4g/+TErF8OY0cgGWw3XhkWn08pAsfO9s4on7kXR2fvcy88NtRuP+p
         dyL++8Yyh7vbL6YMGXwPM6etkFJ9PJbVlyi545GItE9LbLuGwOOsK35JN4KBlhaNfHwZ
         bzFIbd5nyPTB6lGR+UJ6VhxQSsSBV/zwhn4Tw7s3IG2y2ZERXuhLXV6BtvT6nl15mDCD
         8atVwEA4iOpG/6bDYAz6xTs5b9h2iCbhc02rQ1WCg9z738wnWPhX2RB+XJ4QUARPddmC
         VQDsZuv2dq+IIA9TdNcn9fTjQDcwHON1RTuFV4hOWnRTwjzZCx9WZOQUaKv2lxNCl0Hw
         QHbQ==
X-Gm-Message-State: AN3rC/7XRXMxDvKlYVqTt879uYw24ueWoHaNiWxYA/BQUEPE5KX5XLPa
        BxrRXtxRI7pPCwAjzVzRwuEwga/CpNTAir8=
X-Received: by 10.36.166.4 with SMTP id q4mr20877912ite.66.1494328382738; Tue,
 09 May 2017 04:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 04:12:41 -0700 (PDT)
In-Reply-To: <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com> <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
 <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com> <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 13:12:41 +0200
Message-ID: <CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=Sf9tdkOt52M9j1Q@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 2:37 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Tue, May 9, 2017 at 1:32 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > PCRE and PCRE2 also tend to have a lot of security updates, so I would
>> > prefer if we didn't import them into the tree.  It is far better for
>> > users to use their distro's packages for PCRE, as it means they get
>> > automatic security updates even if they're using an old Git.
>> >
>> > We shouldn't consider shipping anything with a remotely frequent histo=
ry
>> > of security updates in our tree, since people very frequently run old =
or
>> > ancient versions of Git.
>>
>> I'm aware of its security record[1], but I wonder what threat model
>> you have in mind here. I'm not aware of any parts of git (except maybe
>> gitweb?) where we take regexes from untrusted sources.
>>
>> I.e. yes there have been DoS's & even some overflow bugs leading code
>> execution in PCRE, but in the context of powering git-grep & git-log
>> with PCRE this falls into the "stop hitting yourself" category.
>
> Just because you don't drive Git with untrusted regexes doesn't mean
> other people don't.  It's not a good idea to require a stronger security
> model than we absolutely have to, since people can and will violate it.
> Think how devastating Shellshock was even though technically nobody
> should provide insecure environment variables to the shell.

Yes this is definitely something we should keep in mind. I see my
comment could be read as dismissing your concerns, I didn't mean that.
This is definitely something to be concerned about.

I was trying to solicit feedback on whether there were any other parts
of stock git that could take external input as regexes than gitweb,
I'm not aware of any.

I thought that gitweb wouldn't take regexes by default, but I see now
that the 'search' feature is on by default, and that allows you to
grep / pickaxe with regexes. Either -E or -F for grep, or
--pickaxe-regex (which implies -E) for log.

> And, yes, gitweb does in fact call git grep.  That means that git grep
> must in fact be secure against untrusted regexes, or you have a remote
> code execution vulnerability.

Indeed, but it's not as clear-cut as turning on on PCRE making you vulnerab=
le.

* gitweb is vulnerable to CPU DoS now in its default configuration.
It's easy to provide an ERE that ends up slurping up 100% CPU for
several seconds on any non-trivial sized repo, do that in parallel &
you have a DoS vector.

* Obviously something that's 2x as fast or more (which my WIP code is)
makes this better.

* PCRE tends to be worse at pathological patterns, but this is because
it has really large limits by default and will try rather insanely
hard to match your pattern.

                -DHEAP_LIMIT=3D20000000 \
                -DMATCH_LIMIT=3D10000000 \
                -DMATCH_LIMIT_DEPTH=3D10000000 \
                -DMAX_NAME_COUNT=3D10000 \
                -DMAX_NAME_SIZE=3D32 \
                -DPARENS_NEST_LIMIT=3D250 \

This can be reduced dynamically via the API (and the patterns can't
change it, except to reduce it). For example on my system 2.11.0
(before any of my changes) on linux.git:

    $ time git grep -E -- '-?-?-?-?-?-?-?-?-?-?-?-----------$' |wc -l
    12434
    real    0m0.444s
    $ time git grep -P -- '-?-?-?-?-?-?-?-?-?-?-?-----------$' | wc -l
    12434
    real    1m20.849s

With my JIT changes:

    $ time ~/g/git/git --exec-path=3D/home/avar/g/git grep -P --
'-?-?-?-?-?-?-?-?-?-?-?-----------$' | wc -l
    12434
    real    0m5.334s

However for user-supplied patterns we can just turn on really
conservative settings:

    $ time ~/g/git/git --exec-path=3D/home/avar/g/git grep -P --
'(*LIMIT_RECURSION=3D1000)(*LIMIT_MATCH=3D1000)-?-?-?-?-?-?-?-?-?-?-?------=
-----$'
| wc -l
    fatal: pcre2_jit_match failed with error code -47: match limit exceeded
    0
    real    0m0.021s

When I locally compile git with something like this:

-               -DMATCH_LIMIT=3D10000000 \
-               -DMATCH_LIMIT_DEPTH=3D10000000 \
-               -DMATCH_LIMIT_RECURSION=3D10000000 \
-               -DMAX_NAME_COUNT=3D10000 \
+               -DMATCH_LIMIT=3D1000 \
+               -DMATCH_LIMIT_DEPTH=3D1000 \
+               -DMATCH_LIMIT_RECURSION=3D1000 \
+               -DMAX_NAME_COUNT=3D100 \
                -DMAX_NAME_SIZE=3D32 \
-               -DPARENS_NEST_LIMIT=3D250 \
+               -DPARENS_NEST_LIMIT=3D10 \

All tests still pass, and from my own testing I can't find any
non-pathological patterns this would break. So we might actually
consider turning this down for git by default.

* Much of the rest of the patterns PCRE has CVEs for can similarly be
mitigated by simply turning various features off.

> Furthermore, at work we distribute Git with all releases of our product.
> We normally only do non-security updates to the last couple of releases,
> but we provide security updates to all supported versions.  I'm not
> comfortable shipping the entirety of PCRE or PCRE2 to customers without
> providing security updates, so you're going to make my job (and my
> coworkers') a lot harder by shipping it.  Please don't.

I'm not going to make your job harder. This WIP patch I have for
embedding PCRE2 as compat/pcre2 is for use by those who'd want to get
a faster grep, but for whatever reason don't have a handy PCRE v2
package already, or wouldn't mind supporting a git that comes bundled
with it.

My comments about "git rm"-ing kwset & compat/regex were meant in the
sense of "I have a branch where we don't use that anymore, and it's
faster", not that you couldn't compile a git without PCRE for the
forseeable future.

My WIP branch does remove much of the non-PCRE code, but that's just
because it was easier to hack up like that and not support a bunch of
if pcre/else branches, I'll amend that and keep PCRE optional when I
end up submitting those patches.
