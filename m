Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2B61F404
	for <e@80x24.org>; Thu,  1 Feb 2018 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeBATQt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 14:16:49 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:46898 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeBATQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 14:16:47 -0500
Received: by mail-qk0-f179.google.com with SMTP id d125so353402qkg.13
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cNtzxunLXpvByYxrlPdt9Xwxk/KRTM2Ak9SgSV56hU8=;
        b=H2PdO6e7h+RSnyx+kkUottLsAHJSFkSoq8SNUzl6zfJbllcKBpm1FNKnUBIPPnoGbA
         M0TFQSmxSBZUtYBOrQCsGXdc2jg+qOKOy7FsBaGyLe/j/cazohL+QMG6IqpV9wheKKg9
         3FLBr/lh4Adq3HRi99Tn/aZw7qH0M4lxL5F1PPN43ASqQlX5bfbenqwxaP3+b8PMnCz8
         b3HmPTSad3gHgHtVIMT4DnvnrhmEFrRl2Twqg2p1NOLrk5ae3Bo79ksTgmOenntgcQj0
         AhJsAXUN3J7XHraDLJlp5RBG07LT+zFFEhnwABlFvb+dzabB+WGCJot85oEb/hT+173B
         6K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cNtzxunLXpvByYxrlPdt9Xwxk/KRTM2Ak9SgSV56hU8=;
        b=Ft6BVQfvAkdtTX9kb58q+GjXVNxmWAMbJ+SIRoIVrG/obcp8Cj63Q9+h8cPRN9gn93
         zs5DIu98lbkOlBQc3yTXzY1VfkeMsX5f2Dlk76FAHdMKO9EI4Zyj1BkX28nGGrtxCN7V
         Qp0pLfVzI7YcixA3W0Cj21oAjzVt70f0mGZzgJkQYSY4KijP3ZSNG0dTVSn8RjwvXmqc
         DBqgDzWcTeqjqImcy9McYKPnucKMni6Zwb3gE03YQOIXXh6zcIp0VbPH04gm9oqCImhA
         Ywhkn6lNExLKjSRT6OAqkzfdBVrORP9uzDU47dmp/zVCwZu1nmm6dK97kMsIc4PM6uQO
         6fkQ==
X-Gm-Message-State: APf1xPBT1Jdif4jWzfapvGsRPuRyF76nuwzwBsBK2/ZFgVD48BGDQB+x
        7IwO/iqkT4Up0VBiNhs//3DRMMDOcMVHtbtR61k=
X-Google-Smtp-Source: AH8x227/RJF0aky3nj8M8cSDJQQZEWNI5vooAheDIOOjd/lJzX+LFJb6tb4q/OddLxnUX7WQWSyrfhnvJr5z1hh8mm8=
X-Received: by 10.55.27.77 with SMTP id b74mr5197275qkb.212.1517512606786;
 Thu, 01 Feb 2018 11:16:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 1 Feb 2018 11:16:46 -0800 (PST)
In-Reply-To: <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
 <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
 <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com> <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Feb 2018 14:16:46 -0500
X-Google-Sender-Auth: 06osXAzc_pN1HbiP5TeilUuUl2o
Message-ID: <CAPig+cRWzvcDUjw7CR78nZ0cbE-mPkB1a4UZqiChR0NUKSZOVw@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 5:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 1, 2018 at 4:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> I don't see that as convincing argument for two classes of "no
>> complete". Since git-completion.bash already special-cases
>> rebase/am/cherry-pick for --continue|--abort|--skip, it is not far
>> fetched that that special-case treatment can be extended slightly to
>> also filter out those three options from the list returned by
>> --git-completion-helper.
>
> I agree that is possible, but it's a bit tricky to do the filtering
> right in bash (all options are sent back as one line instead of one
> per line, which is easier to process by command line tools).

Perhaps I'm missing something, but wouldn't filtering out those
options directly in Bash require only this?

    % x='--foo --bar --snoo'
    % echo ${x/--bar}
    --foo --snoo

> On top of  that, I think we want git-completion.bash to be fast, the
> more commands we execute there, the unhappier Windows users are. It is
> too possible to do this kind of filtering just once, before caching.
> It does not fit well to how I designed __gitcomp_builtin so I need to
> sit back and see how to sort that out.

The filtering as illustrated above using builtin Bash functionality
seems unlikely to be a source of noticeable slow down on Windows.

And, if you're concerned about it not fitting the design of
__gitcomp_builtin, it's almost certainly cheap enough to do the
filtering each time its needed rather than worrying about caching the
filtered list. (It's hard to imagine anyone noticing a slow down of
three extra ${x/} substitutions.)
