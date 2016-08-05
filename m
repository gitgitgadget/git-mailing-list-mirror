Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E812018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948755AbcHEVX4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:23:56 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34428 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1949034AbcHEVXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:23:51 -0400
Received: by mail-io0-f182.google.com with SMTP id q83so311832814iod.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:23:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7nzhwfXuX5G3+8TSQ6IRt3BVEARnKrmgR2ZGbWaBUpk=;
        b=YH8Q8XLY352epDVvlUJY7xvbIL8F9SpJk8k4Jn4lBDNuO2EMOBJRPL+iwFo3nuSFuL
         ndP81vBa91X56hkGG0kkBvmbUhMH8uFLInCo67uP3/4gaTs3rYWlEyLnxpim2qChq+ui
         HO3F0K9LGiz/OTa4eaLbeYyq8g9+/cNrXTKjme2m/j97jW6WQJ0SRyjOopAuC9VaHj83
         l1/FrpFqJDlYc8PNRA1OxnipJ9TP4hFHQmgGWrS4MxaUDSpLNGNKM8VUoNWrXJwLqZcT
         r6ZJbnbLa02wWT03b0//Xucrc/BLOa6eQ1oKUkQ0noBKoYvLLgMMvh9uFo+X7JJHRenJ
         A7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7nzhwfXuX5G3+8TSQ6IRt3BVEARnKrmgR2ZGbWaBUpk=;
        b=gFzYrmPvPddbZ+Fq/EaYOBG3dNSmAEd/zx24oegmhMG9mQW7TF2Ea6GU/oJuqvKODY
         tXa6GfvU5ScYqiH8Cc58KsCr6UZa/mzRkbbUUgxaqzTyCdprrWC5Uw4fFS5HOOY1g45H
         CgNLcKqNYUzXt4CK2aIljtSm2NKlINrBVgetbVNZrg50S/UTBDKS2EtZtiUq6TI0Uav9
         Gtq91s0g849xrqSEQXbsirQkUqvNw1Im0J6+JeUml1RMKQJ7g21PiXxWg7DfO704NvYe
         cJU99/zUCXG+HbvjA7MTYFLjMaCaf+xTi+N46kPUZSh4FdaADckmozuje7L5iYonP2Y3
         P64g==
X-Gm-Message-State: AEkoouuXuLVbSC7n3ucH0IywFNLSngcHc3Mqc5mcaYy9bIn/aBGxIuCFhtr7QDB0Q9uOLXo5y6RjjUeqO3hZq019
X-Received: by 10.107.144.10 with SMTP id s10mr79144921iod.165.1470432229767;
 Fri, 05 Aug 2016 14:23:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 14:23:49 -0700 (PDT)
In-Reply-To: <xmqqoa57vvzl.fsf@gitster.mtv.corp.google.com>
References: <20160804195159.7788-1-sbeller@google.com> <xmqqoa57vvzl.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 14:23:49 -0700
Message-ID: <CAGZ79kY9Wry-vu9ByzW7Qc37SSkKf3doyWuzGzQeMTy4NfLMhA@mail.gmail.com>
Subject: Re: [PATCH 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * You want the "clone" command above with "--recursive" to do "the
>    right thing".  That is, the clone of the superproject borrows
>    from /var/cache/super.git local mirror, and the clone of xyzzy
>    that would be made at .git/modules/xyzzy in the superproject
>    would borrow from /var/cache/xyzzy.git local mirror.

This is not what I intend to solve here. The solution in 6/6 solves
the scenario as you outlined in [1].

>
> What I am not sure about is how /var/cache/xyzzy.git should be
> automatically derived from the information given from the command
> line of "clone" and what the clone of the superproject contains.

Generally speaking you cannot do that without assumptions.

The scenario in [1] can be done without assumptions of the locations
of the submodules. The only requirement for [1] is to have submodules
checked out, which is a rather strong requirement, as that doesn't
help you when you want to reference multiple superrpojects with
incomplete submodule checkout. (Given all of them together may or
may not produce the full set of references)

>
>     IOW, both layouts are equally sensible; what layout (either one
>     of the above two, or something entirely different) is your "at
>     the same paths" assumption meant to serve well, and what is the
>     plan to serve other layouts?
>

The plan for other layouts might be

    git submodule update --reference-dir /var/cache/

?
