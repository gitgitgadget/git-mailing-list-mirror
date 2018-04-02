Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2631E1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeDBWzB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:55:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41204 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBWzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:55:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id d3so13939564qth.8
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=awpAwqL7mC2PFe+yE5c+WoCsHknIn7VeDclRB5ZcPyk=;
        b=LPNcOvjYSB/u2Z4Hksav4TE4jIaskzc56Z5PzIkaBa13QE8znDUqS2WygHzSwG/cgi
         xWDYIgibaHN1Lu4AWsDFq/W1lC6W3cR43PKxsL8Qeh+9Tz2de6EOfIarcjGnFjsRePUi
         oprZ3DGBRlKH0PO/yOBXo5SQjdSawwzYXx94mI9U0QZKnF+OEwEL88TqWbONKOnlysbU
         pPPpPpgwiljt1Bj68TsJm62vBLEi0zI7IISQ6E0uDifuheQVwd3v6BwrKqzi3YaRdK3Q
         /Kej3qdSyektN65i+K1O6LsSfMzrASgFscNoPo/l+XpluM3TSW0IDsG+Si+WHrEJ5D6y
         4nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=awpAwqL7mC2PFe+yE5c+WoCsHknIn7VeDclRB5ZcPyk=;
        b=Jd0uwZKdLLZYyAJ7iXg+XSZuBOjNKKjkzaveEqz7Mir231wVVn9uu3ZoiT63dpSHnX
         1+E6t3Tt+9pYX+54UCwi4sKWJa6Z5iexBqcRv0hrtKUNXwIvb8h5SrCH2X4cb94TodCg
         Olbxv/Klm92M9HWAqnFGqiTNY5tQf6NO2XKyk3gP4cnaPzhd+PyR2RafO/lMJzMkFr+1
         Dj7Q9YWKdq/aUKf92vMdsy+R88ocD0vNkNLdRYn2/Gw/Z9IvNo0qxoJ6DlpKPv7lGYZQ
         Oxux70T5tCpglamwOMczSgjHZAbQ2c1Ef5k58I+JvYw0Gz7jpeqfG6M5/QZx+taUBIWK
         2yJQ==
X-Gm-Message-State: ALQs6tBM2/3JeljtAPidKTeQPf/GdRDHiGGZnWcYIiHB986oe1e+651W
        73xwHzCj9hiVkLZPK4G2OF1iORAWI1RdGNGxnQg=
X-Google-Smtp-Source: AIpwx49Cv01jOUc3sokSQSGdHbwXGPY/qwyei5q419BXWSW66Y9b3kK/KIkFmsal8KgcBSRrOGLpOCvnvzHfz0pdyUc=
X-Received: by 10.200.1.2 with SMTP id e2mr17235201qtg.121.1522709699821; Mon,
 02 Apr 2018 15:54:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 2 Apr 2018 15:54:59 -0700 (PDT)
In-Reply-To: <CAPig+cRTcY+XNedi=PdfRWpWR-LTAVvR4kkKkrs1e58LLYd3-Q@mail.gmail.com>
References: <CAHwyqnV8tB63gQFVJhyNtr304Uv1TwWvYiX+3wuU0fDFhOphgg@mail.gmail.com>
 <20180402221124.88049-1-haraldnordgren@gmail.com> <CAPig+cRTcY+XNedi=PdfRWpWR-LTAVvR4kkKkrs1e58LLYd3-Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Apr 2018 18:54:59 -0400
X-Google-Sender-Auth: 4GuOfFtWaLhcdQqzRKWl1s27pd4
Message-ID: <CAPig+cQ4=aft738gxngHDGB+ZZPFFCmve=D6ExRg_F3jr8634g@mail.gmail.com>
Subject: Re: [PATCH v5] ls-remote: create '--sort' option
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 6:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 2, 2018 at 6:11 PM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
>> Create a '--sort' option for ls-remote, based on the one from
>> for-each-ref. This e.g. allows ref names to be sorted by version
>> semantics, so that v1.2 is sorted before v1.10.
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
>
> Please take pity on reviewers and use this space below the "---" line
> following your sign-off to explain what changed since the previous
> attempt and to provide a link to the previous round(s), like this[1].
> Thanks.
>
> [1]: https://www.youtube.com/watch?v=r_8ydghbGSg

Or, like this if we want to be really accurate[1].

[1]: https://public-inbox.org/git/20180402210523.83293-1-haraldnordgren@gmail.com/
