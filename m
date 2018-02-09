Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C1D1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBIUJt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:09:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45645 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeBIUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:09:48 -0500
Received: by mail-wr0-f195.google.com with SMTP id h9so9418689wre.12
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n5AjDJcAhr5C2r4baUClk7DZjD62isHZzELjsLRmEEU=;
        b=Eynbkynp3vIq4GEf2qIZQkAb7zNE2jPuGntBRpBk6TXDe6VZVQAe3hkPZVvb/jMKod
         KOjBAy26LpMj6gb1cGeGn8MLAXV2PnGay8izznPboM/3bt4M2NQMBAHw3pZ2AtYZEAhc
         yP+GslgusgviEHV0NwQ93eVHjjWoqUlTUQNs5FnRpQVR6HxGyG4PlgPYSpGrpT5pkvOy
         10ln7O8EE+DWZqUZ4RHip8PRqiKLJXClbnRipvtID3KRy27HV9T3DEk2DUZ9psaSmeBU
         gceHez5mrtQG+yN+DNzkM9MlcFSKYFI/rqhYkcCJ8d4yUiR2ZeC7CL8a38GLqHD59A1X
         +HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n5AjDJcAhr5C2r4baUClk7DZjD62isHZzELjsLRmEEU=;
        b=ceCuq4rPTXBjgpLhbPy30ab5X7koAqUPQPr3yMFkB8PJ74SCy19oiQadoN/mkJ5QUz
         x3EOsWqv70JPLnVeoDRT1guS0D4ySbWlDBbfpd/qxLhUdkE2uu/VEaBifaeXVFRg3LB9
         m++axf9RWp3VZBoxuSDb7155Rj6WWJOIbiBivRgph6gmSjuqXu16jb+dCoyjjY2yBUmV
         49WT/8jxBtqB3YLJ5sLIZv9GQhsvyXl+PR/emy0aLlMMJNBYMJIEkUec0xmnwMVapXxA
         y4DDgEjZu+g7owEM26z39FKzSMgm6oSEWjpIzaov7Kmy1k9e0Dhjje3hPht7vgscYBmA
         W29A==
X-Gm-Message-State: APf1xPBlfd3j1BwcsrrsmOyMqWXBU3rCiZm26d1+XkJWBAqCFcDw7Gtu
        sf13SDYGPDhfE0+7zG6I58I=
X-Google-Smtp-Source: AH8x225hnPYbwFQAoTd0xVq9qY+zFS2z5bdiRircnCkIL+6+1GFq8ixv2+EZqeGcLhSbtgd4Jt9K6g==
X-Received: by 10.223.209.80 with SMTP id b16mr3568616wri.86.1518206987213;
        Fri, 09 Feb 2018 12:09:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q14sm2491534wre.66.2018.02.09.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 12:09:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 0/7] convert: add support for different encodings
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
Date:   Fri, 09 Feb 2018 12:09:45 -0800
In-Reply-To: <20180209132830.55385-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 9 Feb 2018 14:28:23 +0100")
Message-ID: <xmqqk1vlx6uu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation has core.checkRoundtripEncoding while t0028 and a
comment in convert.c capitalize it differently.  I suspect that it
would be more reader-friendly to update the documentation to match.


