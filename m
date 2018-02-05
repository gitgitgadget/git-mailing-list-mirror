Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B3A1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeBES5K (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:57:10 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39388 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeBES5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:57:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id b21so27909493wme.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bl+lrzUsQOBihMz6GjKqVoGWwPgLLB1fvNiBGReVgSo=;
        b=d0x54dtFZoLHPwlqHBJKa5m5aZ32qt5zgNeHA+p7kKm+P4O8XfaiOuI4lSM5RAFdG1
         okuJHPiB+7s5kxBGOk4RtUNe7IjsBjFpGQL++QfxkzGD7cljZZ1dhewQj8d5I/aOeZVj
         pLk7dHsMysjedQY5FulP7LhIJs6/YlHQ8TF1Zg08ik89poNyoKlD1I/TO+WLX+1dkhGJ
         KS4HOnm7JRahLPecGD4s5pMT5IVCKbVrTTc/AcQUXBGyBx25DlrWry0ohezHYOmqzaiC
         aWE+/rMcrbGc4OQMa+VJCHIOjIdoslkeF+BYTte3lHc65DcEzCCGRxI7Mjci+KXeWMHC
         /qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bl+lrzUsQOBihMz6GjKqVoGWwPgLLB1fvNiBGReVgSo=;
        b=hmNcTkcFE+SixDQ4T/Fk2TN+gxAdmNjlTHD9dlmGe5bUQG6XiHhBeN9O99rUq64o+6
         9DPu6+hmBO44vWt8iUCd6RAeDerugxLiDs/chBbitBXNSyh+/WO5558XzeJTzZD+A5zo
         ljXwYOmm2YpOWfKWsU4ZUPLMcBBvvRK1gzyZ4I/proOOu3MnSM/Zm/yol9FZdYcJso9B
         YpOy2dytUFEmxzbT+LjHqbGdW8VXzjpTd8cGWuaJ572P0c/p7tK0P5V4yTvTZPBHyyhM
         t+d2uLCFuLdFKEY101+IuKPEjVM6RzAeRPYKWMujuRvyHHyHTniQs0xY9RmYpj4LG4wp
         X8+Q==
X-Gm-Message-State: APf1xPAOSD6NEhgxfFG6/5dsNTSXSUk2zw2ZF4Xwv1P6lpPg7+vJD4qF
        yAPqiNH2/4j11CZudMRALT50XDSZ
X-Google-Smtp-Source: AH8x224V7GAZ5HP8BSBLIz/LTJcokTNYrJ/gUzQY3kFBf1NEFiCK1G9KOfXbIj1mnSWoBThIl/j10g==
X-Received: by 10.28.124.25 with SMTP id x25mr235651wmc.49.1517857019933;
        Mon, 05 Feb 2018 10:56:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c49sm10518633wrc.48.2018.02.05.10.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 10:56:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
References: <20180201130221.15563-1-pclouds@gmail.com>
        <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
Date:   Mon, 05 Feb 2018 10:56:58 -0800
In-Reply-To: <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 5 Feb 2018 18:28:47 +0700")
Message-ID: <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Feb 3, 2018 at 2:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>>> Changes since v2 [1]:
>>>
>>> - goes back to my original version (yay!) where the extra info
>>>   is appended after the path name. More is described in 2/2
>>> - --compact-summary is now renamed --stat-with-summary and implies
>>>   --stat
>>> - 1/2 is just a cleanup patch to make it easier to add 2/2
>>
>> It may be just me and other old timers, but --X-with-Y naming means
>> quite different thing around these commands, and --stat-with-summary
>> would hint, at least to us, that it would behave as if the two
>> options "--stat --summary" are given at the same time.
>>
>> And from that point of view, the new name is a bit confusing one.
>
> I don't have any good alternative name to be honest. It's kinda hard
> to come up with another word that says "extended header information
> such as creations, renames and mode changes", except maybe the vague
> name --stat-extended?

I actually think compact-summary was a good way to phrase it.

Personally, I think it was a UI mistake that --summary can be given
independently with or without --stat (instead, there shouldn't have
been the --summary option, and instead when it was added, --stat
just should have gained an extra kind of output).  A single option
that can give both kinds of info may be a good way forward, so
another possibility may be --summary-in-stat (meaning: the info
given by summary is included in stat output).  I dunno.

