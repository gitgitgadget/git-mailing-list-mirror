Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCC720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeLLP2S (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 10:28:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43708 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLP2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 10:28:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so17964676otr.10
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bygofWe1ebJHXiGC6LGVRL1He4glMAzhEP2SxZxHl9M=;
        b=KbU5lGBXL9ChALQ9FThfss1R0mzh+2Nl2oFLfsp2SX4hEujhxZJbFVtM8lhXt8U0Ck
         daq2c76vlIQrQ50KHy3q94UWRuQ9Wna6A419uszuQtlFJBWZS4C9Hgb+P/QtKE+t6E3L
         mKAUUzlNrMFXUvPVZ8NP8Rhx+zJRTF6RQGRp2F3J3n/flBRru4MGns3qHP5C9qSnxPlc
         fqVN9q6/9IPOK2+qGfTfQOgwcJZggl1jp7KdNKp2mqGUBWNodZCXBjIVAFOyYOlX7OQg
         WRYQ/2f81cioHoJ3bDMh3mmKrs/3iT0wj2Z3et9hSV7UsUJoNuB3v082PtnqmYgmXsUP
         lrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bygofWe1ebJHXiGC6LGVRL1He4glMAzhEP2SxZxHl9M=;
        b=CyOcNWIHmVEsS1+5PNNRbi6old2pqJJsUZRL2UM+mtdNHwOwxCGFqjNZ/qDw+Yeq2R
         FHrdp1gfBbhMcxzNSuAyPX/zePSg0BDxVPeNX8vD+WqJMDXWSyxaZLri9ISmy+1Nwb/s
         X3lIDH6V10U6B7aNIW/+DGwPiRrieA2Y0dllUzREtfDLJgZPS5dzn3JiKDxpeCMJM05Q
         kuCzCrD+YLWPLEjrjwbNR+edSjcDdjzMFIyC+b2CEXhwMVG4n2wCK4Oj7eG0c8csJ4N+
         YgkNqCnow4t9I8sPmkANvli6jIRIpS0VcVTFgWGflNiPoZbYykg6SKU6c5NGZ2fBGzDB
         StCA==
X-Gm-Message-State: AA+aEWbwwlJxGStmnbLfSdpFzn9RSIuuq5PvXa5RQWQ36NdTY8QLlPlE
        OxKdy7KpaZeHVFsWS3hWJ1EEo4P6IOsaCbj+kHA=
X-Google-Smtp-Source: AFSGD/UhtJzJXKGQJjrbbG2pO6iuxEyVuJvUZ+eWQwnd/+H5a6JwpdedSQB8eAm1Kog7a9+lAukTaEuO5JvaIkvDUqQ=
X-Received: by 2002:a9d:2ae2:: with SMTP id e89mr15139715otb.290.1544628497102;
 Wed, 12 Dec 2018 07:28:17 -0800 (PST)
MIME-Version: 1.0
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
 <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Wed, 12 Dec 2018 10:27:40 -0500
Message-ID: <CAJdN7Khf+Y_jyyG2qoqiMHYPCHHSws15EDftOQni=gFJ7SoMXg@mail.gmail.com>
Subject: Re: [PATCH] run-command: report exec failure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for this incredibly quick fix.

I see the fix made it to pu as 6b206be3e5 ("run-command: report exec
failure" 2018-12-11).  For what it's worth, it fixes the issue as far
as I'm concerned and I'm very glad to see the behavior is covered by
tests now.

As a procedural question: I'd like to reference this patch in one of
my own. Can I reference it as I typed it above? Or is there a chance
of the SHA1 changing before it goes into some sort of a main history?

John Passaro
(917) 678-8293
On Tue, Dec 11, 2018 at 7:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > This breaks on Windows (on Windows, the error message says "cannot spawn", see
>
> Thanks for a quick feedback.  Let's update to look for the pathname
> of the command, as Peff suggested earlier.
