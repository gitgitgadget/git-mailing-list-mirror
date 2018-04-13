Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2AF1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeDMRjG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:39:06 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:40887 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMRjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:39:05 -0400
Received: by mail-yb0-f169.google.com with SMTP id c10-v6so4720244ybn.7
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ctPbJ83LQ5yldd2VdmUf8OmpX+xdyRNk1pPM9xldKlA=;
        b=pKbqnxf9HqG0sWytbwMjXKmFO4s5fIt1n5XgK67Zs/bsSNLNNtP6weap7rVshvsVt6
         5p6bzzvC5G8NDH1pxJLwLFP2LvTH4bPz1yd9BFIye7JoJNew+VGqutsQl3grHNECOO6H
         Qlmt9M9W7NdI7ZBhuftBSI/TC9tF8NYBST2CqqxWhR7QShSx4sTeXtGyth9acALs8naa
         QcYxoY8M13XJPNK1dth/vrwkB3UA2c+pwWTbaB5d+GfpQ3OnQrIU1Dww6I9mvj+MT5ia
         noHB9+iC5RDfTe5KoPbybw4KT6uoRNmTkNwy3fcqUPMwGielZmTkEwqTxpJzOejfjI3J
         5krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ctPbJ83LQ5yldd2VdmUf8OmpX+xdyRNk1pPM9xldKlA=;
        b=MeaJeveSRuBvqI53MZAA07lCB2xXl7SK9vzTQElvIisEVDkB5W54Un64XW9BwuO+d8
         vSWVlkwYDHDDFRu+8YHmplUFJAtWoGSaGqFQI1vjFlPdu0IS0hbLQmBO/Kuzhjf5w+5+
         vpGOxLxxW1Sdfs9vk+b2g/sfbbGmUDCBg5+MjhxKULJ8jnE/3CWsw28mskEQeumuANm4
         lady40/r8+vz/SSiyQWiQeHutWAmmgqn5uK3xFxJb6BEmG7k8Yki3Jbd/L6dxgedaIO3
         q349b4HuoiKnSgdUwz5lLaN9RDM/IYJVilDVX9bHfA31R6yEiIuvnk4Pbqheugm+pxv1
         HzYA==
X-Gm-Message-State: ALQs6tBo8n2rfxohFOUweFtV/I+4OsLwWVrDjzl1GvE/xzNfExU5e+/u
        g+wYZ0WLWHHhTElyj3wP7NYsk+JlCTZ2An9Vuw/1xcltNW0=
X-Google-Smtp-Source: AIpwx48AQc56rMAODoE1JVYhL2CYT9KZ0bnPwMzI2QQ+IS1UXK4rpAY2hOyYL4IR3GHAKDl7k4y9n6SnMBoSbiuFOFA=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr5785018ybn.307.1523641144239;
 Fri, 13 Apr 2018 10:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 10:39:03
 -0700 (PDT)
In-Reply-To: <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com> <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 10:39:03 -0700
Message-ID: <CAGZ79kbs0heVvqMf2cjBtxtYs48CFFaM+9+YzB6gUwzWScvr=A@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

On Fri, Apr 13, 2018 at 10:14 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Comments? Because considering the problems this code has had, maybe
> "stupid" really is the right approach...

Would s/read/xread/ make sense in working_tree_matches ?
If read returns unexpectedly due to EINTR or EAGAIN,
this is no correctness issue, but you'd have to recompile the kernel.

Stefan
