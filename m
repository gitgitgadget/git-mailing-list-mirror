Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208161F453
	for <e@80x24.org>; Wed, 24 Oct 2018 14:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJXXW1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:22:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJXXW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:22:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id m15so3874421otl.7
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trux-info.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acGoJK1wXpjBysKXHNQszUDd71oqx6R4/MihBjxaOTo=;
        b=Rlc4NpdMKups6gfU8n/pDHPM6Qle0nGOagIvtUOGxAn3KwWWrPD30jT0C7ryc12vPt
         mCyAlbEJOBgCEJkyow62MR/2BLGXAR7pGgjQckVGxhem6iLsl9PDCcbhY/SROqP0ovSl
         nVyXQ5oOzoHqsqtg7Up3qkemEf5Ixa09DjZ3lEO/vCLhj+Okk26C8v/KW6MNY2fx+vVA
         VyEBJfZnNTOdqrG12F/VwwrGzUKKffoQmGpnQR3f5KeCabMMdvel6kNJzuy5DR/4goMW
         K5oWPmmAJnEoSMHFJqVxTM0rwSbkfg8ZmBiokkX8PkPxscP/379/UEVICSP6duRkaw1b
         8+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acGoJK1wXpjBysKXHNQszUDd71oqx6R4/MihBjxaOTo=;
        b=n9tRy3qCs+L3120IKYE0Sblh7Y7GWcCIVO+uueYBmWjerV6pxYu4VbS52wIO5qaAFC
         cTR6M7xyEBMtDW+A6xe+w5BJuoOfmoGNouBfqh+HtPUOJU1IXmstlhwNEeNHHtT7wLf+
         YJDWjEqVxJ7GgR1EloQMr5lpfzvv0gXbOQO3XtiYd3Wmo50Ydf9Fz+p6jfJthLsk+Y6b
         E0cQ5sawwYZuqn4OewSgtG0arYtu26Hhwmb/1QjHrU1OGMTkHNKj+8mj+uHwbgs+VeY5
         5qPkmlBw/e3QbpYIlK1mpnJc/0LCMyosZiIdY81APn9jsmCurxgZ3yy65B2RJ8ngVLDK
         TAug==
X-Gm-Message-State: AGRZ1gI9WUQiJ3Pzl6CrXZFKK6om7U9H8e0P3CaEivNYcSR5OxkDgzAI
        aq5b02jtu20cSDHrshHcPb5s9DF4v9YBzEYspk98UOU7
X-Google-Smtp-Source: AJdET5e4JIckH6B3z+scMbGUjbbtvVJChY6cIGs3ymMqGVlC638LoDH0idEg5evBwPr9spPd7hd9P1K/9EkLyMKAKHE=
X-Received: by 2002:a9d:5110:: with SMTP id c16mr1946239oth.297.1540392840398;
 Wed, 24 Oct 2018 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-7Hi+tssj4ozKPd04squ-PuFwtt6f2nhbZp-zKwy62pVQ@mail.gmail.com>
In-Reply-To: <CAGOLd-7Hi+tssj4ozKPd04squ-PuFwtt6f2nhbZp-zKwy62pVQ@mail.gmail.com>
From:   Christophe Bliard <christophe.bliard@trux.info>
Date:   Wed, 24 Oct 2018 16:53:49 +0200
Message-ID: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
Subject: Re: bug?: git grep HEAD with exclude in pathspec not taken into account
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I observed an unexpected behavior while using git grep with both git
2.19.1 and 2.14.3. Here is how to reproduce it:

> git init
Initialized empty Git repository in /private/tmp/hello/.git/
> echo foo > fileA
> echo 'foo is false+' > fileB
> git add fileA
> git commit -m fileA
[master (root-commit) f2c83e7] fileA
 1 file changed, 1 insertion(+)
 create mode 100644 fileA
> git add fileB
> git commit -m fileB
[master e35df26] fileB
 1 file changed, 1 insertion(+)
 create mode 100644 fileB
> git --no-pager grep foo HEAD -- ':!fileA'
HEAD:fileB:foo is false+
> git --no-pager grep foo HEAD -- ':!fileB'
HEAD:fileA:foo
HEAD:fileB:foo is false+

In the last command, fileB appears in grep results but it should have
been excluded.

If the HEAD parameter is removed, it works as expected:

> git --no-pager grep foo -- ':!fileB'
fileA:foo

If giving the revision, it does not work either

> git --no-pager grep foo e35df26 -- ':!fileB'
e35df26:fileA:foo
e35df26:fileB:foo is false+

The same behavior can be seen with git archive:

> git archive --verbose master ':(top)'
fileA
fileB
pax_global_header00006660000000000000000000000064133641017230014512gustar00rootroot0000000000000052
comment=e35df26c65f3c0b303e78743496598b8b6a566e9
fileA000066400000000000000000000000041336410172300120130ustar00rootroot00000000000000foo
fileB000066400000000000000000000000161336410172300120170ustar00rootroot00000000000000foo
is false+
> /usr/local/bin/git archive --verbose master ':(top)' ':(exclude)fileA'
fileB
pax_global_header00006660000000000000000000000064133641017230014512gustar00rootroot0000000000000052
comment=e35df26c65f3c0b303e78743496598b8b6a566e9
fileB000066400000000000000000000000161336410172300120170ustar00rootroot00000000000000foo
is false+
> /usr/local/bin/git archive --verbose master ':(top)' ':(exclude)fileB'
fileA
fileB
pax_global_header00006660000000000000000000000064133641017230014512gustar00rootroot0000000000000052
comment=e35df26c65f3c0b303e78743496598b8b6a566e9
fileA000066400000000000000000000000041336410172300120130ustar00rootroot00000000000000foo
fileB000066400000000000000000000000161336410172300120170ustar00rootroot00000000000000foo
is false+

fileA can be excluded, but not fileB.

Is it a bug?

Thanks

--
Christophe Bliard
