Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A595D1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 03:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeHXGfE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 02:35:04 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39211 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeHXGfE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 02:35:04 -0400
Received: by mail-ed1-f51.google.com with SMTP id h4-v6so4887309edi.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ts9yVBLU5DIZXfCeUOcCJ3UccInw7X48AmY3llkAXTE=;
        b=nDZvDhIoJqLQWXu4YU3fFvB+NqbePz1ilowB7MfUMLaiG4zk0ADwb35SyzkZxGTOr3
         3O0TB9ejtVBN4XofM9bGlkFZZ9FHP3Fdlbp4Qlfh/uXgFelX74gFSyQglbIhrthpggjS
         9IPUakQyqyOiH+pN1X0gsEsJah3cbqWyBrd32zMlJ7p7jnizGGpfa1a1giNoA0yrV1De
         2DMLtUUqHmwF6cIRXUvKgVV+0bBdPDQaga1rdMeVWSJvzJwucc6OZT5Rftd2R0tDba6+
         sRa30/BM+Z1r4taPfibCUc61liTqkeazQ5ArAa/2dhOcRKGdrxZDpqsbYsD8JQjm2sRi
         vPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ts9yVBLU5DIZXfCeUOcCJ3UccInw7X48AmY3llkAXTE=;
        b=SvAgqTytkSZPITcxisBJScjfqF6cn+eKTH7eO+51mMeTzBuTtWZjzXC4FK1l3iO6EC
         NDSvNRk8kYZjCq3/PLQtN6KjaNZC0wcrWTn1oXDYIxiuVZYY6ZSEOMx8RyAMApnPeoty
         yCPQYZqYDHbVJmWavNEDneTzmmsg/0b/YgIMjgcdx3iKxHL85CuKEj/jp5+NMfW6pjdW
         S9T8C3HDr8/DCMp78jyMfutBCd+1saM97rNjt7eLLyUu3kXgQNBIXeTWN7IxMb2+6bEO
         iZceqoHYSTbKEKdKZMGyKgdIBZajbeK5AOTHQpxpoa2vo8KsFK/hcW335S4uN8z2P1JX
         1VnA==
X-Gm-Message-State: APzg51APVBy9PXw5RQe1n4T/ZwStYpBpPFviQiX6FLjdgpHxX7vgp3JD
        hxq22ZPdYJ6TwoCS9zukxW1qULb/Y0cCpPGyv98=
X-Google-Smtp-Source: ANB0VdaQay266L4cjI8sOQgcBCR1TNb0/tzk+fvimafJpic/TqXDc/7nzBbNrlePn8js7z9wAPe6Rbu/qIEhgKUdzFA=
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr231821edb.236.1535079747751;
 Thu, 23 Aug 2018 20:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
 <20180823021156.GD92374@aiede.svl.corp.google.com> <20180823021547.GE92374@aiede.svl.corp.google.com>
 <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com> <xmqqr2ipje5i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2ipje5i.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Aug 2018 20:02:16 -0700
Message-ID: <CA+P7+xq3m8PXo9wYu1L7p4uG4hf-i=uwQdh+e=0QJXG1cBi04A@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 9:28 AM Junio C Hamano <gitster@pobox.com> wrote:
> I think the above example forgets "-a" on the final "git commit"
> step.  With it added, I can understand the concern (and I am sure
> you would, too).
>
> The user is trying to add everything done in the working tree, and
> "commit -a" would catch all changes to paths that were already
> tracked, but a separate "add" is necessary for newly created paths.
> But adding a new path means the index no longer matches HEAD, and
> the "commit -a" at the final step sweeps the changes to already
> tracked paths---failing that because there "already is something
> staged" will break the workflow.

Right. I think this would need to be able to understand the case of
"different only by new files".

Thanks,
Jake
