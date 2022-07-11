Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F64C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 01:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGKB2r convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 10 Jul 2022 21:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGKB2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 21:28:45 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A87630A
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 18:28:42 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26B1SaSD046621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 21:28:37 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com> <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
In-Reply-To: <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
Subject: RE: Automatic code formatting
Date:   Sun, 10 Jul 2022 21:28:31 -0400
Organization: Nexbridge Inc.
Message-ID: <007f01d894c5$8b1cd3a0$a1567ae0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJx/GmjE7b2KfIXtW66dZbrqQtAvQHxKG25Amu+XkOsIqnO0A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 10, 2022 8:59 PM, brian m. carlson wrote:
>On 2022-07-10 at 22:13:01, rsbecker@nexbridge.com wrote:
>>
>> Being one of the platforms that will be specifically excluded from
>> this proposal, I would like to offer an alternative. Before that,
>> please remember that not everything is Linux. My suggestion is to
>> create infrastructure to automatically format on add/commit. This
>> could be pluggable relatively simply with clean filter that is
>> language specific - perhaps with a helper option that installs the
>> formatter easily (because clean filters are notoriously painful to
>> install for newbies from my observations). It would be nice to have
>> something in perl that is more portable and pervasive than clang -
>> although perl could launch clang where available. I think having
>> infrastructure for code formatting that is built into git is actually
>> highly desirable - assuming that it is not unduly difficult to install
>> those. It would extend beyond git contributions, but the contributors
>> could be told (Contributor's Guide) that then need to follow standard
>> X, which may very well be clang format. There are java formatters, php
>> and perl formatters, even COBOL and TAL formatters. My position is
>> that having a standard way to plug these in is a more general plan
>> that would reach a larger community. Git contributions could then just
>> leverage standard git functionality.
>
>I am willing to acknowledge the fact that not everybody has clang on their
>preferred platform.  However, I assume you do have a laptop or desktop with
>which you access your platform (since I believe it's a server
>platform) and that you can install software there, or that you have the ability to
>run some sort of virtualization framework on some system.
>
>I am in general not very willing to say that we can't use or have useful developer
>tools because of uncommon platforms.  Linux, Windows, macOS, and (I believe)
>FreeBSD, NetBSD, and OpenBSD all support clang and related tools, and I don't
>think it's unreasonable for us to expect that someone can have access to such a
>system as part of development, even if that's in a VM.  Those six operating
>systems plus Chrome OS constitute the overwhelming majority of desktop and
>laptop systems, and there are several options which are free (both as in speech
>and beer).
>
>Moreover, clang and LLVM are extremely portable[0].  As a practical matter, any
>platform wanting to support software written in Rust (a popular and growing
>language) will likely need LLVM, and there is also a lot of software in C and C++
>that only supports GCC-compatible compilers.  I do feel that providing support for
>modern toolchains is an important part of providing a viable OS port, and that we
>should be able to rely on porters for that OS to do that work.  I realize that LLVM is
>not yet ported to your system, but I believe it's going to functionally need to
>happen sooner or later.  When it does, you'll be able to send patches directly
>without needing to copy to another OS to format the code.

I should point out that gcc will *never* according to our latest intel, be supported on my platforms. *Never* is, of course, an indeterminate definition, but until various matters I cannot legally discuss change, which are not likely for at least 5 years, anything depending on gcc is out of the picture and unavailable, including clang. I understand the position regarding git contributions, but I am trying to get the point across that formatting code to a standard is a more general desire than just git contributions. It is a broad desire/requirement that should be considered. Rather than making processes git-contribution-specific, providing a more general solution that git contributors can use is more effective.

--Randall

