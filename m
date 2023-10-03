Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8BE8FDAF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbjJCUPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:15:44 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8881AC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696364138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIZhcfd4gn/CtmBci+Y1xiX+0Uak/VV2eNOV6iojaQc=;
        b=fjOqmTjDVCB/F276hBKZNKEN8RtItFEAZMosi4S95CO2zAAezLPzbqv6cMvFIn1MHU/s89
        ftWvm5jVPimueo3sFLhDAWIKFhXYtq0r5qJzhCbTAECvVYnqxh29QRPwh7jvcqZ+AZiVtO
        LxCC0whZojDhEZwfAJs675aqju7kuNI3gYsT6blxBnq12vQ0m97OGUJ1FBW4xTDhnwGePG
        jb399KFWxVrDQMqRUigOOb0/nEgXKG4rmPyOo+gZNBW/eG7vwx0rjDinfoRTvZT6Y4hEsV
        QFEtqzwulb7KMDuCAfcP+FWzgVlqLcJLHheY/QgYqm5TsLYQ2Fksw8ptMRO1yw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id ad4f80ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 22:15:38 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] git-jump: admit to passing merge mode args to ls-files
In-Reply-To: <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 3 Oct 2023 14:33:39 -0400")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <20231003082107.3002173-3-stepnem@smrk.net>
        <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Tue, 03 Oct 2023 22:15:37 +0200
Message-ID: <20231003221537+0200.850949-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Oct 2023 14:33:39 -0400
Eric Sunshine wrote:

> On Tue, Oct 3, 2023 at 4:28=E2=80=AFAM =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <=
stepnem@smrk.net> wrote:
>> There's even an example of such usage in the README.
>>
>> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
>> ---
>> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
>> @@ -9,7 +9,7 @@ The <mode> parameter is one of:
>>
>>  diff: elements are diff hunks. Arguments are given to diff.
>>
>> -merge: elements are merge conflicts. Arguments are ignored.
>> +merge: elements are merge conflicts. Arguments are given to ls-files -u.
>
> Should "ls-files -u" be formatted with backticks?
>
>     Arguments are passed to `git ls-files -u`.

My preference is against this (I don't like markup in plain-text files),
although, unlike the contrib README case in 1/5, here there _are_ some
pre-existing backquotes; but the usage is inconsistent.  If we want to
unify one way or the other, I'd leave that for another patch, in any
case.

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n
