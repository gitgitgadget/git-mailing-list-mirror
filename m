Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0434420248
	for <e@80x24.org>; Sat, 16 Mar 2019 23:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCPXWF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 19:22:05 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:40369 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCPXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 19:22:04 -0400
Received: by mail-it1-f178.google.com with SMTP id l139so16299787ita.5
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 16:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uBQZo6BAkKQWoiM/uqYZauryEfJJi395TPCLmkJwia4=;
        b=cGyPJ0ByG0ARtCiVMRw88gEOQjhq4tGXW//88CVqIXOFq+qUtOqrocxokzFs97T4Fr
         1JhdMXFgt8Gs2KwFNq/Eb63yMDpW6QH123XXx+6DtNO5r/lrFfcTtahivTXjWg7jADDX
         Aq7LfSD9Xa/yElD4crJPRA1IajN9gRkOybmLTs68u7DcTi8v17D2TyLHmmc2J6Jx+7x4
         OUPmbcyBro5K/shkXP1G/siFZ8frKVj1lmKfhw98m95X4OlH60BXrHMKiiPZxO0CZTyH
         hdx+4I8tQZqL5cn9aYDW7yDYTOExpX5nhbERjatEBlYdMj0mBw5cxAn2F+OV8/C2W3Uc
         cqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uBQZo6BAkKQWoiM/uqYZauryEfJJi395TPCLmkJwia4=;
        b=K+dgjnlk8mdEJ4f3eniLuX0drVj9kz3G4UVjI8Lt6uOlH3kJhgrgefOXAD6UtN8jDF
         9cSBTpLfHR2+z55Tn2pm8QyvrPY93I+dfK07FmJWBXcAUe4xzW7rYgjsBz4ThML6HaBk
         GgZvG5TmQs3IYi+QDUT05ZylZWa4znkEVQUxR5Fr63M2zYVOQv4jMttJ2zjkza+53TB5
         JZOjbzRwK2L7jBnQArW4J7z37q7RQyKPqUl2YWuDLJTil/CoZzPFOLnI6O5fMHekIlJ3
         ZUzOiVg8o5WXeeBG4XKZBrC38QRfB4yk4TpKPIU+HDXQF5GBbQw89Ki3LWM2Pwk5/ztP
         dfPw==
X-Gm-Message-State: APjAAAX+JfWlT75CJGwL0wAoLfLGLx4DHBglGqEfoOp4wBd6dUiH9RUG
        IA5dj06Bx6StjNyh5VV11z115JvNrVFJ+xP0BnCX
X-Google-Smtp-Source: APXvYqwM7culPAvZu+FaFdW3xn6XKUv5gmO53nXo2qNgEgIU29H98xphI8FLyWapkZ9w7e2Lcm+a6Zk9HDynM047rMc=
X-Received: by 2002:a24:4d15:: with SMTP id l21mr5656977itb.64.1552778523979;
 Sat, 16 Mar 2019 16:22:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:661c:0:0:0:0:0 with HTTP; Sat, 16 Mar 2019 16:22:03
 -0700 (PDT)
In-Reply-To: <CAADWXX81agAg1B9+FM5c4JsWzANKochNTcv2ShsRzAsZpHAVWw@mail.gmail.com>
References: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
 <CAADWXX81agAg1B9+FM5c4JsWzANKochNTcv2ShsRzAsZpHAVWw@mail.gmail.com>
From:   Richard Hipp <drh@sqlite.org>
Date:   Sat, 16 Mar 2019 19:22:03 -0400
X-Google-Sender-Auth: wdIOA16xWkAaoujU2H_5tnrAecI
Message-ID: <CALwJ=Mw0A7XbB12K-X7OGT=kBXPKC4EN0zxtnz4gEz0+yHtEMQ@mail.gmail.com>
Subject: Re: git-fast-import yields huge packfile
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/19, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>    git repack -adf
>

Thanks for the tip!

-- 
D. Richard Hipp
drh@sqlite.org
