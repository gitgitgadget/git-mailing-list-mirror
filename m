Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5589B1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfAIWmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:42:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39225 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfAIWml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:42:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so8646550edt.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 14:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMcGxlDw42AIRgiA/65anGwZooFtYujSX67Yvie0KRY=;
        b=Zj1VDttQeI5E6j8rQQaHxVxolMznMhriJWv0w8lnJBm1KWVAfzJSQYNpJxSodmcyrQ
         5xNmuAi8pAjY4fIOvyz7Oph3IqL/JHs1A9/+GSFluK+KRywsi8AFJNuzl5UA4UvDAZq2
         ddQtDQXWCmCnUq+tj4KSSxrEFmQWZTOnm6fdsF5mcDgu83+cAAZKvRNMoXyiCp9i82e/
         jKGELEPbYJ1zofa86JLzYZGG/lf12bp6VXBS65ukHE84pijCaNmAg+Oyyvjswi8M4nF2
         wcw4Irc4kBlOJjgycKCK76vPsfj62GqYy2tAb4MhrUtx2rSMaAW0eFT3sDWMgXCS80Eg
         37kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMcGxlDw42AIRgiA/65anGwZooFtYujSX67Yvie0KRY=;
        b=J6nCy1QVfmQLRrGKmjeHpCTh2nRZhNrlUR6JQwVO9vbTxSOtWGLBjg3ZoF5jcKAa4x
         ywIdV2b/zJHnTGKFI4w1tKAunIAYo03WRE0Cac0/j8W0ZcMPHFm7j+FBvcujvqcMvSQc
         tgrVsDlhV3UXuuZMG80O8JvqL6f2z8jRdY4iWtk5QKKrpQKMb4OLT1qtHzILclw59UgY
         lnR5JGnod+CIwFU9ydDdiASdm/Azmy5qIWvrRuf+2BlDm6koc/KG05koR0tkDoMfEHTn
         XhonS1Vgoq3Me/39+E0f3Az5wvf9YmlYlhkLB49glQNyasXQV6KIXVWqzvA3mSIhEM/M
         9ZNw==
X-Gm-Message-State: AJcUukfVMmGhZUuma+o4vu5ehrYINvIHqqqYINPH0fewSEYOJ4wU5QsE
        v39kQPlk3WtaLGripYiwDNlnBBrc7M5H3G/yoFkK6g==
X-Google-Smtp-Source: ALg8bN44GedFhhGIC1bjix4Oql/wtuYDCvlSdcCTV1A71s0Qd2eQ/ySiqte7GBShAaO4foFJJ31BnbJTRQ1dH/Yys9M=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr7258336edd.215.1547073759462;
 Wed, 09 Jan 2019 14:42:39 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com> <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net> <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com> <20190108180522.GA4610@sigill.intra.peff.net>
 <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com> <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
 <20190108211632.GB22946@sigill.intra.peff.net> <CAGZ79kZzg4_=Go+6btvyygzXOdEJ7VHwNmP+BDqedv+8hqdhCw@mail.gmail.com>
In-Reply-To: <CAGZ79kZzg4_=Go+6btvyygzXOdEJ7VHwNmP+BDqedv+8hqdhCw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 14:42:28 -0800
Message-ID: <CAGZ79kY81WapxeDzytz1vva_j48TDg9vOXrDwkr9uYDx4H-FFA@mail.gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 1:37 PM Stefan Beller <sbeller@google.com> wrote:
>
> > > Yikes, the conflicts with sb/more-repo-in-api is quite irritating.
> > > I think I'll postpone the later parts of this series and ask this to
> > > be sent after sb/more-repo-in-api matures a bit mroe.
> >
> > There were several conflicts, but it was mostly just tedious textual
> > fixups. I pushed the result to:
> >
> >   https://github.com/peff/git.git resolve-oid-more-repo
> >
> > But I'm happy to wait and rebase if sb/more-repo-in-api is close to
> > graduating.
>
> The merge looks good to me, though I just looked quickly.
> The series itself is also a pleasant read.

Compiling this leads to:

sha1-file.c:1424:33: error: incompatible pointer types passing 'const
struct object_id *' to parameter of type 'const unsigned char *'
[-Werror,-Wincompatible-pointer-types]
        if ((p = has_packed_and_bad(r, repl)) != NULL)
                                       ^~~~
./packfile.h:149:95: note: passing argument to parameter 'sha1' here
extern const struct packed_git *has_packed_and_bad(struct repository
*r, const unsigned char *sha1);
