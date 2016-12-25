Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE2A1FCC7
	for <e@80x24.org>; Sun, 25 Dec 2016 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbcLYX4E (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 18:56:04 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34142 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753757AbcLYX4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 18:56:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so12923167wmi.1
        for <git@vger.kernel.org>; Sun, 25 Dec 2016 15:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tC3D0KA2xcXtXBnviPnJF7RnLT++b05O+7pXO/A0DqU=;
        b=F7Mugkkr4LMb47L2rVS8L6mcIkED86J6lI2sktnT3IP46dEVGsWZE9QVO//N5bFnKN
         n4MZhOFnmOksynwX3DPqWdd2s98Prr7ec6OGRZwDNjasYi6k20PUwaKedZV5sc4Kc/gC
         kc+l2nRI4oj4Ky8uuvM7zyXhXp72UcAbdrQTP/64Sqydwv1EKrgLNHPqlZmfywdhTAaP
         86AMDv1BYAnMu2t8KOQTTkO+/TgQ5t3oW2ZSE0cBm7MucYDlOq74KWdXfUH4AKWsZdjY
         sTmP+pVgQBnS8utErQ/8tGv7TON6kPdUppRAsVx3qrVNREnJBj+SMAaS50o8VqA0cN6C
         2z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tC3D0KA2xcXtXBnviPnJF7RnLT++b05O+7pXO/A0DqU=;
        b=P+dGvI2CjQpiSLR4+YKT5gjDdpjcRwsvfVBdmKw8UD4we9/C61bKB71UqSTvVJqD6p
         8DkXv1qc+JzmzXYABhMn6filnoZuEF3svCSJ+DxuzIoPaYfFkWv0zbAbrx5qoDRTaD8x
         sneM5ssVVF1/F+hUO7agZm53UosWosuQrzceF3tWfLn3x7kRFNn+djaPTSynUEuPyvM3
         Xpfbxx0b9fyJ40ZHUzWMPBQuiJI30waF+7W/Paj715SWERFpk+/Irs48yTWltb1NlLXw
         hDDP9WgfLRJosaDOB5DH6fXB82H+5Vylt6/wbA31Sp8VXa1TFDgLLfAxZ37nYA712f8/
         Yulg==
X-Gm-Message-State: AIkVDXJhVGeJ8Hgck/7hVSfKkU4yO41doMrMxBe71L8R3959jjUmS++GiudRI6DVmt6mCg==
X-Received: by 10.28.105.81 with SMTP id e78mr22910332wmc.140.1482710161434;
        Sun, 25 Dec 2016 15:56:01 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.111])
        by smtp.gmail.com with ESMTPSA id jd9sm36478235wjb.9.2016.12.25.15.56.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2016 15:56:01 -0800 (PST)
Subject: Re: git-apply: warn/fail on *changed* end of line (eol) *only*?
To:     git@vger.kernel.org
References: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
Newsgroups: gmane.comp.version-control.git
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <a3c1d05a-79f7-f3c8-6771-e68e8d5bb4f5@gmail.com>
Date:   Mon, 26 Dec 2016 00:55:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/12/2016 00:49, Igor Djordjevic BugA wrote:
> This is a follow-up of a message posted at git-users Google group[1],
> as the topic may actually be better suited for this mailing list
> instead. If needed, some elaboration on the context can be found there,
> as well as a detailed example describing the motive for the question
> itself (or directly here[2], second half of the message).

For some reason reference links got excluded, so here they are again:

[1] https://groups.google.com/d/msg/git-users/9Os_48yJdn0/j9S_W7h-EAAJ
[2] https://groups.google.com/d/msg/git-users/9Os_48yJdn0/5S9Ja1fEEAAJ
