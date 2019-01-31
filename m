Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D651F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfAaSNM (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:13:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50570 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:13:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so3523975wmd.0
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fN95NfNGvLQUY+CBEivmmLsJTNNYHtS/CqzUYIAhKeg=;
        b=V/IcR11sqWaS2PYkIxqd+BlYj7PbirzEUc3odl97maGOgfG/zMUNKj8ojxlU+gxhEX
         8toxuDnLfDgAA6N7CAy1gaI0eUp6s0YmMZ7s5Z3KGpLLvUSiEXUSHYZb8uM0849VN/BK
         fE/H0km12GK4O4D+9gqm9CU15bdCxo41Ag7vCP4rxv509GhD4ZfDRJHxbg+zTl+um/4v
         8ggIRVKDHclBnadCJ/4EQk8ZVVdSqOAe9tRKeNmHbihxcyFJtJmF+JCfedBsYJUU86tC
         ai21ie/vHUCAocSujLHSwm7dpalgZyNbDFdWJAMikRkBSp4VqwjK9ZLMPvB7tpzZFlhC
         oi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fN95NfNGvLQUY+CBEivmmLsJTNNYHtS/CqzUYIAhKeg=;
        b=j3V5SGKS48lRToucyoCDgWEqCmwv0cy5pgjKgVT5AQcvuhJdB+HcIXRMp7tpRHlkCw
         jo08+lTiT9R9m0f6FsgRmYRIUXcq8Hks/t4traYcuEhXElQCgVTBwLentSZzpdGMqkAz
         ucFTKcGdSDKP3VYRKOSF6V4FzbhoKq2uN4/ChhpUfeUXr+zBt7G9pfkLQ5k8pa6aJvIN
         qEdCriNJoXckPaMwafFGsoJe8z0CpN0ov1JV1yWLSj/rL8K/DSBElu+xN+PMPrTLhpxJ
         WOsEgk/f+FmFu47IdxWxkwvwM1vGz+/+87qwZWMTcMXpulBDRwM6hWeowHHP74Hk/Xye
         gqPg==
X-Gm-Message-State: AJcUukcGVB0SOInHolE4CJLZVO/VVvng0Tyh5DzoXRriZM05W2dtAryi
        ilFf7dBuA/rPflj6iDKtDJuzCNXB
X-Google-Smtp-Source: ALg8bN5FPdlLm77miDn7xvjvKAA3MVzP52P6u3i2txOdpCSNQdQ6zQJRLCYXcosXM62SpVTOOqW4DQ==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr29609083wmc.21.1548958389950;
        Thu, 31 Jan 2019 10:13:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9sm6728514wrs.63.2019.01.31.10.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:13:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/19] Add new command "switch"
References: <20190130094831.10420-1-pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 10:13:09 -0800
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 30 Jan 2019 16:48:12 +0700")
Message-ID: <xmqqo97w3dca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is the first half of the previous "switch-branch and
> restore-files" RFC series [1]. I only focus on switch-branch for now
> because it's already getting long and I still have some work to do on
> restore-files.

Exciting ;-)  This will probably become the best UI improvement in
the past few years.

