Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2841F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeKFLg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:36:28 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34428 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFLg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:36:28 -0500
Received: by mail-wr1-f42.google.com with SMTP id j26-v6so11703941wre.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YMD+YIV8KqFkmnvGlT7SwmskRuLKgNwl4NNVn1bYrQE=;
        b=rtxA7az8fq0la9aVDlZmYXYfTQZvu3s7OZ8LnDg6zI0x8mxrmcFbuMN1G2shSyfgDo
         O10pPSjDi58gQwEdoxLfWH0QZyKI9ioBbeBl8ILy+BIhXsrt+hMgC/xgLG6k98IIsGoL
         qCG+jxovSrktKr5fCLaJR602kJCAiS1IUxHH3FM8FIgw2ddeFpNDFWrnJOY5eloO2mk5
         WjRiZ3rFvgAfRY/KdDhIdIrVfoJR1SeH9iurOiAc3/f4ZgPyIjbkJDqfUrJckSqGZEOz
         M6sKw60iklyLmVWwxBzxQgY7l9zzuYRm1y0+oPKPj+sv/Og5JErSO95eHuN1uuUUj8dt
         qqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YMD+YIV8KqFkmnvGlT7SwmskRuLKgNwl4NNVn1bYrQE=;
        b=K2Y5lxCO8N0uRSxqvkhx0P2Za4huJsQ4ywusVsFSBcM0fH80ueVdW6ai1cZ6UPg9co
         GIMFzfV5V1x+JpxinwRkIDkDk1zRLrNDLScuuKLblVEDrOa9DqPTGOwlL0auz0+VmHr4
         fb4P35WqT9pJ4YuogwM+Gk2Na/uJnEIMeMqjlTshEacrYIC2Iu8wB0Hzb+wVb3hT4u88
         PZeMJdSmLceBjxq+DTKJoupe8P7lofUbU+RxJ9LzewgvxcUzV5e/HA9InDiMVWbL9ggO
         qrWlaOZZlwsD5+38u5PaP35oX3a2ePbqG4CytNqhCjKAGMlhUTb0aMdwTX8hSeHMpyEG
         dm3w==
X-Gm-Message-State: AGRZ1gKNyU/8uEnJTtxkjrDfoifdfywYwKDmctNgmI2o+zc1riiJbeTp
        nobHcxTqvHyrMAn61iLQTcQ=
X-Google-Smtp-Source: AJdET5cJ5bBKLVf3Q2iTB7Tk1G9cLo4Rs1rEi4vGe9JO0gA+RA0WUG2FbfWdhNs+PgSSeJNIQA0e7Q==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr6264744wrt.298.1541470419652;
        Mon, 05 Nov 2018 18:13:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b5-v6sm29384544wrs.34.2018.11.05.18.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:13:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 08/16] reflog: mark strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-9-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:13:38 +0900
In-Reply-To: <20181105192059.20303-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:51 +0100")
Message-ID: <xmqqy3a7eywd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  	if (argc - i < 1)
> -		return error("Nothing to delete?");
> +		return error(_("no reflog specified to delete"));

Better.  Thanks.

