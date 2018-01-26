Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CDB61F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeAZTXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:23:14 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37730 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeAZTXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:23:10 -0500
Received: by mail-pf0-f175.google.com with SMTP id p1so894233pfh.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5vKfJrz8TAV/QX+DC7QCP7PJauietB+hbam+ko293Jo=;
        b=fzrA/CpqUIEXclfk2gRzsfOm0zWFabKkNP3HIoQRB/vnSqX22lXNzvU4sTuxzFQlFV
         YX7ChQy2u6AdMd1qtouExuPPMuwgxGWclGKFHMrTWRWldmGwyqI8PBzapx55KpIkCIx/
         a+sg6v94VgbT1hlBuxRIHiEFf0S3metO2HMM8V2969wdlcJO5mlaX8OcZlFTB+SkGqR+
         Yun60/e67kANP78nZNTgWbnSCtBnwsb0kC5jspd7onEl+Nwm2VQOcDY4ZmgTeRdV64YA
         UgdHdsqcS38bR47uvXqnbsuYPwcXwy4ipG5rmkrGAZsjl+XogpuChp1mzEH81SeSukQW
         2XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5vKfJrz8TAV/QX+DC7QCP7PJauietB+hbam+ko293Jo=;
        b=dJ2XqMg6+MZTKFLDgy3d2m2+bRYVYhVgRmBIhxTFD9pFtUU4sfFo5cJE1glbVgvorn
         j9r6/F0d091AhemM6mlXFujTfH2lkRoxJz/cR3zsUgIJmbtYcA7DMwJ9xv2iCdaMd+j9
         J/K/qA1i95y4V/ecgXANVR8+Fw3cyk7YEp2GIoJ8pAbIhQ/fpWHRa9MOSU2d64TW5PG5
         tIeAwAtTzWcgXXRib0o+CnZh5l1fy0fOa1VRVcv66Soa9nPCUds43BPmLcYJIczBPIRA
         OhBhL+5gieEg7SMtoWC+uLOVoWk0DzeG5ZUCF+JZP58MD7fLOwHmpKmGinRxbZY7FKQ1
         CWHg==
X-Gm-Message-State: AKwxytfmGCZwBdUXAL86KYm2luok48HEXvOdDc5Ap27BmOSct48YX9Az
        qmH6Ls5MIrAkp92lUmMCaC4=
X-Google-Smtp-Source: AH8x227Azd4rmSfb9e8DVX9nJLLXSesmAO2IzHVySvbeU828UWGNPEod/7q2Qfz8iFI1SQsBH4lEnw==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8-v6mr14789335plr.171.1516994589869;
        Fri, 26 Jan 2018 11:23:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id o69sm21210279pfj.32.2018.01.26.11.23.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 11:23:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/10] t5510: consolidate 'grep' and 'test_i18ngrep' patterns
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-6-szeder.dev@gmail.com>
        <xmqqa7x08p0e.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjm0uveCRpNy8H+inwTKa6fzHAjGn=f9tmQ4p1MCWGuirQ@mail.gmail.com>
Date:   Fri, 26 Jan 2018 11:23:08 -0800
In-Reply-To: <CAM0VKjm0uveCRpNy8H+inwTKa6fzHAjGn=f9tmQ4p1MCWGuirQ@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 26 Jan 2018 20:20:02
 +0100")
Message-ID: <xmqqk1w477c3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> No, GETTEXT_POISON only affects the translated messages, but those
> 'grep' invocations looked only at refnames and formatting.

You are right for this specific case, but I was talking more from
general principle---running test_i18ngrep on an output from grep
should be flagged as anti-pattern (I recall vaguly finding an
instance not in too distant past).
