Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A7E1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 06:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBHGsg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 01:48:36 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45498 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfBHGsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 01:48:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id x28so1481954vsh.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 22:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vung/EVA6by4WntMvDpt0bWyQAJrwhicqjDYmiTrXJo=;
        b=QsB71a8mtrbtq4Dwqrxvrwe8F8+qpcgDGSoTSzVfSyemtHjN4PIVpvKgpE+QW5tqMG
         UNtd5XrS2eKjy0bokkQovJNdbILneSbemNuU2VCx+ANvJR/HJJ4DKWGzU/dWqN2cXtUt
         eFCkgxNis3KKuQvdW9u35SqNA2YDJyiCuJcMfVm5d42tG5djqh83yyY0KUNQZx24X5eB
         7PUKziDMxj5FIjdvxCSIExKP3unW79Car2FQMNu86W5cAR30W/JWyeqhtC88EhI/qYfA
         NpskTZWv3IDkntva0xXNAW0i+w5icxBovOfFA2SthrreMPiBaI53thy844F3+tnovRNV
         3K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vung/EVA6by4WntMvDpt0bWyQAJrwhicqjDYmiTrXJo=;
        b=oKbLgvm/CS6jjhsmiMsv7maxYCWNMW3vBveJNBLkWyI/0SSvqi88IU47vg0yO3V8sX
         yPe4HDMmpzh/Ok4Sy2wwon350gFXEWiNbU7M8i1nqYQvZDgVc6bkrAz8+Q3D0rRfVj++
         zr+jusue5Bj0TjXbhNuVygAuB3PsXRz2G231GqXlS3cI9FZaA5IQjOr9UW300PTYimJF
         tB/RJ06dEAATxsrM3da4Owp76ZHuoqMrUxoy+LH2dr4AV0NbnlWSuN1iVQEV27jnhGzg
         WhUBEU1CAiJNQgWw1BmEi4m+9phiIY6tbyAwWgB9c23ugOaZ+TjFfROCX4SK2ol0dC7y
         R3UQ==
X-Gm-Message-State: AHQUAuY2FWbOTgBSfcfjF0sNPPcuxryuhooDDibcdITBN58/tSzq3M/7
        A0/1jNG51MA2ofjUqiUNmk5m7DgH8JvQLvWuwhw=
X-Google-Smtp-Source: AHgI3IYRjWo1sjklTUjHK9scWX6qMkSaX5zVhQweBjReDfAoYGi60z7ycnPqc9dLDpw6w8K3azHTlrTcnLuO3WYYRcQ=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr8141223vsi.136.1549608513856;
 Thu, 07 Feb 2019 22:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20190204200754.16413-1-newren@gmail.com> <20190208011247.21021-1-newren@gmail.com>
 <20190208011247.21021-3-newren@gmail.com> <xmqq4l9ench8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l9ench8.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 22:48:22 -0800
Message-ID: <CABPp-BHHjvC7tv27dBaUNuqXYdmhpbQXLadXTMFWR8GgKH_ngg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] squash! log,diff-tree: add --combined-all-paths option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 8:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > +     for (i = 0; i < num_parent; i++) {
> > +             switch (elem->parent[i].status) {
> > +             case DIFF_STATUS_COPIED:
> > +                     dump_quoted_path("copy from ", "",
> > +                                      elem->parent[i].path.buf,
> > +                                      line_prefix, c_meta, c_reset);
> > +                     break;
> > +             case DIFF_STATUS_RENAMED:
> > +                     dump_quoted_path("rename from ", "",
> > +                                      elem->parent[i].path.buf,
> > +                                      line_prefix, c_meta, c_reset);
> > +                     break;
> > +             }
> > +     }
>
> The explanation for this addition was that it is hard to tell from
> which side a rename happened in the three-dash lines alone:
>
>     --- a/packages/search/ete/src/test/resources/test-suite.yml
>     --- a/packages/search/src/geb/resources/test-suite.yml
>     +++ b/packages/search/ete/src/test/resources/test-suite.yml
>
> and your hope was that adding:
>
>     rename from packages/search/src/geb/resources/test-suite.yml
>
> would help especially when the path is overly long.
>
> But I am not sure if that single "rename from" is all that helpful.
> You cannot tell relative to which parent the rename happened without
> going back to the three-dash lines.  A loop that iterates over all
> parents but shows only a line for a parent that actually had copy or
> rename loses "the line is talking about the change from this parent"
> which is a fairly important piece of information, doesn't it?
>
> If we attempt to clarify it by adding some more information on the
> line, e.g.
>
>     rename relative to parent #1 from packages/search/src/geb/...
>
> the line gets even longer, and going back to look at
>
>     --- a/packages/search/src/geb/resources/test-suite.yml
>
> may turn out to be an easier way to learn that information.
> So,... I dunno.

Yeah, fair enough.  I'll drop the patch.
