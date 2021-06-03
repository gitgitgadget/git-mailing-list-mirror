Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB4C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866BA6140A
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 23:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFCXo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:44:29 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35791 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCXo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 19:44:29 -0400
Received: by mail-ej1-f54.google.com with SMTP id h24so11766119ejy.2
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 16:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBYKu/u2enuu0gvOeAxFqLTFyz5XQX+mWOYMwBhvMzE=;
        b=XSGp/4zqR97GoBad3iyvz1GPlC9RrbWOLO+g+QpdCSdYYFXJ5DBVn5ZeeGZFBVc3J9
         nHSDSj/bFinnYV7GJfJAEmNT1lNqcvOjWsiuBBuaz5Wjn6tiw3UFOo3bW5QC2uIMjyFn
         amPYajxJu869bMYsvPwRYVB7ZKfOBn/lPrJc3/tYCAZrUrViZJxiR2VA7sZ+nVoiN3N2
         ZQNXOGuOoWn/b0lMIPy3DMaS9dKXc9fMOhfZyQbzGJywR8+OO25zI9Zy5dcGQTDwcGD7
         iNiQ3isdcydvozpxF7sdjvRmR1NKC5ZvdEHjT2LQNVYmAt3vg3D/6TTav6fgBEkWvf6s
         qsRw==
X-Gm-Message-State: AOAM533bx8d+G3Zfmaze5zpFrknquR7RGpLj023VHDnta6LheOFRMSAt
        5ojfg8tzPlxx9Iqj8f2W9DCxNH20jCxoq/Q2N2w=
X-Google-Smtp-Source: ABdhPJyUXU5l7MlwUBoCvmQnXWN7gfKKGlScKeWyS3LQ0+Sr5LXAyN1roeylzdOJX1Ed6+41bchLDZdYXFKPcsBSzsE=
X-Received: by 2002:a17:907:1c13:: with SMTP id nc19mr1565454ejc.168.1622763751381;
 Thu, 03 Jun 2021 16:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local> <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <20210603183220.47nx7f2aazk6wy33@nitro.local> <20210603190231.GT8544@kitsune.suse.cz>
 <20210603190756.ri5o4udl2bvusyhw@nitro.local>
In-Reply-To: <20210603190756.ri5o4udl2bvusyhw@nitro.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jun 2021 19:42:20 -0400
Message-ID: <CAPig+cQX7PkPxGMe8oLKU-kqsas0vKoszLtntgNp3K+5SvBDNg@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 3:08 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> As a note, you wouldn't need to use it "all the time" -- just for the initial
> login via the browser. Once it's done and you set up the app passwords for
> SMTP/IMAP access, you would rarely ever need to access the TOTP token again.

Thanks, that's a helpful datapoint. Coupled with Felipe's tidbit about
PC-based OTP clients, it sounds like this might almost be usable for
someone without a phone (assuming 2fa can somehow be enabled).
