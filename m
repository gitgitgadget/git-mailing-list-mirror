Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10393C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 20:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E863161006
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 20:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhD0UvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhD0UvR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 16:51:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419FC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 13:50:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u3so12710556eja.12
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3/aZC8DVDaclvyhktMyjYMmDehOQHRaQ6+pvmMbtiFw=;
        b=MNuZDuSmnYHfEbVsYhvHORfoNUFZWhYbNL7SZm947j50mRNGGQkiyVlJJvKZnC1Vss
         gBX9wbhGS9fG/hgt5Q6Y7ikehYiwqvcuLhmStXVUZKCRYcuffL3ENS9fhD75+W/XSqXN
         lMMXHEX0sRRh8BMR/+LNZtn7TjrXndKpj2Eu2Xez0QNqXxty/UAvv9YVz57toxzSbgWU
         Q5DIBTg0Kigav5LFwc2aHZYYgk8FCdTYbGtfVwVtRahDcUweAcBesvDr3WcGjnC6ZtAz
         VgBhieo6UraTvEXMDO05Pu6HiZHM24AWXUQ/ETrr/IeGGV0oSXu7vqSD102m/tbkn8ak
         X9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3/aZC8DVDaclvyhktMyjYMmDehOQHRaQ6+pvmMbtiFw=;
        b=AKSFGw8NL5ce5u5U2G/N6OrSAcajdTrOv6maDbwjtNICWS17Uzn6vUb7cPPzPiK/d+
         YGmbS5ISs75k/81GXBXC2Ni8y/LtEEcfSuS4sSfttGlSChjgDfYuQZ75wvboN0q12bvN
         ia8+3bmRuatQ4tCM1o+ZqW0bnRoCU8aybBajRkZNYJcxOFOj6zL3vJTfLSxv3U+GSh6z
         oS6o0NvggBrPZhzzcTMPxji6PbYXFbat0S6dbKSUDHCjeNEBdJd69wD0OL58rdnW422I
         PYN6ucOMslaIWgh/rpda8Qs1XiAAJIUR4rze02rOvCxe3CkAs3ndHV7YedotnkloqLuq
         ot0g==
X-Gm-Message-State: AOAM531VOHskpRjkukoXjJXoxoMz4JVoC6OK9G5YP5EgmE/soBchqIia
        FStipB3Tfc2ABs2rmmFRFZ9J3o8n8TPCUbJuOEo8N9XH
X-Google-Smtp-Source: ABdhPJyCwI4Tj7Jy+s5SxjVDs/L47vmzwncGkkiq+Bht44ivCV076uJBFNyeW5k19q85rETFWJBFDzag9XtWoZoHTz0=
X-Received: by 2002:a17:906:4756:: with SMTP id j22mr24434390ejs.506.1619556631764;
 Tue, 27 Apr 2021 13:50:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tsukebumi@gmail.com
From:   dabicho <tsukebumi@gmail.com>
Date:   Tue, 27 Apr 2021 15:50:20 -0500
Message-ID: <CAO8+z-buoW2yMJS4JNq_68yForgZm+D+hY_9qNkk-ii6Uwkc0Q@mail.gmail.com>
Subject: [gitweb] Problem with html base tag
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bb2a5d05c0fa69a7"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000bb2a5d05c0fa69a7
Content-Type: text/plain; charset="UTF-8"

For some reason browsers were not loading static resources (js, css,
favicon) until I appended a slash to the base ref in gitweb.cgi.

Not sure if it is a bug or something changed on my side after a system
upgrade, or some change in some dependency.

I attached the change.

--000000000000bb2a5d05c0fa69a7
Content-Type: text/x-patch; charset="US-ASCII"; name="gitweb.cgi.diff"
Content-Disposition: attachment; filename="gitweb.cgi.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ko0i4rh20>
X-Attachment-Id: f_ko0i4rh20

LS0tIGd3L2dpdHdlYi5jZ2kJMjAyMS0wNC0yNyAxNjowNjoyMy4wNTQwNjM5MTUgLTA1MDAKKysr
IGdpdHdlYi9naXR3ZWIuY2dpCTIwMjEtMDQtMjcgMTU6NTk6MDIuMDYwNzI1MTQ2IC0wNTAwCkBA
IC00MjE1LDcgKzQyMTUsNyBAQAogCSMgdGhlIHN0eWxlc2hlZXQsIGZhdmljb24gZXRjIHVybHMg
d29uJ3Qgd29yayBjb3JyZWN0bHkgd2l0aCBwYXRoX2luZm8KIAkjIHVubGVzcyB3ZSBzZXQgdGhl
IGFwcHJvcHJpYXRlIGJhc2UgVVJMCiAJaWYgKCRFTlZ7J1BBVEhfSU5GTyd9KSB7Ci0JCXByaW50
ICI8YmFzZSBocmVmPVwiIi5lc2NfdXJsKCRiYXNlX3VybCkuIlwiIC8+XG4iOworCQlwcmludCAi
PGJhc2UgaHJlZj1cIiIuZXNjX3VybCgkYmFzZV91cmwpLiIvXCIgLz5cbiI7CiAJfQogCXByaW50
X2hlYWRlcl9saW5rcygkc3RhdHVzKTsKIAo=
--000000000000bb2a5d05c0fa69a7--
