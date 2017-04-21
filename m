Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B602207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 20:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425903AbdDUUGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:06:16 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35395 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425897AbdDUUGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:06:14 -0400
Received: by mail-ua0-f172.google.com with SMTP id f10so86805058uaa.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i3uB6SALDlQZxE6pcaHyRT6Jk4s86IEOg3qK9jiyfXM=;
        b=hV3iz7uO/AEnNkD4vwaG+oOw4t71if+tY5ttrK7DnROg7E6Wr6rdTN1CKA5vwzoPQP
         5j7NRE5otvsqsrvVsi+1sJ58i8A0ZQtPbR5e5ANSdMYHC3mrU/1JUmliMIXMMsfpqPbD
         YYEIQwQPvjukhknS2i2Ph0Z9MnOvCSX2hXNWDxFkV4u59meRVAVtTQAggPHRxOWIbDOF
         ZR/T6adWc/MDWk2ZinXKX3lXvSlTlBLZP8A8D0IPhpX81NY2gJIUEOkZbz9FjspC54IC
         wI+I23A15jP2ulppOlbyylJSBl7sfw0CUSxGLBv+DVzv1xzBtpjIFBxIfGEkstMsl6dW
         NbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i3uB6SALDlQZxE6pcaHyRT6Jk4s86IEOg3qK9jiyfXM=;
        b=JCzrPcpR8JiGS6sOYSm5twCIg+X70FkTebXsQQ4ROcee45VEdvT7RLSYb7NqZETf22
         ++HZE49HEmrV/2mEY9iQUlR1ZbsCkLtNCaRrRmYwxzGWWH/it8Rb+D50jWzKnn2p65hj
         yRpm3e0O9onxjss+aE4hQMmTEmLzFhXI0I2HR9sqzen/5+hE2e/THBLV1v3+HG3Tu/dQ
         oXrvank+SoEYl4LH3x9u5dIKPy/r5LQ4MnBj0wW17AouUJfT2Ntt7rivpCIj/O9pZGWt
         A4N4VNBpWFReCO1ZViHQPznOn4+TlYZn9QuCU6uFAh9MostxROqQrA83VuVi8D8I4Sl9
         B2Og==
X-Gm-Message-State: AN3rC/4jBefqxmyemV9mLNCuEdgdkACVHFeOmBwwpagzBhGVjcPjH6qg
        DiAiu1duP0bECHfRFY6rG5pqBYyZPQ==
X-Received: by 10.176.16.11 with SMTP id f11mr8092044uab.156.1492805173770;
 Fri, 21 Apr 2017 13:06:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Fri, 21 Apr 2017 13:06:13 -0700 (PDT)
In-Reply-To: <xmqq7f2e8u14.fsf@gitster.mtv.corp.google.com>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com> <xmqq7f2e8u14.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 21 Apr 2017 22:06:13 +0200
Message-ID: <CAM0VKj=kaFseg9cs9SOyzJCVtpBXD8sq9mWWWYg=mAxu7uRB7g@mail.gmail.com>
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 2:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> We had two similar bugs in the tests sporadically triggering error
>> messages during the removal of the trash directory, see commits
>> bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01) and
>> ef09036cf (t6500: wait for detached auto gc at the end of the test
>> script, 2017-04-13).  The test script succeeded nonetheless, because
>> these errors are ignored during housekeeping in 'test_done'.
>>
>> However, such an error is a sign that something is fishy in the test
>> script.  Print an error message and abort the test script when the
>> trash directory can't be removed successfully or is already removed,
>> because that's unexpected and we woud prefer somebody notice and

s/woud/would/

>> figure out why.


> Note, that the commit message references ef09036cf (t6500: wait for
>> detached auto gc at the end of the test script, 2017-04-13), which
>> is still only in 'pu'.
>
> I think that one is already part of 2.13-rc0 ;-)

Yeah, I should have fetched before submitting.
