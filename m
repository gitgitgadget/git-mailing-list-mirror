Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5361F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 23:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390585AbeKVKMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 05:12:48 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:35949 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbeKVKMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 05:12:48 -0500
Received: by mail-it1-f181.google.com with SMTP id c9so11424507itj.1
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLyC/j/fb5ur+vsxSJaTEc9b8Y+F1EefzKdiimlESc4=;
        b=bIRVi8pc4IBugM+WnnJXD8IriGX5plLbFg5MIRa8WVacUK41qAnxKkA8aSGaTd4zWq
         XXnID0n1EMX56TybwL9tNqYBWdazQciUiMaiHIk4xuL9wOzMopaiCwbh5K+063JxeCQV
         gQo2OK+OW9ADy8+45EJF6eiSCdmS7tIhEqJL5yFK0FVrhAP4zjcHnHAr0Z8rEI7rQfVK
         RwrBTYW7Ekx74z3GEo0fOywpc3hfX5tN7sbm+ptXiOBMGvxlmasvxspjqAq2V/EOHCQR
         +lr5zgCPiy4cRp//PGQj+TV+5k5TbIyYsr/s+zXfad7R6K+betNN6XV2G+5DpvuNNPO3
         ALew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLyC/j/fb5ur+vsxSJaTEc9b8Y+F1EefzKdiimlESc4=;
        b=BvM3H53IGr16wFA4MThtLm5qV13Ht0YO/of8NdILUwyLJxa/39KLvW9jUTUZQ/+W4h
         hABLA5XTkyChKYwI2HHQfGOg8HnEmkOhVLuVZq8S+vxFQM4KytjmrJnHTK8Kg3iUbS8O
         6/4rbmpfYzk7uln3dAUY7Sd3Cy7eX0vzqZFruJ0caUBeMwdx8Rl5IETbr7MTUgQQ68PN
         KxuBKZa3AeqMIdmLHeN7++YVoYaSrOxNQM0yGJRM1zlLNsP8WH2S39Nei70uCchVxllj
         S3Uj7MaeOqa6olilOBEVabkuJ25Ov5pp+j/DfSH7bdMaA9fCuhNZfUhstzTBgtv6ew8l
         tU5w==
X-Gm-Message-State: AA+aEWa6AcBozeWMqaNLDCfrU5BXGDgso8tNVaFczgWVRwB+4F7e8Bv2
        W5QGeeMvR0LB/RPSG/FXc8MPbsthvK8Jc1soLSQIBA==
X-Google-Smtp-Source: AFSGD/WjM00ZsL0ukIcg8HRV37PbT841x/jtgbWuxuArFMPOVgO+9aeWcwd0ojegKZW4sDz5XO1pS5e9cX0fFS/PDh4=
X-Received: by 2002:a24:19d5:: with SMTP id b204mr6190164itb.6.1542843374752;
 Wed, 21 Nov 2018 15:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net> <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
In-Reply-To: <20181121224929.GD5348@jessie.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 21 Nov 2018 15:36:03 -0800
Message-ID: <CAPUEspjpHJ01M9UM5w7P6n3g_Yi+WF4wYGUG-iG936g4vfuhJQ@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     max@max630.net
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 2:49 PM Max Kirillov <max@max630.net> wrote:
>
> Should I install bash for it to work? I cannot say I understand what the message is about.

yes, you need to install bash and use SHELL_PATH=/usr/pkg/bin/bash;
PERL_PATH=/usr/pkg/bin/perl for the perl script

Carlo
