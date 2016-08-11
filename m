Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD9420193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbcHKR7M (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:59:12 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35907 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbcHKR7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:59:10 -0400
Received: by mail-yw0-f176.google.com with SMTP id u134so1904422ywg.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 10:59:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7qqmiGdGbP6+PquEAy+Sz3a0fgA3rnO0j1HICqxrcTY=;
        b=s6Cafqq78rAKbWDwdUyl4Rfhu7Aulu2qw5TPitNs6fhLcUjLSLzTtvpWRFscBgTzwq
         ISx598Nu7/sBUBRFhhbRSRPop0JyxDm9GJksvd6zlgyKqUMMF1lQXIuAlzHBvgQRkegZ
         Lwr3irIEst95lHkoLbyz2EXmOioghOtleKc1GSycU9C7YCT+5j9Ezj6cOQL5ciEmE4LZ
         pBzO0n7GIFaH+2mvxJR+ziePz9vV3wQOjLRi3EV7SpSdW88p/L7PlPivuK6wG1j3WxHj
         H5DZSiR2jYfAQkUthM2E7Vb4Tv76RUSNamDNmWn/taqRG8qiRnyztxe2kn/lfRt6KiTn
         SjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7qqmiGdGbP6+PquEAy+Sz3a0fgA3rnO0j1HICqxrcTY=;
        b=kMXVJ8pKQmZGCRZhqZtQUTlvRY2SuSiG8PBSkeSs3vNXmrZqnCIrZ/vnR+mgyEqr8a
         1ALARNfx98evcP8QAF9WYynt+2yU5GBSxR3aWem+121QMpHb5JuL1NI+G2UodeYEateR
         LcLKK/cPMPElxu6BuZ8YHix0pmHONc49LT5TUootnp0p9gaqsYF96WRWuTx9OBDQeCLN
         wHQOsNKfwuDVBB4HuIyzajfV6fYbJsVJs3/Uwgt95dRrO+7ccDu3ay/tRHqoNyWvAstf
         9gMzA9oBmss+WCpPn3Am1MBc+ayASsMPu5eyO4CcpCy3hA+Mq8WaXNqQOFkBWthdw/wD
         YHbw==
X-Gm-Message-State: AEkooutVsersI2T2fz66cove/ADbkfmSQiSpPszDnQ8Jh6TZW6j8eVlvuugpO3gfO7r17Uu+WrkZ9xmaQ87ZZg==
X-Received: by 10.13.209.71 with SMTP id t68mr7504189ywd.275.1470938349674;
 Thu, 11 Aug 2016 10:59:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Thu, 11 Aug 2016 10:58:49 -0700 (PDT)
In-Reply-To: <xmqq4m6r2npv.fsf@gitster.mtv.corp.google.com>
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley>
 <CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com>
 <CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com> <xmqq4m6r2npv.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 11 Aug 2016 10:58:49 -0700
X-Google-Sender-Auth: V6pDhlXqk63WUe9PjaAz4ZGOsVU
Message-ID: <CAPc5daWZnSTR8EgTP899+_iDL5JTzi=CT7LkBFnu=Q8puepFFw@mail.gmail.com>
Subject: Re: Can cc's be included in patches sent by send-email
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Also, those who do not want to see Cc: in headers (like me) can

Stupid typo that ruins the whole message.  I meant "in FOOTERS".

> instead edit the header part of the format-patch output to add Cc:
> lines and they should be picked up.
