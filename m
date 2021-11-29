Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C409C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 11:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhK2L6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbhK2L4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 06:56:15 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD7C07E5C1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:57:42 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id y5so33029443ual.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eoiDKNxQ63aUd6qWjLXaUUlffPDIKllbye6TQ2rURLc=;
        b=RETYZwwVOIxZSEFmQHYPugzuwWeg0al+/9M308uo51qyCCZSHNHL/8NoB2H67xzqPY
         PMvhmKIERX8zdHNVAqrPIZpL8Xw5OJh3LKsi4ET+gzAPgQZ7uLqGnAo8xT9qbsuY8w8K
         jcht6cj46uIHB2tuuU4qma/IaeM8yQ6N8JVG50MxLuSMZn1uxIBT72Aob0eIkaeYUBOB
         zoxTTLr4cSrEqmHaDithARj75fO7jeP17iVLcubwIZyDv045IKbFmSN0wJCtRL6z7rC9
         1QsDRCzHC7qzyRcdU+dT//t2qqHnfFkgWH2BksJqwXftqcthqNNE5JBSCF/lgk7x7RyQ
         pbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eoiDKNxQ63aUd6qWjLXaUUlffPDIKllbye6TQ2rURLc=;
        b=3g4lH7e7BAygWkwYydpZxsQWJqs3mA/2Lct7C/o3/gq3uHs45QpDtXItdNpeBKrMPM
         jyl4OjwkOeMnNEEHJwmaqryHDRgf5CRBIdZFNWiUKqeNApoe4dCema9KbCOK3FJyVQ7R
         owKc29p7l5HJnKuz6iDymSz1QBOOU2m7OF8jdevqOWgUi188pby+g+mmuqLe7+xlBZPx
         3hYOEi7EhgsLtMKqnqCOgIHHwpeBz7bO7+DLP5bUMueGzKeNO4ade9pdn+p8zAGPmCuo
         T4ngnvGRUsE727dw+YkUJ3sX6gQGMX3liiULMR7T4wHSnO2RUJ5ZdYE0XViTbjc4N/0U
         /lcg==
X-Gm-Message-State: AOAM530J2r2p3ly55KSjm9wVA05Tp0oUBaXsy7WWvRVd26Odxu0Zms2C
        5mBpNbHcfMtJz6EILZj9i+dgWuV9Yqhad+Fb+4LNPQ==
X-Google-Smtp-Source: ABdhPJyKLrX7nUeKvJm53EUDnZzB7HHQkUC3p/E5wsPGVRB7Ca6XhS3vKUyFZrNjxSAsGHZeZ69/IpJfflWpDn9GNZc=
X-Received: by 2002:a67:c40c:: with SMTP id c12mr31538783vsk.16.1638183461922;
 Mon, 29 Nov 2021 02:57:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com> <xmqq35nj8ix6.fsf@gitster.g>
In-Reply-To: <xmqq35nj8ix6.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 29 Nov 2021 11:57:28 +0100
Message-ID: <CAFQ2z_OTc41g9YgA70W8NCWKWRaRs41EJVZFihmTiPnZFOiEEw@mail.gmail.com>
Subject: Re: [PATCH] t1404: mark directory/file conflict tests with REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:

> And presumably, without REFFILES prerequisite, these operations
> would be supported?  E.g. we can have 'main' branch, with 'main/1',
> 'main/2',... refs, at the same time, with reftable?  That would be
> quite interesting.

The storage format allows D/F conflicts, but transactions are checked
for not creating new D/F conflicts (depending on
the value of reftable_write_options.skip_name_check).

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
