Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EE71F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbcHCURJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:17:09 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38345 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758330AbcHCURH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:17:07 -0400
Received: by mail-it0-f49.google.com with SMTP id j124so245219866ith.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:17:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jbWoY14R1xMk7J5MkZDEE/EFqR/Y+k4URMXxr3lDO2g=;
        b=n+FkuL3QXeY2sdgqCMGDrv4a6x7u5oJxiaMW5paCGSrx/ITE4+0VO+widlsu4rycr1
         qBGXB5PT8Qg91oxtZ+tyRLOxx0dQ0esyxqOy8oFrm1/9/gOd/TUgCO1JjBFTmwBjm5k4
         HdT7T7ctFRUtPocXvJ9Kq9Nga1Wo7E/FxUmCLY4fj5TZH4WPn1HZnSl80HodBxjiskra
         abicPcbgiGX15kMZWGqgkYvQjVV7kosaRdsQGHX0b1gYotPiKgIkqgyc6Al3SYKQ0A4H
         SndpyZj+tx7vJG//Zh3WDEGiKIbs8xk6RfPkfHH+DezXE8pgPstyNfgvB4MkwFd/iigS
         pefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jbWoY14R1xMk7J5MkZDEE/EFqR/Y+k4URMXxr3lDO2g=;
        b=LrtaZenYvzeA2pYuwPcbylqJm59+ORKVoY6aB9bNUVkPBhy6eb7+w+LtFe1ybzBf5D
         EL1KkR5AGuEYsoZpEIdzuPDHVTCeDT+tKT5LoVdC7Dy8P5OalJqsu0lCJVoZHCXoWgB5
         muE/UyRTBMWrOHmnKGcin60sRjx/+uu0aA4aa9J8HqEtUuoDyF1r8hG/ZDA50GexzzRc
         vnLfamZbLNHYFH0h5jJeZcdIAHCz4X1mvm9zcvuzXAhXkuUnmGERMkfTDPrLd8HWbmNm
         k8NlqIO/kTvF2MlSnBO2yllaZCuUFSNDtRIYGi3YAVJWKqNwCFMDuleCywCQL3TJyweu
         VC9g==
X-Gm-Message-State: AEkoousZ4Vzng3hsTonDNBRiFFo+r6aG/eMF/opTvUcSzj5akPJSCF0Z7hHagksdMP73PgNnXXvZ5XxcAqY2/FZ+
X-Received: by 10.36.217.9 with SMTP id p9mr3628615itg.46.1470255111865; Wed,
 03 Aug 2016 13:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 13:11:51 -0700 (PDT)
In-Reply-To: <20160803162512.veyff5g52kaqwlgx@sigill.intra.peff.net>
References: <20160729004409.2072-1-sbeller@google.com> <20160729004409.2072-7-sbeller@google.com>
 <20160803162512.veyff5g52kaqwlgx@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 13:11:51 -0700
Message-ID: <CAGZ79kYW0dwUh=QpKL9W+cv8k_Z9Vc2wxoLMqud5brDtS9DYpA@mail.gmail.com>
Subject: Re: [PATCHv3 6/7] submodule--helper: add remote-branch helper
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 9:25 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 28, 2016 at 05:44:08PM -0700, Stefan Beller wrote:
>
>> +static const char *remote_submodule_branch(const char *path)
>> +{
>> +     const struct submodule *sub;
>> +     gitmodules_config();
>> +     git_config(submodule_config, NULL);
>> +
>> +     sub = submodule_from_path(null_sha1, path);
>> +     if (!sub->branch)
>> +             return "master";
>> +
>> +     return sub->branch;
>> +}
>
> Coverity complains about "sub" being NULL here, and indeed, it seems
> like an easy segfault:
>
>   $ ./git submodule--helper remote-branch foo
>   Segmentation fault
>
> I guess this should return NULL in that case. But then this...

I thought about checking for (!sub && !sub->branch) to return "master";
However I disregarded that implementation as the submodule-config is
reliable for any correct input. Though we need to handle wrong input as
well. So how about:

  if (!sub)
    die(_("A submodule doesn't exist at path %s"), path);
  if (!sub->branch)
    return "master";

...

I think that explains best why we even check for !sub.


>
>> +static int resolve_remote_submodule_branch(int argc, const char **argv,
>> +             const char *prefix)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     if (argc != 2)
>> +             die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
>> +
>> +     printf("%s", remote_submodule_branch(argv[1]));
>> +     strbuf_release(&sb);
>> +     return 0;
>> +}
>
> would need to handle the NULL return, as well. So maybe "master" or the
> empty string would be better. I haven't followed the topic closely
> enough to have an opinion.

Oh I see, this can turn into a discussion what the API for
remote_submodule_branch is. I think handling the NULL here and dying makes
more sense as then we can keep remote_submodule_branch pure to its
intended use case. (If in the far future we have all the submodule stuff in C,
we may want to call remote_submodule_branch when we already know
that the path is valid, so no need to check it in there. Also not dying in there
is more libified.)

Thanks for this review,
Stefan

>
> -Peff
