Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E8F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfA1SIF (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:08:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfA1SIE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:08:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so19220955wrp.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RYqql3QwDNXC1ejY8b5zmJ3K30fi69ZuAdMzxydLp6Y=;
        b=REczzDCQZu93Lal356maKf0H90ghe9Fsp8B0ZoKj8zFB+9wI83a+mUtGJJN0hQW6df
         8dcTmwCK1AJ2qQ6ios/PVc4w2mU/a4lKZ4kV6UP0BUmvhcELhO4cHWVecNhXh5Dwy9FG
         o6orRor4ebOIG0RgLeTAqxV/4JAbxI7MWWscVoIm9OBVmQ6HqtKLOLP+6p2aSfEK+7Gx
         TLuR7SVapC36O84HT/QIc6lEON3ETRMooiRlV59zBm1MIOpFmEY3Jxgn+POcYJ1eRX7y
         A/HEv61XHboGolt36W9e2o8lztkCVozgYP+OJj75X3CEh+urYahB1pSRybcld7WiTvDr
         Hv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RYqql3QwDNXC1ejY8b5zmJ3K30fi69ZuAdMzxydLp6Y=;
        b=Wd2u4z4WXQnDcLcU+nxJhX7UaMGrCWd/JiWtfx+sUpmIYdJkgsJWmy6ShoB6ttxrO0
         HfYSMhCdI/B2VgrJn1wr6BNeiyTwg/XUTBcVCmBU68tKq96iBZd4bWFFTk/fFmRFGfzl
         EiOTH9O4T+1ptoqrM88XhknSl9HGQHbAsJCa+0t67vq0a4wXOwYfmkOGFAlgDmmOfyQ4
         XkKih0SUlHkdt8JGe45bAbKSuEQbZdoXdppzP+rPidytGw+k8ADh96C7kjyMM40hGvE5
         c9mgZU3p1W/GBndg6uWHnh04ozEq0I8LGu80Z9qj25KiFlAV3MP3OVI5QtxeOPDTrXH5
         Z4mA==
X-Gm-Message-State: AJcUukcni+wn1Qmq0kcIiRGkZtDXTlqOA/Z4LYkFsDMMUhC3QH3F40XW
        FgE7ZINHi1RwnRHLR+Ws9bo=
X-Google-Smtp-Source: ALg8bN6w34HhIFVxCoNSChM6nEWOpzpEdwpQl0JCrWbQsw5hfzty8uoet+Mkx8TPmPdNIIOzsjZBCg==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr21483935wrv.101.1548698882570;
        Mon, 28 Jan 2019 10:08:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n82sm54520wma.42.2019.01.28.10.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:08:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Sebastian Gniazdowski <psprint@zdharma.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: There should be a `.gitbless; file, protecting files from git clean
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
        <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
Date:   Mon, 28 Jan 2019 10:08:01 -0800
In-Reply-To: <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 28 Jan 2019 12:05:31 +0700")
Message-ID: <xmqqlg34bqpq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> There's a patch that adds "precious" git attribute [1]. I was going to
> resend once the backup-log [2] got reviewed but I might just send it
> separately to handle the "git clean" case alone.

Thanks.
