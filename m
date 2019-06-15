Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515011F462
	for <e@80x24.org>; Sat, 15 Jun 2019 08:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFOI4J (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 04:56:09 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33300 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfFOI4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 04:56:08 -0400
Received: by mail-wr1-f50.google.com with SMTP id n9so4885109wru.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F5B2S85rTpYug1YvyuItKAZ4P09VoeOwOmmrd6ps0dM=;
        b=SUPltlKrsGAk7CfjlL51RXxZPeCbwcb85DO42zjl/KPHK7xjLLp+t1WoJU52CR07fj
         zt/zpnXxM42q7E7y7/0PE+61ZfakVV+4XrgMS3MJ7j2dWYwBFW+o5xvldV07TlrY3LL4
         k66nIpxxaLJ1mZZ33XJKYFiQj+gV/OGLlWEW5KapFZZdvymslVzgbPkz07uHmfhr0P6/
         teCj0Mrn9u1zLwUWeSJWYpgMwyQ5ZhjFQmn4yNOYZgeSqmRNqwkkT1iHAReEB5ujKTjk
         wCZiDY9TWx/RGzUK4xymOPgdxk4As0NS3Fy5RARwO1wR9bzBXigDY4zd3QQ7jiisor4R
         J2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5B2S85rTpYug1YvyuItKAZ4P09VoeOwOmmrd6ps0dM=;
        b=ag4MscciPDcWpzqRJqhQgbXXYoRXD6o16v1oUYNok0medZavQoRLfRmxHyYSFeMRl/
         UgSDnFJn4MtOCZi98ikG5PS1LLljf0K4YFDNfE4aBevFFZawiIZE+/lDg+3HnAiFlFFE
         uVa/EteSouDKnu2Qz3WxIP67TJEamFsS3kwa0mwYZDqVwhcfzYoiNhbDuGcKC6M3tXAA
         kV2O+Af9sUmJNFMUZOSEMxkZSo8zbp6p0qE87CcCXfMfXWNrwyV2PukUtOVUx4rbhclh
         +C5rf6v5N84G88P7MqrmntO/FFgrm0vP0Qn3EggK7dfA9cY2+y2e/r7lZNicnK+8brBy
         8vrA==
X-Gm-Message-State: APjAAAWbHlfmctFLbYbuEg4+v6h9KCGvR6gzuLlJ/e07ObWRXyNajlsl
        VNbPuC2tf7uRs/zZR0xh/vI=
X-Google-Smtp-Source: APXvYqwH89hu5COcwlwkGi1xza8FQpgJpcOJOW4LYYf3/+4gI9nPFaVUZJRTGlyfN+JkxmxOyOft3Q==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr1900552wrv.63.1560588965915;
        Sat, 15 Jun 2019 01:56:05 -0700 (PDT)
Received: from szeder.dev (x4db96019.dyn.telefonica.de. [77.185.96.25])
        by smtp.gmail.com with ESMTPSA id j18sm727349wre.23.2019.06.15.01.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 01:56:05 -0700 (PDT)
Date:   Sat, 15 Jun 2019 10:56:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sam Bazley <sambazley@fastmail.com>
Cc:     git@vger.kernel.org
Subject: Re: rev-parse --is-bare-repository incorrect when work tree is set
Message-ID: <20190615085602.GH31952@szeder.dev>
References: <8ac7a1d8-9185-b527-67f4-d5e25cb3eaf5@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ac7a1d8-9185-b527-67f4-d5e25cb3eaf5@fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 02:59:50AM +0100, Sam Bazley wrote:
> rev-parse --is-bare-repository incorrectly outputs "false" when testing
> a bare repository with the work tree set.
> 
> To reproduce:
> 
> $ git init --bare testbare
> $ git --git-dir=testbare rev-parse --is-bare-repository
> true
> $ git --git-dir=testbare --work-tree=something rev-parse \
> --is-bare-repository
> false
> $ GIT_WORK_TREE=something git --git-dir=testbare rev-parse \
> --is-bare-repository
> false

A bare repository is a repository that doesn't have a worktree, and in
the last two cases you explicitly told git that it should treat
something as a worktree, so it just acted accordingly.

