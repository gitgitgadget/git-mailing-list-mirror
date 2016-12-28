Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665B21FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 07:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbcL1Hp7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 02:45:59 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36448 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbcL1Hp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 02:45:58 -0500
Received: by mail-yw0-f195.google.com with SMTP id r204so24107865ywb.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 23:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k1rA3sqaHT6sVkojmngA50Gc+tgI8H8FtgdLFTJ+u7Q=;
        b=XazOwjyiu9sdnXFc2vn5j3yMrToMkB72ECvwrStni5EOh5tCkUK5rySxMa01hT48w1
         91vYOfc83ahxxvpLUx4og5pbw3oWW2nc/N4T+qI+6TBkef7CDkXPprpq8NlW41LAXh1n
         piu8t3ZsV13N8mmByvdFYvR8IbOl2iXLd4TGgjdbVh2aG6tyN1MY4yu/Q8H6dyEaMbgF
         L/doLBoNwuXsbiOJm/yKFRJ8TMRrbk+w08JBx+5BglJELbfQe52ZKyvZ/BqYZYRdg/s7
         4HX+UHRL9Yz0gNPjvz48l6YLpNLi8hwOIaURDEPUeZKu5gC69Jq3ojM5E9P+RVukc6Wv
         PItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k1rA3sqaHT6sVkojmngA50Gc+tgI8H8FtgdLFTJ+u7Q=;
        b=n72XxkbooHhn18rutT6e6Z6bh1XcexaeIwbEfNJB+I5xLENKFgtOwcrzwc/Ed3TE+K
         1P7QKMtRZ/w5ymcubSpfVoHJ00IWUq+ovhN7tI2gjUO1xb+Ea7uIiHoJ/8QgTP1QOXl9
         IxzRU+4RN19QoFzZs04t/YCqG+giwEXocaqqDN2p4nNytAaWhHKQgyW/LEi6ePSmuTOo
         ueCpQJNUKGGvZDVMO2erXjm7o1ohgZrTIcWDwwVabm1os7+0WxZWSrUWCVQ5ZdDexduN
         U4ksIcMNetyvd7pdhQmKY8L8cWc9Ly2pUgpGK2VoKASFPYrFzH31aJreYr/lbVUxVxJ4
         j+xQ==
X-Gm-Message-State: AIkVDXLV7WtsFIsLSFdVuMGuLcH3B5xlxxGoD0ARNrv3DaMjFgfb9It2CWZnegWZQxq2z+/lqp+IDr3dOdvMzA==
X-Received: by 10.13.229.70 with SMTP id o67mr27850159ywe.131.1482911157587;
 Tue, 27 Dec 2016 23:45:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Tue, 27 Dec 2016 23:45:27 -0800 (PST)
In-Reply-To: <xmqq60m5842g.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-3-Karthik.188@gmail.com>
 <xmqq60m5842g.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 13:15:27 +0530
Message-ID: <CAOLa=ZTcNj2Wpknim727nAVJzi8SqGqyUCph6uGGfgaJPPnLiw@mail.gmail.com>
Subject: Re: [PATCH v9 02/20] ref-filter: include reference to 'used_atom'
 within 'atom_value'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Ensure that each 'atom_value' has a reference to its corresponding
>> 'used_atom'. This let's us use values within 'used_atom' in the
>
> s/let's us use/lets us use/;
>

Noted, will change.

-- 
Regards,
Karthik Nayak
