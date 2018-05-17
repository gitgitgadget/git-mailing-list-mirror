Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B331F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEQW6J (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:58:09 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:43050 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQW6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:58:08 -0400
Received: by mail-yb0-f180.google.com with SMTP id v12-v6so2046306ybl.10
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Re19mOFe1qOMvE6COYHylGfVpfmgxm+rGq+myc4i5Fk=;
        b=mBOOB0zNvZYPNvROaiO+Lt9Uf0GEXxJHRWFLjgt9UZenE++GlzSzMrfMbi4Rlf8KAo
         ESiucguvvGJhE2OFww4qWLS+tUC3s+mgE+n8IjL2zeMVhJq/ONnAUd2JgtP8cs9bqyse
         aTl8cOUtXOPbyWSIl2K+skpHxZ/xhyI8AGVQoro6BhGH5sZCTAuF/AUwWnajEMOxqjA7
         fbgtiPffqkEh6GCAJhVb++k8QmCVoJGoTZca2jK51W0ppQQiy/7/00+/neBvW3twAYgz
         dGpaMW60Fy3Zsge/S3EDV1V9ujiLkIx+LxsXg4womjCTIs9s0t3W09dIJsNyEjGhUuwZ
         qoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Re19mOFe1qOMvE6COYHylGfVpfmgxm+rGq+myc4i5Fk=;
        b=mGM2W2b/6oOy0uFCEmazSjnxCgk+bn0K1StD0COkqVqdj01tr2Cciwxl7hobhSGFQR
         wxIc0fymsvhG+m7JB+syKuw61igNhYM6CEUq3+Nko1XlO9ur09gVK8u6zgBZZX64GVpc
         YHYzDtFaY7WcwgPVzVWu1IaYWhMGsvG3rZnfN/+NDNBRow/A/zb6zuQleXzzhg+++VcE
         mhlFZKwLyb+v9rWCyGoICf7eqssUrNFGAYGHiAtpYLbtKNfJjFug8MnCA40Q0FAfn8DO
         BXzwz1ofys/xuV8x//XjeFsOGFTg17ycBUtdBIR5eweE73Ko2QOsbOWUw1gxYruge2dn
         v5WQ==
X-Gm-Message-State: ALKqPwehcWL7LUuD21ISwT6yg5swRN5+3x9AlqmzbdhduuurqNWDK4S0
        K9M3BD9xFU2jZPWlnuiM/XaJnFb5Q29gGyDcpw7hpQ==
X-Google-Smtp-Source: AB8JxZqVsJWsO4XczD4qdxyRF4PK95iYL4joznwPPGIfHDonzBahy5a8gW7TC8sffpRllnZ4wSXJPZgSUwTo8M2E3hk=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr3693553ybi.515.1526597887992;
 Thu, 17 May 2018 15:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 17 May 2018 15:58:07
 -0700 (PDT)
In-Reply-To: <xmqq7eo16gct.fsf@gitster-ct.c.googlers.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com> <xmqq7eo16gct.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 May 2018 15:58:07 -0700
Message-ID: <CAGZ79kYcA4TbVoPnJOS2Kmr7hfeZs=OnVPkmnepBhNCMysCfBQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Please do not replace what already hit 'next'.
>
> Here is what I made these two into a relative fix on top.

Thanks, I was about to prepare the same.
