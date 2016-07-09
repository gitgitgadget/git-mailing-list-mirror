Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928601F744
	for <e@80x24.org>; Sat,  9 Jul 2016 04:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbcGIE5g (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 00:57:36 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33460 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcGIE5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 00:57:35 -0400
Received: by mail-qk0-f174.google.com with SMTP id p74so19423159qka.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 21:57:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=lHJ/OB7EKRtMP2VABR6M2elyu3tO05a0/TSvKGSluB8=;
        b=gkEX1Kpjcsz7LpMR+i26zjwphsg5NhqxKMskatBdMSimKshSMCYmLMZ2q3F3kMx9Gq
         caM4PGK0L3t59wd+nQcb48s+v1P5ETMCwfxfNjFupxavy/ZkbJ1oTg7tfxJNrzJJhLRM
         UZQHDsTic9BEcljhNaHrKCoJffTjc+rnsHhKkjsfLO/E68PLB6U086iugeDgSFFfUiNa
         cMZ59cdqudvgD4ChOVbhvL0j01jQABstiyGCiqpyoozLthsWvHqZQgK7szxkoNBI0D/3
         1viCXUKj6XxwbKB4t7tWbAmStjXtM0exN3CZbN5Y6xk3K7w2EvOxaLkZJSkZvkks9Vdw
         IFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lHJ/OB7EKRtMP2VABR6M2elyu3tO05a0/TSvKGSluB8=;
        b=XBAojT//sRaZ0Z1NjPBIi8Ye0a7HG4vfPVTTRvtdmNgaAwW07Mj7h41Xp0DoEmtCB+
         UuNNyxk0p48HDzsUcyZ0ulALVprLJqMh5iJVUeEnkZjTo4IaZv0Z7Gs4hE9wFQFXrMcU
         hvFiSO8kSmNE5+Cj0fk/AbZcCjF7JNBOWe8GyYJgIqtCNgDDzG7XScswowHv5xx4HE8L
         fyo9XXc4YD/m+A2yg7lnjgyo8ogKhvf7dHP1+0FQYzcQBrYJorUIwbbygbrR8R40BOSu
         Dh6HDDmJiTvHS12QS+cm5Doj+D7ort1cBmacsFzpYifDETYVo+cbhuPaMsCYkXghBW9V
         p3DA==
X-Gm-Message-State: ALyK8tI10kkdwXgq+sQjECzJh8dcO8WanWxoIpIBlRcJ36i/1jW59ZgbQpNaQgosPJObDBgyKAAd73HoqSYjGQ==
X-Received: by 10.55.160.211 with SMTP id j202mr11607303qke.108.1468040253973;
 Fri, 08 Jul 2016 21:57:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.47.134 with HTTP; Fri, 8 Jul 2016 21:57:33 -0700 (PDT)
From:	Sunjay Varma <varma.sunjay@gmail.com>
Date:	Sat, 9 Jul 2016 00:57:33 -0400
Message-ID: <CAJaQC31Su7NKd46cD81HE2OvC=O09aon12k8HFV29def4BAYfw@mail.gmail.com>
Subject: Git GUI Guesses Incorrect Language
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here is a screenshot of what I am talking about: http://i.imgur.com/9ZRkeYF.png

This is the `git gui` program.

Just before the first line of my code, it says "C++ source, ASCII text".
That file is a JavaScript/ES6 file. The ".jsx" file extension
signifies that it may also contain Facebook's special JSX syntax
(HTML-like syntax in JavaScript).

Interestingly enough, my other files (http://i.imgur.com/L0qCRO4.png)
seem to get guessed fine. This file is only shown as "ASCII text".
That one file just seems to be a false positive.

Here's the file that gets incorrectly reported as C++:
https://github.com/sunjay/snake/blob/33bb6135b7bc4f6a958c3fdf51162f86e4cdf508/src/models/pathPlan.jsx

Here's the file that is only reported as "ASCII text":
https://github.com/sunjay/snake/blob/33bb6135b7bc4f6a958c3fdf51162f86e4cdf508/src/services/ai.jsx

Both files were unstaged when this occurred. There is no line at the
top for any files that are just modified.

Not a huge deal at all, but still a bug as this code is not C++ at all.

Cheers,
Sunjay
