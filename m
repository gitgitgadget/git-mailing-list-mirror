Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ABAC20248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCMSgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:36:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37956 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCMSgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:36:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id h58so2436720edb.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WONRkLIJ3342kPKEjBEhT/mD0eGNwa44ktSL8yENVhg=;
        b=Q/MA6EwzW2nKXBD5YC1pjraveNAkGyRkJhPs1PC7XUGEwDdtDEOrUoztyF1bDfI34v
         ZdhItKnfKKjhYkDG8+h4LOdjyXm76ByywTQS0uXwxzf6cfGxbXUUS2UntymKjoDG1rTm
         gPRIUQAEeP6zj9CwyiPRur9yiqD1STozEOANm2cm3VQw7rVdc9mvwORVRyjGsvJgaIRA
         xUiRqW5O6cJSgTmcoko2C327yd4vCKIDXMF1XqSe5L2pb6cpe58sCV5Y+iHgGXYWfvHY
         Gbdfxde2xl4YLEyxTMIDVNTJ6KUzV5bzNMcNGIS3NdlUeGyMiO5/BysonmXjF9MnCafj
         C6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WONRkLIJ3342kPKEjBEhT/mD0eGNwa44ktSL8yENVhg=;
        b=Za97sgOD7I1H5seehcShUcu3/v/f96Ir6IX27ibi4TYVQSl6sefcHVTgTMJaomkoU2
         6Xnc5er8pRmt3fIruWeRf7bz7g1Cy0giwmVFn2TepNiPBFnv2wCrZ4auzhIcDGjYS+zs
         u20sX7RbpY0XdC4Rr56XTNlTh1Y0QEmIWizkWg4xm1Xa9ZGJ0eAHj604igM3N5EtRsUd
         F+PtYE64KDqKYf+9weOr3h8g1EIWsXVHb5QVQVE2VLgfsX+k3zy6qQDiWQ64ADJ4J9f6
         Z3KGWEhfTeSg6NtVC7p1gDjS2T6FOIB6FOzClIDWPjGcmA3u7eq70sCqKREgm9cAdMij
         4jUQ==
X-Gm-Message-State: APjAAAWolC02y/1R66cT3jAybYZpKkGMdLnzsovuiX8lurCSMNmmlq8S
        opAbPdoohwY0wJHw+Q61EJU=
X-Google-Smtp-Source: APXvYqzQrtPSjnZPRqAyBTfCj7HpW3lRCSfIoL0RO8yrS2oDdBuZEIsgqWIte4gfThu08UjVZmZW/Q==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr769696ejx.143.1552502166947;
        Wed, 13 Mar 2019 11:36:06 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id w48sm789087eda.88.2019.03.13.11.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:36:06 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Wed, 13 Mar 2019 19:36:04 +0100
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
Message-ID: <20190313183604.GA27503@esm>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-18-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308095752.8574-18-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 04:57:48PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Similar to automatic detach, this behavior could be confusing because
> it can sometimes create a new branch without a user asking it to,
> especially when the user is still not aware about this feature.
> 
> In the future, perhaps we could have a config key to disable these
> safety nets and let 'switch' do automatic detach or dwim
> again. But that will be opt-in after the user knows what is what. For
> now give a short option if you want to use it often.

As I am late to the patch series (sorry!), has there been already any
discussion on that? In my experience, people get confused with detached
HEAD state quite often, whereas the automatic creation of a local branch
is no problem. So if it is deemed to be too confusing to dwim in this
case, could we add a hint suggesting the command? Something like:
"No suitable branch <foo> found, however there is a remote tracking
branch <origin/foo> that you can siwtch and create with `git switch
--guess foo`" (or maybe the one without guess)?

And while at it - what should happen, if:

- there is a tag named example
- no local branch example
- a branch at origin/example

... and we switch then? Right now it just gives "cannot find branch",
should there be more information? Should it even create a branch
example? With switch, switching a branch is unambiguous, even though
there is a tag with that name. If I really want to --guess - should I be
given more information?

Greetings,
Eckhard
