Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D251F45F
	for <e@80x24.org>; Wed,  8 May 2019 16:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEHQtl (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 12:49:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33241 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfEHQtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 12:49:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id q11so16801722ywb.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wefByTUjVN7PH6OJ0K+Js9tkCawHfoOy4Jo/hCXD4w=;
        b=Owo7WPyfZxzMiHV9eAUzDCXEjr/w6Fi8ndcKcsIkEXAwvEf9asO8BIIC+cbkcNXi5I
         Sg0jGz5Ksg14k+/VAzrONds3cQ/P6QApuQAKnu3FcVf4Trv8CLNvx3L9s6ZXfXjFFiXn
         ZKR7WbRkWTWoe9HPOIWL+dK0VZAaFEV8jK4PIEg9ss7QPShPF4wouFm2rWe0iBOq/Dq3
         AtKWFhIfaBuC6ohKNoe0RtpWw+usVtcA5bdGQ3K5oNo+gFgK4m4ie2CUnS77xKzT5hU4
         i3GrWODfsAdMSNkXOlfQAOKI7g1i1F+KpzY2nJtAM03PZgwk1huTlxYGM7eQ5Wzpo+cV
         2xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wefByTUjVN7PH6OJ0K+Js9tkCawHfoOy4Jo/hCXD4w=;
        b=CW0/SiC41Le4249uLSCE9474Xjc22guf87A2WiSHZV4LIU70OwIHfPG+UKfQOwXHn0
         UAZhA/hFk5MCByMBTaSGJyOnOTDAXIKDkbIj2Fq9fXpCckyFj2RM28yIuCmaoukZjq3W
         ekcSLmR/Vug3Y+Xv3HfRuG9XNJ0dJ0hm12g4RsI3CVidjr3JrE5xxTuwUu+fO7Orh/JW
         MhSYtvTRWOva6Q3uST9X0aVnTr57YFqWdgxlfR+znLaUHRUkH4k57uSZHseunM+hAfBD
         GWR6tYxf9RAtQrmL3qe3vkpEJDIXHTI1DrrIXJ5hgzycv/MR7WVcLhYq+p+vpfBT8Sbi
         9CgA==
X-Gm-Message-State: APjAAAV4vg+j4tzUmPATMLCRXdEJoUQHidPxqezhu4Jp3MMxltWclM52
        zTkb2EeRtwL2wGi3vsRNwi7wSzjVyAiwWIP0ecKHcw==
X-Google-Smtp-Source: APXvYqz73k3BNMwISiFW65Cyj+amCl3qpTYSGqPuIxKbaJBLV4bTtGyx8b8I1sgCT9bYtfI+XGewmenoK6tf18gvQ8c=
X-Received: by 2002:a81:2ac3:: with SMTP id q186mr26878419ywq.335.1557334179339;
 Wed, 08 May 2019 09:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190505081633.41157-1-liboxuan@connect.hku.hk>
 <xmqqy33iljo8.fsf@gitster-ct.c.googlers.com> <CALM0=-=5WeTJ2-r+u-8TYzOAih_3aCEESSpA4oKhxjRpK2yj6w@mail.gmail.com>
 <xmqqv9ylh4wl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9ylh4wl.fsf@gitster-ct.c.googlers.com>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Thu, 9 May 2019 00:49:03 +0800
Message-ID: <CALM0=-mDhCqfL0XpaH27cHxcfRq1Y2xJQ=GQLCVdACsOHj0hiA@mail.gmail.com>
Subject: Re: [PATCH v2] t4253-am-keep-cr-dos: avoid using pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Understood. Thanks for the clarification.

Best regards,
Boxuan Li

On Wed, May 8, 2019 at 1:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "LI, BO XUAN" <liboxuan@connect.hku.hk> writes:
>
> > Thanks for your review! I can understand your point, but I've got a
> > quick question:
> >
> > What if format-patch really breaks and 'am' magically does not break?
>
> Doesn't that indicate that you are not testing the result of "am"
> adequately?
>
> I am not saying it is *wrong* to split the pipe into two.  I am
> merely saying that it is borderline Meh, as the primary point of
> these two tests are to see how the command downstream of the pipe
> behaves and not the upstream one.
