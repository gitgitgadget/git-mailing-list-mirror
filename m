Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB351F597
	for <e@80x24.org>; Mon, 30 Jul 2018 13:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeG3OnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:43:20 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45819 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeG3OnT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:43:19 -0400
Received: by mail-ed1-f43.google.com with SMTP id s16-v6so4163371edq.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9QolUUyYdrN0DA0VDOGL73IlG0AsBGsLGRbztpdyGY=;
        b=E5Iym/tTPDAj/qs5pGJRei9W+Bhix9XB30NPsH15DYGPj6g4OmVbvw/REXqxX1uFIM
         yM1JTg4AJ/xqHH1ckoMxR6h9ffzh2GBhPbdSqsMUV1QkNJuaIf1t1UvRMKF1B8RFKx9N
         OS0lSqB389BIXMEOOFGsmywd33WayGapZOW2fSWcdgQOI81eZtDoFIkGDSCnrsCkQ93Y
         u41V9kWS3/v/fD10qkha5Ox/80eA6S8Bb9QP19w29ogimcLR4/xVAGVCNcUwKaksXy+Q
         Rj1Fv2VUP/ARgL4MShmGruwCZo/Tyn5/m9seEbWlIsS8HTNJdENh9R5ASIRWQXbnrYOg
         xidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9QolUUyYdrN0DA0VDOGL73IlG0AsBGsLGRbztpdyGY=;
        b=gv6jbyIRGk9f1eIka73U1+YEbjBymu2AbpmluJHFE9a5MPfgJKNjiAuvqDm3esJ6im
         SSmAh7miFcRMPBXOMuFtZD6P7vb75NOUYbRfSFpi0auUc+lCZyZqU2I3Nh7y4WDIH2N3
         vBCElWIdDh3lhB3v7i8iUxOzb+6fP6fiF4Q98tuQwkQ86azofpa9oh9qRjsfiBdaA6IN
         k8onAGkWCIwBJzHhUEQxGCFFpTLv8FwILXNJWSR3O4EdAWidljVCCyuWG1DrK34UvvrG
         RhlH9Wnu+HC+k25OT+w6kzUiQc3VBGoxtV7qPDrvgMJY6GPQpMv3hAvZz8M/WxQn/jpJ
         QV9g==
X-Gm-Message-State: AOUpUlERM7KsnFfrFWRAApHQxBfMvbWYkb+2vickgCtbf4N845sS55fy
        AOkI0jOTmpwH+N7sRzY9tYU=
X-Google-Smtp-Source: AAOMgpd0NBZE2N830FtajQ/j40j5GJopeA9VyFIC+ggUR+seyNrPrJlgkvDSNeDEA3IQYmUVOoMmAA==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr8249949edd.194.1532956102897;
        Mon, 30 Jul 2018 06:08:22 -0700 (PDT)
Received: from localhost.localdomain (x590d1455.dyn.telefonica.de. [89.13.20.85])
        by smtp.gmail.com with ESMTPSA id n46-v6sm2928977edd.6.2018.07.30.06.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 06:08:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Mika Vesalainen <Mika.Vesalainen@u-blox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Using Environment variable GIT_CONFIG does not work as expected
Date:   Mon, 30 Jul 2018 15:07:57 +0200
Message-Id: <20180730130757.22205-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <LNXP265MB0892616339D20CA9B10D6A31D42F0@LNXP265MB0892.GBRP265.PROD.OUTLOOK.COM>
References: <LNXP265MB0892616339D20CA9B10D6A31D42F0@LNXP265MB0892.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I have a shared linux account which is used by multiple developers.
> But I would like to have git commit history configured so that I can
> see who made a change to common repository (so that author of the
> commit would be correct person, not shared user). There are reasons
> why developers cannot clone this environment to their own accounts.
> 
> So I don't have ~/.gitconfig in place for the shared user, and when
> developer log in I enforce them to configure git for them first. They
> must "export GIT_CONFIG=my_specific_gitconfig".
> When this is done, "git config -l" will show correctly the user.name,
> user.email and other parameters which are set in
> "my_specific_gitconfig".
> 
> However, if user tries now to create a commit the git blames:
> *** Please tell me who you are.
> and so on...
> 
> But running "git config -l" shows that 'user.name' and 'user.email'
> are properly configured.
> Do I need to configure something more in order to get this GIT_CONFIG
> environment variable working. I'm working in Debian Linux environment.

I think it's working as intended, because GIT_CONFIG is only supposed
to affect 'git config' and is only documented in the git-config(1) man
page.  Perhaps the wording could be improved to be more explicit about
this.

Note that more general environment variables affecting more git
commands are documented in git(1), and GIT_CONFIG is not mentioned
there.

Try setting and exporting the environment variables GIT_AUTHOR_NAME,
GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and GIT_COMMITTER_EMAIL instead.

> 
> I have tested this with git versions: 2.1.4, 2.11.0 and
> 2.18.0.321.gffc6fa0
