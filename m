Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB2E20188
	for <e@80x24.org>; Thu, 11 May 2017 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbdEKAAf (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 20:00:35 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35075 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbdEKAAe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 20:00:34 -0400
Received: by mail-io0-f173.google.com with SMTP id f102so11782816ioi.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 17:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DGu7yMbwuPFsVnXFy7pkYzhbBbN4Zk8dbivnx/6Lg6A=;
        b=pXoPJBHoTo4ynjoUbUUszYpyA8j5ACAyBcK9lIs10EpivnslCKorb9zDIPa62cl2pM
         y5DOcH79Gv9xoH2Et5+v4HqXUP33qS6+gUgxuS+zd4XEQez+xRFh7o2hqyDoQzN05Q09
         5CmGQUa5bYTsAUfRuzRnCXkEK/skAp/JDcdqQ8dIkK7/MlAec1JvAe0Z//nD47W0QyWA
         89yuaKAAb5oLFv3koB2yrj60pvlNZG3gAI4JgqP/SrxS7iWUHf70pUAw8X4coleFveRw
         fgbOFqmBkYolmL4ueZ9CBs5hEib3XQXj6+fOr21Fo4FZfFDDAE6z8BMCrs8FU11egbxI
         C7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DGu7yMbwuPFsVnXFy7pkYzhbBbN4Zk8dbivnx/6Lg6A=;
        b=hyV12sfi3rvIaZQoTg1TU4NHpQrPEDEVhCIsnyno07gAYFJtvO8oionLAqGjabPyI3
         m4kc6VS7+jElv+v0s2DoebPOSDgN6/kXzrcfVlbK0El1OgA2il9ALiVnlbzg+/wdVSSL
         /eKXUJvgKRmWQjmNkYYQ/g0kzcCjt4AIOF5+Lpu7qGBDp7JvCurZM8t4mTS6UB7QtwN9
         mAjAKDJtO4hWRmI+HsckA/XtAr5dK/EHanQF22zuxG6By7dDe+TNBCMjEsaejjIeJeeW
         U1ZFm99yMUJFY7aI0BgbCwACqFL9GySvHDWhKW2YNSSSf1F4Syiw4xE8VACMLz7QlVar
         jHig==
X-Gm-Message-State: AODbwcD8/YheBjjYccsHgynpHrzMN3yMSK+KqRrc5KY6iO2Vxks+7D8C
        vTGkgM1YZ3Sxz2M1QI2Q5mgs75+mwOYU
X-Received: by 10.107.138.21 with SMTP id m21mr6017616iod.80.1494460833326;
 Wed, 10 May 2017 17:00:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 17:00:12 -0700 (PDT)
In-Reply-To: <20170510233032.GD28740@aiede.svl.corp.google.com>
References: <20170510225316.31680-1-avarab@gmail.com> <20170510225316.31680-2-avarab@gmail.com>
 <20170510233032.GD28740@aiede.svl.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 02:00:12 +0200
Message-ID: <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: add function to setup a fresh test repo
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 1:30 AM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> Hi,
>
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
> [...]
>>  # call at least one of these to establish an appropriately-sized reposi=
tory
>> +test_perf_fresh_repo () {
>> +     repo=3D"${1:-$TRASH_DIRECTORY}"
>> +     "$MODERN_GIT" init -q "$repo" &&
>> +     cd "$repo" &&
>> +     test_perf_do_repo_symlink_config_
>> +}
>
> Unlike the other two variants, wouldn't this leave the cwd inside the
> new repo?
>
> In other words, I wonder if the commands starting with the 'cd' should
> be in a subshell.
>
> Thanks and hope that helps,

Yup, I'll fix that. Thanks for the review & also on the other patch.
Will send a v3 with these issues fixed.
