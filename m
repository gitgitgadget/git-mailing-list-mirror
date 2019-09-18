Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96C71F463
	for <e@80x24.org>; Wed, 18 Sep 2019 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfIROmw (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 10:42:52 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39621 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfIROmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 10:42:51 -0400
Received: by mail-lf1-f45.google.com with SMTP id 72so5903023lfh.6
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scottguymer.co.uk; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=kQSRalh5AwbRq50JaQYO+fwmbuTKWPW3cVUgc8WSOFc=;
        b=GuoVqA+IlCisz3quB3xrxxuP/qJFbYwq3D39OBJEciJeYNlY0S3W58uIgoSwKiZD81
         pWvYshPW1Vv/tpI6RefShrCKB0MDcmPWPjsKOlGmcH4vT9d7EZzzl6H7aB8RMHpZ+o9/
         QU0I8SrE6naoZ8Ww3EWHYctMm8Hqrq75t73ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kQSRalh5AwbRq50JaQYO+fwmbuTKWPW3cVUgc8WSOFc=;
        b=KaTmEar5N0rTuHCMJRJfkbZuRyCliqBNqNAxUrQ0El6eW/eBAl/5LhnvAU33TngInA
         yrJkFMwUAMwK5slm8MAfG6X88ayY4ROyZzC8mWmxiUTxwjzBBWpNIGfwtQ7lgxBLznYb
         uNTx3vG2DfuipTP2k5rSyCTAGJrMc1QiA+2Dfp1QvB2kkiA34x7CrfIf6wfZ3gFJyszk
         qCWwuoY6ewUPi3LUdNNCTV1AcHF3PuhAIW78ZB2y+o8ohaEIBUqSevaoIANRtT3DPqY2
         RDKFLt13qBL9nmPmmImb6XFd5NI0HSNmOjHGQ0LmK/PKtktKt0pnEaCgTVFbcon/OJ3C
         SbRw==
X-Gm-Message-State: APjAAAV0G0QoRK72UzYmFxh8WZhmeew3WCH9rwlA5geOC5xfhNkY+PqQ
        aJtM2ommyD/+jw3kId5kNlpiRNNfGYFwYEqdU0dRUf4qnBRPIrxY
X-Google-Smtp-Source: APXvYqyjeCBf0CzZW6wBtvS2Hna/I0wKq3LCYjL1m2DucD9GfhBLQ7aD0HzX3PE56H6BRAnlmdatZybY+qHUqU3sFfA=
X-Received: by 2002:a19:3805:: with SMTP id f5mr2294760lfa.173.1568817769293;
 Wed, 18 Sep 2019 07:42:49 -0700 (PDT)
MIME-Version: 1.0
From:   Scott Guymer <scott@scottguymer.co.uk>
Date:   Wed, 18 Sep 2019 16:42:38 +0200
Message-ID: <CADvYWYNvBAmr=fSe=CLTr7RLcwXDasffz8B21cBpW6L9UtFLMw@mail.gmail.com>
Subject: Potential Bug with Client Certificate Authentication (mTLS)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to pull via HTTPS from a TFS server that has Client
Certificate authentication configured.

I believe I have all the certificates in the right format and simply
using curl with the same certs works but when trying to clone via git
it does not seem to negotiate the client certificate auth and just
gets a 403.

I have scoured the config page to see if there is any info
https://git-scm.com/docs/git-config

Is there any concrete documentation on how to get this working?

I have posted a question on stack overflow that has much more detail
https://stackoverflow.com/questions/57473558/git-with-client-certificates-failing-and-working-with-curl

I'm not sure if this is a bug with GIT or just something i'm not doing
correctly.

Thanks
