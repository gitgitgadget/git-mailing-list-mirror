Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25851F404
	for <e@80x24.org>; Wed, 24 Jan 2018 12:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933397AbeAXMMv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 07:12:51 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35052 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeAXMMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 07:12:49 -0500
Received: by mail-ua0-f194.google.com with SMTP id x33so2555493uac.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ESUqbN9Zi9QwcpZyjd+fVuqdqA/BD5pdyi7Djba6KXw=;
        b=eB4ynxlCWctRLGpMs620jOXVgbUIfQjRZAjwpHRgRxhXjDQSuoGwwk34DtVCFtlTie
         U4RPleLptYrba2eq1ID6wg2Juy+Q9mGgqVmVO4YT8UgSXC0XdgpTlloDtQ8hIDsYJRKe
         E5CcHcDwpuBdOHdRWDXeu/QUmRAY1jQ8Y0yEvJCl8gUDfHfg+u/pu/s8KMcGnGXE9w9u
         TkPZWPAIlpgz3WVkSwRhsq0SxVsNfCrqreRBMaaPiueQ4iFNjUSvA1qG4naVJhjCjoP/
         uJ5YpaqK/4cKFQw7eiIhKdoPWQWSDPWypVnbccW9FX8JhswCHdPGNXizXORokA9t4t6j
         NZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ESUqbN9Zi9QwcpZyjd+fVuqdqA/BD5pdyi7Djba6KXw=;
        b=q8FUisx1IzCP9e9sJnXFi0qSDVn9wP8APamjyIOzdGmnXRvti0jfiPmSA+kT4NICeZ
         1+szVwr/FW12E8Qau3zK4TCMAOlTo3f9Iv473mMaC8c/1/2o29485FQS670X1PxvjCFY
         DA3mc6GQ46y8VP03NyBi/5ln7H6sD7bK3QJhZBrP3q+fb2oIuZ8WK4vt+/eHxWxdEFA8
         SPqk4VFMeJq9hpJvRBcqYz+LOs0W1AdGQDOqnaIYZXWGMFhwCqcW6sGMHBG+SmTKeaXb
         kUaNmv3YNWuxz68uIYYcs/N5IxDBqqI67alx2+4x/S1oabK4yBK58jE0C7uT55XYpHsq
         /GdQ==
X-Gm-Message-State: AKwxytc8ycNfycTOKckVWvQJ38YQA3U2ElUPAXx42pAuAsNxLGEaIQ2t
        TJGD9Y3hRAtzHDyd04+dNvQx4Sgi794Dw0TAsAM=
X-Google-Smtp-Source: AH8x225n5uNWTST4wsL3bdM4k1Hva9Ppkmb79KGNyUOCmZdImVBLUVRmEen2jppyRulyt6s//VwB/3ozp7bnbVaFoII=
X-Received: by 10.159.57.111 with SMTP id i47mr4666448uag.79.1516795969009;
 Wed, 24 Jan 2018 04:12:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 24 Jan 2018 04:12:48 -0800 (PST)
In-Reply-To: <20180123162633.GE13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com> <20180122133220.18587-3-szeder.dev@gmail.com>
 <20180123162633.GE13068@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 24 Jan 2018 13:12:48 +0100
Message-ID: <CAM0VKjkGEfL2j2uzRa9=N5jZFbMMKEHn=UX=thxTAMM_g8TB4g@mail.gmail.com>
Subject: Re: [PATCH 2/5] travis-ci: use 'set -e' in the 32 bit Linux build job
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

On Tue, Jan 23, 2018 at 5:26 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 22, 2018 at 02:32:17PM +0100, SZEDER G=C3=A1bor wrote:
>
>> All 'ci/*' scripts use 'set -e' to break the build job if a command
>> fails, except 'ci/run-linux32-build.sh' which relies on the && chain
>> to do the same.  This inconsistency among the 'ci/*' scripts is asking
>> for trouble: I forgot about the && chain more than once while working
>> on this patch series.
>
> I think this actually fixes a bug:
>
>>  # Update packages to the latest available versions
>>  linux32 --32bit i386 sh -c '
>>      apt update >/dev/null &&
>>      apt install -y build-essential libcurl4-openssl-dev libssl-dev \
>>       libexpat-dev gettext python >/dev/null
>> -' &&
>> +'
>
> If this step failed, then...
>
>>  # If this script runs inside a docker container, then all commands are
>>  # usually executed as root. Consequently, the host user might not be
>>  # able to access the test output files.
>>  # If a host user id is given, then create a user "ci" with the host use=
r
>>  # id to make everything accessible to the host user.
>> -HOST_UID=3D$1 &&
>> -CI_USER=3D$USER &&
>> -test -z $HOST_UID || (CI_USER=3D"ci" && useradd -u $HOST_UID $CI_USER) =
&&
>
> We'd have triggered the right-hand side of this "||", and run the rest
> of the script.  The whole "||" block should have been inside {}.

Indeed, the && chain is broken, I didn't noticed that.

Luckily it was broken in a way that it didn't lead to false successes:
if installing dependencies fails, then the first && chain
ensures that HOST_UID is not set, and then useradd will error out with
"invalid user ID 'ci'", causing the second && chain to abort the script
and thus breaking the build.

Will update the commit message accordingly.

> But after your patch, it should be fine with "set -e". Although...
>
>> +HOST_UID=3D$1
>> +CI_USER=3D$USER
>> +test -z $HOST_UID || (CI_USER=3D"ci" && useradd -u $HOST_UID $CI_USER)
>
> If this "useradd" step fails, we wouldn't abort the script, because it's
> part of a conditional. You'd need a manual "|| exit 1" at the end of
> this line. Or to use a real "if" block.

No.  It does abort the script, because it isn't part of a conditional.
Try to run the script twice in the same container instance: in the
second run the user already exists, useradd fails and the whole script
aborts.


> Reading this line, I'm also slightly confused by setting CI_USER in the
> subshell, and then only using it once. Should it be respecting the outer
> CI_USER setting? If not, should it just hard-code "ci" on the useradd
> command-line?  But that has nothing to do with your patch here.

I see you've already made it to patch 4, good :)
