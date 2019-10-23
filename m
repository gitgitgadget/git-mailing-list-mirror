Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E29F1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 08:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfJWIzK (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 04:55:10 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46233 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfJWIzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 04:55:10 -0400
Received: by mail-pl1-f171.google.com with SMTP id q21so1687101plr.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lAmmrptvnDAfSXggk84tJ0DOHH/cXrpDcDXJhpiJIwY=;
        b=o+/Y09v68NrlJMiOdqpqpKAv6k5aXprKmC3rY0nNqBJYz59maJb9Xe1SV5XwSCMifr
         NhsmF9yiEgm1JkONDqyBHVjlaMNpJP3kyCvLetI2xE+NKRG3nQKAaQWVEI1BD3vYl0G8
         O0oqx4u5l44APnkFGKKYTIdrm+WAvTT2uBpznx8iI9Gyp0OevftI4jpBn2PFEBmkJMlu
         5BrjWpOBrZodOFE7JwlZglhuruL6ZD5OA1uZNNopy8RDztxdwUHTdzxfTdFO+13tcLcD
         gMbm35qQDqQkbLAus4Zsah/iztPWHe2ZW3dkkSYoEr+K7AGnKSdOTZ8bvMqmVOKri6rL
         u3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lAmmrptvnDAfSXggk84tJ0DOHH/cXrpDcDXJhpiJIwY=;
        b=dASHZ+XYMfhV+7cd02MBN3bTVnb5qRjJZ36qYnbvEWC/UDZP4lptJGHmWPpLeNob5M
         dozU8WdlhcTHAtwqJIeYLlhYunqE+Y7Vh33Wv7WdC8BA3Z9esjp6a0hxiHfJk6RSIJ+i
         IzAslzQfIs93NItS5Wt15jnwRHEiog8x6hiwOjlM5c7+yQcTElsVdvnyOgoeS76JApfG
         riLKAZ+DLd96/N99GyBc5W1ib6AH7//rhWwOnIabAyNcNmrdoPlvpBGKpXZ+YrPqLQsJ
         Ok5q0cOEnJXI8GCZbe0c9L3kZ20Sq+L0WCq2djKHqZkHqqoqmDQosVJwbrLWP9a4wUYu
         AAsw==
X-Gm-Message-State: APjAAAXaISxoSE8sRnCBW4H3Aqc6wJB9SAuy2kexkq2VYZnoa/WJaZxl
        gBM6rUbuazstNPOjF1/LBPA=
X-Google-Smtp-Source: APXvYqzo/ggsBPhS6llQRp63ERFU9cW+rRfDnMZxeEE+T53saI8twShhIYoMXScRVeajCrhcS5U8Tg==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr8508619plr.9.1571820909073;
        Wed, 23 Oct 2019 01:55:09 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id x23sm22428394pfq.140.2019.10.23.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:55:06 -0700 (PDT)
Date:   Wed, 23 Oct 2019 01:55:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
Message-ID: <20191023085503.GA652469@generichostname>
References: <2154192.LVDMpRDY2h@pc-42>
 <xmqqzhhsi4g5.fsf@gitster-ct.c.googlers.com>
 <1791353.RaUiIlXgNR@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1791353.RaUiIlXgNR@pc-42>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jerome,

On Wed, Oct 23, 2019 at 08:49:41AM +0000, Jerome Pouiller wrote:
> On Wednesday 23 October 2019 04:24:58 CEST Junio C Hamano wrote:
> > Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
> > > I try to use "git am" to apply a patch sent using "git send-email". This
> > > patch does not apply properly. I try to use "git am --show-current-patch"
> > > to understand the problem. However, since original mail is encoded in quoted-
> > > printable, data returned by --show-current-patch is not a valid patch.
> > 
> > I agree that --show-current-patch is a misdesigned feature.  We'd be
> > doing a better service to our users if we documented that the patch
> > and log message are found at .git/rebase-apply/{patch,msg} instead
> > of trying to hide the path.
> > 
> > Unfortunately, it is likely that those who added that feature have
> > built their tooling around it to depend on its output being the full
> > e-mail message "am" was fed (and split by "git mailsplit").  So I do
> > not think we will be changing the output to the patch file only.
> > 
> > But even then, the documentation can be fixed without any backward
> > compatibility issues.  Perhaps like this?
> > 
> >  Documentation/git-am.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> > index 6f6c34b0f4..f63b70325c 100644
> > --- a/Documentation/git-am.txt
> > +++ b/Documentation/git-am.txt
> > @@ -172,7 +172,7 @@ default.   You can use `--no-utf8` to override this.
> >         untouched.
> > 
> >  --show-current-patch::
> > -       Show the patch being applied when "git am" is stopped because
> > +       Show the entire e-mail message "git am" has stopped at, because
> >         of conflicts.
> 
> I agree with you: I think that manpage and/or output of "git am" should
> mention ".git/rebase-apply/patch" (that is exactly what I was looking
> for).

I am currently have a WIP patchset that will print the location of the
failed patch file (.git/rebase-apply/patch) in the case of a failure as
well as the line number. Will this be sufficient for your purposes?

Thanks,

Denton

> 
> Maybe documentation of --show-current-patch should be clarified with a
> note like "This option is mainly for internal purpose. If you want to
> get current patch, rely on .git/rebase-apply/patch".
> 
> 
> -- 
> Jérôme Pouiller
> 
