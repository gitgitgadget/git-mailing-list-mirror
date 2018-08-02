Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9353F1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbeHBT3l (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:29:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56207 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbeHBT3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:29:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so3437236wmc.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BpoNnlD80gcmZUt7pkIBbeMk8gyK0MVLj8hfrLVdal8=;
        b=XTUMt4k2o2RscxknXh+CdCdiWzo6rpmeMLLggXL9F9t/tTSs11y5eUsRIcV7KnDByi
         0voiEMnpc1/OBTcVWjX4cMJAIqYZaB25OhKpr8BRe08FMxnNKEZhcNjIAS0xSLbGdI+T
         Iri/WVtJpg/B6xrsYyb/6oSMoLlIY4Tnog2umhKxI5Chum1KMRe8IvRYxbwyehaB7al/
         WgSc4Gl1ET+FdPvW1ld7e8Oq0952FUirdDZtizd0lTXreOLvjl7t6tDr1u78bo6s9x8u
         Z+z5+KFXL7cTvNxBRmnKYU5AJ0mkNBIuD61S0lqlrdcY0eNAsNSnNX6te0laEO0zhx/p
         wZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BpoNnlD80gcmZUt7pkIBbeMk8gyK0MVLj8hfrLVdal8=;
        b=YwYH2tiaW4MV4hRRyw+df9Ieo7WwTnQY1duGuoG4V3Vz8Gg4yIrhWTSmQsLHoqLGei
         ZfmeZcaia3bpP0zr2coFt02hjXVC2cm5Om4GufT2RAWd47g1wrYTT1T4Mh3ww0Rwk6qv
         iWx2QrBRTFvYW3K4Y2l2H3/MuU4MF3MV01aIFZahOTU/uw1GNoK+t3yBfo4i1nEOtgzz
         mZLTcP6FsXxqN7/Lsbtty3q+UZsrgA0QTmiVU/Jo34nWEIudnCxp2dbOieVGIsJ3qSXs
         vv8CvyrOs3WkAlZUUKI4x1TegcXlg/QR7F90sAomquNpASyYrFvVh2KzJLtYsVROeYlg
         NrSg==
X-Gm-Message-State: AOUpUlEpkAy+KC1+CpToVKov0TTzEs7CoGLnUswnTnXuEr4m0Ul0XtaX
        7DL/VJDOZJSImM1/fbbqBXs=
X-Google-Smtp-Source: AAOMgpd/OYCzejcg3OkhijTXQOQujHGjU5ISfB2DvnZ/EfshfRPUX20WJIsOxj93+YsNLOm47/78Hg==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr2456999wmg.155.1533231451914;
        Thu, 02 Aug 2018 10:37:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm5549895wmd.7.2018.08.02.10.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 10:37:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] config: document git config getter return value.
References: <20180802114753.9715-1-hanwen@google.com>
        <20180802114753.9715-2-hanwen@google.com>
Date:   Thu, 02 Aug 2018 10:37:30 -0700
In-Reply-To: <20180802114753.9715-2-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Thu, 2 Aug 2018 13:47:52 +0200")
Message-ID: <xmqqbmak3c11.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> ---
>  config.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Should I forge your sign-off on this patch?

>
> diff --git a/config.h b/config.h
> index b95bb7649..41700f40b 100644
> --- a/config.h
> +++ b/config.h
> @@ -178,10 +178,16 @@ struct config_set {
>  };
>  
>  extern void git_configset_init(struct config_set *cs);
> -extern int git_configset_add_file(struct config_set *cs, const char *filename);
> -extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
> +
>  extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
>  extern void git_configset_clear(struct config_set *cs);
> +
> +/*
> + * These functions return 1 if not found, and 0 if found, leaving the found
> + * value in the 'dest' pointer.
> + */
> +extern int git_configset_add_file(struct config_set *cs, const char *filename);
> +extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
>  extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
