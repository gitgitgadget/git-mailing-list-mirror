Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737DC1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 11:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKBUz4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 16:55:56 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44011 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 16:55:55 -0400
Received: by mail-wr1-f42.google.com with SMTP id y3-v6so1379367wrh.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2ZuWTcScC1R2n7dCSxw+0KPmfIG3F+XaEKfsRDLLmg4=;
        b=j2/iyYPqWKTjxX4gkSSTR65TThfT3jzC+dss0RSFuMo07omQRoz7vY72B6/fDB7iLm
         n6SvNQMCi6jJNcbQw5UllyP1aVE8hoR8XQ6Rx2CUhJl0Br4ncF3vI1+I2PqF9sMEZyvH
         RXUaBXkeiG7/4MiWhfHIPQ2Lr4cDCF6enpTKHLx9lBDIW6MOSXyG0Gpv5GvftaQGgrHM
         yTbx63mneWHpWOLShM9k73ksplSWwG1QsPugNaW3ygfcOuu6XZGncuKv5S98lRu9milf
         hZ3juTZAagefRF6OScTO9rsT0eIht4hmWOnW8e9ebwDXQqf+jJSlpKFY6Po7fjr8xQli
         J6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2ZuWTcScC1R2n7dCSxw+0KPmfIG3F+XaEKfsRDLLmg4=;
        b=pz28LeCI5/jDOB1YsC+DyHwDunz1yjwZypsIs8XhR1v1zjOIZVjTZtBmRvP6RM5I1w
         JM1Y4tEow4Nq38cDL7XPyNzQ0SfwCGG0Rs4XfOEHXSnmgNzwDjVmeBX50soMM/qspVLE
         IT1eYcoG75PvmJZvZpORrRw4r5lOWTVGVQPtQ41Z1gr3MPr3o9eOsd0rD3+XgsEfI2RP
         PCKI9QbDFkz9ozDdbKgXLhIqy7Qln0W+iMU+G2PSzVcqGT1glRkkzAZj7KAvW5yHZKwA
         JkhkS5t/S/IIbdSojWwSKNmJUGR/PxMVfP4doq2w1TnxLGgv+8aaog/VvIX8kYuKZmSg
         4hfQ==
X-Gm-Message-State: AGRZ1gL2PDG6JLUeUPxr37IbnnWgjpeZbzwLyJjMUpmJUvQSaKoemStE
        gP6kZe3ZmaIDbmtFyv6GOq+BWhlv7rs=
X-Google-Smtp-Source: AJdET5ecwVsqqNuETlzZVrHfi4JKIV/0kTKrs3dlz0hpQlJ887/q5emjEMd+dP/Rq7vMazHjMBBwbQ==
X-Received: by 2002:adf:91a1:: with SMTP id 30-v6mr8960537wri.37.1541159338775;
        Fri, 02 Nov 2018 04:48:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t14-v6sm25221950wra.63.2018.11.02.04.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 04:48:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] it's called read_object_file() these days
References: <xmqqpnvoovzk.fsf@gitster-ct.c.googlers.com>
        <20181102062429.GA29939@sigill.intra.peff.net>
Date:   Fri, 02 Nov 2018 20:48:57 +0900
In-Reply-To: <20181102062429.GA29939@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Nov 2018 02:24:29 -0400")
Message-ID: <xmqqd0rnpumu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's another mention in Documentation/technical/api-object-access.txt.

Yes, and we are on the same page on that one.

>
> But since the entire API is undocumented, I'm not sure it matters much.
> That file has been a placeholder since 2007. Maybe we should just delete
> it; its existence does not seem to be guilting anyone into documenting,
> and these days we'd prefer to do it in-header anyway.
>
> -Peff
