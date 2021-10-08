Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B3BC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 06:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD1361040
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 06:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhJHGxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 02:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHGxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 02:53:20 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC21C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 23:51:25 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id h4so6067088uaw.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/1dJoHWVSoJRsupZgSTzKDlGB6plvJa3p03ZZayrHG4=;
        b=ijcxDBVmu/EIugisgk14YyGMrkGNW8+PiLd4FxXKle70OoOlrbhoyd/Xq404GSIb5J
         jFOLambPRKxWuDkhEq6ZMX+p4b9WVs/wdBFD6woEWy6ed8IEkLmHgxaoNHsVM6BQvgI3
         bsdhDxpxiLJKFfeXSFlt4us+csMZirhGP+daX+L6DAcgs8Fp+VvipmXRNqB95JYQ5WAd
         /4dLdGUuVhJvVPxzf+UeS1iF79iAWB6ygHU0QRVMd+hQ6fdCJqr2d03QCHkDKZNF01/Q
         fED5pk6TUWiFp7HQ+AhMrkrwMuIqBO4ITSLeRReoB5homuAuPVA9f08KY8N7OJdBS9AI
         AQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/1dJoHWVSoJRsupZgSTzKDlGB6plvJa3p03ZZayrHG4=;
        b=nkQFUa0qz1hLFod1omg+p+x+YJIe02bpOnPjPEwOtCm3J917XaOzH+VjeZrcT5qPpP
         skXYhJGdPNVaxLfAI5bl16NzxuFP+VyIPxOh3yKUnEF9Y9l1ph0ophFHOvriN9+BmolL
         RIJ9Fm4TcNnahguhJpjH4spsg7XbJX+XVrCXgXaBZxsfQwng0rq05RW8TFeGwVmAJjIg
         auAETxY9oDojiiGltFukC6f9xhqaY/vdKGS4YlTI5x7hO7O+skrErYZkHele944jZ2P2
         Rv6Kj0wv7YmNmsUwUza7AcmiNjiw6JX3KSHhQx6NWM9ZZLrpTzZz9tP3kRghaLzRE27b
         mTxA==
X-Gm-Message-State: AOAM532RAMjC8i8pTRf5khHxIxSJ8u+oGR+9bkAuH2lauufjeLS28oWF
        sfsBNUa+9+5HM4h7FOxqO1H3iJgLexUFr0an5tiDgnbjCPs=
X-Google-Smtp-Source: ABdhPJy+EDJWJRIObDO102KBdOW1acxzfJpFnNxodKc5XegAurOtsp+Sqtr0KhQZ88bXELln4leNlbbuesjVPd7W/ec=
X-Received: by 2002:ab0:381:: with SMTP id 1mr980351uau.23.1633675884758; Thu,
 07 Oct 2021 23:51:24 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Fri, 8 Oct 2021 00:50:58 -0600
Message-ID: <CAJfuBxwGJmJvH-=Cm=6ZXNzHxWUL=TKjV6JRqPpVDB9xuiPDeQ@mail.gmail.com>
Subject: format-patch -s shouldnt sign 2nd time
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ive started to manually add SOB
since it needs to be above the
---, followed by version info.

git format-patch -s ...
will sign again, and then
checkpatch will complain

WARNING: Duplicate signature
#178:
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

A selective addition would simplify this situation.
