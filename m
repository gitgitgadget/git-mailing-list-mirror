Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EEE20A40
	for <e@80x24.org>; Mon, 20 Nov 2017 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdKTRPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:15:02 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45430 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdKTRPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:15:01 -0500
Received: by mail-wr0-f182.google.com with SMTP id a63so8725346wrc.12
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 09:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+tt3X+gVdbwzR8wwMQ+Fns6T608/oHMyTo9e1rsFbr8=;
        b=Skl3n+q4YVZ4lKpry156u6aae2LIDAntOF9bSkHhYwz0nxL1Lnsc/VZ8SUsSV4uhsQ
         OfNJBsAo8HVbQJmhl2sL3yG3SrCzKmNkt+b+RtvMajdIPg5ozrv9Lz4SxQ4zjsP+/Uw8
         qERAEH05e/N/AZOq41rbWCrKrIr6ZTSUSxllr6Xllo7ZeSa8uEiMcfOtlpczkspej811
         0EygVbszzzANZlFuGn1m78wyqiklrjHyinQczQKlr/TcJFG1J0Qx7j6PohViRAZEFNIW
         In6cOUVQN6JRi7M95shXu9hy+c4sGZQX065gEvg29fF8Qa/tu0xEjOHp8pMi9Em/kGKn
         Fxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+tt3X+gVdbwzR8wwMQ+Fns6T608/oHMyTo9e1rsFbr8=;
        b=RGrhfbXEyXOnxudtPYAvh84Oof1ee2/eCwSVhyWy1kacZ2Duq5fJ/9iFxWxLS4W7rH
         AMEfFEJAPOO+GLT2RzrSG6rg0AM64TEavWwGYQGbEi+wWojm9R7CJvXwc7UB7mGK8GL7
         F93sIwZhsfv+Vys94t7WmRaJL8YcgKUEa2hzeuw9nFc6YR6uK/HHxh8DAtcxj6dzyFYY
         QTRvFp8D37l5M9Kn/NhdalZmMUUyXPujJGbOAukGdvNu1BJ79Mw42GvI2rffF9YauNyv
         oWs1bFCKHmks0fOF6bs+H7OFD3i2ng0m+T41t0wdTIbKADRSGoyrFasUi02XN3dyfn/Z
         jGvQ==
X-Gm-Message-State: AJaThX41UJKRLb/6EAvi6/o5xWlxG2u7RkyMihr3W6ljYetl7YP2MZtf
        jiYYsNDb6gXtt4Sb+v6Z7ivU6VXZ
X-Google-Smtp-Source: AGs4zMaAuky9N1G2zvXg5swH2NPyy9uw0lQJBcm6fvebQRY1Ovyhh44wZ21hmvGMClKk4dZt3YpFdA==
X-Received: by 10.223.142.17 with SMTP id n17mr10650936wrb.244.1511198100324;
        Mon, 20 Nov 2017 09:15:00 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 69sm10628657wmp.37.2017.11.20.09.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 09:14:59 -0800 (PST)
Subject: Re: Add feature to stop tracking files while keeping them in the
 index
To:     Viet Nguyen <ntviet18@gmail.com>, git@vger.kernel.org
References: <CANb5NdLCFiaUjit10aV8ewaJOe3UxM28+PwY96dHDM_95GRv+w@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <ba0c7ff2-98b1-7331-dfeb-b6adae0d6207@gmail.com>
Date:   Mon, 20 Nov 2017 18:13:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CANb5NdLCFiaUjit10aV8ewaJOe3UxM28+PwY96dHDM_95GRv+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Viet,

On 20/11/2017 10:52, Viet Nguyen wrote:
> Currently, a file can be either tracked or untracked. So, I propose we
> add a feature to stop tracking files while keeping them in the index.
> 
> Example scenario:
> - A developer would like to add some configuration files with example
> values, e.g. DB_PASSWORD=changeme. But in the future he also want to
> update those files and to notify the others with conflicts.

If I`m understanding you correctly, what you want should already be 
possible through `git update-index --[no-]skip-worktree`[1].

Regards, Buga

[1] https://git-scm.com/docs/git-update-index#git-update-index---no-skip-worktree
