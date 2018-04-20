Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083821F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDTRWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:22:52 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36920 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeDTRWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:22:51 -0400
Received: by mail-ua0-f174.google.com with SMTP id d3so6181555uae.4
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/wfLt8Lbu/eKaOaZBNbgM3pcSRYF8t3tabAjVviwXkE=;
        b=EXcb6e93BluxrvxTUxAnKdEh+axEVYHG9Elz6tq/tGYtX+WobnLSIDl+nqdrAF8d9r
         tmpeGZaBvoTeiBc2uOUHjM8x76X4c3XMxet3U/++9m93kXHRqtFTYW7Vntf2SiiX9Wej
         Ua/vRNPBgFzGW2wkmO1Wjrd9DPfbN0ww6WuI5neo0JNeIOHp4TdpylYwGQfkl+qOVy3d
         NUtQk9Or/lE1xOnIzvV282tI5AyTJ75oHo1Yn2FfMawHcd1z7Jpser036gnlrNhQA8xe
         zdFrsPHi3rv82E3ikyZfvRZAjOnDzkUaE6uGMBhsKt1m+xGnikm/AJCA7M1L3iEsxX08
         B1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/wfLt8Lbu/eKaOaZBNbgM3pcSRYF8t3tabAjVviwXkE=;
        b=J2Tt9ayrEs159H6BJhEswwMlh1wTQSsllZMejEHj1df3AynCiFfvzPNlVOaoyBAE0M
         Wv9AxHzntAMibgCsLobxJRFMSSSKA1/MZmcwtbrciWqWomxVIvyhwVHBwMkFCKiZluw4
         XRJH4ITAND4h1O4uyXau3/jxFu2O0dEmqk97QUj/leNf+Y8ySJiskTm1DM4CPx/ZRCCY
         Qer25K+LIngPnJC5DrQiHcylKMXheqE9nx0DYXab4IoV8Mhp3g1AkbxStu0u5ndBn+Mu
         P9/frC7MSLih8k53Z8zxupErdkqkMPl/e5E7VngTXQ0cJiDUzv74mxEIHxmZnaQkm+U6
         6Ukg==
X-Gm-Message-State: ALQs6tC8O6IVl6B5o6oD/o4zjNTWq2WtifxrZpSb38MptzH8/S5+ZPr4
        m5vqnfzOJ7IbrCs1/DyN2EF7Dd0Uu87KzzsaaTo=
X-Google-Smtp-Source: AIpwx4+nCNq8ez3TYIrjqeuxCREB2895tSCmoj3gtIM+uuNparSXqB9YuOQt6AMO9AwQLTmsAu9CRTttWsdS3YqriYw=
X-Received: by 10.159.56.15 with SMTP id p15mr5156764uad.112.1524244970322;
 Fri, 20 Apr 2018 10:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 10:22:49 -0700 (PDT)
In-Reply-To: <20180420133632.17580-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180420133632.17580-3-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 10:22:49 -0700
Message-ID: <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] merge: Add merge.aggressive config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Add the ability to control the aggressive flag passed to read-tree via a config setting.

This feels like a workaround to the performance problems with index
updates in merge-recursive.c.  That said, it makes sense to me to do
this when rename detection is turned off.  In fact, I think you'd
automatically want to set aggressive to true whenever rename detection
is turned off (whether by your merge.renames option or the
-Xno-renames flag).

I can't think of any reason this setting would be useful separate from
turning rename detection off, and it'd actively harm rename detection
performance improvements I have in the pipeline.  I'd really prefer to
not add this option, and instead combine the setting of aggressive
with the other flag.  Do you have an independent reason for wanting
this?

Thanks,
Elijah
