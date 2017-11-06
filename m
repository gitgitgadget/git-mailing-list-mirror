Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D7320A10
	for <e@80x24.org>; Mon,  6 Nov 2017 20:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbdKFUKs (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 15:10:48 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:47274 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdKFUKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 15:10:47 -0500
Received: by mail-pf0-f195.google.com with SMTP id z11so8534304pfk.4
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=NVdKvlTrIYBHvkyCe96VKgLimmKbfpOUbkRmPpQeuOo=;
        b=CXj3Di54mcNoS3qpSe8PXJP2VkP68nPsqyw92irhYfC2mBVhLu9H9OALQmiaLsWJmu
         f+7MPMVpK87kFpTn9jmDWU6uYOzblxgmTECnlKoTY3ut06veWrx6gORrLN1wThBQlaRe
         em2iE6Pc/TfNsYCPwmUTwIpqynVOdLMiyBKyliTsvRWUEi8tZlATd/BCLJA285qg0uAJ
         Lu3Zl324Xc0m7lujDFSOIApPf5Lx5V+zMaxwtFUZoxoKLLywp+ig4AM/yuwgRiEJAQhu
         cyO7Pk7bm/xsa9A/QMxS0ZkpAq9g2hzDzKQBtOr8QryObxn9x6QT688ic5ta8Ij3qds/
         vdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=NVdKvlTrIYBHvkyCe96VKgLimmKbfpOUbkRmPpQeuOo=;
        b=DB31Q6AXMZ3+ZdhlP+UxUY87ECu0kwIjhG/Lg+GUuV32mzfE9M0J0ABTPN704oSbay
         RwAp6UVYcBE8FphdDqeiuew1slLVvGFznpJ8TvFaP7i35fH6gKr8bK1LxmQmkk8QClRx
         WO7GxT39nYDUD7cNSODqppWBQ2FzKpYdtV09iqrwxOVcEjBx6PU0Chzd29FjsPRCST6c
         2Rtd/ViWPgVmuVdBpop53kSAHWTO+SkaoImXjLjH3uwN4MdmtiI7z/oo77QjIYh+4CIj
         fSCdZy42OtlZsILEjGuO+jaEsYctXlIeFWgvJAs1zahYuvi6CAowCQeYwv9wh1aBXv0T
         fsIQ==
X-Gm-Message-State: AMCzsaUKODUuM1+XnDmKLZU+sBq9o0Nre+l7X5zBB8q1CrxQts7MHh9Q
        O8aB/FVUJuPlS8OhcHF1OBo=
X-Google-Smtp-Source: ABhQp+S8cjtLCr2Ri0NctlFDtqTfuZM32D9hjEJENVi0PvNeuxphDr/vbbKIhi1nY8izt0QBq2/R2A==
X-Received: by 10.159.206.132 with SMTP id bg4mr15956753plb.129.1509999046455;
        Mon, 06 Nov 2017 12:10:46 -0800 (PST)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id y10sm22537360pfl.186.2017.11.06.12.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 12:10:44 -0800 (PST)
Date:   Mon, 06 Nov 2017 12:10:40 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
References: <20171104004144.5975-1-rafa.almas@gmail.com> <20171104004144.5975-3-rafa.almas@gmail.com> <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
To:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?Rafael_Ascens=E3o?= <rafa.almas@gmail.com>
CC:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <B24042DB-BB27-41DE-82B7-5F3ED502D7D0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On November 3, 2017 8:49:15 PM PDT, Junio C Hamano <gitster@pobox=2Ecom> w=
rote:
>Rafael Ascens=C3=A3o <rafa=2Ealmas@gmail=2Ecom> writes:
>
>Why should this be a special case that burdens users to remember one
>more rule?  Wouldn't users find "--decorate-refs=3Drefs/tags" useful
>and it woulld be shorter and nicer than having to say "refs/tags/*"?
>

Actually, I would expect these to behave more like git describes match and=
 exclude which don't have an extra /*=2E It seems natural to me that glob w=
ould always add an extra glob, but=2E=2E I don't recall if match and exlude=
 do so=2E

That being said, if we think the extra glob would not cause problems and g=
enerally do what people mean=2E=2E=2E I guess consistent with --glob would =
be good=2E=2E=2E But it's definitely not what I'd expect at first glance=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
