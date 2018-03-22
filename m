Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FA61F404
	for <e@80x24.org>; Thu, 22 Mar 2018 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCVTUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 15:20:50 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35786 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVTUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 15:20:49 -0400
Received: by mail-wm0-f43.google.com with SMTP id r82so18276751wme.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ab4Yl2yXcmijCY/5c4GJcZkm7Dm2baYuvVF0n+P2kUE=;
        b=pX4tyMjlARRdoLXPrWUTajnTfEVFBSCQ1W/WrRMEeAVgONIaFjz0HU9JbCd5+5AnUV
         EN52sbk0PqptJPEt8yPEl2fRfyatZCAB0DdU8PG5TR+PJvleoAIMD2cZLMLLMVwwXu9O
         SAgT3ogT7UksUAK/dN8qs4GSHslPIRsFpW/stCbRWIW2J3que5Exmt6PlgTkNicx4k24
         4WVmvHc1L+zP4apViEilEdIZ+hNBTF3sGI3VztYSSvY2xCPBuNFK7fJNpzfLqnIJl706
         71Kj6oJn+gPHEwNPTIbAWNGvqLpFc2e+PqMEcPvr/vWOvqzY1Keq2/dEXHhldQTzO/wR
         hXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ab4Yl2yXcmijCY/5c4GJcZkm7Dm2baYuvVF0n+P2kUE=;
        b=o0IVx0OdMBNQztGXhBW9KcZdQc5Yk2r+nqZrZymzB7k/29qDKQDm8favxqOxoC3P+r
         XlDeUjJRdDVxNzWJbQQrV/lX9JnlQeji560xCPEAniaEiNXgeIaJ5+osOm8pF1gia5CO
         Y/2Fd4O8JgKk1eo61BAYWaWUozmqWN6/aU7m6o97fVx1d3+psuOaClaT6hBO5/LR9mq/
         7JlnE9vHJ+d1bl4XhcW4TeLhPeYfzySogPvRJtIHjoKOX3Q97eXgQ3oPYZdjye5CUeMP
         cJiMvIFIz3me1urssWNdLmDKys/7jWEqa1w4nZYPMcJrh5FdwB2zb44/TmHveSFSvd9K
         2Q/w==
X-Gm-Message-State: AElRT7EoiIjwrlotsPmPuOrST5s//4Ys4Ys5i7SRLggfIowNe4EbAWIb
        GCtoH55lsY1C6hXfjlKYtwWiIgAS
X-Google-Smtp-Source: AG47ELt6kpuxGvUqRXnddJBeV00TZ6Xpr9nBiWoVfTnO+hf5OYAPa9NQwwhWtCqEwz9IhbXTQrqNKQ==
X-Received: by 10.80.232.193 with SMTP id l1mr14049741edn.133.1521746448658;
        Thu, 22 Mar 2018 12:20:48 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id i22sm3472393eda.87.2018.03.22.12.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 12:20:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: The most efficient way to test if repositories share the same objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
Date:   Thu, 22 Mar 2018 20:20:45 +0100
Message-ID: <87o9jfyl0y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 22 2018, Konstantin Ryabitsev wrote:

> What is the most efficient way to test if repoA and repoB share common
> commits? My goal is to automatically figure out if repoB can benefit
> from setting alternates to repoA and repacking. I currently do it by
> comparing the output of "show-ref --tags -s", but that does not work for
> repos without tags.

If you're using show-ref already to get the tag tips, you can use
for-each-ref to get all tips.

But of course that'll just give you the tips. You could then use `git
cat-file --batch-check` on both ends to see what commits from the other
they report knowing about, in case they have branches that are
ahead/behind the other.
