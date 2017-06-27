Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A63207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 03:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdF0DRZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 23:17:25 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34323 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdF0DRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 23:17:24 -0400
Received: by mail-yb0-f171.google.com with SMTP id e201so5806392ybb.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 20:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yb07SrwJ6+AFQwMLE5kmVtICB6iwDbTXZDBbHHHYRP0=;
        b=iBXd9ExH8rq7qmKYVcdFwIip1lQVVkzdpKKxQTlwb//MI48Ke5T2/9QFsNoVY7+Mjc
         UsMSyD4MUugnWjy+Bct0C0a53R3/K8icsuGPjK1peHOxw4716eKZ2Lbdkogx7qqNFDpa
         wWrAqli2DjlICzy3Bgoir3AysHfp3bvY55zBKh6ZwUFJpuQjLY3m1Ht5Vh9vPvXaO+gs
         WP0Sx63+0zjmnQ7jeKCd4J55g8GSUqG6wYLy0k/voOvDEOyTWjn2oIgaqm2wE42kT2KK
         Qa3ep11ohnrqL+vM7Ls3qTPGO48MRCiaOHJsoGl1Asb6/OTEl5Pk0mnV8n6gZ88cqVFu
         Zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yb07SrwJ6+AFQwMLE5kmVtICB6iwDbTXZDBbHHHYRP0=;
        b=sidzAdrTmONK6YlI0tCeopmlchdZvf/qLNxMdFg5aEUhUQbnjlJlGSqH+YcRBaxHxl
         bL9jaK7z3SQRCf1lnWUDWfDy8wirUdlp9XPMcm5RHRzODAjdT7ZSYI5c/tYSD9eGRIz2
         L1l9+MiU5U6RC/1DQ80FPjkK7bPQCkKd7QYEn/4UN2jmDV1jBHrREQpD+MiTkBT17KAt
         cpUlmh28mu6AzbmW9ZoWlpgQqnVyF77sThHO2QnXRFb3qVDYtMRtHNHPzJI1X6YQFW9u
         /A86BMvzMF5CVoSRLsjNN0pc+FY6zGt1+H0if8GNy3Ie7hvX1xXIuKci9s5NFQarmZyp
         nHhw==
X-Gm-Message-State: AKS2vOzGk1/ET3rKGcQZz0RRQS/WEDpa0K/Sv+a2WWS3oV3mPFOeUruL
        SY20dlqFLai9wfd2d/nZKTyRQxtgow==
X-Received: by 10.37.2.148 with SMTP id 142mr2358904ybc.198.1498533443243;
 Mon, 26 Jun 2017 20:17:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.83.12.79 with HTTP; Mon, 26 Jun 2017 20:17:22 -0700 (PDT)
In-Reply-To: <CAGZ79kZ94Qh4CzCUWNYQQU5EB+Oky13gcp09tBKSYoCaFvqOuA@mail.gmail.com>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
 <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
 <CAGZ79kYR_Vw454RBw7A7ygJdiOauzepVZXBb_CvsCoN9AGE-sA@mail.gmail.com>
 <CAHaNChdhg-nHv34-jgumeKw8iJXaXwfY2DAe797nRXPU1VzT3Q@mail.gmail.com> <CAGZ79kZ94Qh4CzCUWNYQQU5EB+Oky13gcp09tBKSYoCaFvqOuA@mail.gmail.com>
From:   Gyandeep Singh <gyandeeps@gmail.com>
Date:   Mon, 26 Jun 2017 22:17:22 -0500
Message-ID: <CAHaNCheiJkh85iqOwgrxx_S7OMW4a82LGRgvNc2FSS_cTdAczA@mail.gmail.com>
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Appreciate it. Thanks a lot.
Regards,

Gyandeep Singh
Website: http://gyandeeps.com


On Mon, Jun 26, 2017 at 10:15 PM, Stefan Beller <sbeller@google.com> wrote:
> I miss-read your email.
>
> So you are not running Git, but only talk about the (Git-)bash that is
> conveniently bundled with Git for Windows?
> For that I recommend https://github.com/git-for-windows/git/issues/new
>
> Johannes Schindelin the GfW maintainer is cc'd here as well, but
> AFAICT he prefers Github issues.
>
> On Mon, Jun 26, 2017 at 8:08 PM, Gyandeep Singh <gyandeeps@gmail.com> wro=
te:
>> Not sure what you mean by output. But its just goes back to normal like =
 this
>>
>> Gyandeep@Gyandeep MINGW64 ~
>>
>> $
>>
>>
>>
>> It was working fine on first release of git 2.13. It broken with
>> releases after that.
>>
>> Will try with =E2=80=93no-pager flag and let you tomorrow.
>>
>>
>>
>> Thanks
>>
>> Gyandeep
>> Regards,
>>
>> Gyandeep Singh
>> Website: http://gyandeeps.com
>>
>>
>> On Mon, Jun 26, 2017 at 9:55 PM, Stefan Beller <sbeller@google.com> wrot=
e:
>>> Which exact outputs of Git are invoked?
>>>
>>> Does it change when giving slightly different options e.g. --no-pager?
