Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0595A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 05:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeBFFEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 00:04:04 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37162 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeBFFED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 00:04:03 -0500
Received: by mail-qt0-f194.google.com with SMTP id s27so720597qts.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 21:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hQF94AZqRRU6JQKZQcK4jh8grhIc5WjklJy7VmhL0MI=;
        b=XtOb19E9pP0/Wzpi2YBEx172Ssw+mTj5pidReUkmprxD4JNTOxmscsnDNu+IjFXhW6
         ve0OGqliKsbH4hJDQC3IIrYuRxFlMxeMgHeXTGYaHfRSohKeffgAb0G7PDHx0GBgwflp
         YMIZUozrNrpshe1VL65ZrxqfeTWqMJ9lWqSMa/Cq0fnYep7+cvVGeYlPIl6JMna7NRQR
         rrEqydjDc7jssSNRhhdSCvKZj5tg2gagD/oghqjT8vyHdYMScZ5TLo0MKsSOoEb4gFXc
         W15w5h0ESU7IOBHv/NWMV/KYFXQ5FQOkGXHYzq6aES5nF9bEYRDO8UyBDLT0PzaBmPgZ
         WLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hQF94AZqRRU6JQKZQcK4jh8grhIc5WjklJy7VmhL0MI=;
        b=sz+2iD5DLSXqgWewHJJaVC0MOqtMstXSqSFLdnu9LreYL+ZWq+n/2780kC051SYSDs
         C+e2Ov/44Iz78gejS4P5a7LoPzWnG6AiIWGXMOS9HmuEd/iEwb1sj8xN9fG6Nl7gFxk3
         npxhXeXwj0sHAdGuvr93cGuh31ztHnyolSbicoJlVFD9tLRXj1HfKPqSp7YQ1+DM1d5W
         y0GA97LqILQaQ/rRf6WgpBa7vTJV2UCulPzd/zg/gROJkZivIom8zTTBBSNm/9siuIZd
         kluyglzWTlwver61nO88QE9M8galpLhIddLNh2blE9Ougvt3ZQ+FlG/gGYOMnUjesoUP
         Zu0Q==
X-Gm-Message-State: APf1xPD/PHNAAXVk6JyYttqtp5hpHsxMNWne+x1amqkCg60wtUV7sroN
        DWSm9yaiPzZT8mrauSFuyaRZEqhPjq/wsat1d2M=
X-Google-Smtp-Source: AH8x227TbL+KT68bRO6Il1SoA82FFtnRoXLGPGwyIY+QNu7eMj9dO18LuF1tFxjczj7beMcEDpDFKS2J+qAlH3S+xkc=
X-Received: by 10.200.62.145 with SMTP id y17mr1777080qtf.237.1517893442319;
 Mon, 05 Feb 2018 21:04:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 21:04:01 -0800 (PST)
In-Reply-To: <20180205095608.GA12370@ash>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
 <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
 <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com>
 <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com>
 <CAPig+cRWzvcDUjw7CR78nZ0cbE-mPkB1a4UZqiChR0NUKSZOVw@mail.gmail.com> <20180205095608.GA12370@ash>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Feb 2018 00:04:01 -0500
X-Google-Sender-Auth: -FbDYzsD1zFEh0d3mbqfJNwH850
Message-ID: <CAPig+cSxxEn5q_5gv9JDXprnnocTTaLaugnhYmpHJz5tzOAkEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 4:56 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 01, 2018 at 02:16:46PM -0500, Eric Sunshine wrote:
>> On Thu, Feb 1, 2018 at 5:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Thu, Feb 1, 2018 at 4:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> >> I don't see that as convincing argument for two classes of "no
>> >> complete". Since git-completion.bash already special-cases
>> >> rebase/am/cherry-pick for --continue|--abort|--skip, it is not far
>> >> fetched that that special-case treatment can be extended slightly to
>> >> also filter out those three options from the list returned by
>> >> --git-completion-helper.
>> >
>> > I agree that is possible, but it's a bit tricky to do the filtering
>> > right in bash (all options are sent back as one line instead of one
>> > per line, which is easier to process by command line tools).
>>
>> Perhaps I'm missing something, but wouldn't filtering out those
>> options directly in Bash require only this?
>>
>>     % x='--foo --bar --snoo'
>>     % echo ${x/--bar}
>>     --foo --snoo
>
> OK how about some thing like this fixup patch? __gitcomp_builtin now
> allows to add extra options as well as remove some.
>
> -- 8< --
>  __gitcomp_builtin ()
>  {
> +       local incl="$2"
> +       local excl="$3"
> +               options="$(__git ${cmd/_/ } --git-completion-helper) $incl "
> +               for i in $excl; do
> +                       options="${options/$i /}"

Is 'options' guaranteed to end with a space? If not, then this
expulsion will fail for the very last option. I'd think you can get by
fine with just "${options/$i}".
