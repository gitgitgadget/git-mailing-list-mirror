Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945B51F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeCFVDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:03:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34603 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeCFVDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:03:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so19773622wmd.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3/KeF44ioAnBpRVkFPwtrwdSNpkqhHjafD6bgSm0Qak=;
        b=W7i2PjwyiKWTFyUzLV8k40TzMU6Xj0PJD2P+vHVuo8pghymBmPPuXELqbFU+twt0v3
         F5VEZDEfrY4Ugi4BdR8cxzLVKgc1SP2tpjA1s/p+KgwcTFZTZzj9Rlfny3zV4j5TIr4/
         79kqFbVEpcGo+Mtz646Zc3smfFixM7n0ipjCzyD+YweOWOAFxHizYMG/oxu9WOFkR6WE
         RbLZKwo2tr8g5HPVd97gJxLhYzl+P8V4NeKYyiLu5rz7TBoDV2EHEYtj+3sp6u8hGl7K
         jLOoWJKMJajNJiQshTcKyW4gk0KTpSvnnjPIVnFs0WQcHpe/awdBJpccprGzF6fLol41
         UYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3/KeF44ioAnBpRVkFPwtrwdSNpkqhHjafD6bgSm0Qak=;
        b=TGE3ZQUHYnEucJXZaZpBWhHHGAD4POIr+waFozSFvLjSrNyv94gAn4ibLcpV/X3o1R
         z/brcyDwAiLutkVix8y6dX4SPiYDUz6NXTBLd0A3QJRZiuloflFbe3S7OvkrbitI/Sh3
         QhqTKTz/ImUR6vY1V0WAVvPzUnT+KuKWgzp4vorWjXxfLMgnOT1gnrc/IotHuTyUiHsM
         52sarKaVkKFhc9YPp46WG0joHRtON+7CsGkJ0ZGuRF5pbpzbIGAVJpWSTXKlj4Nrfd9D
         BW9x1IvY6hAt0AJOEXstVUllDs+28M96rv8Vmhxs1rLYFulwAsGR69s7o5oCgxtNeTCk
         smqg==
X-Gm-Message-State: AElRT7FkQsy8H6mY3DO778xe5Z99j3FzTo1Tv9wS9dvO42hCBebzOsS6
        FNiWdCYDHACSHTX9IMG4jeg=
X-Google-Smtp-Source: AG47ELvOO56Ub6jU0p5JKZBOc+do7yiBLKlr/jIKYpDjZolPPJ8awW/fYli08/oHN2lsz8NLgHGwwg==
X-Received: by 10.28.148.130 with SMTP id w124mr12473568wmd.124.1520370185974;
        Tue, 06 Mar 2018 13:03:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n64sm10505358wmd.11.2018.03.06.13.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 13:03:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
Subject: Re: [PATCH v2 0/3] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180306101750.18794-1-phillip.wood@talktalk.net>
        <64005dad-ec23-892c-4270-b01cae74f663@gmail.com>
Date:   Tue, 06 Mar 2018 13:03:04 -0800
In-Reply-To: <64005dad-ec23-892c-4270-b01cae74f663@gmail.com> (Igor
        Djordjevic's message of "Tue, 6 Mar 2018 21:19:15 +0100")
Message-ID: <xmqqr2ow3ojb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> A small nitpick - I see you use phrasing like "select lines", where 
> the other commands usually talk about "staging", instead, so "stage 
> lines" might be more aligned with the existing text.

Isn't this machinery shared across "add -p" and "reset -p"?  What is
done to the selected lines when you are using this UI while running
"reset -p"?  I hope it is not "staging".  If the interface only
"selects lines" and what is done to the selected lines depends on
what operation is using this backend, then the current phrasing is
perfectly fine and saying "staging" makes it actively worse.

