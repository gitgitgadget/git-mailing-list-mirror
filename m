Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788F720209
	for <e@80x24.org>; Fri, 30 Jun 2017 10:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbdF3KNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 06:13:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33984 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdF3KNL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 06:13:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so38663281wrc.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6JC9VA7ZRT4kke1C4oFwwYgAqyj8j2N273owZPg9O0g=;
        b=vKE9Jiz3YoNJXt8Nivj4WpFHbst89qA0xGwshjg0pPnpbxSsaCc4p34EkOevWxNhtC
         SovEmHlgb4nc6TU8aQ62gNhXwvocCx/ZOZ4iXI472WhdJfbQLHqgxfyRElsNxES0iOnR
         XXtbyffyW7gThA5cV3yo+9anG9rjwoUcr3fqIWXpxzTfWmPO2DFShLWoYDbsELl5VCBU
         xs5yc1W3tI5EMCgg2p7pr9tc3byIacCTzVLHBQU6ermt4A6hq+8Ud1p3meRbbkSz6x7V
         D84OoVD/6ttyMHS27NsxG1vxeCzdcA8Bxyj9ftd20myw7/LVEfSYl416DEJbtAkAQAg9
         Ph3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6JC9VA7ZRT4kke1C4oFwwYgAqyj8j2N273owZPg9O0g=;
        b=OuaLwcdY3nfNVFE0XlwjOkhxuAjddSUAWGwTa7BmjK1kzifJXY76HN/KCBCV5zTXTF
         d0zXWL5d+fa2a+KRuaTQafBz8fTpv7EmTnoeJyjj+x7QnlhUvaZlQaR6XJjmq0kBB6xz
         zorqeaAFmoucmZQjBqGXO/T+Yc3F2ZrbxsgLPoTk628NZuEyvz14GfeYxb6/htHTzFyQ
         IX8kjVqemdawWbt5thZLoDCBzZ2Y8JjX9ZR3li78Jd7yURViEBi6h4GU8CGG3nfLwhof
         Rn2OdGoq3/HI0pcleUbi6j4laEUXcHRSDDWy3nmYrbwUk8yDbkXWdz5SqXtFTt9ZDvEw
         TFgg==
X-Gm-Message-State: AKS2vOybzv/s/e+ROi2nUEjrrrvUX4OpJ7ftTwzV+SjOjiUopbk8BIA2
        veoH+/xg+0c3ig==
X-Received: by 10.223.173.140 with SMTP id w12mr29019541wrc.4.1498817584769;
        Fri, 30 Jun 2017 03:13:04 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b30sm4632459wra.42.2017.06.30.03.13.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 03:13:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAKYtbVbOXZiZrsFGOKu=sFroSL-FBQo2wMaA9GmJvc-Uh7QZEA@mail.gmail.com>
Date:   Fri, 30 Jun 2017 12:13:02 +0200
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
References: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com> <20170629224659.25677-1-miguel.torroja@gmail.com> <41BF267D-5F4D-4031-B9D4-15DB263D35D9@gmail.com> <CAKYtbVbOXZiZrsFGOKu=sFroSL-FBQo2wMaA9GmJvc-Uh7QZEA@mail.gmail.com>
To:     Miguel Torroja <miguel.torroja@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jun 2017, at 11:41, Miguel Torroja <miguel.torroja@gmail.com> =
wrote:
>=20
> On Fri, Jun 30, 2017 at 10:26 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 30 Jun 2017, at 00:46, miguel torroja <miguel.torroja@gmail.com> =
wrote:
>>>=20
>>> The option -G of p4 (python marshal output) gives more context about =
the
>>> data being output. That's useful when using the command "change -o" =
as
>>> we can distinguish between warning/error line and real change =
description.
>>>=20
>>> Some p4 triggers in the server side generate some warnings when
>>> executed. Unfortunately those messages are mixed with the output of
>>> "p4 change -o". Those extra warning lines are reported as =
{'code':'info'}
>>> in python marshal output (-G). The real change output is reported as
>>> {'code':'stat'}
>>>=20
>>> A new test has been created to t9807-git-p4-submit.sh adding a p4 =
trigger
>>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>>=20
>>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>> ...
>>=20
>> I have never worked with p4 triggers and that might be
>> the reason why I don't understand your test case.
>> Maybe you can help me?
>>=20
>>> +test_expect_success 'description with extra lines from verbose p4 =
trigger' '
>>> +     test_when_finished cleanup_git &&
>>> +     git p4 clone --dest=3D"$git" //depot &&
>>> +     (
>>> +             p4 triggers -i <<-EOF
>>> +             Triggers: p4triggertest-command command =
pre-user-change "echo verbose trigger"
>>> +             EOF
>>> +     ) &&
>>=20
>> You clone the test repo and install a trigger.
>>=20
>>> +     (
>>> +             cd "$git" &&
>>> +             git config git-p4.skipSubmitEdit true &&
>>> +             echo file20 >file20 &&
>>> +             git add file20 &&
>>> +             git commit -m file20 &&
>>> +             git p4 submit
>>> +     ) &&
>>=20
>> You make a new commit. This should run the "echo verbose trigger", =
right?
>=20
> Yes, that's correct. In this case the trigger is run with p4 change
> and p4 changes
>=20
>>=20
>>> +     (
>>> +             p4 triggers -i <<-EOF
>>> +             Triggers:
>>> +             EOF
>>> +     ) &&
>>=20
>> You delete the trigger.
>>=20
>>> +     (
>>> +             cd "$cli" &&
>>> +             test_path_is_file file20
>>> +     )
>>=20
>> You check that the file20 is available in P4.
>>=20
>>=20
>> What would happen if I run this test case without your patch?
>> Wouldn't it pass just fine?
>=20
> If you run it without the patch for git-p4.py, the test doesn't pass

You are right. I did not run "make" properly before running the test :)


>> Wouldn't we need to check that no warning/error is in the
>> real change description?
>>=20
>=20
> that can also be added, something like this: 'p4 change -o | grep
> "verbose trigger"' after setting the trigger?

Yeah, maybe. I hope this is no stupid question, but: If you clone the
repo with git-p4 *again* ... would you see the "verbose trigger" output
in the Git commit message?


- Lars=
