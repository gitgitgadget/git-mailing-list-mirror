Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ACF1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755984AbdLONGH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 08:06:07 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:44608 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbdLONGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 08:06:04 -0500
Received: by mail-vk0-f43.google.com with SMTP id s197so5520922vke.11
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DH6Id/UVrW9xV1gACUfXhhjdHtxkZrEBYJOwRPriQSA=;
        b=Z7SAnoKI80VUvSqnqjjjUT7VwoDBDzduHIdNU1X+aoHceFdn4FKeVzJEXQbCAsWSAv
         tSm6iBd9Gzy2r+beBGQbzbG+27IPh5D7UiyMIpAfIEuIYTiAEYTxD4sX5GYbDw85OVaD
         od/kYnPofF4Va1sj+owwC1k7Rz//Eq0EyiWaXz+H/tvLQx5ZkxNqRpFCQkk3c69HZjBC
         La7JaKpg4xmsSeobftiDY6v/Lmi4PCM7393OvlGy+Fwy+PmzziefAQsuUi/qGFi9sUOe
         //92ECtEMQuSY0nv0v6JLFZpiTzXaPEDQpJXoxDr/sAu4m/tOxytW8adPLk68NSUTxs5
         YSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DH6Id/UVrW9xV1gACUfXhhjdHtxkZrEBYJOwRPriQSA=;
        b=nDw9MfiXaUGMyxLgfy878MP9+Knk9lppSJpWoc4cOPqxJUcvq8MWnIuN2TM/5IesN/
         Hnl2BZVZU5/OsianClxi2SqEp1jVhQDV5Yfy6xmGDFKKC7k/ZT1EbBwZtjYJpRS2v2J6
         +8XJSJzPglWaVn9yeuVhAWJKFcl17wj/IkwxogNIJJhmPKNOwPVRss+N5YIuvLhPpyGB
         k7I13C9v/BuhXcdMTORP6hRKzIQu2YkxUiNogAtRzqgt5JCPH6rhtwXt6HN3bqOjS6/r
         hUGFg4gtnr8i+ZyEBxiaf7CM3JEIeB/iZ/fLG9OL9K2J9o+a9emJdumo66kohpxYP7X8
         MQIg==
X-Gm-Message-State: AKGB3mI/eIxVArM25dd6XEOuhYrDP8vPyNLvLMZlJkzYaSYS9VUScI6o
        k0J2ef9fKpCI7rTsE3pO9kremranoGvxrT1t574g2w==
X-Google-Smtp-Source: ACJfBov5W3Icf7TRqAwi5GocO2/PfAhdIvG6ZqFTSENv/GXimlWgLYWZWBh5CN+lKoxi+QFnpM4WJTdyjZbvoyVENfU=
X-Received: by 10.31.9.147 with SMTP id 141mr14349649vkj.119.1513343163454;
 Fri, 15 Dec 2017 05:06:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Fri, 15 Dec 2017 05:06:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1712151308230.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com>
 <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com>
 <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
 <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com> <CAM0VKjkv0XqHf8s94Wj2DHsD49gTP0M6HU2AY=36Jj-5SYhS9A@mail.gmail.com>
 <alpine.DEB.2.21.1.1712151308230.406@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 15 Dec 2017 14:06:02 +0100
Message-ID: <CAM0VKjmpJ_J+GjJ3PyU_pxsWx85L6cPa2tLM0xJx3cJu2T87Zg@mail.gmail.com>
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra
 tracing output
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 1:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>> There is a lot going on in 'run-windows-build.sh', so the output of 'set
>> -x' might be useful or might be considered too much clutter, I don't
>> know.  I put Dscho on Cc, I think it's mainly his call.
>
> Certainly it might be useful.
>
> However, please make sure that the secret token is not leaked that way.
> Like, *really* sure. Due to the failure of Git to use a portable and
> performant test suite, it does take about 90 minutes to build and test a
> revision, therefore it would be very easy to DOS my build system, and I
> really, really need it not to be DOSed because I use it in my day job, to=
o.

Ugh, I was completely unaware of this issue, and the first version of
this patch is already in 'pu'...  **runs to check the trace logs**

Great, it seems we are in luck, as the secret token was specified as an
encrypted environment variable in git/git repository settings on Travis
CI.  It's redacted in the trace log and I only see lines like these:

  Setting environment variables from repository settings
  $ export GFW_CI_TOKEN=3D[secure]

  +test -z [secure]

  +++curl -H 'Authentication: Bearer [secure]' --silent --retry 5
--write-out '%{HTTP_CODE}' --output /dev/fd/63
'https://git-for-windows-ci.azurewebsites.net/api/TestNow?action=3Dtrigger&=
branch=3Dpu&commit=3D1229713f78cd2883798e95f33c19c81b523413fd&skipTests=3Df=
alse'

  https://travis-ci.org/git/git/jobs/316791071

Phew.

However, I don't feel competent enough with Travis CI's encrypted
environment variables to say that this qualifies as "*really* sure"
"that the secret token is not leaked".
Anyway, note, that that '$ export GFW_CI_TOKEN=3D[secure]' line is already
present in all 'git/git' trace logs independently of this 'set -x'
change in question.

G=C3=A1bor
