Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1341F461
	for <e@80x24.org>; Tue, 14 May 2019 10:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfENKtb (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 06:49:31 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:36088 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENKtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 06:49:31 -0400
Received: by mail-io1-f42.google.com with SMTP id e19so12639106iob.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9s2B5Zn8yK84vzUegfQeQW3fzysvBJusmnJxx4ayeE8=;
        b=GLv/nf3R2RR0JlwbUuR9a2bFS7jifHZkAXMtCaM6PJ4o3esrEyOx1XuknjO+Ov8Hcg
         VyK8V0TFbcLl7Zg/BsgNUC00dnaWG9rDuMuTrz2TffQ74JPYq2BwqMcrufXN5Euygiuo
         Bxg089hwGnnEdN/KxZT450MnqQC4+bVFSVgeDFkB/n2FQ7TKdH+Pr0itgsFgiph9zU7T
         4wiV16v6EJ6EmzIealLVVMUFvtzaCg2Oi9QCvAjiPKqOA6I5MugsvZ3UVG6Ju1OczuJT
         3V7JlviSnaHyM/gYceQc026wc5sDFwI9DHnrrmXCtN6IJY9AdC8Tftit2f15PWvDCy39
         pSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9s2B5Zn8yK84vzUegfQeQW3fzysvBJusmnJxx4ayeE8=;
        b=fRiCsuWrhQJYacJU9/l4iuH4lUouYgq7kKnObIwprMIpMvLN9Szq//Pa77/qoayMR1
         nGBYaD3lsEQf3N5dalCuBXXbWXcUBkoAlTaxNOqT2TjkQ9wXxWlkPfHXKMaM6joraKO4
         jg7TNV+yPWuSsZwpIE1ffPGCH3ZQLBkZcytUKtMsiast7VO9f3rS6wsEsDAqwTLn6kfv
         LkePfHi/V6D2kqxhseuKTJMCtDdLd1rHXoCKTcX+j5hw9L/Z218U6at82ujJc1ESE7hY
         YInYb/P3YsVaAyau79Dv6fO5Nm0DRQTD8I0MGl+mmatvJewjgkyCo01Bdt9xtGFh91M3
         iP3A==
X-Gm-Message-State: APjAAAVrOPioHASW0ibjNpKU8SnEHkVj0cED8CCoaic1NVMiI7j9+dP2
        TP59WSDuZ5KyCd2rjCrNe3N25pt6H+OWlcxAWwA=
X-Google-Smtp-Source: APXvYqwmAWJyQYLdZALcuRyi/3KChpZTOnR9nwsCgYQ/hLngdFiHIOW8f2JZZFdDcFPbAlLY1+FJJenKyCv6VeqX2w0=
X-Received: by 2002:a6b:8e84:: with SMTP id q126mr743217iod.118.1557830969912;
 Tue, 14 May 2019 03:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8Bew3i6AL_XWfhLhCvdSFYVCGoEQepi9KLmSDPVmDu5Zg@mail.gmail.com>
 <xmqq8sv99vac.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sv99vac.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 17:49:03 +0700
Message-ID: <CACsJy8DoxHoi0H3R91ovqDPjk0tN3Rr8fQOjaLt_2P9O3n9b_g@mail.gmail.com>
Subject: Re: Is git-checkout's restoring d/f conflict really sane?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > $ echo data > one
> > $ git add one
> > $ rm one
> > $ mkdir one
> > $ echo two > one/two
> > $ echo three > one/three
> > $ git checkout one
> > $ ls -l one
> > -rw-r--r-- 1 pclouds pclouds 5 May 14 16:36 one
> >
> > Replacing a file is one thing. In this case we're deleting a directory
> > and unknown number of files inside (in this case 'two' and 'three').
> > Is this really a good thing to do?
> >
> > If it's not but too late to do anything about git-checkout, could
> > git-restore do something better (and exactly what)?
>
> The user said "I do not want whatever I have under name 'one' in the
> working tree, and I want what I have as 'one' in the index instead",
> so I tend to think that failing the request would be a disservice.

Except that sometimes the user has those "oops that's not what I
meant" moments (and I think it's more often "I want to restore _file_
'one'"). One tricky thing in this situation is (to me) one/two and
one/three are untracked and we generally do not touch them unless
requested.

Technically 'one' is still tracked (even if it's a directory) so what
we're doing is right. I'm just not sure if there's some big surprise
factor here. And whether it's better to pause and double check with
the user before deleting everything.

> I suspect that this will become even more right thing to do, in the
> new world where the no-overlay mode becomes the default.  Unlike
> "checkout HEAD ."  that only adds to the set of paths in the working
> tree, "restore HEAD ." will remove what's in the working tree and in
> the index but not in the HEAD, no?

Yes. It makes me really want 'git restore --diff [--stat]' just to
show what's going to be restored. A careful user may see something
unexpected and examine more before really doing 'git restore'.
-- 
Duy
