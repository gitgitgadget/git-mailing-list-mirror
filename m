Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0AC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBJAKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBJAKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 19:10:10 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5DF5A90E
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 16:10:09 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16cc1e43244so488215fac.12
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 16:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dOEUNwnQ+q4dxMNFAacU3hSrG+oknBz/icOdNwPPB0M=;
        b=WunQv7udkfGRI9pWYaUa4/xv7IIzrwIwkysHA4hmiKLIvlIm0apjZkmQGejAgGeMLV
         yPw1eHnt43hiAn6OQTYLdI96F1os3W2uFDuH0nzn6duEhwrL9dOQuPNrPn7A5o/1Ng/s
         YiYmesMKvYW/0IXqxmDxZ6Qb2YOWHr8Ateh6mmIxHfV9X5sJp9+97KGUf03zS9LHZiiO
         5/8tBFUxIeH98zLA6Zbgy72YvwlGd6EqD6otuHj6P/+ByOrAtcmaAp560we2LXqFcMoG
         pyUWh3gMA9uNeHDjcxH7xJZ3fIk8BmC08X6OSYwjyk8ykVlwUlADltxNywg6zWyDPAx7
         qfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOEUNwnQ+q4dxMNFAacU3hSrG+oknBz/icOdNwPPB0M=;
        b=WHZt08d8YNWu3kYr0AMV+jZrKfBd+YKsqZub1g9NJ2v7ynZr2nQWUUqZ/SViHviDoM
         biInyc/mxYX98NgaLfbmA/WrWBZvheAr6FgJtt09FrenY2dolgehoD4xHRyRcYMgHAXX
         lqKNqSQACm7g/1BxU1ZEKMGJr5FucM+iCV/Qscx9SDcDZ9vB2CoFDkyZ3lrY/nN0ob4f
         4jVisxJc5oJRh4wcpli5tEoY3JIQ/gTsiHxe4vqzfThS8MUTYXzc/WUkxEQU72wxnGkD
         YHvuvx8yByi618RgZfUhsy58fxlshIlnPj417/vm3cg5vPtRnlo34rmRgAjSZDZ701i0
         Phyg==
X-Gm-Message-State: AO0yUKXptLZ+vFH71GzbaUqtgNq9YKj7Gct2TpWnEpS7zh4Z11wRTM56
        aWbo0Kd/hrGiStn9D5sFilf37UEEndODkm1ky0mikRoOK6M=
X-Google-Smtp-Source: AK7set9TL3fsC8kI1S6lIivcsPRhzAd2CjDizerxroktPPoA9IxNxA6xROI4Yi+1RlFKZG0AMW4Hq9zkmBkP2k6LCxs=
X-Received: by 2002:a05:6870:9688:b0:163:4ba0:fc7c with SMTP id
 o8-20020a056870968800b001634ba0fc7cmr1546402oaq.244.1675987808565; Thu, 09
 Feb 2023 16:10:08 -0800 (PST)
MIME-Version: 1.0
References: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
 <Y+V0Mu/v/FO5318/@tapette.crustytoothpaste.net>
In-Reply-To: <Y+V0Mu/v/FO5318/@tapette.crustytoothpaste.net>
From:   Michael Rienstra <mrienstra@gmail.com>
Date:   Thu, 9 Feb 2023 16:09:52 -0800
Message-ID: <CABBAUFKv64xhJtwRk9kMWBov=nV_QzvR-jJqhJxKQyej3pcYCQ@mail.gmail.com>
Subject: Re: Markdown release notes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> these files are actually in AsciiDoc

Ah, thanks, they looked like some kind of structured text format.
GitHub will format them if the extension is .adoc (supposedly .ad &
.asciidoc work as well), here's a POC of that, with AsciiDoc links
added, to allow easy navigation to v2.30.7 release notes & out to CVEs
from there:
https://github.com/mrienstra/git/blob/markdown-release-notes-poc/Documentation/RelNotes/2.39.1.adoc

Docs for AsciiDoc link & URL macros:
https://docs.asciidoctor.org/asciidoc/latest/macros/link-macro/
https://docs.asciidoctor.org/asciidoc/latest/macros/url-macro/

> This is tricky because we'd want to link to them on git-scm.com, since
> we don't distribute solely on GitHub, and I don't know if those are
> available there.

Perhaps there could be two identical files, the existing ones with
.txt suffixes, and copies with .adoc suffixes -- the latter could be
linked to from git-scm.com, to show formatted AsciiDoc, instead of raw
AsciiDoc. Assuming adding relative link macros & URL macros won't
break any other consumers of the release notes.

> If you asked (or submitted a pull request) at
> https://github.com/git/git-scm.com to make sure they're distributed as
> part of the site, then perhaps Junio would be willing to insert a link
> or two when we have another security release.

Unless I'm mistaken: Right now, release notes are only in the
`git/git` repo, which is what git-scm.com links to. They are not
stored in the `git/git-scm` repo.

Sounds like you're suggesting either (A) migrating them to the
`git/git-scm` repo, (B) having them in both repos, or (C) displaying
them on git-scm.com, but the underlying files would be retrieved from
the `git/git` repo as part of the build pipeline for git-scm.com (so
to speak). "C" sounds like the cleanest path forward, as it wouldn't
involve any duplication or breakage.


On Thu, Feb 9, 2023 at 2:31 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-02-09 at 22:15:59, Michael Rienstra wrote:
> > Release notes are currently plain text files -- and that option should
> > surely remain for backwards compatibility -- but it would be nice to
> > have them in a format that facilitates cross-linking.
>
> Despite the .txt extension, these files are actually in AsciiDoc, which
> is our preferred text format, just like the documentation.  AsciiDoc
> tends to work much better than Markdown for things like manual pages and
> other non-HTML forms of documentation, of which we distribute several.
>
> > For example, https://git-scm.com/ currently shows:
> >
> > > Latest source Release
> > > 2.39.1
> > > Release Notes (2022-12-13)
> >
> >
> > Which links to:
> >
> > > Git v2.39.1 Release Notes
> > > =========================
> > >
> > >
> > > This release merges the security fix that appears in v2.30.7; see
> > >
> > > the release notes for that version for details.
> >
> > -- https://raw.github.com/git/git/master/Documentation/RelNotes/2.39.1.txt
> >
> > Navigating to the release notes for v2.30.7 is not convenient. Some
> > users will simply modify the URL, which will do the trick. Others may
> > find their way to
> > https://github.com/git/git/tree/master/Documentation/RelNotes & search
> > for "2.39.1", which also works, but isn't particularly friendly.
>
> This is tricky because we'd want to link to them on git-scm.com, since
> we don't distribute solely on GitHub, and I don't know if those are
> available there.
>
> If you asked (or submitted a pull request) at
> https://github.com/git/git-scm.com to make sure they're distributed as
> part of the site, then perhaps Junio would be willing to insert a link
> or two when we have another security release.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
