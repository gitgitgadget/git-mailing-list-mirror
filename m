Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93580208E9
	for <e@80x24.org>; Thu, 19 Jul 2018 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeGSNHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 09:07:54 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41700 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbeGSNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 09:07:54 -0400
Received: by mail-lj1-f171.google.com with SMTP id y17-v6so7163614ljy.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KQo99wpVB+xmgY69fSoIlQJpmM/cB6hEfKx3YZOwoxU=;
        b=IfSbqgnqKRvExafH0UnmJxOhuHwJmkBMD88jm1x98z8NRNDzqB1hQwEm3/grm7FMUy
         77v8qhD3HV5/uSzhrHraYP3OAxoWwi7VWN4lQUtYXullGyZzf64KSzkpFJVurVu9Xkg/
         xz0Yu9/1adGXpS/T4e0OA8r7m5JRhBwCdeugjhDw0Ymd8oY4JlB9G7NHbmZHtpDYxZCq
         EC3cYDCQI1leAsfID88rfBY1qpcIGM08eVcoYpZHafAyuw90TJjKCPG72DyRd8cleAX9
         8lULEh4Vgn7KNWgGdfbRTVeJn+h9CGZ6M8y6MeFhIR1Jrf/eJmOQLm19T6d3uSKHD1NA
         QUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KQo99wpVB+xmgY69fSoIlQJpmM/cB6hEfKx3YZOwoxU=;
        b=QZtkVr51L2lXQ//KUfWF/B5QNQamQJrO+Tmzj1jQB0KLTZriind+R2p+xpjpv/IINc
         fFoAAUnO6ztKjO3XYF4LtX3eLVkctYhxslbfZF4cJRCbOtb72Vh7EpQ0jAPyd69zcMbi
         rXgAEHtXRdbx7Gy7GbeL8Ea4phgJpLg76Jp8mEa1h2XdjsGy/QGPQvO0c4SkzRdIrrQI
         ks6A1GRkAPmhJrCM0iYa4oDWhy1nVLzPqVmDI4aoj8RzJHAVG+xbvrbUac0gXAHpErKC
         7QpbomXuzpHW3eyYG+UieR7VgW12z8qyZcaN5wM4YOn3qSTXq5toucTpp8KM5yFJMHbb
         tC1A==
X-Gm-Message-State: AOUpUlE17Xyc8p1jltqTXpxMeoVE9+zozkHpD5ycUBU79TW4yOyD0qxo
        KcSImOVoXYJDfZqwrwlXsB4cDJ0Z
X-Google-Smtp-Source: AAOMgpcEzsuBNsM/SFU2oSlU1fIULAqg2EnS4LR0AKsoiCWY932kH/ZZ2b9WXGfWygNferrkU+ik2A==
X-Received: by 2002:a19:e803:: with SMTP id f3-v6mr6910519lfh.84.1532003097826;
        Thu, 19 Jul 2018 05:24:57 -0700 (PDT)
Received: from [209.85.233.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id w27-v6sm945746lfk.5.2018.07.19.05.24.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:24:57 -0700 (PDT)
To:     git@vger.kernel.org
From:   Basin Ilya <basinilya@gmail.com>
Subject: Use different ssh keys for different github repos (per-url
 sshCommand)
Message-ID: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
Date:   Thu, 19 Jul 2018 15:24:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I have two github accounts, one is for my organization and I want git to automatically choose the correct ssh `IdentityFile` based on the clone URL:

    git@github.com:other/publicrepo.git
       ~/.ssh/id_rsa
    git@github.com:theorganization/privaterepo.git
       ~/.ssh/id_rsa.theorganization

Unfortunately, both URLs have same host name, therefore I can't configure this in the ssh client config. I could create a host alias there, but sometimes somebody else gives me the github URL and I want it to work out of the box.

I thought I could add a per-URL `core` section similar to `user` and `http`, but this section is ignored by git (2.18):

    [core "git@github.com:theorganization"]
        sshCommand = /bin/false
        #sshCommand = ssh -i ~/.ssh/id_rsa.theorganization

I thought of writing a wrapper script to deduce the key from the arguments:

    git@github.com git-upload-pack '/theorganization/privaterepo.git'

Is this the only option?
