Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41B61F428
	for <e@80x24.org>; Tue,  2 Jan 2018 23:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeABXMt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 18:12:49 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43202 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeABXMt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 18:12:49 -0500
Received: by mail-vk0-f68.google.com with SMTP id k132so22007701vke.10
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 15:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ogxvwNED+gROO8DCg+Ql4YUG/sFc1t8x9XIRNPCjNAo=;
        b=bYua0L+xpbJniZAcj+Hk8NgP/8EvqFt+HbWoz19Ie2UHPHcSGN5MOu50kRYmJmFX97
         fjI1zeQX1Wb89uZ7TxCnUGTVQDjm4WyQigV5LPXrDcL/7ObNjUaSIXyL71NhVbg64zh7
         4MsGWfSMs9Kkyl/PsmlYz+3q+Ugc9nB7aLu0TStY7WL/xanMZTRS63lyqyi57vq/iMIh
         c9Lg6q8FZn1Ssll1Py9efeC2e+bVoDSS+Dole+3wYWjarQsSLinFkgQi3GU2OlO8nn1P
         6eq9CynDv9gkbY0jmlwRriBjPiDcNGchtMLOVk0SKnFUbp4oK8aC9o84POascqeF6B0/
         iYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ogxvwNED+gROO8DCg+Ql4YUG/sFc1t8x9XIRNPCjNAo=;
        b=MJR6gUC8s748LZTxwoWp2K4NTQ7pvuS71wyI4oPv2FkukklY0cR49iGKuMCdfFNilC
         6/rmyJ1u4NY2fdFWTGoHHXPMLPlvH/Pr6FOoIS0z2O810Go0NAQTvnoID/De+9s6fnMd
         CUq9EKaaFwEqzas5lenOFM5uG9ev5/Veb9W+BrdMyNmdAq1ykU6y2B276q0gLT9m65CB
         3SOEsB/x+gljIDQM9qJ+rZZNxJlrcwncuo171NElDd4zUHmsSKDF6uLg8U6Z6TGVE9VT
         xkzVgn58Dte3dX/CnUZuz6+imY0EbN5zytzr/ARDwVri7Bybe/QuOQblf46/IlDtrnyg
         UIuw==
X-Gm-Message-State: AKGB3mIA0wvAqkqphdhy42F9lJJknVACv2+kqBoHKbH16wUY2c3/ZRpT
        rv5TGcqmx9+lxQMlgqejPghFXFmYHFu7v5Kj0Zw=
X-Google-Smtp-Source: ACJfBovk8ybD8Mpt4rVEAbMr3ukRVankMxeKsq0nWbEamKZgReaRUrhdA2pYVOlDhXBac0jjjxV4oYon4TOtEb71zmg=
X-Received: by 10.31.94.14 with SMTP id s14mr44737844vkb.6.1514934768279; Tue,
 02 Jan 2018 15:12:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.15 with HTTP; Tue, 2 Jan 2018 15:12:47 -0800 (PST)
In-Reply-To: <D977F37C-D0E5-4EEB-98B4-693A5179F7B1@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com> <20171231160206.19481-3-szeder.dev@gmail.com>
 <D977F37C-D0E5-4EEB-98B4-693A5179F7B1@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 3 Jan 2018 00:12:47 +0100
Message-ID: <CAM0VKjmj7VGr5rcON=2VEug-fGtBrvNqhopH9x7pjB237V796g@mail.gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: check that all build artifacts are .gitignore-d
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 8:40 PM, Lars Schneider <larsxschneider@gmail.com> w=
rote:
>
>> On 31 Dec 2017, at 17:02, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>
>> Every once in a while our explicit .gitignore files get out of sync
>> when our build process learns to create new artifacts, like test
>> helper executables, but the .gitignore files are not updated
>> accordingly.
>>
>> Use Travis CI to help catch such issues earlier: check that there are
>> no untracked files at the end of any build jobs building Git (i.e. the
>> 64 bit Clang and GCC Linux and OSX build jobs, plus the GETTEXT_POISON
>> and 32 bit Linux build jobs) or its documentation, and fail the build
>> job if there are any present.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>> ci/lib-travisci.sh       | 10 ++++++++++
>> ci/run-linux32-docker.sh |  2 ++
>> ci/run-tests.sh          |  2 ++
>> ci/test-documentation.sh |  6 ++++++
>> 4 files changed, 20 insertions(+)
>>
>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>> index 1543b7959..07f27c727 100755
>> --- a/ci/lib-travisci.sh
>> +++ b/ci/lib-travisci.sh
>> @@ -67,6 +67,16 @@ skip_good_tree () {
>>       exit 0
>> }
>>
>> +check_unignored_build_artifacts ()
>> +{
>> +     ! git ls-files --other --exclude-standard --error-unmatch \
>> +             -- ':/*' 2>/dev/null ||
>
> What does "-- ':/*'" do?

It makes the whole thing work :)
':/*' is a pattern matching all paths, and '--others --exclude-standard'
limit the command to list files that are both untracked and unignored.
'--error-unmatch' causes the command to error out if any of the files
given on the command line doesn't match anything in the working tree,
in this case if there are no untracked-unignored files.  Without a path
given on the cmdline '--error-unmatch' has basically no effect[1].

In a clean worktree:

  $ git ls-files --other --exclude-standard --error-unmatch ; echo $?
  0
  $ git ls-files --other --exclude-standard --error-unmatch ':/*' ; echo $?
  error: pathspec ':/*' did not match any file(s) known to git.
  Did you forget to 'git add'?
  1

The disambiguating double-dash is not really necessary, because the :/*
pattern can't be confused with any --options, but doesn't hurt, either.

> Plus, why do you redirect stderr?

To prevent the above error message from appearing in the trace log of a
successful build.


[1] - Which makes me think whether we should consider '--error-unmatch'
      without any paths given on the command line as an error.
      On a related note: that error message doesn't seem to make much
      sense with '--other'...
