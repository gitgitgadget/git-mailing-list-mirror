Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6261F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeFFTjA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:39:00 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:39527 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeFFTi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:57 -0400
Received: by mail-oi0-f49.google.com with SMTP id t22-v6so6375008oih.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fktilsZrV7aslno15qgBKIv9rCFXs8TgMbXRIjamcmU=;
        b=Ad2pa8IqPXOusTQK1wGPHJuxWVEjCWTLZBx64RdKxaa6gutkl5SvIin4wW3+UM8wk7
         aoal1EJdy12oIhSBf1dwc4r4lTHkm/2hCkx/rxvRAOF/t0JW5jJlriQJjkOdBctqd/jD
         nbJ/3IuevcK6LZT5ocFLwIn/nbVL2VjjE1RlXz+n4QBof8QuQP3OoNIMq92XNNlOpKvn
         nILe4QfQE+5bpF9l/VAGl5CJno7B1YEjWn6dYt0eWowyv1a6JSTcs6mFNnKHGqSicx1d
         K8lQY1RIq211MzVavg/r1iNeu+OhV5FL+uJG8IIF4B+SFeSHKXA3UTTsxqbDr8XiBjif
         YPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fktilsZrV7aslno15qgBKIv9rCFXs8TgMbXRIjamcmU=;
        b=N+IJ3nTHoERbk7lPH4md+27tqYWH8zR3U7R5txJTqR+yfyMt3lS8iDMkcozcZ1ph4h
         6I/UfRl7eVAhnziBIqXrfbglNlNXB0SJE00IR8PRJ1b9OpFwZpTtwBC2CYDJFWIwKD/9
         lXc/C1G7xjdr7Si89s9bU+/nQDpDba2hg4CLOmNclbrP7fq9dqCxFO5Q+xnIdIHfxdFg
         QwghLtLQ44Ll8TMNpddFsvn5WGKdI0sYifT7oMEK21LvpEDYbAnNZpb2aXyDlJaApKVu
         r5quG//GfYOpIirW83ppGG4sIJERud1kJXbu8phcBomu8uTp4RYW9mMdnXsiid6Fx2JA
         QwEg==
X-Gm-Message-State: APt69E1QUUJSFBBkcSP6di2bBjKf4XF7+wRk8+IrVYQj8A3JVCjNsAIY
        N9kWFGzq0C32Oy5hQKLOEDjxqJsriwGmucEtXDM=
X-Google-Smtp-Source: ADUXVKI4yJ9s1eRAjJdS2zTxTW8A+1S3Z0kWy4CWGPaCZiXgoWEjLYCQIJZk9fng5Oth/+BG3Jgu0q2rWuCGCXkmKOE=
X-Received: by 2002:aca:f594:: with SMTP id t142-v6mr2609292oih.56.1528313936619;
 Wed, 06 Jun 2018 12:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:38:26 -0700 (PDT)
In-Reply-To: <20180530004810.30076-4-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-4-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 21:38:26 +0200
Message-ID: <CACsJy8C=YNRmawuR3SZDMpmkKHMp=kPJsDjffCrcONe+CDpJ_g@mail.gmail.com>
Subject: Re: [PATCH 03/35] object: add repository argument to lookup_unknown_object
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:47 AM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/object.c b/object.c
> index 4de4fa58d59..def3c71cac2 100644
> --- a/object.c
> +++ b/object.c
> @@ -177,7 +177,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
>         }
>  }
>
> -struct object *lookup_unknown_object(const unsigned char *sha1)
> +struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)

I'm looking at your branch and this function (with the _the_repository
suffix) is still there. Did you forget to send a patch to convert this
function?

>  {
>         struct object *obj = lookup_object(the_repository, sha1);
>         if (!obj)
-- 
Duy
