Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E531F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeHQSOB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:14:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38320 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQSOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:14:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id a4-v6so6128695lff.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bzMA0uMuAulQqAvMrmlcOFQtG3TNhNmXgtBu9jgszho=;
        b=dbUSoaRdr718QFuWItjtzoF84jSZM1T4YgmKf2ev0ZvQeOXeVEDy6FkBWn8B7JDPY8
         TJqEaYwczfr/cVB/W3vgylaBwkxfX7vNPK9vK5zVKySUl0g48t9VaAAqdxKjSocC19ck
         QhUKb/QEDWkRb9lo2kDnuYDWJ5VAYKHaROeodDsV3u8JqvOmznvra7XvZGvLSCJ5Xybf
         cXX/IBTx1nDXBjHtcglSJl0evrckpdVVPEH2wOnXP4PinLXjkQvuxy1hcn0Va6Xe6of1
         Ic/WekELaZa6wtXWpon+/Y9XF8s/vaXmbsEgKt9DTL4O4SjTf+/h0ESQr/lVL9l35Jod
         n5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bzMA0uMuAulQqAvMrmlcOFQtG3TNhNmXgtBu9jgszho=;
        b=NkMQYnTv4N+MuRLk75MWE5oVUZO43KRsRu4+exC3efv5RjwUJ/ifocBB9WFQfPKIJq
         XosHaAaao8A2GYRT4Lr45/ZiXFe5+5/te5AZ/83+bfQP+Cxqxp9ZT8kvf3Db2NzJO+6i
         4Hi+CPOcjFkvoNXKAz+64x73itudpoCDVgWaLyZgxBQozD68L/gTH4nt/muXYyK21ZSE
         3vApQ9ilImoeiVdJdx1TeBpngB2f6Ut0rhvBYI3Lm50c38kBbzUZJrTzZmy9Fjv6PFuu
         8VkOTueA6sge2til/A5ftIea1qLAmIC+Ui9wQ/ilT4pZJYL0BMiLotcHu/eUMOr3e673
         Up3Q==
X-Gm-Message-State: AOUpUlHmDMEXppWphRMXhLIoMbi9JCgIFstFuUT9KOHo+YGveS6U+8eI
        itCmOQPFErcnOdIE8PD6cgU=
X-Google-Smtp-Source: AA+uWPz0qBqMQYszdXhjsXANKbFLRaQ/ddBRPucgRPWwLL+ZMeUBNRgzW6w9mkONwHeEd2uJaNo93g==
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr22072347lfi.126.1534518615404;
        Fri, 17 Aug 2018 08:10:15 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r23-v6sm349158ljc.15.2018.08.17.08.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 08:10:14 -0700 (PDT)
Date:   Fri, 17 Aug 2018 17:10:12 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just
 FREE_AND_NULL(x)
Message-ID: <20180817151012.GA20262@duynguyen.home>
References: <1534498806.1262.8.camel@gentoo.org>
 <20180817130250.20354-1-avarab@gmail.com>
 <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 04:36:13PM +0200, Duy Nguyen wrote:
> On Fri, Aug 17, 2018 at 3:05 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >
> > Change the few conditional uses of FREE_AND_NULL(x) to be
> > unconditional. As noted in the standard[1] free(NULL) is perfectly
> > valid, so we might as well leave this check up to the C library.
> 
> I'm not trying to make you work more on this. But out of curiosity
> would coccinelle help catch this pattern? Szeder's recent work on
> running cocci automatically would help catch all future code like this
> if we could write an spatch.

Just fyi this seems to do the trick. Although I'm nowhere good at
coccinelle to say if we should include this (or something like it)

-- 8< --
diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df9..f8e018d104 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -16,3 +16,9 @@ expression E;
 - free(E);
 + FREE_AND_NULL(E);
 - E = NULL;
+
+@@
+expression E;
+@@
+- if (E) { FREE_AND_NULL(E); }
++ FREE_AND_NULL(E);
-- 8< --

--
Duy
