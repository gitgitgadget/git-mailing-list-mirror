Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0D81F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBWWgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:36:40 -0500
Received: from mail-yb0-f175.google.com ([209.85.213.175]:45628 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBWWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:36:39 -0500
Received: by mail-yb0-f175.google.com with SMTP id y190-v6so3436005yba.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZTohHzJv7R2Plahg4ywd3G6j0lZGY3r4eDTxbhVfTSA=;
        b=jliVXQcu6t+n+WcrNDvfifSo8TgKaDB/8vhAM0d8k/aIYRcQa6meLAHEpQpCqkZIiu
         gf1LHfTcTnZAtHU4+BV7sZx/sOo9ce03RBfQnECsNtbvcTjSMV1QXfKqO/IjKsLVsH8j
         RnV2BGN3XIlrh2VEwvOGydDzRGpobi+WOXBIx/6yZ8Te7bkWnu+nxWK6+4rLCB1f7QdN
         T7PtKN6XFb3Zf6/OyosiopkqO5JdHw4LtFAe0Siw78Lcj731FjLtDMDTum4Xqyhp6NIk
         7xIrhp2nVpfV79kA37h/ZFCHA7ZDKLaahyEihVdtjRWcorj7MgmlK9OZr+LJ8tH3IK+3
         bhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZTohHzJv7R2Plahg4ywd3G6j0lZGY3r4eDTxbhVfTSA=;
        b=h5fqGrFjzD3SFUiarsUHBIQjyHRlyPpynLCOUzN/RDkW7gIXaNEk2bwfI2Dl1dXHu1
         par5GpEjiGo28Rxl+PiQDhRTGPKPQO5VHXEg0fbElKdeR70/KLRA4XYkr/QNR2CyWKny
         N3m/GJq9DGgllnrSJS6kBD5bkDGHIJdlYsiTN0O08j8fuyEOmzx75YegtDrSUa3JSzeE
         hOrj9OIayc2DoVvM0Wb5XV68gSTAzcKU4yPadclpPKDSLPYd8nCLxeqngVbfP73G7aQr
         UGEXsEuBRXh85lka9LDd49rBbrP2Aq5Oy+PV3j6EbFZcJxfNCEXXs502BYwyPEW26jh5
         dGzA==
X-Gm-Message-State: APf1xPAyQc7umL3Bss+4LKNZK0CeHhCiWJv/SR1LPbJW4pqDOtnQcj8Q
        6VOi7syQ7tvuU7kmTarerY9i2X+istcPXZPC3Jbf72yl
X-Google-Smtp-Source: AG47ELt9drDK30yZ2QKl2H/qQYl32ducJ6Cv3tpCKnMyH8cyuR5kOIeMgb3zengd2wta8yUGGEczeunTd5/xQ3vw874=
X-Received: by 2002:a25:7d42:: with SMTP id y63-v6mr2334543ybc.307.1519425398753;
 Fri, 23 Feb 2018 14:36:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 14:36:38
 -0800 (PST)
In-Reply-To: <20180222005149.GH127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-17-sbeller@google.com> <20180222005149.GH127348@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 14:36:38 -0800
Message-ID: <CAGZ79kZess5QJL1RuV+qmUYtLoY0q0EJkvRF1rZPWeScFcRz_w@mail.gmail.com>
Subject: Re: [PATCH 16/27] sha1_file: add repository argument to sha1_file_name
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 4:51 PM, Brandon Williams <bmwill@google.com> wrote:
> On 02/20, Stefan Beller wrote:
>> Add a repository argument to allow sha1_file_name callers to be more
>> specific about which repository to handle. This is a small mechanical
>> change; it doesn't change the implementation to handle repositories
>> other than the_repository yet.
>>
>> As with the previous commits, use a macro to catch callers passing a
>> repository other than the_repository at compile time.
>>
>> While at it, move the declaration to object-store.h, where it should
>> be easier to find.
>
> Seems like we may want to make a sha1-file.h or an oid-file.h or
> something like that at some point as that seems like a better place for
> the function than in the object-store.h file?

It depends what our long term goal is.
Do we want header and source file name to match for each function?
Or do we want a coarser set of headers, such that we have a broad
object-store.h, but that is implemented in sha1_file.c, packfile.c
for the parts of the raw_objectstore and other .c files for the higher
levels of the object store?

For now I'd just keep it in object-store.h as moving out just a couple
functions seems less consistent?

Stefan
