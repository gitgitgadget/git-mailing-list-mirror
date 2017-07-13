Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF368202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 06:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbdGMGAY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:00:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34813 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdGMGAX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:00:23 -0400
Received: by mail-qk0-f195.google.com with SMTP id q66so6922472qki.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPEKUpBvCiEZfXdcAM97QNlW0Ol3u/tZ+FHcgw498w8=;
        b=eUoXSLfuguidIMCjaqUQMghpY9Jux0dKJHn/nxuQ1g2r15pqoXGG4fWPXnuqyWWMen
         psutvHs34qFQ3oLSm1EdmoSCBYuVaZvlsxF0EU9F9yH1OluIvEzBOWhO+Q9ydbc6ttFg
         jEucPPgaToRz4FscKIPIK3jahUqo54Pcn5ick/vXFkIHrjHvnB120Q89u3xM2ZwKSyT7
         BsrXcmd5pMypiaLfFUE7r+q1oK8cbvVhxG5SBK4q+8rWH2ST/D4lz4MF5WLsV7NfJnjh
         UPwFxPQvhE1MTsCWvfu89xvYEw0k5Xo8urOfq9ChsYbPujYUWU9Ax3NoQqm0mZLWIj6U
         9KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPEKUpBvCiEZfXdcAM97QNlW0Ol3u/tZ+FHcgw498w8=;
        b=PSBATVujV7m9a+Z2TK99sjZkkwVpdJzkqlUSR61MbRlRh5cFRDRHgYdaA3zpeGx1Zf
         Q6Fk4H8ZH29NeLvK17anU1uV6Pu5FlBGNEI1R53cYLt+57P0hTTNTANmDHhTDjDQV6NW
         qdGUIcEcv66KFJ+OEooa2guWLDGEV5ZDIyGoUPg49OtqgyBWiQljQiU6wZ0jAwoPwnFa
         0hf7rhcP/B/BcT/2oHK1zcfPbrNFXnAWvVxSgSJtpOaZ+nm6q5lPCxHAyA2n7lMxNzx8
         OMhNJBI0qOE+nctz/JT3Hq+/N4qXkMzJR3f1TU9hoVs/VrBnttt5+T/C+FioLBWp9Sn/
         OTfg==
X-Gm-Message-State: AIVw112f1QwAdAYnDMORVa8Y5Nimq5ENSvlh3iEKTaUmlaW/6KcAMWq9
        awdkl/ERhinTXP/Vuc0xlViZMztXBg==
X-Received: by 10.55.203.17 with SMTP id d17mr2579205qkj.147.1499925622619;
 Wed, 12 Jul 2017 23:00:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 12 Jul 2017 23:00:22 -0700 (PDT)
In-Reply-To: <20170712222116.7095-3-bonzini@gnu.org>
References: <20170712222116.7095-1-bonzini@gnu.org> <20170712222116.7095-3-bonzini@gnu.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Jul 2017 08:00:22 +0200
Message-ID: <CAP8UFD0LEHDutF83=V9zrDnFKy27dJSrq5DHV-8YV1=y=cPXqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] trailers: export action enums and corresponding
 lookup functions
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:21 AM, Paolo Bonzini <bonzini@gnu.org> wrote:

> diff --git a/trailer.h b/trailer.h
> index e90ba1270..f306bf059 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -1,11 +1,33 @@
>  #ifndef TRAILER_H
>  #define TRAILER_H
>
> +enum action_where {
> +       WHERE_END,
> +       WHERE_AFTER,
> +       WHERE_BEFORE,
> +       WHERE_START
> +};
> +enum action_if_exists {
> +       EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
> +       EXISTS_ADD_IF_DIFFERENT,
> +       EXISTS_ADD,
> +       EXISTS_REPLACE,
> +       EXISTS_DO_NOTHING
> +};
> +enum action_if_missing {
> +       MISSING_ADD,
> +       MISSING_DO_NOTHING
> +};

As these enums are now in trailer.h, maybe more specific names like
"trailer_action_where" instead of "action_where" would be better.

>  struct trailer_opts {
>         int in_place;
>         int trim_empty;
>  };
>
> +int set_where(enum action_where *item, const char *value);
> +int set_if_exists(enum action_if_exists *item, const char *value);
> +int set_if_missing(enum action_if_missing *item, const char *value);

"trailer_" should perhaps be added at the beginning of the names of
the above functions too.
