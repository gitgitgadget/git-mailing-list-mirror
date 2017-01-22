Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3EA2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 23:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750750AbdAVXEs (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 18:04:48 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35783 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdAVXEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 18:04:47 -0500
Received: by mail-qt0-f176.google.com with SMTP id x49so95219366qtc.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wlz+WLvY4NSIbblAQhQQ7dk2XC3nwKROSb5JWo86C84=;
        b=VnzPpApqjLkwpw/PI7x3ZCMWBHgTEoz7M+4FogoAnAau8KsqKgKama2odzLwIvkXMO
         XXBNRGCaMJ8OD4dKvJXVC4hjVGhwdidLkLUomqSHUI3yjnOBOXuMLWetJXDpnpGr3Xux
         K8dQoRGJ6UcMwm0A7Kmf1WBY27/5KI5eIfpVjHeS+gJhEqbu8+q43R/tiG93DC4qQR8w
         8a13pcj73PbnMfsnxJDKTLYkRndffHV66/wC07efCEt1GodsU86pX28faPB4SLQuHTXq
         yxZUSi0G4u5MnPOVU2X3gXRxHCHKaC2QyjsfPV9btlsHGJ7Zs6vnBzaTXXTv0x0W988n
         0SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wlz+WLvY4NSIbblAQhQQ7dk2XC3nwKROSb5JWo86C84=;
        b=T2ndhJ2u4jCAwDlrZaGlIqMSBOfQC9tsEvsceFrtnxQzUekQG59C/k+X39kMA7jP/g
         g6XSH6Lo0RkwlCik5M3yOZzuKAO1Z/nTD2D2SaNqFosh+WGhTJV93k220wazCpLi23Qm
         fZoxJFOBK43DRnabTUDtbfrQN63s46LXd+ty5q9ACd/auJwhEY0REYfgEN5nJQS2K9lL
         z2oTmDgrBuwT/c4ympomB+Jx2oq89stMT/WQ9lxvtkucxoUA3IslTrA08UpR1dJPouS8
         BhnWPlR0Y2F+8GguyHvxa7C5VKY9ZuKyV6zv8BcAxVAgrGNI3G/M03hdmFqA7NlwNnTD
         BpSw==
X-Gm-Message-State: AIkVDXLMezHvi/PsuhER3vc9BfOhB/a9uCaTN7UdxO6UiM4Efa9SZApRjJMvW+nxUv8KCaihT4skCK3OMClH7w==
X-Received: by 10.200.34.28 with SMTP id o28mr22671481qto.269.1485126286747;
 Sun, 22 Jan 2017 15:04:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Sun, 22 Jan 2017 15:04:46 -0800 (PST)
In-Reply-To: <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com>
References: <20170122212855.25924-1-eantoranz@gmail.com> <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
 <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 22 Jan 2017 17:04:46 -0600
Message-ID: <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2017 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What is the target audience?  If you are trying to write a script
> that reads output by "git blame", you are strongly discouraged
> unless you are reading from "git blame --porcelain" which is more
> compact and has this information already IIRC.

I wrote this for human consumption, actually. Maybe I overestimated the
need for this feature (I definitely find it handy, but it might be just me).
