Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C5520323
	for <e@80x24.org>; Thu, 16 Mar 2017 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbdCPU0o (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 16:26:44 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38255 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdCPU0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 16:26:43 -0400
Received: by mail-it0-f43.google.com with SMTP id m27so2169772iti.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j/1SYWHHHmj72w+b44YSMKR+GlyPRFiSIYKCq8Oc8wM=;
        b=hoRNEpDxhdTR+WDJPhrqfwbzfKcQL/s43sx+NQSzY4W3hGDg229KleWxqaJ7qQji5p
         mOgh928Z2uAj1j1snh774z+tLxPIaFpVMDgzj9O5phKIkdznGfWIvIAelvcAGsNPKzxe
         wGC6PbUlWnx1H1sdYjtLA1q3ECzWzorLdlEguNKEPc1uU3WeWnArkZvGZJA1YjbK6gTD
         VXcJ1VTY5deA9oJKg+qd0yO9tuUUN+Oa6VDs+r632azM06TQ1nTfcbcYZCRcAiuoL29a
         NZ7pXqw5U+d1Fi/31yn4gLs1N+FeCpB4YxrWg6GuIXrOfRmz5XFUpRWyn/MFGR0erRrB
         6UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j/1SYWHHHmj72w+b44YSMKR+GlyPRFiSIYKCq8Oc8wM=;
        b=bTUNTQi4y1ukhPnxq0l0xbmQ7Pt0BLlhvR6XmBGGgC58gnU4HZ6RLVQMogwDFZwJeM
         po0soG01EM6es/L4KFOxFDFgjpJnPYondXrbuf0ER9V68OsSDSoDIYDxXCD3ENGfaEbG
         sWxzOL0isUmUlTKycWd6qFPYnf+F034VpMxsjBNmF5NKTnwIvNhlXvg5E4KtTfeCTItH
         WekN53q4eQIGgOG3jpZ9GcUYVD648Y1BbPmpb7SqC5zbktBRDnX4aqj4QaB3WVdVYU/n
         vgPKKkLKDFmF6QW0kA9hzYNLVXYThO/Y6gFsvBSdkJfr+KcqW5SyzHfHJQSvK5bzU4OA
         V/TA==
X-Gm-Message-State: AFeK/H1ZVpIDZJXsU0281e5aePU+eVYinz53AarQvg0W/tPm5J6Wdb1xGkRM4KqD1v9pHPr8lOypk0ZAP06VcA==
X-Received: by 10.107.178.137 with SMTP id b131mr11243167iof.50.1489695979141;
 Thu, 16 Mar 2017 13:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 16 Mar 2017 13:26:18 -0700 (PDT)
In-Reply-To: <CA+55aFzVB2gAXJ2rn3vPDtCJU7Rgozs0e_HhnK-nFziixCCfFQ@mail.gmail.com>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net> <CA+55aFzp_dxevLEbRVWCmbx=zY=8hwqEBKK=Pcs7Au+rdg4pRQ@mail.gmail.com>
 <xmqqbmt1atta.fsf@gitster.mtv.corp.google.com> <CA+55aFzVB2gAXJ2rn3vPDtCJU7Rgozs0e_HhnK-nFziixCCfFQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2017 13:26:18 -0700
X-Google-Sender-Auth: q22z_Lk1Rn7Xsw6gl9R1DidDi4U
Message-ID: <CA+55aFyo2ap2SDbaeSC6=Av26sNP7KdxqzYZDW+MW-M5p5o0AQ@mail.gmail.com>
Subject: Re: USE_SHA1DC is broken in pu
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 12:51 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll send a patch on top of 'next', which already has the header file changes.

Patches sent. It all looked fairly straightforward to me, but maybe I
missed something.

                     Linus
