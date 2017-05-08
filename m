Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4161E20188
	for <e@80x24.org>; Mon,  8 May 2017 01:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdEHBmH (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:42:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33900 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdEHBmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:42:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so8349578pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6QyNt9c1lSRVo7WSLvFah/zBAXu3smOin7q6qL9mPLU=;
        b=Kzs5fGdpjnhKLifjUS8BFn70zcZ4Phz2nGXNvNOQhSils9ov5aHW1EDbPhrEwteW1M
         Aocma6XXI3VeVhkQa1TIwyKsZDeHNt+qwg2jktsDKDKspab0I/P/+w8oo+I2Nyyjjffm
         sc9vgljZvgGXvDLmYe0zGDTOSLEh71AdMUGqpeXFLKhM2Hg2jOaR8y5yzlT7FJD+NL1i
         op7cIRGmW6ZmZhIk+mGt/12zRogScWLfelk1SYmY9dNT97EMFxww7X1mLRNNPanwk6Eq
         6Bmv5jh4vI+m+5A37wTazQKOyWunuGy/9adEotoxMZRfkVSvQ/kmJXbro5ynvSE5nnOp
         ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6QyNt9c1lSRVo7WSLvFah/zBAXu3smOin7q6qL9mPLU=;
        b=t9Cy4k191dXPhwxfRlPh7LcIAT/hVquzmICtmZJmP38qAYpUHND16YIqL2gj+/Nnti
         z/nm//txkym5YgbiqNmpvUqtEH7I8IodLgJRijTT2hhUlJ8HtzhSfI8dtQN40k5HMAmp
         twTLEHWUoW8R4b8Ag7C6qkjK+nmvMxK6gWtxINWBaX5Q/zS+Q/1dvN/GFPXcnu7kVrhy
         GeRi2qn9hIQ4bQ8226HOezKF3v3qy+ELdqnCY6zJ1GFPr/gaBGd+EQ6fH1J8WcJjnuXn
         J9uGp0CNOpFy8ncfpXKHSJawfIgYYwGj8unouhz+drOEOjQYKHT9HhwZYhDyqfrOpUng
         6fCA==
X-Gm-Message-State: AN3rC/4Sjx8zSEHViAk3cGjVwq2NLnIVf99QMbuZ4r/4f2pKdRrsCao2
        tkIFT/mQUoAskg==
X-Received: by 10.99.224.69 with SMTP id n5mr15517464pgj.113.1494207725546;
        Sun, 07 May 2017 18:42:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id r18sm19937688pfk.109.2017.05.07.18.42.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:42:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/2] split index extra bits
References: <20170505145713.8837-1-chriscool@tuxfamily.org>
Date:   Mon, 08 May 2017 10:42:04 +0900
In-Reply-To: <20170505145713.8837-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 5 May 2017 16:57:11 +0200")
Message-ID: <xmqqo9v4azv7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This patch series contains 2 patches that have already been sent to
> the list but have felt through the cracks. It would be nice if they
> could be considered for v2.13.0.

There is no way for anything new to go to 2.13 without getting
reviewed and discussed at this point---it simply is way too late.

