Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36BF1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 04:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfF0Ey2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 00:54:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36102 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Ey2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 00:54:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so848270wrs.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 21:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL60yh+4N4iKnxgJDXiatTO9usSj7ulTugdzGkQCFDg=;
        b=pe01IYRkVgQRSHldyfbD7tG1hH6HBEByH3q/P8bRkoS86TApR8KYy38KE6tsgaRprz
         KuHCg/OjGMN1I2E3Jjs1FGK4sKVxa62Jqi0jt1zsgJLrzaEVrhsFSpLg2nAN0LVAU2gl
         wbdp7jhEuM55YUjFX/EVoYLIzrDHMk+xdKMI+zTRbZKr9UkRBHJk4kW5a4Fw+UNEEEvi
         tirsbsTFHkSZuCEtvmBzhvBVznwiM63pIBqHoi//s6tgIUi6q1PH0pBvKRE3w3eN/XFE
         RnUFtRnYgWPEgXZkrByybsyuA7llxJTQeAIRRrC4thqeRSDTPhKyd3CgIho7Mk+FZi/Y
         Bfrg==
X-Gm-Message-State: APjAAAVikasPrUqDjrigWCLQNB1wQuRBX5IsDHRqggq9/ClIyaZ9q31Z
        AiemRHIAV56/eXcCxZUlhNdLWN2SK22yE7W2e6I=
X-Google-Smtp-Source: APXvYqzO016ub6gmcPobOF2MoggC9ICTra9DvLGbznUnibCyQnLZDw4G93eECgBvxLSgjbT4oJTs6+vQNXdRcvaH3aw=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr1197066wrw.231.1561611266205;
 Wed, 26 Jun 2019 21:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-5-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-5-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 00:54:15 -0400
Message-ID: <CAPig+cT4=qMers5QTGCCPJx9=ej6rPUHjA94SqChxXBdJDTdmg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/13] walken: add handler to git_config
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> For now, we have no configuration options we want to set up for
> ourselves, but in the future we may need to. At the very least, we
> should invoke git_default_config() for each config option; we will do so
> inside of a skeleton config callback so that we know where to add
> configuration handling later on when we need it.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -24,11 +25,36 @@ const char * const walken_usage[] = {
>  static void init_walken_defaults(void)
>  {
>         /*
> -        * We don't actually need the same components `git log` does; leave this
> -        * empty for now.
> +        * We don't use any other components or have settings to initialize, so
> +        * leave this empty.
>          */
>  }

Meh, I don't think this change has anything to do with this patch. If
the rewritten text is the one you prefer, then just introduce it like
that in patch 3/13 where the function itself was introduced.
