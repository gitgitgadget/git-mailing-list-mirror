Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241791F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeI0XR2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:17:28 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:39295 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI0XR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 19:17:27 -0400
Received: by mail-it1-f169.google.com with SMTP id w200-v6so8448408itc.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQlrt01Dwh9vPb6rca2M8quH5u454yav/vZS2JNyYfg=;
        b=d/biL50R1hRKeyb9/vpUq4SHCuimlbOwaZZmbO/FOKU23fedwU4PGg4um1gqlfCzBY
         gcu/ImmxwNMkx0rCUHNUbcxW8jRuK0ndbk/YykgjIPoYt5hfO7Ijqrn3rj+qFRtNJCkq
         Q2gTzHJNo4lzdwvt2UQjdOe5+7M/UEUevj2wpSbHnF5u7IEB2F8VGHY3LJQfB2Kp+QN9
         nxSWVyHhFcI+VA7jBXnD+RpkeTn/v/c4oz82TKBeHPq8qSNh8xuofCVzjcMMWmboc2b0
         9ejzLWJMlhBccg82OaoWSUizI7ZXbvN3/tTeOleaRrrpi7XmW7+/1r+FXMQoujT0azm9
         deeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQlrt01Dwh9vPb6rca2M8quH5u454yav/vZS2JNyYfg=;
        b=DZJEs7+lM5yPmP2oIywEc8RwYRjKaEf2Kzg/0grk1fLCXL341N58s11FL+qYh3m4JL
         WwQ1hq5xcML38mtG3pR4HjbxWVyiC8ezI9e/WVQ+pqNeHrgv5ZRYS7Afy1qFUHx+60E0
         iXQwfUGU3nI5I7e8E3F0gboVTfdqtmqk9yfEstAwB+YrVBIpGCMFNxWu2iFQEeciwheb
         Cihu9regUn4eCfeONw6gy8ji4CwaWAfQTHqp/HraihMvqtEPqhgs0u6qlKz/xsjCGaPt
         RoxWmtojI75IpMEEKBmuVWjOAFAX7n4QSDiiAoKExBKmZ0MAO6CNPiqQPmkt/2HR7rtb
         Z+Iw==
X-Gm-Message-State: ABuFfog63MOJdNZ0UYTcidAemKEIuc2jLQILaJ27NK34k6/d8QCyy7nx
        fPrBS9hC4b1Lsi5T7gk7sqw5zPu6DSv6FN33Yjc=
X-Google-Smtp-Source: ACcGV60Ymoc8qrwVynwPPn4pad346JYITa8JNErv5KbfO9DVofsPl9b4+7NvwzIyE7hwIFKg7BX/bNB69ygOjCADZ48=
X-Received: by 2002:a02:95c7:: with SMTP id b65-v6mr10665685jai.61.1538067496878;
 Thu, 27 Sep 2018 09:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
In-Reply-To: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 18:57:50 +0200
Message-ID: <CACsJy8Ck+2EpRD7aDKH1wmNprbnZi7Y3XVAp6vv1=TeJNnT5Xw@mail.gmail.com>
Subject: Re: Null pointer dereference in rerere.c
To:     ruud@channable.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 10:24 AM Ruud van Asseldonk <ruud@channable.com> wrote:
> Please let me know if there is anything I can do to help diagnose the
> problem.

Nothing yet but please keep the core dump. We might be able to dig
some more out of it to confirm if we find something suspicious.
-- 
Duy
