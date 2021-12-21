Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE9EC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhLUHaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLUHaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 02:30:15 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8693C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 23:30:15 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f186so36209823ybg.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 23:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/442UP/uhG4YqjAlzKUjCVuwIvrOE3KB0QUlzFwVBM=;
        b=O5usYi65M/mYBuJATtbqb6GVYalQOO4XTFJw2qfuy9M1s3OAjZMkOt8ozsmM3NjRvV
         16oGnI1HBMfSKMrnmXB3pSBWe2i/f0VDQAUjYVnOd7eCf+jyOZpL2CfWeU21CrORUEcY
         LwoN2gx4V3SkEanSiPenBpOkzTBUZ8aZ/sOTkjqOyXbzwZbI1iP8mUHiZbJhebxde4xy
         UPohTY0a1w0Ru+MSlzlup8l8dCBgIET48d+3YdyLBZOqTV7HToAGuzOiWfp4lRP5asNW
         3LKDK73FR2folKCGb42rjiXWuohZcSqRjyoZbIDi56WYQrc7NUqkFFHdaNibiUN0j4Bm
         iNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/442UP/uhG4YqjAlzKUjCVuwIvrOE3KB0QUlzFwVBM=;
        b=xPS/hVEtoiGw304zax6QDQmKxdeBW4BBzx3hXghZejUQadw0GRd2HCsVuFZgaFPsmH
         lM5ATWmgOjOrgTi7guHxgF4Y+Mwf9Z7pAVlNYo5/YF/vsX82Z3giZJ49JzShJMObutg3
         kOnXIPCBSWE2wOH1WHejFWet1k9g5U9qY6zztnyjpEh2Sdpjlnh5TkR6E7H8c8O7v0+P
         3mmTk++TLjvrCMa9/Ym2fd5knovxvwO6jR7G4tEgmv4SQreS+fjFbY3/JpeQNPUmy6sY
         mGtFWeG0EM+L7D+CnPAXYK0XYn3Sn9/uv2qiXnpvq8K2KxllXIviONuLPORMUOS8WFI3
         mxbg==
X-Gm-Message-State: AOAM531f68s/SIWpH0LI13QBVr8+8JoYTf26S3E+LloVA6xOYC1f2JD9
        xDbmr+/HPqrQOSSROlvGIk++46jswB0r6gn7n3rK2Fs0
X-Google-Smtp-Source: ABdhPJwVBGGLFQE4bqTyA9mN+vySPTekOfqhZIs0mmzBSLEoKO2Er2gh5dBP8FgV19rk5/FY5oxrVBy9Q7hE2LbhEYQ=
X-Received: by 2002:a25:d248:: with SMTP id j69mr2621661ybg.693.1640071814823;
 Mon, 20 Dec 2021 23:30:14 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8rwlz3cq.fsf@gitster.g> <1e9d0913.2b.17ddaa010fb.Coremail.pwxu@coremail.cn>
In-Reply-To: <1e9d0913.2b.17ddaa010fb.Coremail.pwxu@coremail.cn>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Dec 2021 08:30:03 +0100
Message-ID: <CAP8UFD1MtQVk6YwocLxPqdAh4XrGKN8kuQO6pYqf-W4NoTXzXg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #04; Wed, 15)
To:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 8:14 AM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@cor=
email.cn> wrote:
>
> > * xw/am-empty (2021-12-07) 3 commits
>
> The alias of my name should be "pwxu" but not "xw".

This isn't an alias. These are the initials of the first and last
name, so only 2 ascii characters.

Maybe "px" or something else are better initials though. Your
suggestions are welcome!
