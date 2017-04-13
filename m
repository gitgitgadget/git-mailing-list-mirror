Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46FE620960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbdDMTam (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:30:42 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33103 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdDMTal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:30:41 -0400
Received: by mail-lf0-f54.google.com with SMTP id h125so34293911lfe.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LInxG1c/J5JCdSIyLnMIHARJktUnAF+1NvRXZOWk+V4=;
        b=Bma3Xn/J3rgR3pnFZU/vphQbCL8vrHqlew/MIQwfPGMB1Qq6YDXSWIL+GIpcO1/o6H
         Fc9L7+ydClFNRll2T7LZmUY8OSlt6aP416FDupx/2rChZHGwO/Sz7c/q/MXUJCxy6zNz
         mc6QJAez46i0206chwZExVWXyHdiJIgQMZrt7vbtE2Ki52QHJmFOGdqHl4QV48yPfzHR
         FmqJGXllISHV5p6KDs+bHQKvH5yqaRTQks+PCzqMH7/H2qVuLeA0JYBEjsDhQj4y0Bzo
         0+BIB0nUv6kLHXngJv/P2fhyDolsxlbE26kLbVbSJGTy6IlD+PDz5x6vNd6CBhENePRp
         wEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LInxG1c/J5JCdSIyLnMIHARJktUnAF+1NvRXZOWk+V4=;
        b=kiN0/aUO3ySF5j6+xDpCUbKrkmfxnovQ+7Ftcw5tW2abPz6zbG0eBeJ//70YF+KPkz
         NVpnPOJ+9xv8D28i5CaHnofV+czOenlfk3N53ozGLaIh3fgbhRMr3gFV5PAgd25BJDIQ
         S4/Oaj+LpuRmV87FFLanuf+FEtN2xOA6SYxVJmAabMVxXMeFRQyz0FQXcZEoFAoBqfgI
         cUMZhTTWwaBY4ctLQau9NFgy6begvbdJngjr74BZOBv4YFUgHHUgv4kGAz1PDWy7AwZr
         0FUmzDm+bULRJFSo+LXWF1v2Xc7fqgzleah3oyU5G6lRpzMM9lJJdgliTx/Ko+tQBn2R
         tEZw==
X-Gm-Message-State: AN3rC/6WgxN/wN+F4ajVofdosCPsMvybjawdOjcC1ySE1awVDK6OSjVM
        IV81md3pzUx788qiuWB5jiIzkoBEQQ==
X-Received: by 10.46.9.4 with SMTP id 4mr1454741ljj.23.1492111840282; Thu, 13
 Apr 2017 12:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 12:30:19 -0700 (PDT)
In-Reply-To: <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
 <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com> <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 12:30:19 -0700
Message-ID: <CA+P7+xq7VUAT3pLahj72YUnF3zDm2u-ZBFu6TxWRYcJCc0c=Ew@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 13, 2017 at 12:12 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Apr 13, 2017 at 12:05 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Thu, Apr 13, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
>>>> Add in a check to see if a submodule is active before attempting to
>>>> recurse.  This prevents 'ls-files' from trying to operate on a submodule
>>>> which may not exist in the working directory.
>>>
>>> What would currently happen on recursing into non-active submodules?
>>> Can we have a test for this?
>>>
>>> Thanks,
>>> Stefan
>>
>> We should be able to test for this. Is it possible that we can recurse
>> into a submodule as long as we have the clone in .git/modules/<name>
>> even if we don't have it checked out currently?
>
> Conceptually that should be possible, e.g.
>
>     git ls-files --recurse-submodules <ancient ref>
>
> where the ancient ref contained submodules that are not present any more.
> In that case we would need to do
>
>     struct strbuf sb = STRBUF_INIT;
>     struct child_process = CHILD_PROCESS_INIT;
>     struct submodule *sub = submodule_from_path( \
>         <path as recorded in ancient tree>, <ancient ref>)
>     strbuf_git_path(&sb, "modules/%s", sub->name);
>
>     argv_array_pushl(&cp.args, "git", "ls-files", "--recurse", ...);
>     cp.dir = sb.buf;
>     run_command(&cp);
>
> Stefan

This is probably the right flow to use then.

Thanks,
Jake
