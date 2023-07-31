Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8166C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 17:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGaR4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGaR4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 13:56:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0023E5C
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:56:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1525a12.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690826207; x=1691431007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCtx4cIc+CUfk0nI/MFL8VnB3GUrbt4WYXBmZowQKIg=;
        b=LzAO7QMltNXo3fzfI7A5pk6ywPbsbIpwPcVHzE/0JcayCFtXgZQpHS9wtgBfndK42r
         Dc5+gd+x9CTN5XhWhujMeGZrkVVKt4n3410z28JMairILUlTnFR0kkkDxWlJeMNTvq6k
         dLEvUrHICnBEMnP/o4XvBy/n6A2Sp+CLIdruWWFn8yk58WvXb3o+Va9ftVbWqyh6Txwu
         PuNEcbAkZnwm4Wtcayfkf0B98HO1EayeAkdH9VoTakXoFVX/IDTNXjJrWxbrpr1JETY2
         B7SxYr6xoAFu5EDBZWjxT4Udf/DwbTEmkUe2Cir6+lA9DyeSqT/VX/E3jr5JWwRZ30Nu
         EUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690826207; x=1691431007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCtx4cIc+CUfk0nI/MFL8VnB3GUrbt4WYXBmZowQKIg=;
        b=CxZ7xFSua20MgMRqP9GTVcrF6WH9+K7Z5mo+bZD8iZJ1R4DAsOdhBvT7EPO/g2qIRc
         XeTrXtNvCu4EuhP+SaHHUo6PBegdB+Ym31ju7KYz4ccxbvxclhW/V0yUpJaWWoGmcldY
         sfK6Mld5yDR3IbLp07zwa+1erZ+1ZRC8YYGlv2DO1bo40YdLm/vYwl6BlNuG1aYnnBiM
         1tp8aIWgpM7sBsf80CANGE9k1Xrc7dHg+ft2rf7F1fIiFLXjxHhXCKnVk8iDwkSbHRvl
         21zuRjkzlAO36wSdL08pji4KnuzH98aodd+jYv1GgvmfAhOc1aMKhLH+Bgmd0BC+XpOq
         gWjQ==
X-Gm-Message-State: ABy/qLZqoDDq7QgfVHUpmocIqyKld1r0bxsTiC5sqtWGrpN+4snMYGUr
        okbtyPdbRWN1TpA3TotSDr7JyK938q8jhUL43NENyVtaBF6EEvTCsvbMmg==
X-Google-Smtp-Source: APBJJlEYjI6NTWDXg51sgm4wpWqtw8aGOP+OMvbroZSx515WibWt9hCocaEWPMl7iqXJxEEydEh/GMf//gmBVyeqLsw=
X-Received: by 2002:a50:9f61:0:b0:51e:54d5:50c0 with SMTP id
 b88-20020a509f61000000b0051e54d550c0mr212146edf.1.1690826206624; Mon, 31 Jul
 2023 10:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZMATKIaU1A1D0wJg@nand.local> <ZMFfRiTSXcrkzdAJ@nand.local>
In-Reply-To: <ZMFfRiTSXcrkzdAJ@nand.local>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Mon, 31 Jul 2023 10:56:35 -0700
Message-ID: <CAJoAoZkNRa+WREeXsr6fi-wxk_67mY+RL6WWsViwoPvyCbc5ZQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2023
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 11:00=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
> >   http://bit.ly/git-contributors-summit-2023

Since it's virtual this year, my team is considering hosting a "watch
party" in Silicon Valley, to get at least a few folks to be able to
meet face to face, even though we can't travel. Basically, we'd book a
conference room at some Google office, invite local contributors to
come along, and dial into the summit from that room - nothing fancy,
no extra programming, maybe catering. Before we make any solid plans
it would help to know how many people would be interested in such a
thing. If you're already planning to attend the summit and would be
interested in attending such a thing, could you direct-reply and let
me know?

Thanks,
 - Emily
