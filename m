Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8538E1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeJMBxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:53:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36049 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeJMBxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:53:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so11832326otg.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7n5Jkj4Vtj7WFbE6flotRcTfBe4YjYelVef5+vdFwSM=;
        b=icPleO2aKSWL/AHEedaaj7cLKhcYeQHMOct4r6/auVOAC4ZNrz0903aUhdIZ4b0HXH
         aI+MuC0rOTzwu5/KSnGO/Mjcm/+Sj5eXQTRBKjkcTeUMokDbPIOGGBbN6bQBocobZRVe
         3XvAQ7+L4pgTnWoxXyFWHNHxguSo1z0Dnloxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7n5Jkj4Vtj7WFbE6flotRcTfBe4YjYelVef5+vdFwSM=;
        b=uIQ3ynEJtbhRk5pFD1HFzquuy54ucwwS2LNAg2PkDL9gvCVix/BWRt/jkifUM5xTRC
         KSXwoWzmHhomOlqpMC9rpvR1uqxlFWwLEixVCn7YlrW1R/EZbzgUoRmc59ekb94GLau+
         gDSdtf7mjV0SbXzyJsXDZfa7YDrtGfZkWcVfG0w8cqH9Rym5vVpYuZoMKNrtUdPsu656
         PFADnNO4J+r6/t9rT+fa/mPk/TA3d4fxuO45RsoAggYXWLz2Qn3m+kK3zDHiF+8ejzGz
         1XKmG1KsQJSC0bK5VWwu2FFFJfx526ccf9Rdcly4gIqEfTpUJPjl/DntxWwdpIKN1/l5
         igdg==
X-Gm-Message-State: ABuFfohh4fhJPzZOpPdqipk31TDkxZbgSUleWMcU0vGSfmFgji9d791I
        yR1tsqfjYOG/yfwIKCJ1JOm1IDO8nNI2iLqV/Y9EIw==
X-Google-Smtp-Source: ACcGV63bo/R4Zod9L5z3J9g3IW5vRzigqMJQgNp67uZzE8Fvejriv2oOviIV6sZYn7tuPk6EuvKd0Rf8b4z+napH1d8=
X-Received: by 2002:a9d:5148:: with SMTP id u8mr4178364oti.5.1539368358174;
 Fri, 12 Oct 2018 11:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181012052833.6945-1-luke@diamand.org> <20181012052833.6945-3-luke@diamand.org>
 <xmqq7einb7ob.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7einb7ob.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 12 Oct 2018 19:19:06 +0100
Message-ID: <CAE5ih7_sT8aP7n6h0moEj=6JjRAGJ+AXUCDkTFoJmnbE_Nh1mA@mail.gmail.com>
Subject: Re: [PATCHv1 2/3] git-p4: unshelve into refs/remotes/p4-unshelved,
 not refs/remotes/p4/unshelved
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Oct 2018 at 14:45, Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
>
> > The branch detection code looks for branches under refs/remotes/p4/...
> > and can end up getting confused if there are unshelved changes in
> > there as well. This happens in the function p4BranchesInGit().
> >
> > Instead, put the unshelved changes into refs/remotes/p4-unshelved/<N>.
>
> I am not a p4 user (and not a git-p4 user), so it is a bit hard for
> me to assess if this is a backward incompatibile change and if so
> how serious potential breakage to existing users would be.

I don't think it's a particularly serious breakage - it reports the
branch it unshelves to, so it should be fairly obvious.

However, maybe it would make sense to pull this into a separate commit
to make it more obvious? I should have thought of that before
submitting.

>
> >
> > -If the target branch in refs/remotes/p4/unshelved already exists, the old one will
> > +If the target branch in refs/remotes/p4-unshelved already exists, the old one will
> >  be renamed.
> >
> >  ----
> >  $ git p4 sync
> >  $ git p4 unshelve 12345
> > -$ git show refs/remotes/p4/unshelved/12345
> > +$ git show p4/unshelved/12345
>
> Isn't this "p4-unshelved/12345" now?

Yes, I think another reason to pull into a separate commit.

Luke

>
