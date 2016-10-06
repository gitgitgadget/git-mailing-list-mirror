Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870B3207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 13:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936454AbcJFNQz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 09:16:55 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38868 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754816AbcJFNQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 09:16:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id i130so2837848wmg.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=32u3mbITQwJCrbmDtRDtP+0aDEvSSchWhpoEoS0jXW8=;
        b=im8orcdMibLSNvVF0cotxkkv5g+ta1nKvK5MrqEvIGlqv5po4d1pKp1YdgElBWqDAv
         rsNY7GbTDGOcZKqb3RyhJ1xUxlVXFL6x3dTSrFNYgqTV7y6tZP1Yqm7zI7m6cWapr2+w
         lRswrWz6s36p6eWg0Xh77W5xveIR+VdvxucXWAyvYqkM7ybiMIYD1uHmkUIX+rZ1R36E
         qnEnWRM7StD7GYB/aQpcLELdR21xps+p0huxX4k4ypKj2fb27AD4rfDSoc23MPKMaimQ
         v8REVIMTsfRVJDgM+dLhxQommn9ysQrUy+lscLWvwnC8PcLWLShZeRbTPslEGvr7ZqN5
         vwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=32u3mbITQwJCrbmDtRDtP+0aDEvSSchWhpoEoS0jXW8=;
        b=mFCnAqh0Q3xEXI1ShSyovlFE6OdqUt6bUyeBA1worT8usDYh/lOzLFJAIEtSS2S/Yl
         sycJLqNz5zE1yg+o/upF6lJNY3dZvxBg0Yta+vMoz5mehpKsG4KzUCIt8oTTbY/eZTSp
         lJJ7RSNmg57S9VK4hAqKAPZXJELEfz508Dq45qvWqMIgbFKpgbItbPA6YJXy9OtPaDhE
         xEEAkU0FhnTHfotOC+fl4zCWDki8r48yziaAf0UXytIUNDxNZ0rcejDlotWQjLLxlE0a
         BuGohaHqUYDOcxNKI9sb0Y/pL2oaiAkSr88BeFY/qd452HfUi0phfcp/3YX4sOy9BShM
         NpMQ==
X-Gm-Message-State: AA6/9RlZu59tCEXKloKcJRpc6KIqFeeDHpYOd8bhc78P5pYCGvUIfcoJqUgjx0i/vNBZzA==
X-Received: by 10.28.109.207 with SMTP id b76mr13331192wmi.66.1475759811916;
        Thu, 06 Oct 2016 06:16:51 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v128sm15062304wmv.3.2016.10.06.06.16.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 06:16:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2c53b837-4690-dae8-60ff-e7907a9b13ef@gmail.com>
Date:   Thu, 6 Oct 2016 15:16:50 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52356944-49B6-482A-8951-2B7F8D8032F7@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-12-larsxschneider@gmail.com> <91589466-439e-7200-7256-b9288beae685@gmail.com> <4DE57A65-1020-4F17-81F2-9F319834BB2D@gmail.com> <2c53b837-4690-dae8-60ff-e7907a9b13ef@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 22:50, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> [Some of answers may get invalidated by v9]
>=20
> W dniu 30.09.2016 o 20:56, Lars Schneider pisze:
>>> On 27 Sep 2016, at 00:41, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>>=20
>>>> +
>>>> +After the filter has processed a blob it is expected to wait for
>>>> +the next "key=3Dvalue" list containing a command. Git will close
>>>> +the command pipe on exit. The filter is expected to detect EOF
>>>> +and exit gracefully on its own.
>=20
> Is this still true?

Yes


>>>=20
>>> Good to have it documented. =20
>>>=20
>>> Anyway, as it is Git command that spawns the filter driver process,
>>> assuming that the filter process doesn't daemonize itself, wouldn't
>>> the operating system reap it after its parent process, that is the
>>> git command it invoked, dies? So detecting EOF is good, but not
>>> strictly necessary for simple filter that do not need to free
>>> its resources, or can leave freeing resources to the operating
>>> system? But I may be wrong here.
>>=20
>> The filter process runs independent of Git.
>=20
> Ah.  So without some way to tell long-lived filter process that
> it can shut down, because no further data will be incoming, or
> killing it by Git, it would hang indefinitely?

Yes

- Lars=
