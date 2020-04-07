Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D71C2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9246206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDGR2J convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Apr 2020 13:28:09 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37792 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgDGR2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 13:28:09 -0400
Received: by mail-qt1-f172.google.com with SMTP id n17so3323883qtv.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 10:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nvdK7qV8V6qOm6KXzpXU41m0Rf8tDLifJQVcrcgrnBU=;
        b=irftcRtf0AnB1JPl50JzHkKYrUNjUI+jQA/n8KkVnvEMZYVWwYrCSMZX6txr+Wc6gc
         e+VVLhfRSbfwr29b5hrwJkPEoZIompBhXqk/4YqUEDBDZxBQbuz6IG18XKYj9d4vGiEO
         LPxNkyI5EsppaaTg+ahbT6SjUM0rUK9ZTKc++5Y1VM5gLV8Bh6CNGb+4RkW7lEI0yO9N
         r03bUfjRT4wYi4aDNNNOZjA82ic7Bb/AvYKEGBjyyLPj+zJvCK1TRfWhRlCyY02OJxZB
         x79/isyghsVFa3YVAqDybF9S9jJKlgKuN5uZgMoUaa2eQcD2qmor7YJueax3Tg7qglpr
         yq4A==
X-Gm-Message-State: AGi0PubQM9Aeai4rnMU/szBcW+ImmR00LdKdQ7aU8rk2sPtI9tYpAjsS
        FTWSOzGqbLlvjO4Hu/hTjdn8sduj5TyJMYJl5c2t4ILqqXo=
X-Google-Smtp-Source: APiQypKoBSMUmaHwbcMbDHgc0WfCkn1Nu0G4A8QuKbSS1xqYB/XaeSYYZF9KXqLhso8FDZz0Mq4assQQpXqT6gAfHL4=
X-Received: by 2002:aed:2e07:: with SMTP id j7mr3503640qtd.40.1586280485420;
 Tue, 07 Apr 2020 10:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
In-Reply-To: <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
From:   Sami Boukortt <sami@boukortt.com>
Date:   Tue, 7 Apr 2020 19:27:54 +0200
Message-ID: <CAAb+AL-95RKhTghJX4uLxiM3dqZW6U914XBXaLcwK+gC_FezWw@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the very prompt response.

Le mar. 7 avr. 2020 à 18:54, Elijah Newren <newren@gmail.com> a écrit :
>
> On Tue, Apr 7, 2020 at 9:33 AM Sami Boukortt <sami@boukortt.com> wrote:
> >
> > Hi,
> >
> > Using git 2.26.0, I just tried using `git rebase` to strip empty
> > commits from a branch, but it leaves them as-is, even with
> > `--empty=drop`. With the “apply” backend, it removes them properly. Am
> > I holding it wrong?
> >
> > `git rebase -i` also doesn’t pre-comment them like it used to.
>
> Yes, from the manpage:
>
> """
> […]
> """

D’oh, not sure how I missed this. :) Thanks.

> To remove previously intentional commits, whether empty or not, use -i
> and remove the lines corresponding to the commits you don't want.

Sadly, that is somewhat inconvenient, as those commits are not
actually “intentional” from my viewpoint (though I understand that git
has no way of knowing this), but rather created by another tool
(git-imerge), which means that I have to check each commit
individually and risk mistakes. The old `rebase -i` behavior, where
such commits were automatically commented out, would be an acceptable
compromise, or even a comment added at the end of the commit line (so
that they are still kept if the editor is closed without changing the
rebase list). If there are plans to eventually remove the “apply”
backend, could that workaround be considered?

Alternatively, I could also use `git filter-branch` (with
`--prune-empty`), but apparently, its use is heavily discouraged.

Thanks again,
Sami
