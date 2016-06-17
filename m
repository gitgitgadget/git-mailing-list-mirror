Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7511FF40
	for <e@80x24.org>; Fri, 17 Jun 2016 02:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbcFQClS (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 22:41:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:32903 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbcFQClR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 22:41:17 -0400
Received: by mail-it0-f67.google.com with SMTP id i6so9339071ith.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 19:41:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ws6t5YEipEdb5RjQJif2lmKT8sKoNDnBWqrMI6he8Tg=;
        b=Q8R3B0W4SFZsIPRegF2jgv4eky4ixy1o0DboXk4y3dL5JoRrlr0fNKA/h3XU0Ae6Kr
         e0XLortGRH3zyutsSKLSuhi5wDpo3g+ImwZpO4TpceYnB/Fd7datRjv57+9ULvQRwJKE
         ADoUwxZNAv4fld5zYJUZJESMa/JHKUg6GIGq3UL2RxReBc2KzAdV4+STPY/0mkrQaoFP
         r/Jd3YgSf2MkGE5EFh1Hv9vPjlzwPgFNooSzhWCF1E4zkHdS/9yMvSWI5Ud3GSAYurBR
         ZcM26Palp8GXrT7Ul5X8yyFeUFCMh2QPhENIKC1OhNXlnHwWtenCp8PQ8bRZSn2ewO64
         G90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ws6t5YEipEdb5RjQJif2lmKT8sKoNDnBWqrMI6he8Tg=;
        b=NgqPiJe2W1+AQpnUIrf5QtIaLlCCr4Q2OBq41ohabVVH2NcOgiRxIjVdDjta+0VDMh
         /KElkFwlOOXhRoCgNbA9GeC/Ods2u1As2LxCXxCD4OLh0HnTZ48YEp5eeNl/URcj+GmT
         iashQsWk/85SFcYVNsCrwLfuHrjQo7YnmLVC9l4P8clkOzIw6gsRsvHgOoYmYlbeRgnf
         hJexx8qWJIklFXYBkzSO9sqT6obERKPx1LPpdtUsgJ11EO8CwfF6Fs/nhzegaOV35tzM
         MRhjqeIFeC2weo/MLkROq1JRrrLDpWa6Qg/Nb/e+BHpkS3NxbO7d78dgQ0kRzlJrjEfa
         0G1w==
X-Gm-Message-State: ALyK8tJcDpdwP67lTRAiS8SOOcZlp4XiGEF5w7/fIub5Vylb46Ad8j/uKrJ8lS8r/4XIOlLTzxr13sr77MIFtA==
X-Received: by 10.36.129.130 with SMTP id q124mr7780405itd.41.1466131276907;
 Thu, 16 Jun 2016 19:41:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.86.134 with HTTP; Thu, 16 Jun 2016 19:41:16 -0700 (PDT)
In-Reply-To: <CAGZ79kZaZCwZ-cesB_voq0s0Qt+ipcgb6TkdzLE+EWSF_qRj7A@mail.gmail.com>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
 <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
 <xmqqbn31581d.fsf@gitster.mtv.corp.google.com> <CAGZ79kZaZCwZ-cesB_voq0s0Qt+ipcgb6TkdzLE+EWSF_qRj7A@mail.gmail.com>
From:	Chris Packham <judge.packham@gmail.com>
Date:	Fri, 17 Jun 2016 14:41:16 +1200
Message-ID: <CAFOYHZAnx-sg41OdFnbfgOkggfKCdAKXuMRXuKcbzaJibwR2Rw@mail.gmail.com>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 7:48 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 16, 2016 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>>> Hi All,
>>>>
>>>> I have the git-sh-prompt configured in my .bashrc today I visited an
>>>> old worktree that I haven't really touched in a few years (sorry can't
>>>> remember the git version I was using back then). I received the
>>>> following output when changing to the directory
>>>>
>>>> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
>>>> <= item->len && item->prefix <= item->len' failed.
>>>>
>>>> I assume it's one of the git invocations in git-sh-prompt that's
>>>> hitting the assertion. Any thoughts on what might be triggering it?
>>>> Any debug I can gather?
>>>
>>> A bit more info. The directory in question is a uninitialised
>>> submodule. It doesn't trigger in the root of the parent project.

The command that fails appears to be 'git check-ignore -q .'

>>
>>
>> Sounds like
>> http://article.gmane.org/gmane.comp.version-control.git/283549
>>
>
> I looked into this. In pathspec.c#prefix_pathspec (the function
> that has this assertion at the end), the assertion can only
> trigger if PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
> or PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP was given
> as these are the only places that reduce item->len.
>
<snip>

> Regarding the assert:
> We are sure it's a submodule related thing, so we can
> have a quite narrow warning there, roughly:
>
> diff --git a/pathspec.c b/pathspec.c
> index c9e9b6c..d0ea87a 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>         }
>
>         /* sanity checks, pathspec matchers assume these are sane */
> -       assert(item->nowildcard_len <= item->len &&
> -              item->prefix         <= item->len);
> +       if (item->nowildcard_len <= item->len &&
> +           item->prefix         <= item->len)
> +               die (_("Path leads inside submodule '%s', but the submodule "
> +                      "was not recognized, i.e. not initialized or deleted"),
> +                      ce->name);

This certainly would have pointed out the uninitialised state of my
setup in this case.

>         return magic;
>  }
