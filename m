Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515EC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 22:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbiDNWae (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiDNWad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 18:30:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE022C3353
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 15:28:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi26so11459778lfb.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4nJjGi4ldSjeyhdg8mK5TKr5cu/QnTyeqggoOkHFSQ=;
        b=L+04Ym6RIim+QuPXpEL/Bs+oFaWNdifKzPUx3S99LhGuCjuSOKpzu+Z1NU9y6ONuLU
         ti9pnaDUAC2vgTCCUgbqb4fAEZnp6vllp9Ia65rk7FcVig4F7r/x8ZZeo3ocX2hYdLyX
         1BEhbyRBTQe+l4O52fuDAjl7lhvcEpKCYBPSI4iRgMLpqs5DYzScpDk1/bgrufG3ae8B
         L2WQePjFyQmB92ZBu3smCsc6Wg8MPiKoc0eB6gI7ad1sdKiASRrO/6O8HPiuWymiYCiF
         xurpkTBbk3SCu+xhUDsta0mmPoTDYqA9Kw3KmGB9hlcexBY6+/pXtlmOmkV/pPc8B3zf
         mIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4nJjGi4ldSjeyhdg8mK5TKr5cu/QnTyeqggoOkHFSQ=;
        b=cw1uOjpzeTBs0JVTR/oJdkodllFhGMnZO3+LC3PrXUD2lD9HC3sNZmcskBMCUDxBzr
         zA28DkLKxNm/yGisjLnDTCshaktLf84VBIrPDKbr11WnHFzNpgRrl7HvyCa+EimxXLxv
         HSkU6ajI+K++TZPEzJvW1UxGrUrWG4vEyuf4+pGgWS0PrQrY+2sNE4wUt5c4cCe+esDZ
         DjqkPeXfGllkFP10TapmqT1ExKVCqb04WfyCpmWEdwEHzzWnAtJFc2G2aYognnrQp5NP
         +91vC3ok2Tt+TnA60ftyVTzZ+ZHHPWLtXSoZGu9mF4CxDlUXs6vZd4WRa/bvNsVb4D15
         /ZCQ==
X-Gm-Message-State: AOAM533ed7Ym1oa1cD1eqhi20uNrvd+6iigYr/JxqVrOPx4aCV6ZT55D
        1Rh4fepw9XCKoHRXu6h3aTK1UoLLeZ2zRiyv7RFmJcKlZK0=
X-Google-Smtp-Source: ABdhPJwMrB9ob2k1lNlrwfKHzzczILnMb0ACqJgd0PGq00h4WK8+lu+EXMkr4ZUlKnSp4mWqkHELnmA5JYT3u1CSKII=
X-Received: by 2002:a05:6512:12c3:b0:44a:27c2:b0a2 with SMTP id
 p3-20020a05651212c300b0044a27c2b0a2mr3201636lfg.325.1649975284860; Thu, 14
 Apr 2022 15:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
In-Reply-To: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 14 Apr 2022 15:27:53 -0700
Message-ID: <CAJoAoZkqz=jy94fm8E7aaMWO_qCannOiVJCYMft3K5O=fX=2GA@mail.gmail.com>
Subject: Re: Git user experience workshop
To:     Jorawar Singh <jorawarsingh12@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 3:18 AM Jorawar Singh <jorawarsingh12@gmail.com> wrote:
> Anytime between mid-April to April-end.

FYI - I spoke with Alice today and we decided to add a few more dates
in early May to give us a little more room; I think trying to have the
workshop next week would be too short of notice for Alice to prep.
Folks who already filled the spreadsheet may want to update responses;
anybody who's interested in participating but haven't filled out the
spreadsheet yet, please do so!

Thanks very much Jorawar for your help putting the sheet together!

 - Emily
