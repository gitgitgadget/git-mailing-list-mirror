Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0761F406
	for <e@80x24.org>; Mon, 14 May 2018 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbeENQH4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 12:07:56 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39355 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeENQHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 12:07:54 -0400
Received: by mail-wr0-f171.google.com with SMTP id q3-v6so12954417wrj.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=gVoFnBzukZsSDWhRO7g21zeNE7+Fn6I3opgtNOuZ3fQ=;
        b=u0KB1R02Eph00DgY5u3w9YOvh+lWoU3nWATC5ikezIfwB/FDmrroJsEL155rxE3gdq
         SJYWLp6SRfMRi2oj8byg0sTL9iAgGn3BX8In/PAyGrJLhzAZFMUMZkpRNXoAntNdtpjh
         DjSa0NDetWVav0uVv8UfTbuUZJc18Wbhy1j8X2jIqGorQpPmPX0AuGQplKof/ykHv+LO
         gcJAs3O31KUFyclyYwT+LEqhhscs5kr92feZMhb24vTL5M4he+oqH/CPJtVgTschN9At
         7NwhaJL0QLMdpYRBFoCQCSj6DD8W+UKHjD2rnO+BSVRbzQ5mWHjUpUAtcIpzxtNsOTEH
         aD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=gVoFnBzukZsSDWhRO7g21zeNE7+Fn6I3opgtNOuZ3fQ=;
        b=Rqh3s+V3vSF+miMyvXEEi9+z6rQ9bOpkEhcwyo0tNKktOtxCxTTA7EQ0p/2Xwy85be
         EFr8wWDOCufeaGKkKQuH2knf6w07LsFBpqydp2K+fDcmRcZWXIwp1aeCZBjLecC0nTB2
         XyaOjzdqx/faKsouQm7NT3IHFDZrF9tsYpBcK2i6CdLIDjZQoLYDwsD1wg7pL7xXNdTV
         wtAjviVcnizCJi9qigXV0DgMqui91U4t7Ki2yJQJjHO20xusK63WufqcyFakWQpwpBY9
         sV1o1OecPwtX3rKX/2zBpsD8+jKd8X4y6QIxZCXzYxzDIq/8+KGPPqEMw4TI5hjKHh3s
         Iqog==
X-Gm-Message-State: ALKqPwdRKf+ttS4vYeQ0poFmpez5ka3kBNZeTbocWa55aFTDV81/Y6Wg
        yrC8tqQDeiN9g5cD
X-Google-Smtp-Source: AB8JxZqovbuyufE/+iORg1Hrvk2kp5kUoW/1LECyw5EWpwiFmKlTuMizQdMDD8FNmlrmaSUUdMugcw==
X-Received: by 2002:adf:c18a:: with SMTP id x10-v6mr8101507wre.84.1526314073447;
        Mon, 14 May 2018 09:07:53 -0700 (PDT)
Received: from [192.168.25.100] (ip-176-198-175-130.hsi05.unitymediagroup.de. [176.198.175.130])
        by smtp.googlemail.com with ESMTPSA id b10-v6sm15445581wrn.42.2018.05.14.09.07.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 09:07:52 -0700 (PDT)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Subject: git diff: meaning of ^M at line ends ?
Message-ID: <6c23ed9e-4a14-12e4-20ca-3ac6f80cf9ec@googlemail.com>
Date:   Mon, 14 May 2018 18:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What does ^M at the end of lines in the output of 'git diff' mean ?

Thanks,
Frank

