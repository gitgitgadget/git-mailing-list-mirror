Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842AC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjBNIEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBNIEP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 03:04:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F95261
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 00:04:08 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s20so9631507pfe.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 00:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=58ZnfirMuNCOz2EYOiKScWUjZE5Jk3tVaI+rtyuf/FQ=;
        b=Vl7UHi6Y3Hi8hXcGxf5/CtgHFWhHAHB3EBvXXYPBxRNS//3njUT3Y0yWil5n1aibTW
         QJqqd/pXb9zy+w6jXYB8po/QNXybCJvAJMNI/WHvMi0dW7JvHMfSYUEQtzRx+DbZNEzs
         dHumkTbyClr0ZWtht69+6YLr86/NQBNp0SJCQ8XqtwbQN2j7Ry1x6Gw1Lm6lfJXRZK1a
         cT38w/x9OKpcZho66KBjvxi3upBx/8BQAYXo4wR4etAdjJh7CdSPyiz6gWFzuk+glBsr
         keYe3qNg3p73NXuwiGKL1868IFNaYA4IzSqp9EbMghg+JkNr+gEV7bNxD/tCbKx85Kkd
         jlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58ZnfirMuNCOz2EYOiKScWUjZE5Jk3tVaI+rtyuf/FQ=;
        b=Ge/6oz5FCD3Jw/94tUj9s+l4g2qfuUxeFggcCum4G2YdJGM0+PINgGrycDOqKK4Aiu
         jMALyhKBDGakVDuJ7I7/aaedHOHdElxc82ObkPD09o+gc5s2eL/zp93RQbZnW1Oy7NDv
         ejQMEK07XxLD04JighULGAHVmmm8sohaczESyZCnp+x5C3L76xI/3hSxqh2yS021XC7n
         1ZKGlBh4yaLSXRELE/tt/Wn3HnQ1/0tfykfK4vcqvewBjvarLLIiBeTddSytRAhoG0cs
         +a5TrvKyJpHO+Kzj4yZSPHHy/Hi+WgnkIrW6c2txEBUvOdrYji9cbhvBDzBDqFae1THW
         YcYA==
X-Gm-Message-State: AO0yUKWtIJLLW3tHO4MQGfTLdOMKc1jxWTQ191z8UASxO3zVROpNqY1Z
        /4LkXQD595j571lDIp6XBxPl0WaEIKMJPEhUcxA=
X-Google-Smtp-Source: AK7set8Coe+voalRwdcyToTMraglbE4NRq9cP4whl8CzOGrSZJOQT93p4w09JzBjHz6FHcjrmfck0QY2O0VPi07FP78=
X-Received: by 2002:a63:7a08:0:b0:480:ae27:c7ae with SMTP id
 v8-20020a637a08000000b00480ae27c7aemr167553pgc.24.1676361848214; Tue, 14 Feb
 2023 00:04:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com> <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 14 Feb 2023 09:03:56 +0100
Message-ID: <CAN0heSq8OSOyX=FpRd2SPvyb6EBbju-5gbTQGxHre0wkwB=tkQ@mail.gmail.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Feb 2023 at 23:03, M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -167,7 +167,7 @@ helper::
>  If there are multiple instances of the `credential.helper` configuration
>  variable, each helper will be tried in turn, and may provide a username,
>  password, or nothing. Once Git has acquired both a username and a
> -password, no more helpers will be tried.
> +unexpired password, no more helpers will be tried.

s/a unexpired/an unexpired/ (or "a non-expired", perhaps)

Martin
