Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865EA1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbeGLUpP (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:45:15 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43417 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbeGLUpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:45:15 -0400
Received: by mail-wr1-f54.google.com with SMTP id b15-v6so22999852wrv.10
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k8CxHDXgDxamWfKuk0Grb1ToFRgb1RvbETiebJnz/DQ=;
        b=JBDEQjVowWGorqKgIT2CO+f8M7V7YL+6osm6lBNj0+qm5/ULA/sBzxEJPNqOVTvqkO
         xuE5la12xsdfGd41FdKIUfcUDoMU1AU9hAupCa+PyjdtZbh7YW2IDTXUoopzr6dMZI/s
         odjXtjk3JW0Fn/GjjzZnQSIgYlNyRFMgW4ur2di99UFHYoHLp+T4870CY09xDi0ytyFw
         A9QC5LjPIZB1eWa67W356tRnVCUcLWwFbXxrHCM0dwlwuWzRxuJ9xVRgZdp1HiYOwVlb
         R0sATQ8dj0jsd5qBljjvwOgForKTg8ta1DGe1G7ACZCAqZ/YS3fi6FAcep75OmqqoCGf
         UMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k8CxHDXgDxamWfKuk0Grb1ToFRgb1RvbETiebJnz/DQ=;
        b=Lo9fBWsxM0fL/Z/ltcO3z7/IcazvMnYAxC42HnY10dptJgh0Bm6PtN+iAc0i5k08kN
         Bo7soIKJ0khPyZYaWvU+wgmRT5ZgMVbxa2QPDwCAQkiM+yVaZwsR74iPssmEgJB4dwuf
         bcLBSV72HEnvvGeMSeKKc5yIt33mZM+jk1lEMpq6koPwPRM8i9swFmdqP1vfICb32Fz3
         AlGRqpEU+QkYPen376X1RlI1V2EPDyW34BFD5Xf1cYsQJ8sTsCKdFzumRiDmA2S1yzBA
         uSeW9jErBSYrsfUzuATiH3YWg2Ianp+jqr/Gx/8W6sbSYCX2ylfkFVJ1Vp2rqpFFHc4J
         t/yw==
X-Gm-Message-State: AOUpUlEs2dVxSAI32Alo73de2jYrEdXyUPuzFWeHh8SfsMkK8N8uMLDl
        BDo+IWZrEq5R4bK2t4A9X2o=
X-Google-Smtp-Source: AAOMgpfdZJOH7Sapdovq2Wcl4xxXuET8R8BZfabPEGy6X94bIDMEh71v6p3rS1AP63FM7sHmCFcktA==
X-Received: by 2002:adf:9025:: with SMTP id h34-v6mr3017428wrh.123.1531427642554;
        Thu, 12 Jul 2018 13:34:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t2-v6sm8700499wrg.25.2018.07.12.13.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:34:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] handle lower case drive letters on Windows
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <20180712154419.18100-1-benpeart@microsoft.com>
        <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
        <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
        <xmqqmuuww7rq.fsf@gitster-ct.c.googlers.com>
        <BL0PR2101MB10122C1A2F038B61470A6994F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
Date:   Thu, 12 Jul 2018 13:34:01 -0700
In-Reply-To: <BL0PR2101MB10122C1A2F038B61470A6994F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
        (Ben Peart's message of "Thu, 12 Jul 2018 20:09:28 +0000")
Message-ID: <xmqqva9kurba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>> > Thanks.  I thought it was strange as well until I realized you only
>> > see the error message if there _isn't_ a valid drive letter so seeing
>> > the entire path makes sense as it will likely be something like
>> "\\server\volume\directory"
>> 
>> Yup, that is why I thought Dscho meant to say something like
>> 
>> 	"'%s': path without valid drive prefix"
>> 
>> in my response ;-)
>
> I'm fine with that - want me to leave it alone, spin a V4 or have you tweak it?

That's "helped-by Dscho" patch, so I'd leave it to him by queuing v3
overnight and wait to deal with the final decision by the weekend
;-) That way, I do not have to make a decision on anything Windows
related.
