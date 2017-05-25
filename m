Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1776F1FA14
	for <e@80x24.org>; Thu, 25 May 2017 10:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759549AbdEYKry (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 06:47:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34814 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756251AbdEYKrx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 06:47:53 -0400
Received: by mail-it0-f66.google.com with SMTP id d68so22294930ita.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tr5lmXgqp/4PwPB0RZXH+bA+opw64dRt4jk/GX6tnOk=;
        b=FACHktNwYOqRCdkNx7Ic0MbRCCozj1b6tuFVw7AqvOVtdx+cjMb8S/WA/sMhXKMQnC
         /NJikGvQqb99eLV4R/gtXBap1z/PWmkjudKCoNpRlc6dc7gcXpp0i5N/lDwIb4h7LNPv
         aGKY16WQUfuI9DpftpCnw4kmAQpjBZclfyiMZ/GcLWPPPWO5Ea8k1OeUtzYhl0TtONE2
         xMChhsaL2k1++mTLtBZ1zDOKC/6n3nZy+//nHW4H9/PYlNq/AiFrm1lmhwOv1C+WqE7E
         TSHGql8TIKBdH6eOdK6MjovF3afoD7oDomZj2djMOkrUqcx19/yObQrSfwYOQsG2Cmig
         mMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tr5lmXgqp/4PwPB0RZXH+bA+opw64dRt4jk/GX6tnOk=;
        b=n5Qso3OPxeVxzY2xa8B5uPJQVwHS+PfE2pibslAUQwIAQuuK7oZFFWbeq/i11MxbCc
         Zks+Cz7DK/D1v8toHz4A8+GRTBzNWTVM93qgqGFzZT7q+CgTPFsSXoBTC2rrPRj9DLxS
         Lc+JPcre6cIOQXB8su21wQdnYXxz35gvcHT2bmZDtocTs/QvnzI75UcMBMdey60eFu9b
         /9XXZNp9GlVslo9nyS4a3eRGZAmb3phCfNOEK1veQjL3FqhLScsH8M7CP6sz9o0CcUwp
         /INaSAUifeME3G5L7MYCg67rw0jU3wxdNTrwDDaX04LW/fvC4SNobhHmE7bwq+yGIZfl
         ctrw==
X-Gm-Message-State: AODbwcD8EcK5Ug1ech7qSmMrnMHfC9fmwmWr0c7p/5U7tVSXKU9T5pcz
        uDTIviNLaUw/s7nWiDUe5kFwFSKKMjhVP0E=
X-Received: by 10.36.53.79 with SMTP id k76mr12562750ita.71.1495709272291;
 Thu, 25 May 2017 03:47:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 25 May 2017 03:47:31 -0700 (PDT)
In-Reply-To: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
References: <20170518212858.3649-1-avarab@gmail.com> <20170518212858.3649-3-avarab@gmail.com>
 <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 25 May 2017 12:47:31 +0200
Message-ID: <CACBZZX43Mrv_7W_Eoo9YOB1zV832GibNj_T+KjQ8QZQNVYo7nw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sha1dc: use sha1collisiondetection as a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
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
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
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

I've since sent a v2 of this which addresses this by being more
careful, but since then I found these Travis docs that seem to
indicate that cloning the submodule will Just Work:
https://docs.travis-ci.com/user/common-build-problems/#Git-Submodules-are-n=
ot-updated-correctly
