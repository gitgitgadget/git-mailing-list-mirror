Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E44F20188
	for <e@80x24.org>; Thu, 11 May 2017 02:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbdEKCum (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 22:50:42 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32896 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753996AbdEKCul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 22:50:41 -0400
Received: by mail-pg0-f43.google.com with SMTP id u187so7123654pgb.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XlcLIdoFov1V4Vq6fugyM2JLNOm1gzxquXfQ/QjMsYc=;
        b=DYAVXQltuZnGyiTOyi1M3VWbeQYl4yxHtKtFF0ubohGtQB2tPwzYNw5+qOWXMaojce
         PF9VYFZhmYusF4vUxmprmL/MIXEo53PYGtaxaHz1e+BmPTsr2+8liZIkcWgrTgCy9fOy
         hnilL4NBiU0V3rAt7+dP5E8pGrZPMaMbo4IY5DyRhIfPXFJyc3ASPz3i9FiROSaSx7d1
         3HLBvDWG2IC3+QeVFRuCxG/PwK96Kxco3bVTc3LXwIIzA8AKSNznmU5UTyu4JwLJzHzT
         y65pbX0L41TS+d791oAL6vu0DBtcE/IqW5zp85U+sMpMORrST3MvKImSKJmj59V00ojx
         9yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XlcLIdoFov1V4Vq6fugyM2JLNOm1gzxquXfQ/QjMsYc=;
        b=EsAkrw25UbWARHM0KPhGZ3JqZl8QRhWuXSR+ufBYOyJwp6hQF9CdXJ0gqbG7OwYP/I
         z8hgg7nwRnftv5FTMt9n6yjEI+feWy7QnSK/iHlv0HXAjSgpyIcdLap+cC0rbjG9OVD1
         sLKOapizgqxe8jp1CM1xkMr5oH6ZtAB+YmDnBYLLj5AYV6iFPE1TPEfE72Q2RUbCHpAl
         uxu1Cp/mD3OYHh11MWkyg7+YRdLcfYY7m9oQ3SpHwnCVn5MKmXAoGG/imqzPg82HG1yX
         7qm6MNer0mUIUQq28ykYMU9VEP5wIdHqelj39TQmMCwq9QKyLvgk+4ARn9LtZN0s/Gxu
         7UHQ==
X-Gm-Message-State: AODbwcD5lAbiBFVNcsur1RZpVVlEHvg6EkefVOKKEsP1BG1Y71kFNWhR
        jflbWh6R9zlzkw==
X-Received: by 10.98.131.134 with SMTP id h128mr9788152pfe.0.1494471040607;
        Wed, 10 May 2017 19:50:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id w85sm418068pfk.62.2017.05.10.19.50.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 19:50:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jean-Noel Avila <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
Date:   Wed, 10 May 2017 19:50:39 -0700
In-Reply-To: <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 May
 2017 10:08:14
        +0200")
Message-ID: <xmqqinl8cdj4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> * ab/grep-pcre-v2 (2017-05-02) 19 commits
> ...
> This can just be ejected. ...
> 
> * ab/grep-threading-cleanup (2017-04-16) 8 commits
> ...
> Can also be discarded, will re-send in a different form soon.

Will do and wait for replacements.  Thanks.


