Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABEF31F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCZWCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:02:30 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44697 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeCZWC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:02:29 -0400
Received: by mail-wr0-f174.google.com with SMTP id u46so20387967wrc.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0orWDGgOaTykQCea9Xa5VlH1aA7tju+01mzKixfqr48=;
        b=OF00tWxOLGIXvEuSCP8OjTi5a6UVGrItNIq0YV1a7pHXGap5t31SCrdDDT6DJe2G9b
         ywvea8jfVdTRTOmjyPXp2DxLPGcabPhx6sPudon/fKMrvmeeJxawcPdNrraB32gNTJQP
         vv/Q+UjxIRWvL7muAz3PcxjxYbuwpfY+j+TFLeZ45dqXVJnD/C/Z93IxzvWfWopcqTI9
         YgDA9TLxjCzEWpnvNf8LdCP2CtfckxbSZNr92M3zhIt5anwNHsncVGlroja1341i8sr7
         7RIMo19u16hNmPyspdJMQYfpCzVXDi/QtedAfkl4Q81wxtjxYeWC90YNe/BA3VP57Zzd
         92TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0orWDGgOaTykQCea9Xa5VlH1aA7tju+01mzKixfqr48=;
        b=ihbvA/b0TChf8xplNE70f6VTBzmvoD4UnDMu/+jDw0D85zz833iyt0WFC5Esuw4EFB
         2eE1GcUTx4ysiUM1XeI4FoK36hUB+7XwYlN/62t+WW5N+FYVV25xMyIj2astVXqU/oXj
         C+Ji7yXM31pYPv9IlT67vZlRuovlhTyeiv5y48GCcxnirMt1TgbffhHf0BhQivRTUWSj
         Z/zPF/2GiePCKXSaOdii+Ml7Fq4f4+55Hgu86+ZAP0yte4o7P7XijZL7h/5D5HRhs8hW
         TbskIhqZT69fxI1n+fS7UmxOP8LiAxBJZCReCxNj3jYSgT2fzlzeovr4ilRbEmo7TdoP
         0KYg==
X-Gm-Message-State: AElRT7FyBo9jUxRNznBL3/YW76gGCDxGleTuagHkAbN9dNu6OjYu0KKD
        plL0OLmGO7G0LfDNTV9+9PQ=
X-Google-Smtp-Source: AG47ELvZ+IFJ1EEKEYcQ02m1P8sGhk9t9ltDLu2J/Wg/miR1OJOMLbJ9qcD7weMhWacB8NGXIAajeA==
X-Received: by 10.223.179.195 with SMTP id x3mr28055185wrd.94.1522101747976;
        Mon, 26 Mar 2018 15:02:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l41sm33761701wrl.2.2018.03.26.15.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:02:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        larsxschneider@gmail.com
Subject: Re: [PATCH v2] Makefile: detect compiler and enable more warnings in DEVELOPER=1
References: <20180318081834.16081-1-pclouds@gmail.com>
        <20180324125348.6614-1-pclouds@gmail.com>
Date:   Mon, 26 Mar 2018 15:02:26 -0700
In-Reply-To: <20180324125348.6614-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 24 Mar 2018 13:53:48 +0100")
Message-ID: <xmqqlgeebiml.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The set of extra warnings we enable when DEVELOPER has to be
> conservative because we can't assume any compiler version the
> developer may use. Detect the compiler version so we know when it's
> safe to enable -Wextra and maybe more.

This is a good idea in general, but we are not quite ready without
some fixups.  

Here is a quick summary (not exhaustive) from my trial merge to 'pu'
(which will be reverted before today's integration is pushed out).

 - json-writer.c triggers -Werror=old-style-decl

 - t/helper/test-json-writer.c triggers Werror=missing-prototypes
   quite a few times.

 - connect.c -Werror=implicit-fallthough around die_initial_contact().

