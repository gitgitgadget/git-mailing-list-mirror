Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAC0201CF
	for <e@80x24.org>; Sat, 20 May 2017 11:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdETLyl (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 07:54:41 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38856 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdETLyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 07:54:40 -0400
Received: by mail-wm0-f49.google.com with SMTP id p134so6411145wmg.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzX/EO/sd+/KYtfVMEZk4AD1LHMDI1Nkd4OczOs79rU=;
        b=ms/L1FGawqNhbVTQ1zBMw75kWnyxIcL59/6jl81AbVnguDryg5MBSjgoyp9llmSwhE
         fHY3SdLZUATSTH2oqzWE/w9ha8hRb3lwOq5d6qnE4N39yo31R7nsMTXRybkUC0gNa4kW
         pnfNiOpV2srd8PGhx4ksFDA2STMpNVLVujKrahW4tvL+NyfoVXdwNKiZGtGLgUpcYJvm
         /uxFqxC/s9CCG7K2V9MFyTS02Xv8/U/rsySRv/5Sn7vlCCvRGqrkM78TlTBgR+aoi7Gf
         lLVsKH6G6haGpATRXeG7XdLuPObqP6Jirpr/fxA4keDzGsrP8KALNwYRAkDJ/YHyYcPh
         RU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzX/EO/sd+/KYtfVMEZk4AD1LHMDI1Nkd4OczOs79rU=;
        b=TWPeUnquFvzzR+NvNgurdeuQUQplXKtCSHqi1rxiSLizgB5cyr2vIusGYrhc1azbaZ
         C/XP+xxlNQcyxip0OU2R8+946ZTZH0qPG8NWtOs6Zj+0x8gyoi8mQ1Rm1JVivDmbxBrw
         KxqsCGzMX3FtxDO9myoq0aEl3i9zVgm8wElNgLuN2RimEk9nHiegadskV4lX/dc8pli/
         s0fftovOtQ3Fyzu/ykS73sw9yS4jDEkb+c5ERXs92GqbR+YtlSCxDlJZo57tNfze6c0o
         VKhXKaKRU/Hnp5m9Ruw7vrKUFjnL6H/TfkY+d6MYLs7ottgXBrzBQ8K1kMWPnDk3mOPv
         ZZSw==
X-Gm-Message-State: AODbwcDN3TG1TNFWnK5wCZQ9XXlOBVfikMHZ3+yG5hAeJMNkq34eJ2F2
        IG90EY6SNwRWFQ==
X-Received: by 10.28.54.206 with SMTP id y75mr8629418wmh.72.1495281278592;
        Sat, 20 May 2017 04:54:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n99sm5887280wrb.62.2017.05.20.04.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 04:54:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
Date:   Sat, 20 May 2017 11:54:27 +0000
Message-Id: <20170520115429.12289-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Replace the forked sha1dc directory with a copy of the upstream code
>> imported as a submodule. This is the exact same code as now exists in
>> the sha1dc/ directory.
>>
>> The initial reason for copy/pasting the code into sha1dc and locally
>> modifying it was that it needed to be altered to work with the git
>> project.
>>
>> The upstream project has accepted my code changes to allow us to use
>> their code as-is, see the preceding commit for details. So import the
>> code as a submodule instead, this will make it easier to keep
>> up-to-date with any upstream fixes or improvements.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  .gitmodules            | 4 ++++
>>  Makefile               | 4 ++--
>>  hash.h                 | 2 +-
>>  sha1collisiondetection | 1 +
>>  4 files changed, 8 insertions(+), 3 deletions(-)
>>  create mode 100644 .gitmodules
>>  create mode 160000 sha1collisiondetection
>
> I am not sure how prepared our .travis.yml is to deal with a
> submodule, I'd prefer to have this step broken down to two step
> process.
>
> That is, [PATCH 2.1/3] first adds an otherwise unused submodule, so
> that people can optionally do "git submodule init && git submodule
> update" so that they can compare the contents of sha1dc/ that has
> been updated by [PATCH 1/3] with the up-to-date upstream.  Then
> [PATCH 2.2/3] would update the Makefile and hash.h to use the code
> in the submodule.
>
> I actually would want to see us proceed even more cautiously---if
> the latter-half, i.e. [PATCH 2.2/3], is arranged so that it uses the
> new sha1collisiondetection/ only when the submodule is initialized
> and populated, and otherwise it uses sha1dc/ as before, I would feel
> a lot safer.  I wouldn't be this paranoid if this "let's start using
> submodule ourselves" were done to some optional corner (like compat/
> or contrib/ somewhere), but this is the default hash function.  I do
> want to have something like this to force us (and submodule folks)
> to get any kinks out, but I do not want to see many people not even
> be able to build while this new arrangement is eased in.  Once
> people are comfortable with the new arrangement to use code from
> submodule, we can then take [PATCH 3/3] to remove the old sha1dc/
> directory and the migration will be complete.

Makes sense to take it slow. Hopefully this addresses your comments. I
dropped the 3rd patch to remove sha1dc/ and the 2nd patch adds
sha1collisiondetection/ as submodule, but it's not used unless you
specify DC_SHA1_SUBMODULE in addition to DC_SHA1.

Both patches should be safe to include & not cause any disruption, but
now those interested in making the submodule experience in git.git
better can init/update & set DC_SHA1_SUBMODULE=Y to play with it.

Note that both patches update to a newer version of the upstream
code. I sent them another pull request with some cleanups, one of
which is to ignore .depends in their .gitignore file.

> I also am not very happy with .gitmodules pointing at a single point
> of failure.  It would be nice if you can arrange a couple of mirrors
> and have a comment in .gitmodules file to tell folks that they can
> use these alternates by insteadOf or some other mechanism.

I liked the suggestion to make the URL a relative path, but this would
require you to maintain a mirror in the same places you push git.git
to, is that something you'd be willing to do?

For now having no-mirror isn't a big issue with my new 2/2 since it'se
something you have to opt-in to with a build flag, which I suspect
only I/Brandon/Stefan & a few others will use.

Ævar Arnfjörð Bjarmason (2):
  sha1dc: update from upstream
  sha1dc: optionally use sha1collisiondetection as a submodule

 .gitmodules            |  4 +++
 Makefile               | 21 +++++++++++-
 hash.h                 |  4 +++
 sha1collisiondetection |  1 +
 sha1dc/sha1.c          | 91 +++++++++++++++++++++++++++++++++-----------------
 sha1dc/sha1.h          | 90 ++++++++++++++++++++++---------------------------
 sha1dc/ubc_check.c     | 13 ++++++--
 sha1dc/ubc_check.h     | 14 ++++++--
 sha1dc_git.c           | 24 +++++++++++++
 sha1dc_git.h           | 19 +++++++++++
 10 files changed, 193 insertions(+), 88 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection
 create mode 100644 sha1dc_git.c
 create mode 100644 sha1dc_git.h

-- 
2.13.0.303.g4ebf302169

