Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E177420954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbdK2Biv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:38:51 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45783 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdK2Biu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 20:38:50 -0500
Received: by mail-qk0-f172.google.com with SMTP id d141so2448513qkc.12
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fYbGM/DV56v2E/acfbdSNsFQ6vAoUIlZctyzNMeMD+k=;
        b=qo0meC6+YHNej28vaw2azldxRtT76CQRAniADC1ZbRp7R+CfPuC9x8CZfvG2tPEceD
         kniFXtmLPN86MswR1Yu95bjRKstek+k8ta10Knix9EvK1diF0ipaL8+hn/4V9wCYOMrW
         KZeKltwu/eVTktB5fGPfIGWpTPHsBEdL1/wJK9jfa/rFsTJ4rghehKDkm4LLZcP4Zgdr
         KVAvQzxJsl7+GKbL+eCKAVpgBRTTbFGZY1b49+AifF8CKVWJyQEUAe8c/ZqglRAhXvhf
         PSmJ4LvRIPuPIbsQzH216vaRuUItlmyKGMZlHaQkcGb8orMYoUxQ4OQhj3Qoht8+BOch
         6Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fYbGM/DV56v2E/acfbdSNsFQ6vAoUIlZctyzNMeMD+k=;
        b=kqDnoegemKiPZqGvidYPw8NhESPvwbWQ0kfrOWnxIbgOXLKWsOxG9SHWrPRCXSg7aC
         4Wlu8VI/mvPapUIwOxZyKEHP1x4DVVCepHTVyrTeQEUIYLRI0fhbSxUDP1tefWik+l6s
         LUmnzTM3FlO6wWVZ3ZcY9fHtR2+kqOKj7Vm9uOpy2d9eR0JvOELFQ8J2Ex0a+FO1xOV3
         7yRMGEo5ZoNsSoKzX4gSIAiS0mpsmjYVBYOZdCAVIDWslSFz1Tw6NdyqPtlDFf0Shn02
         JbTnBt/POekIiLoVYti5jpzA2xpQl2S/lGXHza5pwBtM09nnhe5BGvLqTOcNhcDc+LRS
         Ds8A==
X-Gm-Message-State: AJaThX6T08QpuIT7cpHCtUsN2Z6DFJJIfVgcFIh5y+3dpDtNETXYMX9I
        BIxaRlw95FqKtNwJZs2RtevV8g==
X-Google-Smtp-Source: AGs4zMYRxtImCCqRIS6xD3b46xX4NjnmGZi8LTzSdu9RxpqWHcJpNzZmWMZEZSfEkjVawsEmy/NV2g==
X-Received: by 10.55.122.134 with SMTP id v128mr1981710qkc.354.1511919529866;
        Tue, 28 Nov 2017 17:38:49 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id c16sm411677qtd.80.2017.11.28.17.38.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 17:38:49 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dnj@google.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Question regarding "next" merge
Date:   Tue, 28 Nov 2017 20:38:48 -0500
Message-Id: <20171129013848.37208-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
References: <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

I read the "what's cooking in Git" notes and saw that you were intending to
introduce this patch set into "next". Johannes pointed out some quoting errors
that break Windows builds, and I have incorporated fixes in my working copy.

I was going to hold off on publishing v4 in case some of the other reviewers
had additional comments, but if you would prefer, I can publish them now
before you merge, so "next" doesn't break on Windows.

Please advise! Thanks,
-Dan
