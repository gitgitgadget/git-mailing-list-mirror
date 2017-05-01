Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23F21F829
	for <e@80x24.org>; Mon,  1 May 2017 03:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032442AbdEADHP (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:07:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35318 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939227AbdEADHN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:07:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id c2so3959210pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rgFKfu54iotYzRgiKhg8gLGymgdJlZbfQtGzHSWRVTk=;
        b=ivbpA7LAT8fesVrlwMd9Wz8WruM+xNB9cdqeX96wHvNHCSQqzQBRMfwIcn0oErgMAm
         8uExN3Q0i9OpCts/ueP4sF3qUcKFzbbOro2MIhKutW29mrWK+ah364bowFSd8vIpVA1P
         IFEKyz5vhfsdF1qR6vF7HDM7xcIJIlNLXEAc6iFwVigaGrVpnfGa1JsRxERro06SIhjn
         9WkYo3u+TzkOzU+0CxDnyWfoJDlwON82d6f2NgYhVnhGrZs1F4kkh0t72oT7rZdLgPF+
         xsj9gAGyN5MxlrXnwo4E9Wh2vpqCEhMk+2r8oy6N7bP7tDljZl81XpZ/RF33912PbhxL
         QcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rgFKfu54iotYzRgiKhg8gLGymgdJlZbfQtGzHSWRVTk=;
        b=crped6IwKk4JAG0j35uT7td8DH36Zj+6MONlnJ+forQmxl50tRCOg/ePv5+E3XhI5G
         hLL/l+C/TU18ZM0O0DH63DzMZBLj/D3TdWLRHT8WWURqtxfn0zHoN+i7Y+kXUlLi0L8P
         wtB+0CI3vTpCUMHO4X9VmnAGK7kZ/L0MK6nN8DxGZXOw0CdIwwAFS29412JDE65XA7jV
         fhsyOsBaMAARsXSU/ZlzB0A4eN64TD2vbpkM2PiMYIdkBm1WQRWEplXm3C70N3rgP5z9
         jF+tktJqCuMFqfO+z58eXXGi2ZjnfTUJjjcIr/zElMBAMmQcDPoAD27wQxSd0E7dP3Xr
         8dcw==
X-Gm-Message-State: AN3rC/7l07JlYSTdin62ewldjDRqCk8XzzyqcVtYpMBC+a2uxtk4E1Pb
        cg2t9lJeQfM7xFepQSo=
X-Received: by 10.98.211.27 with SMTP id q27mr24476079pfg.126.1493608032835;
        Sun, 30 Apr 2017 20:07:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id v12sm20123788pgn.5.2017.04.30.20.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:07:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH/RFC 1/1] t0027: Some tests are not expensive
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
        <20170429153454.16879-1-tboegi@web.de>
Date:   Sun, 30 Apr 2017 20:07:11 -0700
In-Reply-To: <20170429153454.16879-1-tboegi@web.de> (tboegi@web.de's message
        of "Sat, 29 Apr 2017 17:34:54 +0200")
Message-ID: <xmqqfugpi8bk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
> ...
> The execution time for the non-expansive part is 6..8 seconds under Linux,
> and 32 seconds under Mac Os X.
>
> Running the "expensive" version roughly doubles the time.

Hmph, perhaps none of these is truly expensive if that is the case?
I am not talking about ~10 or ~30 seconds in absolute terms, but
reacting to "excluding the ones only halves the time."

The files used in the test vector seem to be all small.
Is the expensiveness due to the fact that there are so many of them,
and not due to some specific conversion being very slow?
