Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1673920A04
	for <e@80x24.org>; Sat, 15 Apr 2017 01:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdDOBhc (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 21:37:32 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33401 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdDOBha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 21:37:30 -0400
Received: by mail-lf0-f54.google.com with SMTP id 88so310721lfr.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k8X32O+4BfvrzA5aCVx/WWTdeg9oUQtVHfUOQvWZofU=;
        b=UYddsMPBCI11SWN/iUmjrXG6L9Tmhs2g97MTHjUyxBTGxXhWqSLYHashPcGo/lxJm+
         DgrhwxOJpi9sdah0ghdbhkAgcS1q5n8MuB+aFXGLXXeMGgw+Z85xTrqXjMiBTFkQChmm
         YIUYkpfPJq5XzQ3zbYuiKQuJVFU+4vTcfQmBp43NDJW5UyrPmiYOV7JSB3nXyW07pbMD
         V45mTFtIyZI7U5fvUhwGiGCbzoDy+ESrIBUlt2MyFD73dztbW/wwjW0Lez9FO+men7s5
         /WLwpXFR15gu87TPVGoS9GdsUt3RULOsnI8WysIyY0Qui55wfZsO2TxF5hwn0pf6zIhL
         63xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k8X32O+4BfvrzA5aCVx/WWTdeg9oUQtVHfUOQvWZofU=;
        b=UeN53QIw0Vo7aNPZrynmLGT7mkO5u3qLt1jB1dmywqfMYkN4VCtRIrsZxk6eBE/MMh
         oJEsA3VNDSghzpfqrh2zeSIrXkKvyyw77qJyZrRt93zZsBuRR5qcGNckMj8pNXw2PAho
         g9ORCMr93xZ7JXRGMr8Z5BxRQGWXyQ+YElFX+UfXfSKHDtOP/zyLGmOeUttddGggBV3n
         kMjbAJrqIGIRaB6I+tovfSDi+8cRSTv6PO5BmciaO7ofPNAadDxnYT3SZfjMbLTnF6AE
         Ae30sLLbVxVDGOpFUFxsBmPIidw+8mjn9r3Y3odbWY10EltI4lQZaOldvg/XhgZ8fGQS
         8BsA==
X-Gm-Message-State: AN3rC/7YvVDVYuKOZJ987RqP9AC52XN3DNFd+7yFRYe73z2/LJMaGSpZ
        jUZNtgvo5ykh9ngyiuzPD2A5QICbxw==
X-Received: by 10.25.196.133 with SMTP id u127mr139209lff.88.1492220248909;
 Fri, 14 Apr 2017 18:37:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Fri, 14 Apr 2017 18:37:08 -0700 (PDT)
In-Reply-To: <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
 <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com> <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Apr 2017 18:37:08 -0700
Message-ID: <CA+P7+xoBYApdmucEpdxT8qHJ0HP5RR2gOkStykd5Fq=8qsZxZQ@mail.gmail.com>
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 3:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Apr 15, 2017 at 12:08 AM, Carlos Pita <carlosjosepita@gmail.com> =
wrote:
>> This is much faster (below 0.1s):
>>
>> __git_index_files ()
>> {
>>     local dir=3D"$(__gitdir)" root=3D"${2-.}" file;
>>     if [ -d "$dir" ]; then
>>         __git_ls_files_helper "$root" "$1" | \
>>             sed -r 's@/.*@@' | uniq | sort | uniq
>>     fi
>> }
>>
>> time __git_index_files
>>
>> real    0m0.075s
>> user    0m0.083s
>> sys    0m0.010s
>>
>> Most of the improvement is due to the simpler, non-grouping, regex.
>> Since I expect most of the common prefixes to arrive consecutively,
>> running uniq before sort also improves things a bit. I'm not removing
>> leading double quotes anymore (this isn't being done by the current
>> version, anyway) but this doesn't seem to hurt.
>>
>> Despite the dependence on sed this is ten times faster than the
>> original, maybe an option to enable fast index completion or something
>> like that might be desirable.
>>
>> Best regards
>
> It's fine to depend on sed, these shell-scripts are POSIX compatible,
> and so is sed, we use sed in a lot of the built-in shellscripts.
>
> I think you should submit this as a patch, see Documentation/SubmittingPa=
tches.

Yea it should be fine to use sed.

Thanks,
Jake
