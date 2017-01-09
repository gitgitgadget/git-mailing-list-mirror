Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C26820756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758701AbdAIKbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:31:16 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:36580 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdAIKaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:30:55 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so17396710itd.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sR3efWIO+WgCnR6kSH68tV4BhtZX9JKzdLm3oZg/Mq8=;
        b=NEsnn9ZTee3MfetCsl//AwzYeGeaCP+nUrFnJhCJoeHkV3TCbgkIpO6IXuyfb1bzfM
         9GzA3U8uZmYe21QbcdcSzMDAFZG7amZ7qybdRXSgakCRtrp49H5+CMDT/iEDIwOVRbvF
         +aLPYO2ZKFUMiSI/30XVNyPwr8K+3pjswAo0/vjbyQTnIhdjfjgx7zl5Z40HoqJm+eQO
         m60AYha5ICc1stzjS5BbiOewNUHlQRs8grkkFsT/36w2NYemi/8/RZW/eND6pMmiYC/b
         dZ79WisKdKIhu3vu1PKEFSkrRnnfhrfDEfFHqDZaAuddeNzXy0h+8i4DKlvgCPGeJ8Pe
         mgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sR3efWIO+WgCnR6kSH68tV4BhtZX9JKzdLm3oZg/Mq8=;
        b=c0JdwVnl9CoBigLb6owJt0bZUT7BBCtqTpnJSYP7Haj7tGkUuYH+/8XNDm6+kayBwV
         p3xOANkjIKPZtARQRdVTaRqucNdL3f2+cqPi5xHJzdxbm9Y8zvFfXEkAsLq+z3JkjsqD
         wROZ4RxNs7NywaB6ytVCdjAzuUKEgOMvs/3E+SHZy6a+7AvpUeMC12CU5uIrakD8e9vq
         cns5OQahbBOijE/hI4dm5gXNzQ1FKBAtV9m85yX6iX122eoyPOnHQOEgXpfloGzOq5FP
         8LOdLUDRHRJi1a/fZjMjztLciY0Ioag5aHtSzYgLZ5wv8AX6AzsFYs013fSrHehTv653
         D+Ow==
X-Gm-Message-State: AIkVDXIJ1V1XtdjcqnyJyn1Uwk9B8d48jpGpD7+ucuyQPQTkBjREF7l/il1KHXIT1szluWccXC3/SYEbt042OA==
X-Received: by 10.36.184.194 with SMTP id m185mr8215906ite.3.1483957854527;
 Mon, 09 Jan 2017 02:30:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 02:30:23 -0800 (PST)
In-Reply-To: <20170109053047.sn75d6ynipgf4nur@sigill.intra.peff.net>
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com> <20170108101333.26221-1-pclouds@gmail.com>
 <xmqq37gtyluf.fsf@gitster.mtv.corp.google.com> <20170109053047.sn75d6ynipgf4nur@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 17:30:23 +0700
Message-ID: <CACsJy8AjW1TrLO28mSUSTc6V+_0kuShf7V-=Pkw3Cw9t7ZRfyw@mail.gmail.com>
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config log.graphColors
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 12:30 PM, Jeff King <peff@peff.net> wrote:
> I also wonder if it is worth just using argv_array. We do not care about
> NULL-terminating the list here, but it actually works pretty well as a
> generic string-array class (and keeping a NULL at the end of any
> array-of-pointers is a reasonable defensive measure). Then the function
> becomes:
>
>   argv_array_clear(&colors);
>   ...
>   if (!color_parse_mem(..., color))
>           argv_array_push(&colors, color);
>   ...
>   argv_array_push(&colors, GIT_COLOR_RESET);
>   /* graph_set_column_colors takes a max-index, not a count */
>   graph_set_column_colors(colors.argv, colors.argc - 1);
>
> It is not much shorter than ALLOC_GROW(), but IMHO it is easier to read.

Indeed. My only complaint is it's "argv_array_" and not
"string_array_" but we could think about renaming it later when we see
another use like this.
-- 
Duy
