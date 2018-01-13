Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BB21F406
	for <e@80x24.org>; Sat, 13 Jan 2018 00:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965360AbeAMAW0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 19:22:26 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36669 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965304AbeAMAWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 19:22:25 -0500
Received: by mail-qk0-f174.google.com with SMTP id d21so10820767qkj.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ahF3H80v78dRAIyL4p0kjNfpd9/OGx9o5wtc5dVfSf0=;
        b=Oeo/MG7hldNmrRzC19zj2DtwBPZ6zjFzAltZ979eXoUpvIVtPnmsWAM5tPJjkNmvtS
         +yUnZ9kEz4rxb9P6VVAwz2EN9OtcqIWjTkQ9XuzbUWxedW7ne1almc3Nj4H5/pcnLdTf
         UKU9478ihrYq+28rmKa/s7wYAz/OQR4nXubPIgdSn5NhsFmzDsFdjURJhYgGdQRRwXqR
         yS20ou8ePslLR63imZeNhZ41C1+p803RaqqFlwdCUJN+om7Oet63VqBrEWr+Pj2meaF7
         LkPD24GsnVoeo4sNPQA4nFFB/4HdwvauAZXU+cKTu7ifaA8O8Pgfuv18KmuzY6evW/vP
         QIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ahF3H80v78dRAIyL4p0kjNfpd9/OGx9o5wtc5dVfSf0=;
        b=mFL/b1FosZSPypWeRKMOiM3U6sLse5BHrT9NgDKtrQ/BmMbChLRReGopaBK2j6DQwr
         5PNySGtZYqAT0IV9k2ZZ0p/RmKMFucN+4DzoiDCsJp38hhj5BYLvqbcMfDwEv5uoNkLA
         xVay29GJTJzOVmJdO5BlsO77anlBoqmyhnb5pu4summwf+/MFHcp9FNs9wOT5u1ypSOF
         UGyEqZByxDDfZZ+jfOZ7pw7XLLKBFzszRET7DvqwFAOyrTG9BKCFqGFA6g6+ByCwv+eY
         PG3YYheVcJmANNU5kbHe30m2T6PYhHIxPYldGBoWapsjZfwqja30fo5KGC3FMyADoXkH
         u7ZA==
X-Gm-Message-State: AKwxytcCHR+nAIiumAS+rDlUT3LtTf2M67enUPUaJJz+M9uzeuvgD0Z4
        BegNSoXetm5FFxA9+zR05ksCq2EY
X-Google-Smtp-Source: ACJfBosomrSTXpQowjjqHbAArGLA5+SiGyG93MOFdhvIrJicb0sznMiwh8GP/yINkLRDP3ZBq4ll2A==
X-Received: by 10.55.214.75 with SMTP id t72mr41033747qki.12.1515802944180;
        Fri, 12 Jan 2018 16:22:24 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id 137sm450979qkg.83.2018.01.12.16.22.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Jan 2018 16:22:23 -0800 (PST)
Date:   Fri, 12 Jan 2018 19:22:21 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Andrzej =?utf-8?B?T8WbbWlhxYJvd3NraQ==?= <me@osmialowski.net>
Cc:     git@vger.kernel.org
Subject: Re: Git uses wrong subkey for signing commits with GPG key
Message-ID: <20180113002221.GQ29313@zaya.teonanacatl.net>
References: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej,

Andrzej Ośmiałowski wrote:
> I have an issue with git and signing commits with GPG subkey.
> 
> My setup:
> - master key used for certification only
> - subkey for my main workstation
> - subkey for my mobile workstation (a notebook).
> 
> Both subkeys are used for signing only.
> 
> I've configured git to use my specific subkey however it does not
> work: git config --global user.signingkey = KEYID. Every commit is
> being signed using the newest subkey. I've verified the same behavior
> on three systems (although with the same setup). I've tried to use
> --gpg-sign=KEYID flag, but it does not work either.

I could be wrong, but I think you need to append '!' to
KEYID to force gpg to use that specific signing subkey.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A vacuum is a hell of a lot better than some of the stuff that nature
replaces it with.
    -- Tennessee Williams

