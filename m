Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622C21FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 01:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdAMBAJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 20:00:09 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35863 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdAMBAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 20:00:08 -0500
Received: by mail-lf0-f44.google.com with SMTP id z134so22306679lff.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 17:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U8BQhynGE40VT04AsIJLrNj3DMljY9/Fczttp6ENX+8=;
        b=pezR2iEB73zVpgOc2hz6Myumk6MN0ki0ZC7TdIvMGM75+R8fr+ddzEEmzE37HEhoPK
         g7hZUpr6/+6V1vlgKC2U2feeiXpGs+4gTl4i7r0rMz3JlwYOuCMi/9s2JB5DzYvDki9/
         M/8rdxQ+IN/T0yqVyfVyuWDGlkw06Lvsky9dyFqrp1vD4GD9jge00plMWp6rjDZZVFRn
         VU+mEJVPvMoOm47snegZSpy4PywnRaync6YJ7wQCtaW7xSe4USZTyOZ5m5PX2rQJSEBf
         yehQ1/OxsZ7LRQpDywsgu/Sbxi39N8keeB+WT+HByBB8GP/VsvxKjB0K3n635e67aoXv
         hWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U8BQhynGE40VT04AsIJLrNj3DMljY9/Fczttp6ENX+8=;
        b=iHm3DuPMpZZVCV1hRKGEDKek0z7pZj0st7W8XhQK2JajyAtkj7mPV6evt0H56Z9IFw
         d/cuQhbVluVFACjWB5oocHOK0rhXphKCZPAe2wn/EXMWIgjFAUZgRL+icgExvA8W14go
         dXFh81tQMCV32jSWpPImiVZYKu4lw7/0T4wkouzGi8KGVJAt0VGuOni9Yv0wUCbb7nq+
         Q+BAjImNipMmSlGSLAYZklVicGjReZO22qXjGEYmnydgN1fl4VwYPOhk0YP3J/6pazGY
         6d0eAKNY8Eg6MQXCEB/n3lZa4Q+QljCSd4it3FyL9qIv9JSN1iPRgt0G40vdt9HR3m9b
         zeBQ==
X-Gm-Message-State: AIkVDXK6/0GFc8EwFpDv3xpawgeJfT/40N85G92EdoCokp+fAsiSYZ/2WhjVVLCEbKURyoXKvBHzgbBeYNfksw==
X-Received: by 10.25.141.147 with SMTP id p141mr6786924lfd.147.1484269207260;
 Thu, 12 Jan 2017 17:00:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 12 Jan 2017 16:59:46 -0800 (PST)
In-Reply-To: <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com> <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Jan 2017 16:59:46 -0800
Message-ID: <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 5:45 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 12.01.2017 um 01:17 schrieb Jacob Keller:
>>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git-describe the `--discard` option which will allow specifying
>> a glob pattern of tags to ignore. This can be combined with the
>> `--match` patterns to enable more flexibility in determining which tags
>> to consider.
>>
>> For example, suppose you wish to find the first official release tag
>> that contains a certain commit. If we assume that official release tags
>> are of the form "v*" and pre-release candidates include "*rc*" in their
>> name, we can now find the first tag that introduces commit abcdef via:
>>
>>   git describe --contains --match="v*" --discard="*rc*"
>
>
> I have a few dozen topic branches, many of them are work in progress and
> named wip/something. To see the completed branches, I routinely say
>
>     gitk --exclude=wip/* --branches
>
> these days.
>
> It would be great if you could provide the same user interface here. The
> example in the commit message would then look like this:
>
>    git describe --contains --exclude="*rc*" --match="v*"
>
> (I'm not saying that you should add --branches, but that you should prefer
> --exclude over --discard. Also, the order of --exclude and --match would be
> important.)

I think that --exclude makes sense, but the current implementation
does not differentiate ordering, since both are merely accumulated
into string_lists and then matched together. I'm not sure how order
would impact things here? In the current implementation, if something
is excluded and matched, it will be excluded. That is, exclusion
patterns take precedence over match patterns. I think this makes the
most sense semantically.

Thanks,
Jake

>
> -- Hannes
>
