Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7CD1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdLHVRI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:17:08 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:46144 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdLHVRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:17:06 -0500
Received: by mail-qk0-f171.google.com with SMTP id b184so530637qkc.13
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hXJFrvSRMI30ONP+KinzCX1EJIWME1pzpL6c7dDmmA8=;
        b=c7l1vtq5j4TPenFzSZUVlc0qx4DOrmZk0gnrLffAkik9fpGliZdZbm2ZAydqxjNoU8
         zJaEQHbOAUpea4ufsr5w33AE6styKm70iVM4TYF5VD3MVZCh6x/D5VJoftQXlHa3/BJC
         Doad66ENs6bZHBmznujoiiregOAHZXkfPXXO6hdzvrAUVgcwNp1O+GgY2GA2ie9YpFxD
         OBUKf/Y6EEMqOxHN4Sg3VIAXcuF/KnX1za130PVhxd3o234MBUrPgbMt04C0+lJ9pNbN
         XwRNrFogAPznM2cEKckbwCe+dxyfRg7c34TGrWyTdmcp5TWmBb7QdTKDSIWBQFmicLV4
         NFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hXJFrvSRMI30ONP+KinzCX1EJIWME1pzpL6c7dDmmA8=;
        b=BfG3LqnwQKpFYNi5vtAIupksIZH4RnhLn6Tetsafvr70cvzC1hxs6et8KPDq7vrDty
         /uO7LKPyKVhouQdjdvkw4MZZ0p8o+oD2nT2AcOeU4Os8qX4HeXMZKfwOtaN5E4PpWbVL
         PbIVmCoNli0MMLDjk4kMWStKaDDHvhXUX07w0SBm5boMzjs0W/mEZtybXFLnccRaDgzk
         tjW9HkkFfyT732cQrXMxMlJ+gqgPvKdV6rctPwota3TbeO21U9W/KeAo08aNvz8sqFcN
         J3RH+KFha/UrCmrsLYWWsPAuGHotZypJQKinyRC9D/nB8fc5SePsGbfm0bgAXmfu1Z7j
         Rofw==
X-Gm-Message-State: AKGB3mLU2TbAX0zUDe61bhnRApZKGDODEgjIsherScOyzoLwntZD8oxn
        OXYXh4u+MoGBTq9Jvvavnka+cYg1J6DdzrWI6FY=
X-Google-Smtp-Source: AGs4zMYoQU5UnXlPwP879dacbRDazdQJE3CC1u7E8LBSP2nr83t8H4/TCDXLDPMdw11wPo4b+/l4lTXvF10uuTJyi78=
X-Received: by 10.55.130.194 with SMTP id e185mr35948186qkd.357.1512767825600;
 Fri, 08 Dec 2017 13:17:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 13:17:05 -0800 (PST)
In-Reply-To: <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
 <20171208172324.GB14261@aiede.mtv.corp.google.com> <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 16:17:05 -0500
X-Google-Sender-Auth: YzaQPBUeVYcVCPSyNv5Sqzjdv2E
Message-ID: <CAPig+cRrVRJ+H7c5Q3zLj6gjPegLFQmngGtiezgxTBTDqWSj0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build
 platform, too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Adric Norris <landstander668@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> @@ -413,6 +414,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>>>
>>>      if (build_options) {
>>>              printf("sizeof-long: %d\n", (int)sizeof(long));
>>> +            printf("machine: %s\n", build_platform);
>>
>> Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
>> of a mutable static string?  That is, something like
>>
>>               printf("machine: %s\n", GIT_BUILD_PLATFORM);
>
> Good point.  And if this is externally identified as "machine",
> probably the macro should also use the same word, not "platform".
> We can go either way, as long as we are consistent, though.

In Autoconf parlance, this would be called "host architecture" (GIT_HOST_ARCH).
