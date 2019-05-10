Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5E11F45F
	for <e@80x24.org>; Fri, 10 May 2019 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfEJMKw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 08:10:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46498 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfEJMKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 08:10:52 -0400
Received: by mail-yw1-f68.google.com with SMTP id a130so4513295ywe.13
        for <git@vger.kernel.org>; Fri, 10 May 2019 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ttz7cFugtbVJDauhmT/ZXn7HdfdNqIE7rDigK4LwdYY=;
        b=k9Z5ieR3g0lB5bvC0Lw9d7/1iQJP3eUW6lJNdWi6ohxu+/Uui6C8hRcxoAJZh8Pcn6
         fp8Son6gntbMb+YAn6izouFqWSCJETiAUn38kchwx5PXKAJDlo72wWwY5izkpmBHc1a3
         2k6MibTtdq9Xp8uOObQxwEG2T+kiOfLXTi5KgxyHl4fHtIFh19Ih0LAAac39pwp0wzGF
         BaSW2C8uFKiFzbMTGKSTlG83DaO2J9WRI5xKxB5G3LP+Usn9/rM4K2lD4Dlj3HhZZ7vN
         MzhyovhVSS977mt/h/1Lgu4UsgcpytXkvyX+XPcXRFZQ1eo6Psj48Kjxzrf9pNGKTBQu
         9ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ttz7cFugtbVJDauhmT/ZXn7HdfdNqIE7rDigK4LwdYY=;
        b=pO3wOUzpfeowYKXuEwk8nq3IxErFOQDPK4gaVoTlJZzdnVTT0VoJQneUtzw+63pAX2
         3wnw9XVzH6aMFW1HWk/Ou0pqoTV8XDC3lDghOB1Dx7E4aqs1J2ceZwGaC5Amz+W5yNlK
         GXq0i5fxdKDZTk21FccsPQ3ByVjQdmxfHwMNlkkT+w3foJ7u5QEVxToJX4Mi75V7miLw
         j/+F3Vz1GzFkYlaUy+JS/vsCVVu4zFqxt4+GptW+9EV8cvyq107NJqFQ1WO+CeEfTWJ0
         oZedtQfR7LansyJrm6xooQNvxYjgeCoykPpV8zBREjEzfSR72NKP5J0jSWkm0Fnha565
         SDPA==
X-Gm-Message-State: APjAAAVJe2Uo5P8J2W7Coe3yzE2ifonl5mtLVM66919HnvdWSn4+2aNn
        6QQN/ggtqSNmAA0ME5oFKJvpLVso3pI=
X-Google-Smtp-Source: APXvYqxHZtYMGzNgfYeErnsK02QydQyvKYToQ+pFrYO8kAHEdeYHcncbaMB7wMM8VXrwZPcHSruDlA==
X-Received: by 2002:a81:5cd6:: with SMTP id q205mr5095833ywb.13.1557490251282;
        Fri, 10 May 2019 05:10:51 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a11sm2801333ywh.49.2019.05.10.05.10.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:10:50 -0700 (PDT)
Subject: Re: [PATCH 03/14] builtin: consistently pass cmd_* prefix to
 parse_options
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190509212558.GA15438@sigill.intra.peff.net>
 <20190509212850.GC15837@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3851512b-9957-8e77-f4f7-3a859f808676@gmail.com>
Date:   Fri, 10 May 2019 08:10:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190509212850.GC15837@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:28 PM, Jeff King wrote:
> If a builtin uses RUN_SETUP to request that git.c enter the repository
> directory, we'll get passed in a "prefix" variable with the path to the
> original directory.  It's important to pass this to parse_options(),
> since we may use it to fix up relative OPT_FILENAME() options. Some
> builtins don't bother; let's make sure we do so consistently.
> 
> There may not be any particular bugs fixed here; OPT_FILENAME is
> actually pretty rare, and none of these commands use it directly.
> However, this does future-proof us against somebody adding an option
> that uses it and creating a subtle bug that only shows up when you're in
> a subdirectory of the repository.
> 
> In some cases, like hash-object and upload-pack, we don't specify
> RUN_SETUP, so we know the prefix will always be empty. It's still worth
> passing the variable along to keep the idiom consistent across all
> builtins (and of course it protects us if they ever _did_ switch to
> using RUN_SETUP).

Good explanation that we _should_ be using these parameters. Forgetting
to add these prefix uses would probably not be obvious if a patch added
RUN_SETUP.

Thanks,
-Stolee
