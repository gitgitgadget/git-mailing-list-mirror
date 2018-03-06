Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9014C1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeCFWWM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:22:12 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:44411 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFWWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:22:11 -0500
Received: by mail-qk0-f175.google.com with SMTP id v124so289375qkh.11
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cntuYqVTy2iFX7s8RMW8EdjGWaB+gzKLgnstVGI3U7Q=;
        b=Edz4Jxek1aR6f9JRrul9+OABbmekp8WapaQxowOGsMbpZqHsWb9B40P+UauYs8XV9l
         o1b2fcJG9fC/UiE8FHR0zRt4pPGrgTRggCRsFiGnTBoXo9G7SEYlRUS59+hRv+EQHpd/
         zBqsHOTFjg+p6ElkS05IKxi+diOOoDPU39taKOSs92TSSRVXJ5jn5Ev+8aS+KR7s8Pqk
         LhvxACT2o+b1NPuKaFbM2oKiQawDctSiLOlIxmgw5zenTg7ujWAsK48aKGKuqIdILFzn
         uAUMi0xe50jg2GnUXu9qvDqZgn0Dq7Q5XGGIMcgL6XDDfHdlzlCZEjysUd2wAHhO6gei
         n0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cntuYqVTy2iFX7s8RMW8EdjGWaB+gzKLgnstVGI3U7Q=;
        b=nh4PfREeEBVMTnIpYh9ioSLYIoUKvtjAujzq4m5f4gBFJM0jjBK40hGpbOxWdhMGpe
         94j/qUJxSZ0ErdPKaTKirbHjbeKk6gdMjCv0WBcA0ASLb6ZNhgFjXle9w2pyV5wnpWmN
         g0xrS/KhSkRZ8tw3/StKpuNTHoIy4Fg5hovNP1ynTQxyCqziuEsNY8GkUDxAJgw/u/Df
         Sdgg5azPdt3xN0g6Dnuklmcj+8CVmTvs2U//C5VhjDvPtD0wNDgF4MUmVIvC8wrkeA6m
         /JH6tkH3RQqdaOfsS8dAFA1lm9aaomKr634cZlznBupPcVBBxSXFvxBkqtUmC4CN7div
         8OBA==
X-Gm-Message-State: AElRT7GYDHT77TrpGL/xK2lCX3rXJ1tOCbA1GDGmWarqT31z/Pl42EM5
        PPif0fyUNnXji8CepsH+Q27a9UK4uLFms8nG6hQ=
X-Google-Smtp-Source: AG47ELt8dTD8F2vO+7+t3LbaPBLLuFaX/SsJycAVa3i1pj+/o2SfM+ulczTC7UK3QUpgFdoEcJMXzjzw0pullYIlXaU=
X-Received: by 10.55.133.131 with SMTP id h125mr30925708qkd.79.1520374930838;
 Tue, 06 Mar 2018 14:22:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 6 Mar 2018 14:22:10 -0800 (PST)
In-Reply-To: <570D707A-DD9E-4397-8155-E8B3C3D09760@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
 <20180304201418.60958-6-lars.schneider@autodesk.com> <CAPig+cTOpBODeoHV=+4-4MEjKM=pUrZSa=BEmHh4mVP=xPpFCA@mail.gmail.com>
 <570D707A-DD9E-4397-8155-E8B3C3D09760@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 17:22:10 -0500
X-Google-Sender-Auth: jwx2aDXrDMowNX537F15ChtZnbg
Message-ID: <CAPig+cQE0pKs-AMvh4GndyCXBMnx=70jPpDM6K4jJTe-74FecQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 6, 2018 at 5:13 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>> On 06 Mar 2018, at 21:42, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Mar 4, 2018 at 3:14 PM,  <lars.schneider@autodesk.com> wrote:
>>> +       return xstrdup_toupper(value);
>>
>> xstrdup_toupper() allocates memory...
>>
>>> +       const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
>>
>> ...which is assigned to 'const char *'...
>>
>>> +               ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
>>
>> ...by this code, and eventually leaked.
>>
>> It's too bad it isn't cleaned up (freed), but looking at the callers,
>> fixing this leak would be mildly noisy (though not particularly
>> invasive). How much do we care about this leak?
>
> Hmm. You are right. That was previously handled by the encoding struct
> linked list that I removed in this iteration. I forgot about that aspect :/
> I don't like it leaking. I think I would like to reintroduce the linked
> list. This way every encoding is only once in memory. What do you think?

It's subjective, but I find the use of a linked-list just for the
purpose of not leaking these strings unnecessarily confusing.

If I was doing it, I'd probably add a conv_attrs_free() function and
call it from each function allocates a 'struct conv_attrs' (including
calling it before early returns -- which prompted my earlier comment
about it being a "mildly noisy" fix).
