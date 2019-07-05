Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B141F461
	for <e@80x24.org>; Fri,  5 Jul 2019 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfGESwi (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 14:52:38 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37347 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfGESwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 14:52:38 -0400
Received: by mail-ed1-f44.google.com with SMTP id w13so8698680eds.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y3wJj71CYoqKAhr5RYQ1T+Lhq/A5EMvNc+Ad8solI7w=;
        b=F4CLyghyi6BrpJeyyTHXWtg57/2s+g/dR0Gg7Ck3bmrLY8WXW/0H2yPUt4IhCtF577
         LFfZLrhLhrLqYwu+SIN1bD2N8hXmZjEmUtv5MVuxZqMsuPbG0xl6/fPoZUq8heaHFiq+
         0acmw7kT2VvZGFdHoFnJPiywiTcM7f4UT6c6pssRqv1wsJ1evaV6XDIcED+/FszweTzx
         ILIg4XMANNCnGF/JiQRyDcqNsdBmfMWuWP+XcaJAASrwq611gjMmOfqRIXlrMPy4BgUX
         vywT/WMilTCz4JqVH2SpoHfVq2T211Z3+YU3Gh6gAQ3MRDpCNYtcmLo3FEH89P8PdRfa
         pkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=y3wJj71CYoqKAhr5RYQ1T+Lhq/A5EMvNc+Ad8solI7w=;
        b=Uth0BI8NuEKniAxusl72ueXZu96ISVBpokybCUXM8xqKz9lUDHJT+wRxfyPFhZGLIn
         X4mF7OOw0VKLw2lA81b+cHtbIZky6af7qSAlRHh+wA9JFt7phh05p13NynjOp9X42wpY
         SCsnQhrmgmKJmU6e0dbsCxpmm+vsvl/KK8GvNYpqvws5SfgHzbvF26Fv8VNkwVQRSF62
         4IuOzYq/ISPi1xdETb8FRBYgK77kNolJRjUUUntJaMQfBy0ba9KZLp0EQvjAZts2fLQ9
         haQRHSZI2VrWPiXwp4TZ5j6RDxTEk5hHpmUbzR/9BNxGFv9TIkU0fR4klBCTY3YLoB9T
         MqdQ==
X-Gm-Message-State: APjAAAVx0TJK8rOS8b/HZJQdlBwS1U2vxic4gUTCDWg4fpB8nk1XT7ja
        pFM+GqJEToyOwQy3D2pdkaYUEl5f1kVWV2vzqVQ3ri7rqubnZQ==
X-Google-Smtp-Source: APXvYqyhItBs9w5zODZr0oCmp+IaTC1Z/NO0hH/NdSEWcPSK/f6KgI9HN1K66931YPHV5Qhl/yQ6CX98IZowM79TTu0=
X-Received: by 2002:a17:906:4a10:: with SMTP id w16mr4910914eju.299.1562352755927;
 Fri, 05 Jul 2019 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABUeae_90xG7avh1yt2_X78pmpYUvLtXAZ2Kd9A=FpcEayvi-Q@mail.gmail.com>
 <20190705162544.gckigv4cbr4k6zpz@tb-raspi4>
In-Reply-To: <20190705162544.gckigv4cbr4k6zpz@tb-raspi4>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 5 Jul 2019 20:52:09 +0200
Message-ID: <CABUeae-kmc7WV1iv5e1wY+BPMrpXpAoJY0H3B-iQ9D2yyg_hMg@mail.gmail.com>
Subject: Re: Handling text files encoded in little-endian UTF-16 with BOM
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Jul 2019 at 18:25, Torsten B=C3=B6gershausen <tboegi@web.de> wrot=
e:
> On Fri, Jul 05, 2019 at 01:35:13PM +0200, Mateusz Loskot wrote:
> >
> > Using git version 2.22.0.windows.1
> >
> > I have a repository with number of .txt files encoded in
> > little-endian UTF-16 with BOM.
> >
> > What are the best practice and recommended configuration to
> > manage such files with Git to avoid unexpected re-encoding to
> > UTF-8 or others?
> >
> > Currently, there is .gitattriuts with entries like
> >
> >    resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM -text
> >
> > Despite that some of team members have noticed that the files
> > occacionally get re-encoded to UTF-8. It is unknow what are
> > actual steps leading to that. BTW, there a few Git clients
> > in use: git in Git Bash, VSCode, Fork.
>
> If possible, I don't want to comment on this kind of
> "sometimes something happens something on someones computer" thing.

Perfectly understood.

> A little bit more information could be helpful.

If there was more, I'd have provided.

> > What bothers me in the .gitattributes is this `-text` attribute.
> >
> > Is the use of `working-tree-encoding` and `-text` together a
> > valid combination at all?
>
> Yes, it means that the content re-encoded between the repo and the workin=
g tree,
> (that is what you want)
> And the "-text" means "leave the line endings" (LF or CRLF) as is, don't =
convert them.

That's quite a useful insight. I understood "-text" means content is
not a text, but binary.

> In that sense you can call that a legal combination, but may be not a rec=
ommended one.

Right.

> > The documentation at https://git-scm.com/docs/gitattributes
> > does not seem to touch on that.
> >
> > I'll appreciate any suggestions on those UTF-16LE-BOM files.
> >
>
> My suggestion would be to use the "text" attribute:
>   resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text
>
> And depending on your application: Do the resource files need a special l=
ine ending ?

I need CRLF.

> The use either
>   resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text eol=3DLF
> or
>   resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text eol=3DCRLF

This is very helpful. Thanks!

--=20
Mateusz Loskot, http://mateusz.loskot.net
