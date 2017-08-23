Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B6020899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932420AbdHWR3L (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:29:11 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33054 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbdHWR3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:29:11 -0400
Received: by mail-yw0-f182.google.com with SMTP id h127so4893276ywf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hlKELBOuf/162GH0M0++lf6bmNBAEXfaJNlLAd8M7Ag=;
        b=QTlzLYZQXFsLhQegTUFGrhAyBYuH4TcwVmgOBEGk0LspCCjorRlpBvCFNjtdbuSIW2
         MgicBMisF6/aYdP34GyGrbOHtYIpChMWf9UOC1vdQ2+fdDDSYsqEciqDFmJDPmy/UPly
         k41+AeJ9yxcbMPeishGicjWinXkMbB1GX+lZsjgUWM25x1kRUMqQDcs8BWXvChxvAsTi
         /kSo044vKSzW60+jm83RcU6lwoiQ7C3hvjP9cQeUEvPtLIcPBcYhZwYrIK5mXfLkQ2RV
         Q9udbj3cE+sTAMkSxpApOl5lgOH27Qlhz//VpPfhsM3V42VSSWgIPyPKK+7vembaq002
         q8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hlKELBOuf/162GH0M0++lf6bmNBAEXfaJNlLAd8M7Ag=;
        b=fYas6Ql2ht+EaIVEI6WpIPnqHbRXks4OjxsTnwcSL88vKDZ0KQ7Ze5kr0cbOqTHRgj
         o2QKqJ2zNgohwba2yyj875PKK57h3SkeQN5PaB4FPTXQgfHdbfL2byR4VeJcJiya9yAM
         Cf+c4vGg6N8pLtb+Qtigj6t3EGU8C7walIm7uYddGgRQYNtVXWUJMGnDi6ey9Xi4H9+1
         de9+jP3Y9vyZvaiZXp4NVI76aTAONJOeGnDoPdquSI/H+/ciyjmzdxttMuBXGXc06RP9
         c6ymuRsOsTH5UD+s+q7er0YpR0W/oIEp4mvYvOP/MSJR4Vpeoa4R28RcgeFxoj+orgKw
         4mMw==
X-Gm-Message-State: AHYfb5gEI3NhPR2ZM+Gq4P2uiQYRoKK7Rjbrtjz0LrmCgdvbnMHPyLT3
        lKZslHfsczWoxnesubbwSLIk6dPVKjEt
X-Google-Smtp-Source: ADKCNb43mLaqOlOKc5lIGu9foClEkMB13GS2GZdxb1s7DnKjTywnnYra6Lx6d4+zeCwsuZUX2f1LG7dP6one+nV+jvg=
X-Received: by 10.129.31.215 with SMTP id f206mr2648018ywf.29.1503509350111;
 Wed, 23 Aug 2017 10:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 10:29:09 -0700 (PDT)
In-Reply-To: <ece1018b-98b1-e9b7-546a-d7c68dacfbb7@gmx.net>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
 <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net> <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
 <ece1018b-98b1-e9b7-546a-d7c68dacfbb7@gmx.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 10:29:09 -0700
Message-ID: <CAGZ79ka-SS8ZyZkp6d=0iNtTtQgh2cAhzJSt4m22F88vb1rbhw@mail.gmail.com>
Subject: Re: [BUG] rebase -i with only empty commits
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 8:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 08/23/2017 04:40 PM, Johannes Schindelin wrote:
>> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
>> you want to do that, too?
>
> That's a very valuable hint, thank you very much!

While -k side steps the original problem, it seems like it would
have helped me, too.

Is there any value in discussing turning it on by default?
