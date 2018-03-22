Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC691FAE2
	for <e@80x24.org>; Thu, 22 Mar 2018 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755671AbeCVO2L (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 10:28:11 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:34304 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754546AbeCVO2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 10:28:10 -0400
Received: by mail-pl0-f51.google.com with SMTP id u11-v6so5403890plq.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject:references;
        bh=oNOfgcHepuZdvJKc2bwqVbHJv3mXn6cRHSg/xknF1tc=;
        b=q1JQOVlE/eThpUI7bCG10PGfJWJ4hJArxwvh98298m/ydfQL3IRtidKuVanP+60G1Y
         DbHaPmOXvY5gu94cMKW0Zx8fCXZ31RjTq7lzfrg/Q4jY+5wq2WOm91Qb9QCDWODBw1zW
         EyBuViza6qNrUcodFnUYuTYz2wM5hzwdWEpin7EvPeexrCdHGdRNCSoqm8prWFXcrZw6
         s+1cTA0L7BClJcsdbpB+682vg7ElBrK0Vry9bkahWLDvVhCs7dlSKeIMdhq+Yi97RbG1
         Hi/Qq/jhT/soLBTIg4i2a2jIjn4c4wi/yrhBp4n+QidGb84xhTb5/p7d3ak1QYpZamc+
         Zb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject
         :references;
        bh=oNOfgcHepuZdvJKc2bwqVbHJv3mXn6cRHSg/xknF1tc=;
        b=cn8U0MeJQ5kR1XyX9IJGJO4kFX5Pw8Cf1rhGW0y6AeM+IXBSFX27oiycea1nVqosFd
         AzNijeyvoPt9O7YmGEQm9ddzsIEoeAlEL8/t8ruJDgquxeZ1v3pdwRA0+5pTldxoUMTT
         0Sp9+Q/jk8XoCH66cvSxbojpwBainqZuovCR1anro17YggqTiQK1uxK7VD+soO506Y23
         eHaHW6O4Nd0yKWX2jRvyV4U6C5avlj+d+5+32Fw6cVAOB6jC8jORLXx0injh2HxgTwxs
         h8/P5KvW+MjWGoVdHdUR7BMFb1VOO4C4FN/uMFYm6O4Sco2SA7hyqr+5jAEtoE2UnhH/
         rOyA==
X-Gm-Message-State: AElRT7GdbXMPZQQBqiCDxThkzs7pksKzzgaWn3SazMpPK1Qi9TX9uPSq
        5iUwLNHYV4MJSO5/8PxPUxM=
X-Google-Smtp-Source: AG47ELsqlRKrzu31MCa0YleJyiM/M3iSINnjXNQGMcV3p5VmU7W8jkZoyOGJWWrQUlsQkFa4NUkoBw==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr24867128plc.403.1521728889864;
        Thu, 22 Mar 2018 07:28:09 -0700 (PDT)
Received: from localhost (softbank126094241038.bbtec.net. [126.94.241.38])
        by smtp.gmail.com with ESMTPSA id q17sm11879753pgt.7.2018.03.22.07.28.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 07:28:09 -0700 (PDT)
Message-ID: <5ab3bd79.d14d650a.be5c0.8544@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <xmqqpo3xnqq4.fsf@gitster-ct.c.googlers.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Thu, 22 Mar 2018 14:26:10 +0000
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqqpo3xnqq4.fsf@gitster-ct.c.googlers.com>
        <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
        <5ab2b606.86f5620a.c0c10.41b3@mx.google.com>
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yuki Kokubun <orga.chem.job@gmail.com> writes:
> 
> >> Yuki Kokubun <orga.chem.job@gmail.com> writes:
> >> 
> >> > "git filter-branch -- --all" can be confused when refs that refer to objects
> >> > other than commits or tags exists.
> >> > Because "git rev-parse --all" that is internally used can return refs that
> >> > refer to an object other than commit or tag. But it is not considered in the
> >> > phase of updating refs.
> >> 
> >> Could you describe what the consequence of that is?  We have a ref
> >> that points directly at a blob object, or a ref that points at a tag
> >> object that points at a blob object.  The current code leaves both of
> >> these refs in "$tempdir/heads".  Then...?
> >
> > Sorry, this is my wrong.
> > I wrongly thought only refs/replace can point at a blob or tree object.
> 
> No need to be sorry.  You still need to describe what (bad things)
> happen if we do not filter out refs that do not point at committish
> in the proposed log message.  
> 
> IOW, can you elaborate and clarify your "can be confused" at the
> beginning?

I meant the confusion is abnormal messages from the output of "git filter-branch -- --all".
For example, this is an output of "git filter-branch -- --all":

Rewrite bcdbd016c77df3d5641a3cf820b2ed46ba7bf3b4 (5/5) (0 seconds passed, remaining 0 predicted)
WARNING: Ref 'refs/heads/master' is unchanged
WARNING: Ref 'refs/heads/no-newline' is unchanged
WARNING: Ref 'refs/heads/original' is unchanged
error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
fatal: ambiguous argument 'refs/replace/8a2016f3730cad8309c110f819c855403ed0a5b9^0': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
WARNING: Ref 'refs/replace/8a2016f3730cad8309c110f819c855403ed0a5b9' is unchanged
WARNING: Ref 'refs/tags/add-file' is unchanged
WARNING: Ref 'refs/tags/file' is unchanged
error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
error: object 1bf53b49c26465454e4ac377f2ed3f91bb1d6ac1 is a tree, not a commit
fatal: ambiguous argument 'refs/tags/treetag^0': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
WARNING: Ref 'refs/tags/treetag' is unchanged

You can see a lot of terrible messages such as "error" and "fatal".
But on the whole, the result of "git filter-branch -- --all" is not so abnormal.
So, this is a just problem about abonormal messages.

I think this messages should be suppressed.
How do you feel about it?
