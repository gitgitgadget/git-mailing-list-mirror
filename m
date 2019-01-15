Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF721F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfAOXQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:16:54 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36878 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfAOXQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:16:54 -0500
Received: by mail-wr1-f48.google.com with SMTP id s12so4910910wrt.4
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WT8Py+7BJdOxBpqr221FBWtj3MexdE+k3Q1ZJQ/ftoM=;
        b=D6ZNezkH3iiX8YOwDvtU9fwJ5d7Bk8SRUZSKNLkcTTmE1T14AV0LCzDOrzr8zeilrt
         Esho8muE2QYsOKF7rYTxGy3KL3oWv3Az7JuibQwYY8YhopeEsmieFp81q/twScoVLIr5
         ab0ko1K27WxUYYfZIj8OYgVd40bU2T7bZ+g3EkfSCGmkGoF7U0BHoGZhN3R1llNyg4fb
         gelhecuOTDiBGKIwwb4fxxsEkHZTWvnftkcFxov/F2Cjbu0Ht6J+lg//ENmgdZlaeK+I
         Pn0Y5C0yITHfY9bUoVZLSj/GKdo11vmdx4xMnTzkeOwnnGeeThbnf4GJm6wBp53FZazD
         EnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WT8Py+7BJdOxBpqr221FBWtj3MexdE+k3Q1ZJQ/ftoM=;
        b=bLdcmZMf3gBrXEwqAUDWEKjkDQgTgXfNV9jP/suWZALm644gpsZ98DgFvYW7l2WbKz
         GJzMYQ2FYlHG8ro1FIGx1PLBF7T+f6XxCvAR9NcTkRYr4XNHIsT29GkvRypgyIXL7Qe3
         Z+a9ZaLVbzT4qGaHv35WJtTeUzbC2B7QsDE9vQv/MyC4IYjqQXJ41AJelb1xSMLvBdje
         mbbGWsz8XoIJ+woMSSS4Pq94RdBeYjh4Mm1d9cIByB2rmiev/a710wfy/zMPDvluM8Pw
         UnZWzYE2y1vJzWrnCKDmwO1ZwIj9WUbhWmcQTe4pIbT/ss0RTNC0/G1BzgrerF4vQd6b
         yDjw==
X-Gm-Message-State: AJcUukeJv5xZxcAsMdMfE7yQ1Wu0QdQsFrnocFqzm8EMb/PaB0LNGFtt
        c1SDat4xMe9GBIDFEwb/4S2HyVNH
X-Google-Smtp-Source: ALg8bN4xWo+GohS1/NvtovAwYftvw+HEprvoIMjDexI5Zec1b5FCVMDvlnDe7w9MKfx3YhrexiNfbQ==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr5090125wrq.273.1547594212103;
        Tue, 15 Jan 2019 15:16:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o9sm22179453wmh.3.2019.01.15.15.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:16:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
        <20190115224901.GA22644@archbookpro.localdomain>
Date:   Tue, 15 Jan 2019 15:16:51 -0800
In-Reply-To: <20190115224901.GA22644@archbookpro.localdomain> (Denton Liu's
        message of "Tue, 15 Jan 2019 14:49:01 -0800")
Message-ID: <xmqqmuo1pl3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The current patch should be kicked out in favour of the new revision,
> v5 [1]. It hasn't been reviewed yet, though, so I expect some revisions
> before it's finalised.

Thanks.

> After our discussion here[2], I resubmitted a new patch describing the
> use-case of the feature. I was just wondering you're still "not quite
> convinced" or if the description was just outdated.

I personally am not.  That does not mean much, though.
