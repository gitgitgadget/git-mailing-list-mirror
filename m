Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B5420401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbdF0Tsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:48:37 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35187 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbdF0Tsc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:48:32 -0400
Received: by mail-io0-f182.google.com with SMTP id h134so24065005iof.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KrHED1+sEZkJ2JcLS7VCO9oObLDiRMqxOLSf/xaLqB0=;
        b=Pxc1YFzScmHtJAgqwLlYBYuYKuUni6cgwAmK1NF5cKbsA8+Hv9DJ5c5NpSMcItVfSj
         7KxHjvBTFSAniPoK1x0CvNnMDYT5V/sE47RtdRV31q4a89wZcmxlgb2fy0I8WjK90nCb
         UShiz5f68AhFWFVumHOheraeNewjni4iJngIJTo8M0p4jn/tGA4TUF8yT5WOsqTLJM2Q
         iVONcfZHqps9HSnKjaRFDi3ap+qI5KyNoHd3xrLKge8T3gQahB5x0oql5MLlWsEPOpie
         gXryUhStKV8//S06EBmApXNjUTNVM0RVm5EuHOmRu50kwvHZvomBfeccU0QiH6pbrS+D
         IUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KrHED1+sEZkJ2JcLS7VCO9oObLDiRMqxOLSf/xaLqB0=;
        b=aFbLml3/mR1UDCkHoagYIKOQ1Vg8UArBLDQVwKa8i0P9uk2uGp57agipCSpyXbdIVm
         TOggD1VI6R8xmbfPN9Ji/srT85Ch1L/zH+0GA12qhK5wfMgiIFbk+HjfiHhlQWkVET8p
         ccr2cE3YzJlT+Mcalx+AbrFgR8bhQVrlbPsMimRmKL/1OU6ceJxszVAZNhN2uQv5CgX0
         EOQ8mPzjkN6bGBWJfiX3sIeNnQ33GrlVc00lMNAPqT3yjLRypl/BXmsf2BJ4lOdEo3Zd
         MmSe3WXTFMT1Z5zp1O0zcNVMWsfeuP/bIIDDrNWbrV5YwXRMT/714wyT7wKcXzleuacw
         AOHw==
X-Gm-Message-State: AKS2vOxy3LsWZwQEVywCXiGE2Dw8KA/Ix4evp+V6r0Dv0iAu5QVOqYxi
        oKK5goDnBYFqXao/VUiNh+qS8SkJRA==
X-Received: by 10.107.16.9 with SMTP id y9mr8960290ioi.134.1498592906718; Tue,
 27 Jun 2017 12:48:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.20.136 with HTTP; Tue, 27 Jun 2017 12:48:06 -0700 (PDT)
In-Reply-To: <20170627193835.goix6woeil3hfkhe@oracle.com>
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
 <xmqqefu52znl.fsf@gitster.mtv.corp.google.com> <87wp7xjo5x.fsf@gmail.com>
 <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com> <20170627193835.goix6woeil3hfkhe@oracle.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 27 Jun 2017 12:48:06 -0700
X-Google-Sender-Auth: pxepmxZcsyUNQ_M7PA9_AHWVp6o
Message-ID: <CAPc5daV4T-n2+8e2zaJY0qgid3RFLnES4KWujLpcQmmtsFT47A@mail.gmail.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     "?var Arnfj?r? Bjarmason" <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 12:38 PM, Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
> That's not the case.  _BIG_ENDIAN is defined but not to a value.  I
> believe _BYTE_ORDER is defined as 4321, but _BIG_ENDIAN is just defined.

OK. Thanks.

That sounds pretty much useless in the 21st century, where _BYTE_ORDER might
want to be defined as 87654321 ;-)
