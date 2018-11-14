Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A221F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeKNKsj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:48:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32847 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNKsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:48:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so15374294wrr.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ueTfRsKn/sFusWbqZPAWrpNjvu+S/22EXuHF3FjdAhw=;
        b=A9m7igZtKVreK0tsvmIWQBZ54JQYTIrqiiLN+mbtaKAeTFwJ8A0fcIeEm+tvRKjaZ3
         ZPt/wciFsmRmvAiw/YWzERmdx7zlaBlB3sVFYbtlb2SWKoY15Zqpbp7/gjoGWEnziJzb
         hUKR8LUiHGz4Qv6vXpL32QvAKDViCr14RY9980XOSZXIvewGSQNQmIOeoSlPPM13fIzr
         ttmkwkdc8Rlq3LGcBrWZJ+We96sYTu2ylSksaSmThv+7xdSKknulMv27Jp3ZOPVJ43j+
         ZT6yP2yX9iEwRD9XbelzayweK23q9bXoeJr5bzipFmJXAUgKQFUrxNxTrcZmr7kLyt3X
         oTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ueTfRsKn/sFusWbqZPAWrpNjvu+S/22EXuHF3FjdAhw=;
        b=S2BFgCZbEoM9jY3yQejtWBA2v1jlRPm/aNOCshj4n+3I6aZhJrLUD+l7cLLhNKqxEB
         fSk2riHUWNVGpgr8fI4Tmb2zMrdqzflGJFfmw30cG/ohpShQvT7i15ch4+tTy3sLtyLF
         eSWDfk+Jf8J7T6adREdNe5eybV0Nk65nzbai6/DbMo6HliWq4sg/+HGWWtd3WWet80oy
         4fnKwaCf1elwq778cy/zZuWkw4fpwpNIb0S/q8yd+C1HIq3RjwSAsI9fZLsZbJLyEaGd
         k4DeDo79pVNrAvrfftVLtkHM+LkRxVNpQd+5KeH8GvWAW2PLUiGdxPZdmA6iTrYr7F8V
         xkJQ==
X-Gm-Message-State: AGRZ1gJlvlwjAC6MgpSNrCPdkRfTVMjpIgghZC9doFE596LbR/zwHOBd
        x/rG29zyGkPLoIffLl0ZS1ViMywZ
X-Google-Smtp-Source: AJdET5e43GCpzl/mtXPg/VZ/ZIj+B30ucdRK0IOWO0e5EJ4q/ueUPBJ1R+4pS8L9I6Ik7vfHxnT7Kg==
X-Received: by 2002:adf:c084:: with SMTP id d4-v6mr7014275wrf.268.1542156468433;
        Tue, 13 Nov 2018 16:47:48 -0800 (PST)
Received: from szeder.dev (x4db2a36c.dyn.telefonica.de. [77.178.163.108])
        by smtp.gmail.com with ESMTPSA id e10-v6sm27267568wrp.56.2018.11.13.16.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 16:47:47 -0800 (PST)
Date:   Wed, 14 Nov 2018 01:47:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181114004745.GH30222@szeder.dev>
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <20181113182802.GG30222@szeder.dev>
 <20181113230347.GH126896@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113230347.GH126896@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 03:03:47PM -0800, Josh Steadmon wrote:
> > > +		for (int i = 1; i < nr_allowed_versions; i++)
> > 
> > We don't do C99 yet, thus the declaration of a loop variable like this
> > is not allowed and triggers compiler errors.

> Sorry about that. Will fix in v4. Out of curiousity, do you have a
> config.mak snippet that will make these into errors? I played around
> with adding combinations of -ansi, -std=c89, and -pedantic to CFLAGS,
> but I couldn't get anything that detect the problem without also
> breaking on other parts of the build.

Unfortunately, I don't have such an universal CFLAGS.

With gcc-4.8 the default CFLAGS is sufficient:

  $ make V=1 CC=gcc-4.8 protocol.o
  gcc-4.8 -o protocol.o -c -MF ./.depend/protocol.o.d -MQ protocol.o -MMD -MP  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  protocol.c
  protocol.c: In function ‘get_client_protocol_version_advertisement’:
  protocol.c:112:3: error: ‘for’ loop initial declarations are only allowed in C99 mode
     for (int i = 1; i < nr_allowed_versions; i++)
     ^
  < ... snip ... >

I couldn't get this error with any newer GCC or Clang, and using
options like -std=c89 trigger many other errors as well, just like you
mentioned.


