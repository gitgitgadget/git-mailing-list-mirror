Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA0E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeHNAF1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:05:27 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45278 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:05:27 -0400
Received: by mail-lj1-f169.google.com with SMTP id w16-v6so13706698ljh.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PgNUaCqFh4jgxTPPJuEl1v3sV9GioSYIawH8wEOPeLw=;
        b=SFx49JtrXysgI85rpTNicuv2N7yvo4rbbX6tYb8U9XwZq5NqTujCqQvKlCasbjeotH
         FvfBTZo8pSiTP9NACAg7kkMtk0hsIqJ9tOMO483yYjTqj00mDxsNEMX2V/OATsMYr66t
         +52/a8Z+uTvYO9qREPK0yoab9HW2l0K44hRG9L+tJHkJS/4Pm97bVXB/OA7a+rodfb28
         kDJISp/WHjR91diftRBuUVXQ1ub8ySkoDRLLTYt+QBwXTOgvyKIwBpM8Mqjl+0gDpnoe
         xUyOx4dYR0dnhoAtYIv/VVcBunPuWyicdSpftySJiOCNlBj3pYoO+pHaCqyVWXJReVUJ
         /Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PgNUaCqFh4jgxTPPJuEl1v3sV9GioSYIawH8wEOPeLw=;
        b=bb8vbZhmwG+E7nfarEA2oRgXqFww1e/jRg/t2TCUGN9n0CtbErHaZjCQszq+x4Ra0n
         kXtmrh56OY2P1e/6ulISrorJe2qDe9EybnJRSM0yr6uHai5RZtk208oWfZtcrKpzHC3Q
         YtLffRs1BProq7hYoDRyLN6CgmtMJwhSiXI4GbOwYEno9e0F+vIGmv29CFyxDZLCXobc
         4s5TTEcQItHwc0V3il2RhSjo/ocrt04Bj96Gu5E6I/PKhHRn65Shb0YiukXqUFTlnOKn
         2gboMOguXMB4+jp7TqAuTLtn4b6r8y6e8c/5dMjvbv5I3ihVUT6JuHJ+csOK4pwUMmBS
         khEA==
X-Gm-Message-State: AOUpUlFWskshJvNENLA8GUrCiyEIEg2zuac25kD6Gaqz6FHRSptEPWGS
        RX9OY/cENV2e2aWsJjWks4lcJ2OjqcdPxeLSRwtyNA==
X-Google-Smtp-Source: AA+uWPwwuzYM0VXxn37xGTgR/GTjaBbxyA37FcJ4CH/BYmnfIEU8rG47NdbopV+DTT/Aj8KVqjNnLUOAmd1ZNnLXC1g=
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr14091361ljf.79.1534195286798;
 Mon, 13 Aug 2018 14:21:26 -0700 (PDT)
MIME-Version: 1.0
From:   Kaushal Modi <kaushal.modi@gmail.com>
Date:   Mon, 13 Aug 2018 17:20:50 -0400
Message-ID: <CAFyQvY2Sb+XOSRUC6biLKrKrfV_qZAfcSMC0hD8Z_0mYQk07cw@mail.gmail.com>
Subject: Unable to build Info pages using "make info"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have updated to the latest master and trying to build git plus its
Info manuals.

I am on RHEL 6.8. It does not have docbook2x-texi, but I was able to
install docbook2texi from https://sourceforge.net/p/docbook2x.

The whole git build goes fine except when it reaches the "make info"
step. I get these errors:

MAKEINFO git.info
user-manual.texi:15: warning: empty menu entry name in `* : idp4751360.'
user-manual.texi:141: warning: @unnumbered missing argument
user-manual.texi:3204: warning: @ref cross-reference name should not contain `:'
DB2TEXI gitman.texi
MAKEINFO gitman.info
novalidate not a possible customization in Texinfo::Parser::parser
gitman.texi:1610: @ref reference to nonexistent node `ATTRIBUTES'
gitman.texi:3165: @pxref reference to nonexistent node `CO1-1'
gitman.texi:3181: @pxref reference to nonexistent node `CO2-1'
gitman.texi:3186: @pxref reference to nonexistent node `CO2-2'
gitman.texi:5070: @pxref reference to nonexistent node `CO1-1'
gitman.texi:5075: @pxref reference to nonexistent node `CO1-2'
gitman.texi:5079: @pxref reference to nonexistent node `CO1-3'
gitman.texi:5129: @pxref reference to nonexistent node `CO2-1'
gitman.texi:5132: @pxref reference to nonexistent node `CO2-2'
gitman.texi:5135: @pxref reference to nonexistent node `CO2-3'
gitman.texi:5475: @pxref reference to nonexistent node `CO1-1'
gitman.texi:5481: @pxref reference to nonexistent node `CO1-2'
gitman.texi:5484: @pxref reference to nonexistent node `CO1-3'
gitman.texi:5489: @pxref reference to nonexistent node `CO1-4'
gitman.texi:7466: @ref reference to nonexistent node `EXAMPLES'
gitman.texi:7476: @ref reference to nonexistent node `FILES'
gitman.texi:7559: @ref reference to nonexistent node `FILES'
gitman.texi:7569: @ref reference to nonexistent node `FILES'
gitman.texi:7578: @ref reference to nonexistent node `FILES'
gitman.texi:7785: @ref reference to nonexistent node `FILES'
gitman.texi:12524: @ref reference to nonexistent node `FILES'
gitman.texi:12630: @pxref reference to nonexistent node `INPUT/OUTPUT FORMAT'
gitman.texi:12938: @pxref reference to nonexistent node `ISSUES'
gitman.texi:13353: @pxref reference to nonexistent node `DATABASE BACKEND'
gitman.texi:13488: @pxref reference to nonexistent node `configaccessmethod'
gitman.texi:19956: @pxref reference to nonexistent node `CO1-1'
gitman.texi:19959: @pxref reference to nonexistent node `CO1-2'
gitman.texi:19963: @pxref reference to nonexistent node `CO1-3'
gitman.texi:19978: @pxref reference to nonexistent node `CO2-1'
gitman.texi:19982: @pxref reference to nonexistent node `CO2-2'
gitman.texi:19987: @pxref reference to nonexistent node `CO2-3'
gitman.texi:20001: @pxref reference to nonexistent node `CO3-1'
gitman.texi:20004: @pxref reference to nonexistent node `CO3-2'
gitman.texi:20007: @pxref reference to nonexistent node `CO3-3'
gitman.texi:20022: @pxref reference to nonexistent node `CO4-1'
gitman.texi:20026: @pxref reference to nonexistent node `CO4-2'
gitman.texi:20030: @pxref reference to nonexistent node `CO4-3'
gitman.texi:20043: @pxref reference to nonexistent node `CO5-1'
gitman.texi:20047: @pxref reference to nonexistent node `CO5-2'
gitman.texi:22570: @pxref reference to nonexistent node `[CRTB]'
gitman.texi:22935: @pxref reference to nonexistent node `[CRTB]'
gitman.texi:23278: @ref reference to nonexistent node `Remap to ancestor'
gitman.texi:23394: @ref reference to nonexistent node `Remap to ancestor'
gitman.texi:27608: @pxref reference to nonexistent node `CO1-1'
gitman.texi:27611: @pxref reference to nonexistent node `CO1-2'
gitman.texi:27614: @pxref reference to nonexistent node `CO1-3'
gitman.texi:37177: @pxref reference to nonexistent node `[OPTIONS]'
gitman.texi:41101: @pxref reference to nonexistent node `CO1-1'
gitman.texi:41107: @pxref reference to nonexistent node `CO1-2'
gitman.texi:41110: @pxref reference to nonexistent node `CO1-3'
gitman.texi:41117: @pxref reference to nonexistent node `CO1-4'
gitman.texi:41133: @pxref reference to nonexistent node `CO2-1'
gitman.texi:41138: @pxref reference to nonexistent node `CO2-2'
gitman.texi:41141: @pxref reference to nonexistent node `CO2-3'
gitman.texi:41159: @pxref reference to nonexistent node `CO3-1'
gitman.texi:41165: @pxref reference to nonexistent node `CO3-2'

I have searched online in general and also in the archive of this
mailing list, but have't seen this issue before. So something in my
build process is not right.

Can someone point out a known issue on old RHEL 6.8 systems that can
cause this, and also the workaroud?

Here's my build script: https://ptpb.pw/Rcco/bash .

Thanks! And please CC me on all the replies.

Kaushal
