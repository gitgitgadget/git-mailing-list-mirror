Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D6C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiCIJLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCIJLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 04:11:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15416BF95
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 01:10:45 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j5so1450268qvs.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 01:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=68f76z4EpAJxh6iHGXzi9j6E3/qwnAAeH32qXsqwrvU=;
        b=X3CkWbzAPWE+BBGGp3RONqSrBWYrThTID0ZocSg9mF3coMXycx0adPWp4PZQTgH1EB
         L6n28bLZlAUTcORAaVesmgHQDhKlDylExhiyGnSCPG0fHU4lJgFNGZLAD69vYHM7rjlw
         aW02ILVGWoOm9+AcAkX4jmMpeGMoRZz0bej4ExuxDkOaAHSCy8JoOWULB76tapj1ITsg
         WIipgfSo170uobsZIhLhLAa3J0KBdc5uWbp9yC3eW1kw2YMmu6RQJOGSG00BesYnMCg1
         njCLryGx1E5Dc70mc6+WYPVnMDboPDvk3HY5CU9LBZ+r3brKLDE0EdQTzGcY7I54Tveb
         sHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=68f76z4EpAJxh6iHGXzi9j6E3/qwnAAeH32qXsqwrvU=;
        b=cLyd1IscZSZTDnZzbHA5fwjKvTWde9NihDJqHgoVMXpiL0N6HvBPcUzv5+wOcxu8IC
         CSoGz5ONlm9yFf3oj+PGTCTCQRCxIUGN0UNixRyU7l/yOtZyBp7quScb9l3L8l385thr
         ygPQ+FXHu9Z5pwjXn0vm3cH7/kj1H6el0zekGBt+rp1dFg7SgGE0RgYY9CZ4yM2O40mp
         gNAU51UZpcuNijP/9u2bBEWHzjuzWuXTqVZA54ocVF2DpH+/JgrpBnKd4RU+g+S8Ijsf
         WU37KlzQA5uz9EIz9fLL2uDwJMcP1ORJVNrP2L8aCWtxo0QeiaGaQpTVCnSW/Awt/XJm
         H8Pw==
X-Gm-Message-State: AOAM533AKRcUxwp+uVMTdaoYlV76sQaEtDDiNqssIEsUVq/aE88JARjL
        dkvXXm5Gsf92gAmWdb6o7jw=
X-Google-Smtp-Source: ABdhPJy5Tz1qHYeMXBqGHpfVqzfokdD3BQNv5HUtsh7ZIKMwcdHYN8nsIZrd7NZeVephc331CEcncg==
X-Received: by 2002:a05:6214:2605:b0:435:bb0d:6361 with SMTP id gu5-20020a056214260500b00435bb0d6361mr3053182qvb.47.1646817044158;
        Wed, 09 Mar 2022 01:10:44 -0800 (PST)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b0067b1205878esm679258qkj.7.2022.03.09.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:10:43 -0800 (PST)
Message-ID: <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
Subject: Re: git notes question
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:11:16 +0100
In-Reply-To: <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
         <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik,

On Wed, 2022-03-09 at 09:54 +0100, Erik Cervin Edin wrote:
> Hi Nuno!
> 
> > Is there any way to remove the default "Notes:" line on git-notes?
> > I
> > don't really mind to have it in git log but when generating patches
> > for
> > instance, I would like my notes to be something like:
> 
> Just to be clear, in relation to which command are we talking about?
> 
> For git-format-patch there's
> --notes
> which I assume doesn't support customization.
> 

Well, this is the one I would like (hoped) that we could do something
about. When I do '--notes' in git-format-patch, I will always see:

```
(Typical git commit)
...

---
(I just wanted "Notes:" to be removed and my notes to start at the
beginning of the line).
Notes: 
	(my notes go here)
...

AFAICT, git-format-patch looks to be using --pretty=email and I think
we can use --pretty in git-format-patch but having to mimic the email
format "by hand" is just painful and I was hoping a better way could
exist.

```
> For git-log it's possible to customize how notes appear in git-log
> using the standard way of formatting log messages, pretty format.
> %N
> is for the commit notes

I'm aware of this and by briefly looking into the source code this
seemed the only way to actually remove those predefined strings from
notes (I was just hoping I was wrong).
> 
Thanks for the feedback!
- Nuno Sá
