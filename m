Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B5C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF38061BC1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhKQVQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhKQVQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 16:16:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CFFC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:13:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n26so3840118pff.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Duhz+aTRLeHGQl2vkRaD8UppFl3m52yGwXR0IOi9b8=;
        b=e/xPyl2iFGj1dTaW7gnUosXqR4HOvGvgmVUBEJe5UzeJYHj+0CDHOD17PvseZnqJYB
         HcDqCR8kFPNl6d9AxbjujegDCnNBEpUy9552Eh8oSbuQhJ4pj/JqCerwsEf5B7qnmqRZ
         Yn3VpYeWsp8zlOtCXClTjVtXlUolK+clqoxMwXPcTn/F6IftcRRdYz5/xWyaY2UEJWvj
         NWUwAqeCCPAp2Se3mrFERQaCLXQ0v1FEegFcmQ7X9Mevm2vtzu2GkmBmS3bDckEtsmMv
         V20HU0y5BsFbHOVGCU2ueM5PBTbiGJuP2u+ZsEw/0mlWOeSmt4oFUO2JtKtEhwxKJI4W
         YvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Duhz+aTRLeHGQl2vkRaD8UppFl3m52yGwXR0IOi9b8=;
        b=uJCx/tUaIVWFAUZpTyNvWQQWq8XoG5DMYaEjUjtcXD518wzBQ+QWAPJ2WFMrBcRXbM
         pcjrCNdZgvyLfcFUKi1TGnWQ1MynEDEDrB9y4HSYsXuAEP+wSvYVEgLAAUkI+O5DB1R0
         0TQBYYWLk5eqC7LdWFVmHB6PntIdxizdX9uc6WMEgur1HrlKb13B4s6kTA2pBArCW0vr
         eRVC7bsb2zvrQNvAMDzIr7EGvtW2kbFovLuV7kC8+lWRm7AdOz850ZIup1iXKOStAkqp
         11BTJ+al9zsKdP3fWLoPMVYPl+EZHP88JXMdsGZQ3GT1xYKOXUocYKwN9bscgPtfpRPm
         VA8w==
X-Gm-Message-State: AOAM532TYIOLQvkOqRJyJRjFs+AxJCiG1LyzMJD1laBy42fx+UGc+Z3E
        f5AchG9J/xa0bhJbSusJGUc81K2c4uORkE2EK0A=
X-Google-Smtp-Source: ABdhPJwfr4rROqKvuyCFTp7dW7MMgv1auzkmxCm4lWy6oCWw9Zn2PWfsX+NsDLbyes7cfuLo+2K4Z0CPeA1+e4js5EU=
X-Received: by 2002:a62:1b86:0:b0:47b:d112:96d4 with SMTP id
 b128-20020a621b86000000b0047bd11296d4mr10050089pfb.52.1637183581087; Wed, 17
 Nov 2021 13:13:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
 <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <dbaad4753c156487e91b766ebd3c9a39d68c1b12.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <dbaad4753c156487e91b766ebd3c9a39d68c1b12.1637158762.git.gitgitgadget@gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 17 Nov 2021 16:12:52 -0500
Message-ID: <CAOjrSZstAHwWxW_m0jSeDN9wgKC3p7oGJYDYRPL27q67GS7Y+g@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] cmake: optionally build `scalar`, too
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 9:49 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The CMake configuration unfortunately does not let us encapsulate all
> (or at least the vast majority) of Scalar's build definition in the
> `contrib/scalar/` subdirectory.

I believe that this isn't fully correct in that you could call
add_subdirectory() with
a directory that isn't a subdirectory so long as you provide it an
explicit binary directory
which is part of what we're doing here anyways. (at least it works
fine for me with
cmake version 3.21)

>
> To alleviate that somewhat, we guard the inclusion of Scalar via the
> `INCLUDE_SCALAR` environment variable.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fd1399c440f..dd7496b0322 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -729,6 +729,13 @@ if(CURL_FOUND)
>         endif()
>  endif()
>
> +if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
> +       add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
> +       target_link_libraries(scalar common-main)
> +       set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/contrib/scalar)
> +       set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/contrib/scalar)
> +endif()

Would it make sense to just mark this with EXCLUDE_FROM_ALL so that
way you don't have to have
the INCLUDE_SCALAR environment variable just for this?  This way
people who don't want
to build scalar can still run `cmake --build .` and not have scalar
built and people who do want
it built can just run `cmake --build . --target scalar`, alternatively
you could also do something like

if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
    add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
else()
    add_executable(scalar EXCLUDE_FROM_ALL
${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
endif()

Just some food for thought,

Matthew Rogers
