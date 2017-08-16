Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F08208D0
	for <e@80x24.org>; Wed, 16 Aug 2017 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdHPMhG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:37:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36012 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdHPMhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:37:03 -0400
Received: by mail-it0-f68.google.com with SMTP id o72so2312779ita.3
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yr09otEU4qiq2VLRXGLRhMNwHrJEOT49rlad95QbbmA=;
        b=IWP0EKyhAnufo0WpPaojQcT+hpelYwa0aECmD0GIsodGEKNYCklQog5kobESCLQTfp
         1jI4iq96ZdNKnOFYYraIywVDT5BXES8eDiQrY72H3iYpSAOK/uiOwoxmevfHUukysAPs
         Kmw8p3MBxZZWv9iGF/sCYmV8i2XV7OwTSffGHWYh48xXmwGpPH8yls8OKTwbyU0BLvGC
         nJy8jm+4Szjczs+EevnZI67qLaEB7PPumTCA/owTVTvVTxXCStS+akgwDSE+s3ShuBsK
         kLVoPhrlhUktZXuGSbugIyc2/6bcIzPE8FHflGwDY0LTomui5viEiPGINT/4wL+mbBSc
         0iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yr09otEU4qiq2VLRXGLRhMNwHrJEOT49rlad95QbbmA=;
        b=ADoZ0WyM8RdOD5pngVadE4Vj/JH8RzhWj4Tq43K5yT5G8KVSdi46L+9eUI4tDkYLVL
         qRnNvvAcRAjhSIlB06asQvVA98THg2VEboN5Y1x4+YCt8GD+E2WOtNfYGrvfj7lIqxE4
         crmYVUIzmE7w8wsDIOOwFrFhXCN+jsji/TpK2ILi+8ira1jLkIfd/9mOZoQd47YlT4Ze
         V+qZSdpDT/D08KimxaKbX4vZ97rYGWdK04/YRCzaBq7iYobKV4D2t9yv94uy/mIqQsRV
         yBT0joMgg2m9wZKfhH+2i5eWc2mnxLn1Ee5J3j6eGUghT3eo4900di1yuvRKb9qoEc3o
         FKNg==
X-Gm-Message-State: AHYfb5gC7ukw6D8/hr0iUB7+s6KsI6rhMwu5uTtWkut9yR291DADDpLE
        0Be3RzEAvj1yBFTjSOKZDxvI8YKE4w==
X-Received: by 10.36.123.23 with SMTP id q23mr1559282itc.69.1502887022850;
 Wed, 16 Aug 2017 05:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.127.85 with HTTP; Wed, 16 Aug 2017 05:37:01 -0700 (PDT)
In-Reply-To: <20170816002257.GG13924@aiede.mtv.corp.google.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
 <20170815111725.5d009b66@twelve2.svl.corp.google.com> <20170816002257.GG13924@aiede.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Aug 2017 14:37:01 +0200
Message-ID: <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 2:22 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Tan wrote:
>> Christian Couder <christian.couder@gmail.com> wrote:
>
>>> In handshake_capabilities() we use warning() when a capability
>>> is not supported, so the exit code of the function is 0 and no
>>> further error is shown. This is a problem because the warning
>>> message doesn't tell us which subprocess cmd failed.
> [...]
>>> Let's improve the warning() message, so that we can know which
>>> subprocess cmd failed.
>>>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>
>> This looks reasonable to me.
>>
>> I am still wondering if protocol errors should be fatal,
>
> Yes, please.

Unfortunately I think it would prevent new filters or new
sub-processes to work with older versions of Git.

For example if filters are upgraded company wide to support the new
"delay" capability, that would force everyone using the filters to
upgrade Git.
