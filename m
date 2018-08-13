Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF891F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeHMVYr (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:24:47 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37224 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeHMVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:24:46 -0400
Received: by mail-it0-f47.google.com with SMTP id h20-v6so15612810itf.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jb1yXu00FhRiQHGNmEi3a257253DTxo3Q4l90Y0x8lA=;
        b=GkkwIYWpUZAgRpdh6J3ADI2BMTCZydzOOZUB3NwWwtsS9cCfo8wdSR8T0vMrTsGxg8
         +hLdD7IlIAvkPQ3dEsIYbcChl8/GWiggKfXMFxazNOexxIMJEL1u5egeYNzX/CeGWSV2
         KY4bWQjSkiCeKFfO1HrJ7Nx7ajvFy5h9Tjb2MUfJqnFiRlETDROgJd+0HEEVQzxA5V8W
         NzJQOncXUtZs51rPeqTEHxB6qTqejfZ1gJtDqeZ6JavgwV/uaxDzd8jijRkLlD9KTOBC
         tYgHNvlxilfVHT/cVzK3RndqMatwOPpT29qskzeIvPQOye3zaVJVvRbe8NhQteHHp6MO
         nquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jb1yXu00FhRiQHGNmEi3a257253DTxo3Q4l90Y0x8lA=;
        b=ispVwEMrORFUJ5EA8TjCOLJQNBVQ4q+oyq1vDHL9HATokNj4hEgH2UiNXRaYVWMqOy
         irVgxOveqBjIK1Io3iq9aHpzB4M30pswQoPwFdeAhk4xeKJ91ddI8vS2GTZHc+vZSgVK
         f3wwlkCMOCpmvPMljJfsbyN8CS1dndAf7oktmYJGBWjfw16tBnvEZHoZFJsaREUkryqv
         o2pwV/pv+Y4KdghTWZp0l8nLfdTMZmJ8xcE+xAURM9aqYVKMiTC8j3I888Sdhprwp1IY
         FrjSFGYQaWib17KVUgfBaoF9ZznmhOKIjHru84BvfNJCAJt/c8uMYdlchPtMvoMDFZUw
         /YQg==
X-Gm-Message-State: AOUpUlH2kWERjaGbKWI4kQUgtj7QFZXiNkz+yYnoRVMNKP7xPDHZAixJ
        L7ZU/0ODJ7dr4JIh2fRAPj68/QI7L6WhA95IZWA=
X-Google-Smtp-Source: AA+uWPzl8wJwF+H+kCP480amNUR501zLPn57nbNMPAJdW93Pdbg4433s4X+t9Dym4bhf78JnrrGPq9qBGp4sVeYq2Xk=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr16400947jam.61.1534185682407;
 Mon, 13 Aug 2018 11:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813161441.16824-6-pclouds@gmail.com>
 <20180813171718.GB240194@google.com>
In-Reply-To: <20180813171718.GB240194@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 20:40:56 +0200
Message-ID: <CACsJy8BCb2fbUwOzifd-01ak3vNFKdBavWcmp4da9A_RR1xCMA@mail.gmail.com>
Subject: Re: [PATCH 05/24] dir.c: remove an implicit dependency on the_index
 in pathspec code
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 7:17 PM Brandon Williams <bmwill@google.com> wrote:
> I'm just sorry I made it this messy :/

Take it with pride! I think all core devs can say "oh yes I've made
big contributions. See there? I made that mess!" :D
-- 
Duy
