Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0E41F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeAXT71 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:59:27 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33621 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeAXT70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:59:26 -0500
Received: by mail-wm0-f49.google.com with SMTP id x4so28091012wmc.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 11:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VuDl3A86nwkqXpN451IiEcwlYBUasPEqSXHs0hYCWSc=;
        b=jV3QAo9o/QQfm6a/23kjoWUPkCRy0yIK/Wn4zv8WGhPGG+W6IJT0vEbCg9s9VpBSaL
         fBOd7OBoJury6w8Dbc/DAf4TZlR7tvFPB8Ekbm+10FAOfuK/gFtXFEF+wbAER4fsOnZs
         MaIlujLOhK0VafYh7AVc1ffcCrPSun1JlGhplbx/uwbwtHT5PcQ2qqBicENSfGB0RsBF
         AjX6O1atu1LH+Le+IsoD35EQWQhLMb8he2qUfUEHVTtYE8wJI3yIlPpUMZYknbw28KLL
         wNBKAIc/Ta1jy0OHIs1GkFM0Cn3qvqM4TBxDlG/6sxveq0ECtgoopU3gnMiO86AW5QS4
         SaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VuDl3A86nwkqXpN451IiEcwlYBUasPEqSXHs0hYCWSc=;
        b=JbOz3bFgPCfiFJeYNJwI4r0KpJWb6le5/5TU8Okoel4J5t2QMy6feBqhz9ztYa1IY3
         dis90+eO8bH3n1Y30EK+PghO6O+wwon/nXQfRo7nSyGczzux6kX/eB/G4ylH23wnrMkr
         ZF1dyDzAvgvbbdpBpfMGujOtBlFZXimUoI6N0d9ycL4q9Mk+wLaNgQUOTc3UIbVOOx+h
         iE/VZ+IBGCb4iqZELiFlfEugimd5MgUEZEzWMpFiN1ySZKMdqwJLxIV0jMaf/mjm0dfD
         dX4d4FKB+Sdc6cxrr414/8sBmRLyC8BGr1DpSkv1CeHV2P5/D3muTfPyQMjh7p/+AOJ+
         ZAIw==
X-Gm-Message-State: AKwxytfUC/R/sJxqYWkXWkpXs5rMJQPCRMALOKMWNLpqSqMW96jZbIPI
        D1pKhg0l8aOPt5oLnrtyGepGnZmuodURACHmlTJue6x2
X-Google-Smtp-Source: AH8x224c9sHg33H7zCdr+ZE1rPYh1+7u9S1odcrpXjzQ3XZDr1Xa7b0Tq32suefibJwqoAGE3cpdNXUH0b0lCm5Hiy8=
X-Received: by 10.28.169.76 with SMTP id s73mr5088472wme.122.1516823965248;
 Wed, 24 Jan 2018 11:59:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.166.115 with HTTP; Wed, 24 Jan 2018 11:59:24 -0800 (PST)
In-Reply-To: <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Wed, 24 Jan 2018 14:59:24 -0500
Message-ID: <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff, no worries, fair enough. I know https://github.com/grpc/grpc
uses a shared file to generate code for several build systems instead
of maintaining them individually. I plan on doing the work anyway just
because I have my own reasons to use CMake in Git (for packaging in
https://github.com/ruslo/hunter is my main motive here). Whether or
not it is maintained upstream is not a real concern for me at the
moment.

Junio, in terms of maintainability, yes that is my main concern as
well. I proposed this here knowing that might be the main issue. From
my point of view, CMake is a much better choice than Makefile + uname
overrides, but if no one cares for learning CMake, you are correct
that it will not be maintained.

In terms of the benefits of CMake, let me highlight some examples I
noticed while porting this:

* Makefiles rely on hard-coded paths. CMake does not (uses find,
configs, etc. to alleviate path-related issues). One clear example is
the way the Makefile has to exclude certain package manager paths on
Mac (i.e. fink and ports).
* Makefiles do not have a good way of finding dependencies or checking
versions. Compare these two choices.
   Makefile: curl_check := $(shell (echo 070908; $(CURL_CONFIG)
--vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne
2p)
   CMakeLists.txt:  if(CURL AND CURL_VERSION_STRING
VERSION_GREATER_EQUAL "7.22.0")
* Makefile cannot use compilation results to drive build.
config.mak.uname needs to be updated each and every time to delineate
acceptable builds.
* CMake can automatically produce a compilation database for clang
tools (iwyu, clang-tidy, etc.).
* CMake is procedural and generates a dataflow Makefile. Procedural
programming is a little more intuitive IMO, especially true for C
programmers :). Case in point, debugging a Makefile is a lot harder
than debugging CMake.
* CMake is compatible with non-Unix/Windows platforms.

My point isn't to convert you, just to explain why CMake has taken
over in many many projects over the last decade. I agree that if there
is no maintainer, do not accept this patch. I'm only offering it in
case there is any interest. It seems like there isn't at the moment.
I'll see how the Windows build currently works and if that makes
sense, maybe I'll try using that build generator here too.

Thanks for the feedback,

Isaac

On Wed, Jan 24, 2018 at 2:36 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/22/2018 7:16 PM, Isaac Hier wrote:
>>
>> This patch adds a mostly complete (aside from building tests,
>> documentation,
>> installation, etc.) CMake build to the git project. I am not sure how much
>> interest there is in a CMake build, so please send me feedback one way or
>> another. Personally, I believe CMake will help with Windows builds and is
>> somewhat easier to read than a Makefile. I considered, adding this to the
>> contrib directory, but CMakeLists.txt almost always reside in the original
>> directories, and I'm not sure how wise it would be to do otherwise. If you
>> are
>> interested in a CMake build, I would be more than happy to finish up the
>> work
>> here. Decided to wait until I discussed the issue here to finish the final
>> parts
>> of the build.
>
>
> On Windows, we use "bash" and "make" from the Git-for-Windows SDK
> installation
> (which gives us a bash shell and most of the usual Unix command line tools)
> and
> the main "Makefile".  We do need a special section in the "config.mak.uname"
> file
> to set some platform compiler options and etc., but that is small enough.
>
> Johannes and I recently added a few new options to let Windows build Git
> from
> the command line with either GCC or MSVC and to synthesize MSVS solution
> (.sln)
> and project (.vcxproj) files to allow you to work with the full MSVS IDE and
> full intellisense.  And if necessary download and build third-party
> libraries
> not normally present on a Windows machine.  Most of this work is Windows
> specific
> and may not yet be upstream.   See GfW [1] and VCPKG [2].
>
> The synthesized solution and project files are automatically generated, so
> we
> do not have to separately track changes in the Makefile to the various file
> lists.
> These should be treated as read-only and re-generated in response to changes
> in
> the Makefile.  Using the solution/project files, we can completely build Git
> in
> the IDE or a command prompt and without the SDK.  This further simplifies
> things
> for Windows developers.
>
> So given that, I don't see a need to replace the main Makefile on Windows.
>
> Sorry,
> Jeff
>
> [1] https://github.com/git-for-windows/git
> [2] https://github.com/Microsoft/vcpkg
