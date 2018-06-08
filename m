Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC3D1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 10:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFHKG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 06:06:58 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33496 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeFHKG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 06:06:57 -0400
Received: by mail-oi0-f53.google.com with SMTP id c6-v6so10225249oiy.0
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BOwQ/cAxQm532u6Zvfs4PVtOz+VDXCQ7R11AwR6mO6I=;
        b=baMXz0c+OY1EajQG3kW/Mx3dXd3WL9z3ijYEt2HfhBySbsg2vuvboQg3r+dxrJAURO
         dIshSl3B/XEgvVIs6VMqvsoiNlnHDpVpk155ltpHgfi4S97OEcoVFzFgAiD83ga11Seh
         r0MSpweyxIWk9Ye+W+qow0wRi3ti180nJrNgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BOwQ/cAxQm532u6Zvfs4PVtOz+VDXCQ7R11AwR6mO6I=;
        b=nNjiUrf3RskkME+3DgyGAWYl9bnvFYI3vk6cEPs/n+tjcoBjeykfkhiaIIvqJ3FhGu
         K+mIf50fNVYMf+3T+7a4/wGCaCezFIt1ikqVAkNGZ3gcM+G2oJ6pSYAq4yzz+uQqYlh9
         kLZ+1oSZjbQAeMJlsU7aB41E0IwVv9iPJ2fuqcz882gj66q7GGXBDQXEQCOX7VUPLBar
         CoiEBbs30Q8gKeWcU/CB81GGlgG6OkkxIxQtppu5wcsRxBNUG+FBilQeZmwXM92jnztM
         C2jeOinN4eX0fGuqs/djpoXYS4e/MKUvAhYIwMOuwO09UcjKBOU+3OvJwu+WfaHboOti
         P8rQ==
X-Gm-Message-State: APt69E0Tt+AAg3p49qEUC3RXaO3AOXsx7u8Q9t0Mg7obIhoTxhSA91Xo
        xXLlzug4wfmcs0bKRhzFnlCaJofwOVfG+sSgKQDzyA==
X-Google-Smtp-Source: ADUXVKJTOz3xo3LaY6s2soxq2MNOA0mk5nnAIRdXPPo5U6jJ4g3CR0F341BDS2peGPp4bkpYhHmJBJEe5ENL6ZL3sOU=
X-Received: by 2002:aca:ec09:: with SMTP id k9-v6mr3018543oih.81.1528452417051;
 Fri, 08 Jun 2018 03:06:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 03:06:56 -0700 (PDT)
In-Reply-To: <CAE5ih7-HMRJ3nFNuQCXmJEC4Ar4PZY=_4Q=4gDK+VTFRhMvCGA@mail.gmail.com>
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-2-luke@diamand.org>
 <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com>
 <CAE5ih7-1StB8RNrobO+hpG2QOSdoscUNfVP9+muZV0_b+m+XSw@mail.gmail.com>
 <CAPig+cTSrzmOtYPwPWLpGfDa5tt0SV6Aq8SmhYTTicK0ikst7Q@mail.gmail.com> <CAE5ih7-HMRJ3nFNuQCXmJEC4Ar4PZY=_4Q=4gDK+VTFRhMvCGA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 8 Jun 2018 11:06:56 +0100
Message-ID: <CAE5ih7-4CTOgaWuc2dVha5bcF1MsD+ERPj3hQNTOddOrkvMZWw@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on
 error from p4 server
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        vin ku <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>
>>>     ErrorId MsgDb::MaxResults              = { ErrorOf( ES_DB, 32,
>>> E_FAILED, EV_ADMIN, 1 ), "Request too large (over %maxResults%); see
>>> 'p4 help maxresults'." } ;//NOTRANS
>>>     ErrorId MsgDb::MaxScanRows             = { ErrorOf( ES_DB, 61,
>>> E_FAILED, EV_ADMIN, 1 ), "Too many rows scanned (over %maxScanRows%);
>>> see 'p4 help maxscanrows'." } ;//NOTRANS
>>>
>>> I don't think there's actually a way to make it return any language
>>> other than English though. [...]
>>> So I think probably the language is always English.
>>
>> The "NOTRANS" annotation on the error messages is reassuring.
>
> I'll check it works OK on Windows; charset translation might cause a problem.

Works OK on Windows with 2017.2 client/server.
