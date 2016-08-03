Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E12B1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473AbcHCUvd (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:51:33 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35747 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389AbcHCUvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:51:31 -0400
Received: by mail-yw0-f182.google.com with SMTP id j12so238588641ywb.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:51:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hpRVftWYYcBPpzkE0PkGf7IzxDdRoPdP5xhDpTalKTU=;
        b=dplDoWxBOqOMYG52p8hPd6SWtkrDMhf7Wqj5r5Mec+poJqP2Bz+/u1+Uehyx1i1t7T
         a9nT7WAUZsf3YoYrJWmvlWpXKYmXtFP/zezpmWG0dAsk6J7/WNIK/yjPn4zjN3DpxMnh
         vvzgiRhDgsBdqE93DMNJ8KF6jIJ+ja1gd43zbwo0+xvtZAD+bHZIaGyXrFh/cXlSJpD8
         C9v3xLvVKkfF0i0Q2SAaLgNaC8y4Ky02UpH9PnfZI/aHZB8iu3Ec6+87bQvuRdVcbPDU
         gqKBqlVw/HcH5z7pVa29obgReu5JQOIUGrFnS+hv9MFSouQQYrL/1yMzdGR8OwVzOWL6
         10WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hpRVftWYYcBPpzkE0PkGf7IzxDdRoPdP5xhDpTalKTU=;
        b=X5w6jSGLN8QehaX9aLEmO9nn/V0jlqyw4kBg+JV20LsAS0dRGOaca1fFTccg9N4Nln
         yzCpU/lVOPkoPNm96FvAhmL6LmzYYX7lgtzWLDN6G3mKRTpnYA1YxTiY7eVhRuZu3eXO
         jakvffdoCe49LUUV3xpWmaR0nWJiKP3igRrzNUU1h5Q9Vxw3xQLiGzroBkG5OVnHNYXd
         1QTXXz7GOFq0Krjo9rVzfkNLy3uYihu6y+HgQF4TXzn4ddSHH3WyLMQrNwxpIz9dQPiH
         3XWEOXIHrvZ+5/oYmEb8+DIU9x9RYIJeYCiN/csO+PYiclspVEe+Z+d5l+WJk3EF9CsT
         jeig==
X-Gm-Message-State: AEkoousn7/c+tepvO6tev1JOkS0TscnKM0JKDLPqjm/pzSs8VYtg8vmqXXrKxsAQzRVKJ23kyFy3vRyZcElLKA==
X-Received: by 10.13.212.139 with SMTP id w133mr56187424ywd.49.1470257469143;
 Wed, 03 Aug 2016 13:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:51:08 -0700 (PDT)
In-Reply-To: <xmqqmvkudiju.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423cf7-078bef36-54e8-4200-9097-17d95d4f3c40-000000@eu-west-1.amazonses.com>
 <xmqqmvkudiju.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 02:21:08 +0530
Message-ID: <CAFZEwPNeSV6b-MM7eabjAqBYWvYoJDhGYPrqzL9sy84+GxA6hA@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 09/13] bisect--helper: `bisect_write` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Reimplement the `bisect_write` shell function in C and add a
>> `bisect-write` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh
>
> Up to around this step we've seen these patches well enough and I
> think with another reroll or two, they are in good enough shape to
> be split out and frozen for 'next'.  We may not be there quite yet,
> but I think we are getting pretty close.

Thanks for taking out your time to review this series. I will follow
up with the patches in a day or so. I think the first 11, many things
wouldn't change (except for your reviews). Most of the changes would
happen in 12 and 13 and more specifically the argument handling.

Regards,
Pranit Bauva
