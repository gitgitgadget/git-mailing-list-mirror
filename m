Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD9DC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D392221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BKE0uZPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHFUYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:24:19 -0400
Received: from mout.web.de ([212.227.17.11]:51369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596745456;
        bh=C2vroHKYyGan04NivBx7qa8GgunvGcyPrXuGZgmeLiQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BKE0uZPrJLnFCBm3vetjiQgP1HeLHLjRJWhhXDkGoOQ/tOL+4AN8hu7b7su05+BxP
         1U5jqKufWp75MSl3ZWQhJGoGJorUyPpINYIhPenigxBOSUzdjK/uIWK55S+KyIsh0j
         uWWrS7oP/VVSs5c8aAcBQB6eOtTOCulVP/YTh6tI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYX0-1kft8c372Q-00gZFx; Thu, 06
 Aug 2020 22:24:16 +0200
Subject: Re: git bug
To:     PANEL Christian <ch.panel@free.fr>, git@vger.kernel.org
References: <1596725319.6764.7.camel@free.fr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5387a5b7-4551-53a0-abdb-e26cc2702536@web.de>
Date:   Thu, 6 Aug 2020 22:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596725319.6764.7.camel@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uTM8+j69i+ZI/MU9cuFJVMue2sWc2RoojWjDsQaUc4+sFtMyTAM
 Tb79a79RE8y94UVsk4jUSFQLLhD8PsUJmvzEfpPUKGLShraKv5mq46mhgGm94aheT2qOarW
 /0rsVALLOe4P6G18ek0HxlUIEeX/MC5rmLv9E6WQA4QbHp3QzW1b6mB3mrJwKre2k8kn5pF
 YEvbV0Dg7VCdYQCI8bWgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQLAKUHWx1w=:63d23BSTtfpx6AqKXvCM/k
 5VDAFHal/oXqrS0PPwEHrHgSbkmqWR6e3oAt3SWdI0qChHmxJfAw8DQITRUXtTt4qk6asl4X9
 uCFOKVS2v4N9GEEj/CC42MKUiTxKseKpk2exGuYSzpvxARLHRv9QXW6T3XwK+jmbhK5VKxvs2
 Plp+15mgRAb3I/bb8A1cuVvtp5cMvlA9P/EfENvC3+yjcyjBire6n1a4xfeeM4q+9CnrIt/oG
 Hk4l2SfAankshxS1AMIjqjyVsisLM5UYmzhnNvo3A8mwP6CPJmlnA8puCQPQwtbjSrhbTg5Vr
 TMamB8A/kcVL2hW/+1rpo6zB2N3ipfyof0YKQz8N/nMVdKDDq+QZ9enun6Iciu39Dr0APVrlB
 RfxLbIdYIaRW8O3cHM41IB/J2alq0NMyz++lZG6bH7KmBuMsDmzVmaQvO3m7p6n90fP6stpJc
 ZsFsyNjw6H9VxzUE3ZAzLbW2l60g9t8GcywfA9NY2/BcD0Hi0ApIkFWegJV/lYNda3a+zwz0/
 FWXgeg87MXwo9rMU9C5f+I+IrVB39c8mkEL1/4XFM8DnKyNo64mJ0rx6jTPBw7twADtoRnbN4
 U05mykAtP6iZZy1W5HiSH1sk/iYqKYlMGQY5K8z9UOCExjX2wbn2lcKDnTIFiFC4c1DCZTVwi
 4UywaYmU5GMvneHxk6+uPN4Sy9gh2WD0VCitg2IL28PwWaoJD4kBtcJhoYbduaCi666DwYS2O
 y7qNGFOZoj/Hytjq9a28RumhpFnbXxwx6TCgWzMkNcjI1T+bjXcyIjnRan5EcAHQarBR505OX
 dC8Zx8LNqI0rWpdGQgvnGarVs0kk3KTmOvt3v5EAYHrvwRiJDIeF6iESQE+3midlTXZEjkemI
 j5bMkUrh3EcM0+ZfYpruhDkDYYhVsetzem8yYozi49gbSKU1IdHBmiXGYtIkkyLhe10DyuVta
 IaMlIQlKJsMCNQKLXCGPv/ccEmued4MRO+tl/QsLa9vHUGHQwCFYJIKqORqp6mE3ynRPXzILT
 mso22lnTGlfJHLXrP/4bKyX/W6ICXAtjluycSoKaxiUehErbf9hXf4T5I+rvgBxaP0pDqo1uo
 bXOYSKfcxgd8kzpkrskDex0PxCaWBRZ2y9+AR8Usrd65/d94HSTVJLH1WVGhKoi3puFUVniJd
 Mp/HTqYPmcec7I19k7mVJDenNoF4045ZBgSqCpXtOkxFiQ2gTzc7CXv46NmxT+ZuRYFf3vXkJ
 nCleDIhu433K2YHOz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.08.20 um 16:48 schrieb PANEL Christian:
> someting is not logical in the behaviour of git :
>
> suppose I have a project and a file in it I don't want to include initia=
lly in.
> so I put this file name in .gitignore
> now all is OK when I write "git status" : the file is ignored.

Like this, right?

  $ git init a
  Initialized empty Git repository in /tmp/a/.git/
  $ cd a
  $ echo ignore for now >file
  $ echo file >.gitignore
  $ git add .gitignore
  $ git commit -m initial
  [master (root-commit) 2df5d68] initial
   1 file changed, 1 insertion(+)
   create mode 100644 .gitignore
  $ git status
  On branch master
  nothing to commit, working tree clean

> but later I want this one be a part of my project.
> I delete in .gitignore the line that named this file.
> but now a "git status" command ignore always this file.
>
> what is wrong ?
> did I missed something ?

This seems to work as expected for me (continued from above):

  $ >.gitignore
  $ git status
  On branch master
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
  	modified:   .gitignore

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
  	file

  no changes added to commit (use "git add" and/or "git commit -a")

So "file" is no longer ignored.  Committing the .gitignore change
doesn't change that:

  $ git add .gitignore
  $ git commit -m 2nd
  [master d4c95a1] 2nd
   1 file changed, 1 deletion(-)
  $ git status
  On branch master
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
  	file

  nothing added to commit but untracked files present (use "git add" to tr=
ack)

Which steps did you take to arrive at a different result?

Ren=C3=A9
