Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C57CC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679CD2072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDGQaW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Apr 2020 12:30:22 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36982 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 12:30:22 -0400
Received: by mail-qk1-f169.google.com with SMTP id 130so2286219qke.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 09:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xQuYIJTUVB0XaR3F2DUGqqke/JEuGjdBH6mn4/1We70=;
        b=LrvQWeeI0c0VDiM7vEYWp6tNfXSL5wsNtSPrJRABWEJ/5AH3CRZ72entr7D5a6plmL
         Jsltr5OERTYCOnIs37bXZEhbs0xJXjCa8N+oI4tyiHSCr9Ucs0O+FpeHmvgtx5qiow3U
         YCm8MisMN8JnOyBYzL8kLZbi8UHh/V5WjJRSsqYJq1ZIQhMcsC1qZuINcuC7cgUNTwgg
         hlTNmz187boUeGFDzlLOQmnreXPkN81UtGc4XSXaUTrGfSvx71S7mSZFO3tYAVPxK7WC
         b/YFFb5tvO0q7vvAGTRo/zH2mbULAO7rfHi57E4+lRoV5J06Dd96Q3rqTHnW/V/Xh6ph
         LPpw==
X-Gm-Message-State: AGi0PubyBn9NbEUiT+ZANud0iMf9hAVHbmqZ243HjRtP2kUpBeR7elXd
        UkYmOjGKt1aVLhYFdjIdsSBP/vXmEOq/eg94PGjDwP+klhlxUA==
X-Google-Smtp-Source: APiQypIC8dysIGfQd6Dgay5diWS7FzqoO6j5X6QEGuwZmhV64pyRvjtLNQQgcSXvxqB5D4phjIMRTwZnC9le1i2Fj2A=
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr3152593qkw.347.1586277021155;
 Tue, 07 Apr 2020 09:30:21 -0700 (PDT)
MIME-Version: 1.0
From:   Sami Boukortt <sami@boukortt.com>
Date:   Tue, 7 Apr 2020 18:30:10 +0200
Message-ID: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
Subject: New git-rebase backend: no way to drop already-empty commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using git 2.26.0, I just tried using `git rebase` to strip empty
commits from a branch, but it leaves them as-is, even with
`--empty=drop`. With the “apply” backend, it removes them properly. Am
I holding it wrong?

`git rebase -i` also doesn’t pre-comment them like it used to.

Thanks.

Best,
Sami
