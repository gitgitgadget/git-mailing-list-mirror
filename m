Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625A520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 03:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLNDMF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 22:12:05 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44876 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNDME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 22:12:04 -0500
Received: by mail-wr1-f41.google.com with SMTP id z5so3991145wrt.11
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 19:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7Rw2SvXtg9V9GPmMkheS7nxFEgY7WmY/6aZ/8HQNmgw=;
        b=UYAXRohb9aomdzFO++fCSeSlk3df1o482pYSRSiorMArb7zPIDuNfFdM4VwAR0Bwhj
         ZtJe89hESLX8aaGETAcwnN64w4DCN2PnqHYDNVo58pQhExNSaVubH2Rz3cI2eBKrwD8B
         5sX0oE2Hc9lTeEEUOcY1MH8Y5Ul2iJuj00mLggFJ7xD8VspatTJV5ZpXVk+ZbuQ7xaLP
         TJstyak6qMH1zvt7xFU7nfYns5X0p+fxOAuTXayXxlKjizSysmsk7Dj73+qrcT//tS6V
         OLcU2/qMveRviuMNfaIT4mibv6cNy7kujqwTstnnrzGJDKlkkTKls6N4Fy3yf576Lynv
         zCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Rw2SvXtg9V9GPmMkheS7nxFEgY7WmY/6aZ/8HQNmgw=;
        b=r7naCR0aNas+TfnQqbgrG7i7WJCec3YDGxBBGU4Cz93xf4/jK4rBEc7VMgkqq332B8
         45RzEOwIQ2cetcQJekIZpOyPerprR0nxbhqwYejhiYy+mOt2n2Df/njDL+q2XvOVIA4Z
         aSIshAVOp+W6tsLylAyvXuizwEytB5q1LERxjW2RaomcpXE5/0G7QXMSN8kzQILO1+sp
         AmK43OxMo6oYOIcMBVv8VOVfhav+VFeNQ/hv0u9AcDiozJbByjhRXHEjFsdF3Yg4dmnj
         rsaDATSkWL7NDCEMKx1yBeoUWboAPFleDLQKKPmW0xVmOAyo+1vnyvVFrC+qKJWPxiUy
         NDTA==
X-Gm-Message-State: AA+aEWaaVgpTOSGBCHz3aav7bXMQhmvCT0OKigH7XYlaGXlM5r/qHSX3
        xkElqf6ZPffKQFzTt/1btgA=
X-Google-Smtp-Source: AFSGD/Uu60fROW/GkskltG0VPD4uQqXbnKTKN+C8qXfpbARBocNVcSI3/fXgCsqSbPXcbsPDKtT+DA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr1005159wrq.5.1544757122687;
        Thu, 13 Dec 2018 19:12:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c129sm3466526wma.48.2018.12.13.19.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 19:12:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Question] Complex textconv text
References: <004501d492f5$98f0fcc0$cad2f640$@nexbridge.com>
Date:   Fri, 14 Dec 2018 12:12:01 +0900
In-Reply-To: <004501d492f5$98f0fcc0$cad2f640$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 13 Dec 2018 10:07:37 -0500")
Message-ID: <xmqqo99odcou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Hi all,
>
> I have a strange situation and need help with resolving funky characters in
> .git/config. My situation is this:
>
> [diff "*.dat"]
> 	textconv = enscribe-conv
> --format=-a1\(A=-a1,-a16,-a32\|P=-a1,-a32,-a16\|=-a1,-d,a14\),-a224
>
> Basically this is a formatter for diff so that I can show structured binary
> data. The unquoted syntax of the format string is:
>  --format=-a1(A=-a1,-a16,-a32|P=-a1,-a32,-a16|=-a1,-d,a14),-a224
>
> Content is not really important. The issue is that git is reporting fatal:
> bad config line 2 in file .git/config when I escape the (, ), and |
> characters.

That failure is understandable, as

    The following escape sequences (beside `\"` and `\\`) are recognized:
    `\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
    and `\b` for backspace (BS).  Other char escape sequences (including octal
    escape sequences) are invalid.

is what Documentation/config.txt says.  \(, \) and \| is not a way
to escape these letters from the .git/config parser (they do not
need to be escaped from .git/config parser)..

> I get syntax errors otherwise from the shell running the
> textconv. I have tried
> --format="-a1(A=-a1,-a16,-a32|P=-a1,-a32,-a16|=-a1,-d,a14),-a224", to no
> avail.

Would 

	textconv = enscribe-conv --format=\"-a1(A=...,-a224\"

work?

We want to show the shell what you wrote so that pipes and parens
are inside a dq pair, but the .git/config language strips pair of
dq, so the .git/config language parser needs to be told that these
dq are not for it to eat.
