Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5501E2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbcJKNZA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 09:25:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33662 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcJKNY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 09:24:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so1058146lfl.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xo3JxyPXXmvUQHbzOeVqp9t5bXi2dYeRombsJrZ6aMk=;
        b=0D77vdtAlHWsOnYYvtgPy2RVgTkZOxcuCWGrYlfuLMWXKcgJuKk5QAJHc8B1sECnjc
         s3BYNKJlCEUJU8Zv7mD8S6tFnjS4EgnuTuA8T4QLkscdoz+wJxK69m/ZxXjWAJLYK7zj
         TXNizi+TZia2LkEzY7KoeKGb4G/FGwp1zk3D6Zf2zDdYmFoYB0ssmF4eP0ongsrPucT7
         RleHu8+nFQnXUyeXifbLmI5Uh8hAVvAgUkonre2NmQz4GxWQs7wT7ed5liQOQLDfC6FX
         E9UmMlLLWublKGz2SH9z//8wbFTOxps/ZPGa4J5w/NX33yW2VacxA08oS8Zm9veIhhwt
         OAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xo3JxyPXXmvUQHbzOeVqp9t5bXi2dYeRombsJrZ6aMk=;
        b=cpqIV++t5R9XEpP+TiIe3A93jDlQKoTaefuByeYVxtIPUredzoF6e1lJ20qGToDlRv
         SucAm3RfS8hJD1dWvvcMFu1l30IcLUzzI/qsO0cDQ0lB+GFgXk3eo6mY1sdUtzkKGF+x
         2vK8dXxJnBQ4qOliwhWDf8DK9X8vo0tTocEqFVa5TOA8F6LxJ3X+zrwn+ATgoZkBEWEM
         v73xc3SpxHNpZv3LWsxWqXrxA50E6oRhT/K1ixO6zV5lGjVrtAM82EhmT8uMl+JHRxM9
         BqGDyskq2/O5rEAUvMDrbcekvQ+9ZTI4b8F720rpp4BsbGxdwgC/OoabKbB0LknK0tCb
         AHfQ==
X-Gm-Message-State: AA6/9RnTUNAJoPQlQ6HEgNc1bWU5gUZ3dSwQdUardHm+NGRw3rRoJSirk/LsT/CXbezP6A==
X-Received: by 10.25.211.142 with SMTP id k136mr2650563lfg.45.1476192296863;
        Tue, 11 Oct 2016 06:24:56 -0700 (PDT)
Received: from [192.168.1.26] (adaq66.neoplus.adsl.tpnet.pl. [83.11.252.66])
        by smtp.googlemail.com with ESMTPSA id 79sm995758lja.16.2016.10.11.06.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 06:24:55 -0700 (PDT)
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
 <alpine.DEB.2.20.1610071616390.35196@virtualbox>
 <f41a1371-7771-1960-27e0-cba0ee5b1461@gmail.com>
 <CACsJy8Bip0mscutDHib-2O1g+eN2twO0m+OyOg2BTUudjOdwfw@mail.gmail.com>
 <20161011135107.Horde.XsPGOYSpK0L1qW2xMcGqD1i@webmail.informatik.kit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d2de6d3f-5291-c68b-5db1-b55b81ca5c10@gmail.com>
Date:   Tue, 11 Oct 2016 15:24:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161011135107.Horde.XsPGOYSpK0L1qW2xMcGqD1i@webmail.informatik.kit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 11.10.2016 o 13:51, SZEDER Gábor pisze:
> Quoting Duy Nguyen <pclouds@gmail.com>:
>> On Fri, Oct 7, 2016 at 10:55 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>>> W dniu 07.10.2016 o 16:19, Johannes Schindelin pisze:
>>>> On Fri, 7 Oct 2016, Jakub Narębski wrote:
>>>
>>>>> Note that we would have to teach git completion about new syntax;
>>>>> or new configuration variable if we go that route.
>>>>
>>>> Why would we? Git's completion does not expand aliases, it only completes
>>>> the aliases' names, not their values.
>>>
>>> Because Git completion finds out which _options_ and _arguments_
>>> to complete for an alias based on its expansion.
>>>
>>> Yes, this is nice bit of trickery...
>>
>> It's c63437c (bash: improve aliased command recognition - 2010-02-23)
>> isn't it? This may favor j6t's approach [1] because retrieving alias
>> attributes is much easier.
>>
>> [1] https://public-inbox.org/git/20161006190720.4ecf3ptl6msztoya@sigill.intra.peff.net/T/#mb1d7b8f31d595b05105b8ea2137756761e13dbf4
>> -- 
>> Duy
> 
> The completion script is concerned in three ways:
> 
>   1. it has to get the names of all aliases, to offer them along with
>      git commands for 'git <TAB>' or 'git help <TAB>',
> 
>   2. it has to get the command executed in place of the alias, and
> 
>   3. strip everything that can't be a git command, so it can offer the
>      right options for the aliased command.

There is also a possibility to tell the completion script which git
command to use for option completion via some trickery, even if the
first git command of many used in script is not right (e.g. when
"$@" is passed somewhere in the middle).

I don't remember exact details, but let's look at source:

  # If you use complex aliases of form '!f() { ... }; f', you can use the null
  # command ':' as the first command in the function body to declare the desired
  # completion style.  For example '!f() { : git commit ; ... }; f' will
  # tell the completion to use commit completion.  This also works with aliases
  # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".

Very nice.

> 
> The '!!' syntax is the easiest, I think it will just work even with
> the current completion code, no changes necessary.
> 
> The '(nocd)' form is still easy, we only have to add this '(nocd)' to
> that list of stripped words for (3), but no further changes necessary
> for (1) and (2).

Shouldn't the '!' vs '!!' / '(nocd)!' affect pathname completion?
Or do tab completion in subdir offer wrong completion of filenames
for aliases?

Best,
-- 
Jakub Narębski

