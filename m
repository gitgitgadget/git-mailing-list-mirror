Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A76A201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 01:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdGAB7H (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 21:59:07 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36228 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdGAB7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 21:59:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so74806042pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=9LZiWf8+nMeRInyOQS4AqXhLFjB149nvvoLwU9/1gjk=;
        b=UpCyX9PL59EmRVV+bElKjlmrwVioMG4cLAWoP2i+eiy8bNh4EqQX4O3weN1qm4yLTN
         xQAnj6Zs5qFzbYUSp8G25EH5+nhhdc58SHWGAghM3r4S4TYSno2/cmdbdbmUKOwvSmOd
         lYwvZZeRUsgTa1n4BDQCdniRvn+S6X7bqcq+KAi6f+JszfvbxRz6RJsgisYqd1Tdg36Y
         VXAAGq079x5Vw37Ymi6XI7CIMrRKaA6h3tRZuB+998hhJuZUaRmsOZCMtYMGiD/pLgUQ
         zQD2PB2eXtvhaGHZ2H3/UpXQ/TzdtGkB/+wBE3Hd58OsCI74NSD8BWhlJF7mrV3uog0h
         uaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=9LZiWf8+nMeRInyOQS4AqXhLFjB149nvvoLwU9/1gjk=;
        b=ac+F9aHR+iml0U5uHSq+DhWeR5iqcOijJ6tUnPR9l3ealZzlpddYgPGxkwpXGYSQfl
         gAqa6dI/Mea2++Cf6E702Lj0ZYBPu5QyF3HeBf31pX/0P4FSt2gt30VGqN5ag/rZxWHj
         16T3xtdk8L8piil8jnQG8SmLXu3bDTNuxK2YQyV7rlmKyXnEcenxE7D5AK4log19uNRV
         3d1zyLlsRfx5ki87eDbkOWYs9dMABa1xZHrzd2RDVn/TWnSfznNKuQ2jWlirF8/T6d3w
         AHnsoMQK75UWqSEppwEaGeYe1Dckl1UCvfun8NqvZmBy4Pf0q8WRhtDYDiOAlkAKHPso
         X21w==
X-Gm-Message-State: AKS2vOzeNHO6H4C4ENi/UXmkWE3mNX0vze0U2T/oq5s1fWG9mCKiWJHc
        B5BjhzKOCg5qyA==
X-Received: by 10.98.59.152 with SMTP id w24mr25360998pfj.107.1498874345801;
        Fri, 30 Jun 2017 18:59:05 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id 73sm6042240pfp.103.2017.06.30.18.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 18:59:05 -0700 (PDT)
Message-ID: <1498874344.2245.0.camel@gmail.com>
Subject: Re: [PATCH 2/2] commit-template: distinguish status information
 unconditionally
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 01 Jul 2017 07:29:04 +0530
In-Reply-To: <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com>
References: <1498792731.2063.5.camel@gmail.com>
         <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
         <20170630121221.3327-2-kaarticsivaraam91196@gmail.com>
         <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-06-30 at 07:52 -0700, Junio C Hamano wrote:
> Thanks, both looks good.  Will queue.
You're welcome :)
