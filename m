Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71C91F404
	for <e@80x24.org>; Sat, 13 Jan 2018 17:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeAMR0B (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 12:26:01 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37795 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAMR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 12:26:00 -0500
Received: by mail-qk0-f170.google.com with SMTP id y80so5851214qkb.4
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1oJcXRGCRptwfx/yP+pJ45H9ytspmuwD5Aqehc4LQdU=;
        b=kpAKrQ4gT/sI2t3+W8slc+f4k+RhypChgpLVs7EMsZAxA8c6wAuK6Eo510DyhAfpcf
         txiIAtd8khRnvZhczRvDFTuVeal6M0e+D4L2nbblNHQRX/9jGauQvpWC3QnO6GlhuQPs
         4OzrP102ihiZdQ+TtGC1HpDF4zCnIB2T1ccOU/ZXDbV4Amr7VnKcxN2SQEHWt9rX5oCT
         8xdAtsizEkeK8N3cVTFPMfwFlLDi17eNuul9VScGFIMXko7KKriOkIsGGyILZjLBr33o
         YcTfHzFh8MD9jrzQ95XYo9pYwz6nTN8zQTaraQXU64coW5sKqC1mMNPTde314HKTuW2A
         4QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1oJcXRGCRptwfx/yP+pJ45H9ytspmuwD5Aqehc4LQdU=;
        b=SV3iSix9sbmaFnIgUkZstlXeHB5O30RVvQzDT8D75iqd2NlUSrTjFFwIksWknHQUM4
         YspuApPfXePfxrqSscAAbvtucfv8z7xd/8WktmwAR/3DijY5eOdOWGwunbFTSYi4YJ0D
         YtGKQa//hD7j7Bc3sLOALhKOkZYy2KrgILYg//Cj38oPAKyKTvVAYOK67Hai/FPOw6GD
         UikZWg5tUabzLgzuza0Je1850NpvWzmkuhYpFxMhF9+ErJEeA9J9kpR6mtj9I5l3FJlC
         CxunnUPf3gk5zoNvdaByWlEu9ZVPqWdLRRcKlCdqW+wAwCjmKymClt94fBm6NXRhHMYr
         M0ug==
X-Gm-Message-State: AKwxytego4b7wvrXfsjwyQKoIaUAXp225t584ILWu5qK2ym0H2E0rMHV
        8VzxhvXUw0b3R3huEBJgy1/4/2ZT
X-Google-Smtp-Source: ACJfBosT/EHNxqTjmudM1VpuzqLjePEHQ9zRXodK39slYkGonddX98oOyfcVwlnH2WNYIaRPgah/Hw==
X-Received: by 10.55.99.143 with SMTP id x137mr16344888qkb.90.1515864359281;
        Sat, 13 Jan 2018 09:25:59 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id d7sm15438537qtc.13.2018.01.13.09.25.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 Jan 2018 09:25:57 -0800 (PST)
Date:   Sat, 13 Jan 2018 12:25:55 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Andrzej =?utf-8?B?T8WbbWlhxYJvd3NraQ==?= <me@osmialowski.net>
Cc:     git@vger.kernel.org
Subject: Re: Git uses wrong subkey for signing commits with GPG key
Message-ID: <20180113172555.GS29313@zaya.teonanacatl.net>
References: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
 <20180113002221.GQ29313@zaya.teonanacatl.net>
 <CAHLNBdUTWTbvkLdqbvB-1vs=oPJOHP5S3CWMZbtCgBnJNh4hRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLNBdUTWTbvkLdqbvB-1vs=oPJOHP5S3CWMZbtCgBnJNh4hRQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Ośmiałowski wrote:
> On Sat, Jan 13, 2018 at 1:22 AM, Todd Zullinger <tmz@pobox.com> wrote:
>> I could be wrong, but I think you need to append '!' to
>> KEYID to force gpg to use that specific signing subkey.
[...]
> thanks for reply. You just solved my issue. I will prepare a PR to the
> docs to add relevant information.

Glad it helped.  The git-tag documentation points to
git-config and the user.signingKey variable in the
CONFIGURATION section.  The git-config documentation for
that variable currently says:

    If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
    key you want it to automatically when creating a signed tag or
    commit, you can override the default selection with this variable.
    This option is passed unchanged to gpg's --local-user parameter,
    so you may specify a key using any method that gpg supports.

Whether that can be improved without being too verbose (or
duplicating too much of the gpg documentation), I don't
know.

Maybe it could point to the gpg documentation, though that
can be in gpg(1), gpg1(1), or gpg2(1), depending on how
their system installs gpg.

The online link covering the many formats that gpg accepts
for the --local-user (-u) option is:

    https://www.gnupg.org/documentation/manuals/gnupg/Specify-a-User-ID.html

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It is impossible to enjoy idling thoroughly unless one has plenty of
work to do.
    -- Jerome K. Jerome

