Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F591F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeBVUgn (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:36:43 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53215 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBVUgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:36:42 -0500
Received: by mail-wm0-f53.google.com with SMTP id t3so792122wmc.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EBm9DlIoBzSbbKH0ACitwOYRp2+8vjdOiZmiA/2di0g=;
        b=KWdfGYeiJUc0BAST/TWpp94PghqmKtBX7M0xOI9UeAczKZiS+Mco0ydKVfi0cbt7Dq
         RlF2R3v4Kp0qDURWu5XdkeQdVRIRNo9+e2m2FgR7a+/u0o3JG8tsjddLyah3fY0wEwIy
         EdHLJwhydU9uUW3/9nRGUkzso6ZVQ7cqj8AsFPjxx7mujkW0pARfRyZMF6V0A+t+fTGt
         E0FyUiQtxP1EwAxPbPSY2GwOd3moQxk+lw3qmgVDudEh3Bc1z8bcuecskiTU1/SiCUAh
         jGEPJTP6PlLgxQqL9AeOxDaWhFwfiju5E02GKwLU3SKdrcfIXPgCuIus2MZ//Mv4UQ6C
         8gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EBm9DlIoBzSbbKH0ACitwOYRp2+8vjdOiZmiA/2di0g=;
        b=gryP9hQkqmac8KcEkVcAzqvtwNCcs5IpN7RFxcANEFKBPpRlPSQujuKAS/qO/r32+q
         7jRd3tpMfH8haKqWh9qfssKoC3daqJMgpmNvB94DKYr+vcWyttsHd1RiYpP7Bh7v1olx
         ZnXW3I5qY+WW5foQz9xOn6GhdX6TJizSjcJSLKTl0oQMS1x0OpkcNhedf9A6EBT2yIA+
         EpuItc2NA8Tvk73IwHczvFzpOKFf1nit4EPsTnWuxzpN2mRDGoQSvGv+tFfKf5HfE4JJ
         sAXk41/edoNae1gEdtPirklhxddDWQntoEv80ul5Xr2WVMkxALAP/90ZlUg2iNShqFMo
         McZw==
X-Gm-Message-State: APf1xPDb2FgBgoU36bxsOl4TnkITbji13Gr3PqHJGwhrIJUjD7GfwqI9
        2BwBaqBf8HqLEj9dCr8tVzApPSaaWbvbZH5ruBP2uJ9a
X-Google-Smtp-Source: AG47ELvZBzPduUCmfDej3G0qQrOOmoe70y/2HawIl+K4qN6BeFz+gWy6BbywpkbF2irXXMuiBtIfWxVIsJUT1MJB5PI=
X-Received: by 10.28.69.87 with SMTP id s84mr326303wma.107.1519331801107; Thu,
 22 Feb 2018 12:36:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 12:36:40 -0800 (PST)
In-Reply-To: <xmqqy3jkvkr9.fsf@gitster-ct.c.googlers.com>
References: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
 <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
 <CAGZ79kYLtXJZA865DS2JRi1RRw_L0t=f1iKJzvN+Uyroeg-pbw@mail.gmail.com> <xmqqy3jkvkr9.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 12:36:40 -0800
Message-ID: <CAGZ79kZMkuek_yVAfrTBz6jbeamc3JDjPg2JTnYb45tONAj1iQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Fix misconversion of gitsubmodule.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     marmot1123 <marmot.motoki@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Forgot to say something of your own?  Perhaps wanted to (1) show a
> sample of a better log message, (2) say "Acked-by", (3) re-raise the
> point that the same "error" already appears in the same file and it
> is better to clean them up all at once, or (4) something else?

(2) Acked-by and (4) I-am-sorry-for.

Thanks,
Stefan
