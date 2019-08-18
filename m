Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69521F461
	for <e@80x24.org>; Sun, 18 Aug 2019 02:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHRCob (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 22:44:31 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:47064 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfHRCob (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 22:44:31 -0400
Received: by mail-lf1-f54.google.com with SMTP id n19so6562808lfe.13
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cp4U/v/oxm2qzX0ZSGc4pGhWml7cPnfCHkWNh9B/0oA=;
        b=MAMHQe3LD5Cxa1hOTW1201ZHE7oQvoBUazkwQDTpnMN7J+kQ/1gkoy10KbRTkUQorD
         hFD8h3Rzhrz+EjT5CNTrL/NJZmMwY2IV9OPS3ZWErs/rKHZOXspAfZIIsIkW3Ke5VkHe
         P+lWwvKoqJ49HmiRFT+6tz+vAOWx+7fP8d9i5UejsCnpqB1QyfyEmTWbaYpIOyzvC8JX
         yD3z4n7QezGc9lyDtZhH21BSco/9YdgiKTeFKWq6WuN7SJghV2UxfWV/Jp3sL5BX5VIp
         sTPdPEfgWwX4YOjDhkjbv77MbG40N5TmxWPBU9E1J+CYrd5K2lklIJxFw4/W0V6aeG6t
         rm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cp4U/v/oxm2qzX0ZSGc4pGhWml7cPnfCHkWNh9B/0oA=;
        b=cIhpyyG/S3XQ/4SvTAmijHZqtacJsuKlSqVyrdjOUdP7BdzQmludho6Fk42+hZpgsS
         GjxwhS8bFFK7nbCY7ZS1KTTIPAyRfSUxDsN2QU56x9yoY6Ozb+v0Iv2xjCHQwVmA00Hc
         kGJIsw3SJOc/MIYd82UvFiSVVc/NXXHlrtIi8xLXNZGMm/CVu/FkTe7vv0kcCEFA7Bf7
         j6q+/XZ9y8GoT+8N4reKdLUkoQVdlDHFFc8OClNLRP6py5ugIrGob1lMW68bOdfUqmo/
         ZQU3rFzRjdJc3l/LdfeWGsufpaYa1/OucI09GB926IysLCzmGp6Gs4bKMgroL/89XPQ/
         bqFQ==
X-Gm-Message-State: APjAAAXykWtJEQGYbY5rxKG6j8j2iR7a1VzUoxDnAt5L55O5noz3fLJd
        jATAqjGA9lDaI4ln2j3b1L9e374V7D/UJg58quVufQ==
X-Google-Smtp-Source: APXvYqyJ1kvDS/g93dAexZ7NvyxSy6T7vl3npa7764f0+XquYXTgfJddWnMrBEJAKxaiZN1f9042pbM3As9TED3Nydo=
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr8571447lfq.44.1566096268629;
 Sat, 17 Aug 2019 19:44:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dhaval Patel <drdhaval2785@gmail.com>
Date:   Sun, 18 Aug 2019 08:14:15 +0530
Message-ID: <CADSGPzV+dfNR=epmz2whKkrpiH=JMUR4gVjpZ+x+kzKrX0kD-A@mail.gmail.com>
Subject: git diff autocomplete
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to reproduce

git init
touch abc.txt
touch abd.txt
git add a*
git commit -m 'first commit'
echo 'hello' > abc.txt
git add a[PRESS TAB]
(This will autocomplete 'git add abc.txt')
git diff a[PRESS TAB]
(This will not give 'git diff abc.txt')

Suggested feature -

when I press tab, git diff should autocomplete just like git add.
