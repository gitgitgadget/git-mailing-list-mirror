Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC751F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbdLNSST (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:18:19 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45470 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdLNSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:18:18 -0500
Received: by mail-qt0-f173.google.com with SMTP id g10so9033362qtj.12
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rVCXv5XDBxrmqCviZpipO+dr1zIcF+Zs7v/PLroMkIw=;
        b=u64OHjL7aWl5t9WggIShc5QS5rhchwarz3f9c7Baimh0Y51lhBImYXOQoTA9RvXzT9
         0JmNTt4IDq67rdurtkNgzJ7UJwTio1czKLUBMk2m+yWJXUXPJzmvpgALc1cRTCaSbPL0
         w8IhPUcR3bxGg874AHbBz5uVYxtuQDQtT6haceCycwXQYvkZf3RsX0rhjB/KPl1a03IU
         kTq8kcb/DCmQxwS6YFRcUgoaH6ZWcdCCNyIRRSmwPYjAMLTpr5L+J4/753XJay5jCxhX
         CK740dSjMbL6YJHerojM928/5VxWdsrgQNcdQYViJTdiPXwIoMOI8TtHHz2U5r59NuUC
         BOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rVCXv5XDBxrmqCviZpipO+dr1zIcF+Zs7v/PLroMkIw=;
        b=iQ7mqt0zy9JYapn9gnrLNmH8nM4CzYoYWaXIqDVU7AK1sM8PlfRbffUJrm3GYDtyLD
         wP1ArWGgyKHF+9bASWFTDu3iXXXKra+RRAMDqK4SanlW3Y9hvAocrw2KxJjvgQGnYE77
         jda74v1RP9mN3N1G7sOyXAbMVLqhK+iqa0GT+Si2Q0VfXrPLNrG2exGgilv+GDCQXbBE
         iOWmLUj+SpJi5nKSJYr/ZAhyvZVL2DhvfHzYwOiL+JO1Id/O0V+oTFbaixcbyfsUTyXH
         QjTlOee0aILQwE+nBn+lCJjhP4nNO35WS7+6OD+jIJ4+0qkVXe4d0xils2sR75ZM8Ln7
         LCDw==
X-Gm-Message-State: AKGB3mJ3hjG1wAgAS7pTJYFLA8INVyEBiWK1JJoy8sbTfcmpRzOrLmZz
        1B8vMDWWulDINYTqduzJuq9F/3prQt4aKT+VbWU=
X-Google-Smtp-Source: ACJfBovuXkSYJAU3Sixmpgi/aY7KNoKlEJBwiikG9hzoJBthrzezY60j+I3yW7vx+GWhAUZziM58lqX4BceFqG9BW6Y=
X-Received: by 10.237.37.162 with SMTP id x31mr18343785qtc.58.1513275497896;
 Thu, 14 Dec 2017 10:18:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Thu, 14 Dec 2017 10:18:17 -0800 (PST)
In-Reply-To: <87o9n16145.fsf%l.stelmach@samsung.com>
References: <CGME20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a@eucas1p2.samsung.com>
 <CAPig+cTYYGRynG8r_2DR53u77eCFDGe1BEDcEK3_cJQxT3yncQ@mail.gmail.com> <87o9n16145.fsf%l.stelmach@samsung.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Dec 2017 13:18:17 -0500
X-Google-Sender-Auth: da11wj8Hyp8qDITAbKFcrlozMHk
Message-ID: <CAPig+cR1AErh7b7RO+==W=QqkCS7vBkF5O9-cuwYK9MYDF2TNA@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: Prevent double UTF-8 conversion
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 5:43 AM, =C5=81ukasz Stelmach <l.stelmach@samsung.c=
om> wrote:
> It was <2017-12-14 czw 10:42>, when Eric Sunshine wrote:
>> No need to re-send. If you consult Junio's latest "What's cooking"[1],
>> you'll find that your patch has already graduated from his 'pu' branch
>> to 'next' and is slated to graduate to 'master' (at some point).
>>
>> [1]: https://public-inbox.org/git/xmqqzi6mutcc.fsf@gitster.mtv.corp.goog=
le.com/
>
> I am sorry. I didn't get any notifiaction by mail and I haven't studied
> Documentation/SubmittingPatches throughly enough.

No need for an apology. My response was just a simple informational
message to help you (and perhaps other newcomers reading this thread)
get up to speed.
