Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D971F954
	for <e@80x24.org>; Mon, 20 Aug 2018 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeHTPhO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 11:37:14 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36984 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeHTPhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 11:37:14 -0400
Received: by mail-io0-f176.google.com with SMTP id v14-v6so3315324iob.4
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0QwOlFdJw16d5Snh3i+q77WKtxKxLg0CgpDvkdsS8Lk=;
        b=lLq3o0tGBFvk0s1BIheHruG44DXs8+eiFaWKzp0tMqxnDmuZyX4c9OeQhIhRBlesxL
         HMGCa3xBbBO5NSM4K6ouGOqJdd0JwrZIa2r14JC2lhq5A/+1Bj27WczD0ZGMiFYd+Ikd
         L+/ApxmJnSojfZUFPE/RaTzHdD4sJY0N40IaVG9Dtn4ZE9vWHC9CH9lVvudR2NkKCIJm
         o/AMJGCba5l3+YUhohs2YgrknrRl9XiZO8TwCTR+bzFOLrs/4dpjV/BTRh0P5s9CXRpy
         qqRGmGFgLHlbZmXPskHZlHGOETSAMIiFawIqFrxtHxD3roxTz5u6eobuPwUPrxm3Ux2K
         Lnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0QwOlFdJw16d5Snh3i+q77WKtxKxLg0CgpDvkdsS8Lk=;
        b=bMd/xXwRatad2L0nqPYZPGtVrEuPb6JoXVcuQ74K5FsbjGmoC7bp2PQUTsFJD7ysb2
         L9mFiqJPghTJWWabFCOw35RQ7Itww8jeU/rDWomckV3g/IvFkTauclMAXmPq7mtdf8cF
         CAdfdCcGa/shBjPTQs1fn1YMOsrGCqKTg+hYJlQnIeAvkGmQo+cP21jUlsvVl74HKKdf
         DhtNpto9/5QIGz64HeF+GD0+82i9600MY27vfQiqwJEhw8XOKZj5OZciqnko6vBk3T2R
         a/PwgTQk80AS1bbjGORy9Ia2L3SErfiATTW2sWbzO2W8KUxWXvKPEoAg2iACppTOthKx
         YZdA==
X-Gm-Message-State: AOUpUlGtGhfWyfYEK4Lo2qb28iTs3QMFzXaAq1mpLjhIYWi4AF/d6vCZ
        HJUR1DZUg8Y8AK32dHv2X0BOQRM5KqTWJfyG4fEVAg==
X-Google-Smtp-Source: AA+uWPxlLaIRRUABS13zldrzvCKz5pZUiCTphUJFq0aNIvoSv5rRTxzlA9o9KeGb5p+DszoF6UTs6tcsajIWiUyGqXg=
X-Received: by 2002:a6b:db01:: with SMTP id t1-v6mr37917007ioc.114.1534767708751;
 Mon, 20 Aug 2018 05:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180807125108.104293-1-hanwen@google.com> <20180807125108.104293-2-hanwen@google.com>
 <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com> <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
 <20180818060911.GC241538@aiede.svl.corp.google.com> <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
 <xmqqin47acir.fsf@gitster-ct.c.googlers.com> <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
 <CAFQ2z_NEBeiHWeC8BLKeBhTq_zA2iN2cTrENfPTdfykyM5uduQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 20 Aug 2018 14:21:37 +0200
Message-ID: <CAFQ2z_PiNAHduht6dHRAw8ybAUYkFcKXExypYa178u0gu2owRg@mail.gmail.com>
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote
 sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

and, thanks for cleaning up after me :)

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
