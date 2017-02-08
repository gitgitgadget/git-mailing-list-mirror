Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DEB1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdBHXNE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:13:04 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33507 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdBHXNC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:13:02 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so16049335pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 15:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uMxOwUhsjCygA6nQslV8xolzBgMhZy00zCFq3tpc0lc=;
        b=eCuaMnzJsLuGovMl02qgaCVI4ZBj5YkKuMWMYX+1S9WsrsQgtIhpzDPyCY20o3z2iN
         xV4+gD9qn+JejdIY/spy3ydjYHD1JYDxJF0DC1I4vUm0shEqA01DNn3KJdpgPFo7iMo8
         dxs7DkUcVnpbs6FrshwJRxcD56jCg6WpMkoopBG7nhHADpahMLuVVjlolQVRFJRQHW1Q
         junhKWTGP7QwRTgXOy6szox+w6HxAhnJLgjqnVHRBm2h1V05qYckJ6fntjaQ9cWV0JsA
         9YnFxcP2M7ENrSuX8PMfkbADRQCkDAMUmhayh6McCba+ulKETW2ENYzaH6Ttbd7PHlyp
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uMxOwUhsjCygA6nQslV8xolzBgMhZy00zCFq3tpc0lc=;
        b=jhcj+rn9lMCS6Ea177Kw2tOgYAgW7m61Cot12bak6QukBhYqmPQl+s54t3gb6o/pn1
         fH6FTPVGLrYUVdXiFD/g8GomD1CVYwRLjMB25HPFoe12n4JPQZveKxa2rDlYMn7ydkhE
         uhyV1fahUAeE6JncUn30sg1J59Lc+AyHRjqNfllX3PNIH37hwojvgNj59mnfvt3//3vk
         voXzjJnEfKqL2agDMsQHzA/SYUPlEr+kajVafS2ya3cUo5UW/+OpBQnAArptzs8/WUrq
         QY6O4WXrM7XwqB+yVJQ4H1kCCO58loTULHRHLrOpd6/s7IjzAE2Z3PseIiw/QeMWvF9M
         HRtA==
X-Gm-Message-State: AMke39nkJMzN5FJ4ApFmLy27A5+If9fgusYVJ17K0QCVYAH1SHKJzonMDrgnMmfJ9s/8Gg==
X-Received: by 10.98.163.216 with SMTP id q85mr28681110pfl.123.1486595158461;
        Wed, 08 Feb 2017 15:05:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id z77sm22976452pfk.47.2017.02.08.15.05.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:05:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
References: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
        <20170208223532.GB108686@google.com>
Date:   Wed, 08 Feb 2017 15:05:56 -0800
In-Reply-To: <20170208223532.GB108686@google.com> (Brandon Williams's message
        of "Wed, 8 Feb 2017 14:35:32 -0800")
Message-ID: <xmqq37fouvu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> git cmd -- :^dir
>
> would produce some output which says:
> ':^dir': pathspec magic not supported by this command: 'exclude' (mnemonic: '!')
>
> And the user may scratch their head for a second since they didn't
> supply the '!' character, but rather '^'.

Yup, I am tempted to tweak Cornelius's glossary fixup and squash
this into the series, for two purposes.

 - it makes it clear that '^' and '!' mean the same thing (and
   clearer than Cornelius's original, "! or ^", which could leave
   the reader wondering "ok there are two ways to say negative; do
   they subtly mean different things?").

 - it hints that '!' is the more official spelling, making the
   output you showed above acceptable.

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e61a9..822ca83264 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -386,8 +386,8 @@ Glob magic is incompatible with literal magic.
 
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
-	through all exclude pathspec (magic signature: `!`). If it
-	matches, the path is ignored.
+	through all exclude pathspec (magic signature: `!` or its
+	synonym `^`). If it matches, the path is ignored.
 --
 
 [[def_parent]]parent::
