Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4271F202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdKUBQh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:16:37 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:45242 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdKUBQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:16:37 -0500
Received: by mail-io0-f178.google.com with SMTP id z74so17714659iof.12
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 17:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTLFZXT/tUQBJ3cghdbyAzmFN7ib1Mr+d4TmBP09+2Q=;
        b=LZHS/mjAiYywmd0jAs+aaVLNxCzlrNlJHvCVszkunDYw/1ea9fq3gfrtBMcRqWSRMd
         MeBySgSqzxTYAnuOH/zMxzhN5rDtOCjA5Xe8721T/9Y/1FpUUiKuZeFUXZ+kQzs0Jn+h
         dpRMCDhoHDLly+dJgXmzZtDCWRs0ldG8DMfdodrz6bOHRfxHHYDnpB7aosL6EWGBfLqs
         LEDJ3PsM5nbu6yXy0/7K1VbyAgXPIzua2odl6sbJ+Ra7AMQtvMgCP+v7JkhYBG7tS+Ox
         nN6WeA8Z1jx2Wg8FxLRBIupdSIIH0nj3wUNffAmdielW6sPfD/OkRiVSnWVZ1uPRRU0z
         Tnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTLFZXT/tUQBJ3cghdbyAzmFN7ib1Mr+d4TmBP09+2Q=;
        b=VhTj4mjqD0mn5G1rubQRwCWkluGJJaUxQBihRtiBuyOQusoQEcTF6UO9VKcIOs7MKt
         lKIbhWSITSRhtvQ7Owf0jRzj21zlbp3KO4NJFYWdt2YiZjnPkLvA/Jw/2TRDLtA3wtIN
         MyihNQzyiRN/ysasQWSf67XTOGjtaZVg9YSex7BlKd+t4kXqK11e8yJx6NoArVyG+4ch
         rXJhjRE94KyGBwsGw8mBpk+Kq5JKGokC4ilwNeHMm5zWorRkRfj/P/nDPuJapEkg2xlK
         ZtiLuUOarNKFPVHXe51wckUlLBAx11vWPuOEfCNOIghsoW5esH6VFHTR8JolFX0smPZp
         HyIg==
X-Gm-Message-State: AJaThX6gFsasSnMMsA04uJuW2/BhWb3rujyMc+1GeaXyjp6uDaln0T6o
        cX7wD/l1sxYeDfShKzu4Axc=
X-Google-Smtp-Source: AGs4zMa0Dwgse7tLjdIwbGtDCo5DRDJgLfZo7We7wLDOGY4GxaP8bmfuvo31r7e3hkT86vkQp6eMYQ==
X-Received: by 10.107.36.17 with SMTP id k17mr3348071iok.176.1511226996472;
        Mon, 20 Nov 2017 17:16:36 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 14sm5026509ior.48.2017.11.20.17.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 17:16:35 -0800 (PST)
Date:   Mon, 20 Nov 2017 17:16:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] list-objects-filter-options: fix up some sparse warnings
Message-ID: <20171121011634.dw6tdgp2s7lpl2lm@aiede.mtv.corp.google.com>
References: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ramsay Jones wrote:

> If you need to re-roll your 'jh/object-filtering' branch, could you
> please squash this (or something like it) into the relevant patch
> (commit bf0aedcbe1, "list-objects: filter objects in traverse_commit_list",
> 16-11-2017).

Micronit: can these messages use the ISO 8601 order 2017-11-16?

That way, the date can be read without confusion regardless of what
locale the reader is in.

Thanks,
Jonathan
