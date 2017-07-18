Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D04620356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdGRR2j (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:28:39 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33289 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdGRR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:28:37 -0400
Received: by mail-io0-f172.google.com with SMTP id 5so16940568iow.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+oCSSX80Ft9q8run9c0rGB44/6+i+6Q1lG3/HC3LBPU=;
        b=S2MlR7LoyqXfwhFg10vGn9ZSC/IJQ4mm7zZmsieAhEbRFJ9cEr7hQaDZAfPRUtRu8l
         vzBkplAJQ53OSRahdn5R99GDnRVjmTMFs3lwAf7GhmZeBNCtA651kEZSfYFVRIaCUXH5
         jQT2fZtBaDiFneryi5Wnfi0GQZf1ON9OiSnKhAzLw0TVTasH2eMym7BjoQUl6Dybfrhi
         Nfe6xS4D5ao0JdIZOuNLw+uP+f7KPBYIzSWCusfXFjEqq1//OOJHiycUR5NIaGJQQ9+6
         tZp/jjqxWG8DTbFVyqOBfPjm5NTpmBjsvBkyM/Y9d+yILYUvu9GIzvXmeLU8E8kB9Bke
         ljgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+oCSSX80Ft9q8run9c0rGB44/6+i+6Q1lG3/HC3LBPU=;
        b=bRBrIfg9eZyuggLJtCgPkt6Np2pTZ61uYjhgcc8zsuWvzgJOkDITty2g6AL4V38Wr+
         5Hq8hZilAezbD8NPDcXFyppcA4zqbKt/932eZaKgA2WI4QOM9p6mMDB8uiN02gD794dr
         FPxf8o3Jiw1Y1oha+NKeuTcoPbe2nphX6HuVFkbup+RuK60IYb26U+/xWcK5rmxwh5ZT
         PTLPNgI11L/4RgwAjLQ3PjyRK+WGqA5xMFXL1gh1JRqMxyGzTdG1LtaFCckjObbNgwnO
         8+lDt+CdVIuifgsPpWonVeg+pYab6hX9S9Dq8144Va0iaHfsgslUKNppQ4KY/mKKFCWp
         YY6Q==
X-Gm-Message-State: AIVw112X3nSQHYYhtQZdN9+k3uBEP6/bYqB29kvdVfFEfpCG8lEpXUPa
        er6vKLTiJNuo3rg8bSR3nJSGBafalBfT
X-Received: by 10.107.12.166 with SMTP id 38mr2583840iom.151.1500398916844;
 Tue, 18 Jul 2017 10:28:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.29.78 with HTTP; Tue, 18 Jul 2017 10:28:36 -0700 (PDT)
From:   Gilbert Catipon <gcatipon@gmail.com>
Date:   Tue, 18 Jul 2017 10:28:36 -0700
Message-ID: <CABdvCd2ntSJT_9G2NnTHLeLA8zRStyECPaMSfifW_5JYzye4Qw@mail.gmail.com>
Subject: git command unrecognized argument issue?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed a surprise inconsistency when using the git command. Using
git version 2.7.4 and trying most of the commands listed by git =E2=80=93he=
lp
usually output error: and usage text when passing an invalid argument.

The exception was the commands log and show. Looks like a cosmetic
issue but I didn=E2=80=99t know if this is a dup issue/already in issue
tracker.

Thanks,
Gilbert Catipon


So to reproduce the issue:

gilbert@tea:~/dev/profile$ git log --foobar
fatal: unrecognized argument: --foobar

=E2=80=A2 Using a for loop to check a list of commands returns 2 fatal comm=
ands:

gilbert@tea:~/dev/profile$ for k in bisect grep log show status; do
echo $k; git $k --foobarf; done

log
fatal: unrecognized argument: --foobarf
show
fatal: unrecognized argument: --foobarf
status
error: unknown option `foobarf'
usage: git status [<options>] [--] <pathspec>...

=E2=80=A2 All these commands gave expected error
for k in branch checkout commit diff merge rebase tag; do echo $k ;
git $k --asdfasd; done

=E2=80=A2 On ubuntu
gilbert@tea:~/dev/profile$ uname -a
Linux tea 4.4.0-83-generic #106-Ubuntu SMP Mon Jun 26 17:54:43 UTC
2017 x86_64 x86_64 x86_64 GNU/Linux

=E2=80=A2 Setting GIT_TRACE=3D/tmp/git_trace.log

gilbert@tea:~/dev/profile$ cat /tmp/git_trace.log
09:59:47.703082 git.c:561               trace: exec: 'git-bisect' '--foobar=
f'
09:59:47.703164 run-command.c:334       trace: run_command:
'git-bisect' '--foobarf'
09:59:47.710513 git.c:344               trace: built-in: git
'rev-parse' '--git-dir'
09:59:47.712607 git.c:344               trace: built-in: git
'rev-parse' '--show-cdup'
09:59:47.714954 git.c:344               trace: built-in: git
'rev-parse' '--git-path' 'objects'
09:59:47.720353 git.c:344               trace: built-in: git 'grep' '--foob=
arf'
09:59:47.723324 git.c:344               trace: built-in: git 'log' '--fooba=
rf'
09:59:47.726310 git.c:344               trace: built-in: git 'show' '--foob=
arf'
09:59:47.729065 git.c:344               trace: built-in: git 'status'
'--foobarf'
gilbert@tea:~/dev/profile$
