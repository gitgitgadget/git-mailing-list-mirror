Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F7A202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdJSXeT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 19:34:19 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:55848 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdJSXeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 19:34:18 -0400
Received: by mail-qk0-f169.google.com with SMTP id x82so12438915qkb.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GovKVtttpw6Sr2PJTub6h1PRsDF52Xlr02KgfZHShmI=;
        b=smsab6k+R4wY4u8n0eSguNDHrkaaJ04+NOiCSC2sHclJU+qBgklD325YLNiuUJzVRi
         stL5M8U8cc/lBXtbokJuu5tf7x2UF7nkf3/sP5OuTzRAVIczJjy6Cj6lHkPAYvyRiMOb
         346GG4YXOf7aVwKT3cGjrNDRI6b/2gxEmp9BwkpP/pG0CnxxQY5xWpCmEJknk1W7betW
         6AA4soRYoK+VvlZ++/QebOcxRLyumw3STxq4Mf9PwsDLt/jH5i/YncOqyHTw8+Xvx86b
         cFtnlThBqa4/+GKn7mo82L3mOwQLvsTO1szCUkL6awW6xxZboHibZ2vdTXL+fimrCg/i
         xnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GovKVtttpw6Sr2PJTub6h1PRsDF52Xlr02KgfZHShmI=;
        b=YjvMsEolICGVpKruaDfbwg4YVKkKWaNDyf2AuLSzCiRMi82MUZY8Pbxsgakuy8REzn
         wSPtj1PaKul90cd1Ere3NZ8LVszsf2MroBf8IuFOLw0F4y0LSIHW3XdOuX9YBK2m9bxV
         8ci7MKQoqo5KTlb5Y7FDeGcIOldmKdtVi5g5EMDxQlNz69Mqd4jDJEELkd9J5NNU6vh6
         qYHWKzAyxAA5rbl9NCG5S7jGTJ0IOTcX5+MrHuRDxt/V3KxOj1EV8RJWKaVmZYFn/gKl
         +WqL3cPZD5xSUQkjCcPy6kMcNhFpmgQ5kyw5cu1UAK3xamUBfbd9terZghYuoUOF2fJV
         kuIg==
X-Gm-Message-State: AMCzsaWdf047FU+Pi4H1HgwDdQT8jK43Vyi5UH5KdP14i7Bk0NE/7MCd
        z3CT2cMNrfqNsV5aaovODiq2bNyLA7zg337jaC3s0A==
X-Google-Smtp-Source: ABhQp+TWsg/VFUVQ5oQcASHzfuZCu5m611fmQea5UzkGt4z8Y4S6QJLt1G+Cb4fWm8VGefn0j2ajqLHtlaoAIaBPzUM=
X-Received: by 10.55.125.196 with SMTP id y187mr4640380qkc.180.1508456057363;
 Thu, 19 Oct 2017 16:34:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 16:34:16 -0700 (PDT)
In-Reply-To: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
References: <20171016135623.GA12756@book.hvoigt.net> <20171016135827.GC12756@book.hvoigt.net>
 <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com>
 <xmqqfuahmif9.fsf@gitster.mtv.corp.google.com> <CAGZ79kaTXC9Eius3jMZGefZioJtS-uuf+ar5zt=WSEWQJxdcwQ@mail.gmail.com>
 <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 16:34:16 -0700
Message-ID: <CAGZ79kaisP5fGMOvyscz31XOf9HxN6og2MjsZKO_Dpkq5cy=Mg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] implement fetching of moved submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> but if we already have a submodule with that name (the most likely
>>> explanation for its existence is because it started its life there
>>> and then later moved), and the submodule is bound to a different
>>> path, then that is a different submodule.  Skipping and warning both
>>> are sensible thing to do.
>>
>> Skipping and warning is sensible once we decide to go this way.
>>
>> I propose to take a step back and not throw away the information
>> whether the given string is a name or path, as then we do not have
>> to warn&skip, but we can treat both correctly.
>
> Now either one of us is utterly confused, and I suspect it is me, as
> I do not see how "treat both correctly" could possibly work in the
> case this code warns and skips.
>
> At this point in the flow, we already know that it is not name,
> because we asked and got a "Nah, there is no submodule registered in
> .gitmodules at that path" from submodule_from_path().  Then we ask
> submodule_from_name() if there is any submodule registered under the
> name it would have got if it were added there, and we indeed find
> one.  And that is definitely *not* a submodule we are looking for,
> because if it were, its .path would have pointed at the path we were
> using to ask in the first place.  The one we originally found at
> path and are interested in finding out the details is not known to
> .gitmodules, and the one under that name is not the one that we are
> intereted in, so fetching from the repository the other one that
> happens to have the same name but is different from the submodule we
> are interested in would simply be wrong.

Eventually we'd want to also init new submodules on fetch
(if you use submodule.active to specify the interesting submodules),
and in that case I would imagine to fetch both submodules.

As I wrote the code to further improve this series,
I realized that this is maybe "good enough" for now,
so assume that I have reviewed this series and found it good.

> If we only have path without any .gitmodules entry (hence there is
> not even URL), how would we proceed from that point on?

Oh well, right. We can only offer to keep the existing behavior
which means supporting existing repos in place at that path.

Stefan

>
