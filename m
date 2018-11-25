Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A0F1F981
	for <e@80x24.org>; Sun, 25 Nov 2018 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeKZAxW (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 19:53:22 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37709 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeKZAxW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 19:53:22 -0500
Received: by mail-wm1-f47.google.com with SMTP id g67so2293694wmd.2
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7ZuRc3wdLTy8+OSB1jBrsucXoAVkRT3MNaKNd1C7sVs=;
        b=UQ0X/RmZogohNYBNKRAZb8Ivp2MCqL9NQI4+bpCNUFJFd9JDPQrjHU136TDatfUAAe
         y77bN+m3bofrmEILGp5wHVuuCiDztPI6vptUNRQ2x+49PfxuBkdBE8p4LhZPtCyEiyId
         ABQu/ZeazLO9tXmBHnYMdSZB6qy9w44/0XWC+YjhuTtP92h0/2am2becbeggJzKK0xrz
         Gt56af05H+726X060wrtyfwihmsXPJc3LxcW1GjraGglL9GdNiN3QFoCQH6zCzUi9HVj
         WaAD23LhW3IC8Sk0bBIBuGGECkd7Sm4LfVza2pkTkLFzq35RHH4a9tq1vKN1rcf/yhl1
         Jrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7ZuRc3wdLTy8+OSB1jBrsucXoAVkRT3MNaKNd1C7sVs=;
        b=DwcaRKY1yzP4dfHI374agt/WMJFv+NJlkrovVg9DUviZbfB4Qfyea4+zXxyfD+oT8E
         3SZf11Oyfl0/0QZlpHkqlfLp1/Lx5g/1BrKZJ5oI5AXoKjeIxSPTtZhjQ6Yiu4QJXZmQ
         knrfUv6Fpg4T/pAoe0i+HVX0DWX53Ec9lgSqH4Goh2bd/Kh48SfGTNHcuom6dYj08qen
         PoVCktPq81YvZpIJmZFjRuAVnE0k3HgGDE5L/BBlwYG7sguxEjE7DQ19eCy/gmTa9DWU
         L3xuwYiiXfFY1tjXutMEPntlSq3tI9OHwYlzu/Ue3+iDn82U6+p3SluRabuer9ZDqnOO
         QeiQ==
X-Gm-Message-State: AGRZ1gI3jo9Z/T++YjJN+fhIRNaNfigRGiY9TdoxknPP3BwR/joiTBMq
        47nVMsZQvqVzwRgnMV0=
X-Google-Smtp-Source: AJdET5e1OVJoQ/621rS1XgM4Zdj9+lHAvkr0HsZuumEN4oyK3tKDOXl3mkc37dCfJ1D7O/usJ1ZOvw==
X-Received: by 2002:a1c:8d46:: with SMTP id p67mr19186999wmd.28.1543154532008;
        Sun, 25 Nov 2018 06:02:12 -0800 (PST)
Received: from [192.168.25.100] (ip-178-201-167-217.hsi08.unitymediagroup.de. [178.201.167.217])
        by smtp.googlemail.com with ESMTPSA id t17sm12162724wme.43.2018.11.25.06.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 06:02:11 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
Date:   Sun, 25 Nov 2018 15:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.11.18 um 23:07 schrieb Johannes Sixt:
> I don't think that there is anything to fix. If you have a file with
> CRLF in it, but you did not declare to Git that CRLF is the expected
> end-of-line indicator, then the CR *is* trailing whitespace (because
> the line ends at LF), and 'git diff' highlights it. 

Sure, it's correct to highlight it.
But it doesn't highlight it in removed lines, just in added lines.
I can see no good reason why removed and added lines should be treated
differently.

Let me give you two real-life examples:
 
1) If CR+LF line termination is used in a file, changing the content of
a line (but not its termination) currently produces a diff like

-something
+something_new^M

which causes the user to think he has changed the line ending (added a
CR) although he didn't.

2) If someone/something unintentionally changes the line termination
from CR+LF to LF, it doesn't show up in the diff:

-something
+something

I don't think this behavior makes sense.
At least it's IMHO not what users expect to see.
They want to see what's really going on, not to get confused.

Regards,
Frank
