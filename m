Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325991F404
	for <e@80x24.org>; Tue, 28 Aug 2018 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH1QSm (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:18:42 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33989 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1QSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:18:42 -0400
Received: by mail-ed1-f54.google.com with SMTP id u1-v6so1059547eds.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Wns5JvH2KMlb2QlZgbtOFzbzJBt6DxcLqFmaFD0ISc0=;
        b=VLCT75uTHmXBN2NSOGj5to87GKT4OzHJ6Jt0stdG4skkI0Xp6mkZZBMhwgp7OCct9L
         ejPsTleF7IJZgvdhiaCOHytYN9QV1SAzvpQCRWXDnCOcVBqWNLGUAFWyAO6SXfDdKZv9
         YyyaygVcemUofMxp1a2VQqogwB0sxKTgE0dXnEzTLYb5msB+mb5e63fBY0CFbPHkdtb8
         qD/QqzionZEmFHOYR3AgIcjNH9Ivue7O9qVPjBhhRtWS9DXyAmPlKtKMZsWFTzUQ3/uc
         EIEmhTJ5DXPgWkp9nROCfsETfv19quPEYlKyXXZ3nlWgoQZZl13bgngRPihB30vRVw6g
         yIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Wns5JvH2KMlb2QlZgbtOFzbzJBt6DxcLqFmaFD0ISc0=;
        b=bRzzS1i6FE1Z+847nxGG8trdNtzDWo6IpAXLelQd+qDL1L/70QnTMrVAGc/jnLxJU4
         9181aDbDhpgO8GUGWqF9O/50OmfwovtBt6FJpoJdZxxzAihQSidlPg1csPvhOKPxcWaO
         x5gClc19U4HxbI4w+SgiFp1eHlgHbD7nuEUZ0PGsQKAjjBksf3KGidoiDGFTIUNpO9Wa
         563CwKKXJ8UKry//ENO4cCc9cRdEl3PmNyCgxHZ6W8cbu6l4LYpnYFV1VJrGE7BHSaY2
         EoH6eu77XjZ314QszdN7WsulCZd/yt26NSRPrgC7azjBRGZJTGdNtdqVki/6wQk6ciZO
         pG+Q==
X-Gm-Message-State: APzg51Cj2bikBGVsquCVsl1pdrMSoty1K/Qy260oEStkMI3Gv/KMfBKp
        nk5fNGPhxx/Geza71oEXyZ65sVmp
X-Google-Smtp-Source: ANB0VdYS05CUtwe6PGlFRHDrJdpSRGZCm/elr7JSlzzmM1pfUAEnVJQOANDJ7FqoumW7cHNMHLh88g==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr2285293edd.30.1535459234965;
        Tue, 28 Aug 2018 05:27:14 -0700 (PDT)
Received: from nikolays-mbp.flixbus.com (h-213.61.119.99.host.de.colt.net. [213.61.119.99])
        by smtp.gmail.com with ESMTPSA id j10-v6sm551091ede.5.2018.08.28.05.27.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:27:14 -0700 (PDT)
From:   Nikolay Kasyanov <corrmage@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: A rebase regression in Git 2.18.0
Message-Id: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
Date:   Tue, 28 Aug 2018 14:27:13 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=E2=80=99ve found something that may be a regression in git rebase =
implementation in 2.18.0.
First I spotted it on macOS but I can also confirm it happening on =
Linux.
Git 2.19.0.rc0.48.gb9dfa238d is affected too.

In order to trigger it, a repo layout similar to the following is =
required:

files/
	file1
	file2
	file3
	file4
	file5
project

Let=E2=80=99s call this state baseline. Then, in a branch, let=E2=80=99s =
edit project file and move file3 to nested/files subdirectory, here=E2=80=99=
s the final layout:

files/
	file1
	file2
	file4
	file5
nested/
	files/
		file3
project

Let=E2=80=99s get back to master and also edit project file to cause a =
conflict. After that trying to rebase the branch upon master will cause =
the following git status output:

rebase in progress; onto baf8d2a
You are currently rebasing branch 'branch' on 'baf8d2a'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	renamed:    files/file1 -> nested/files/file1
	renamed:    files/file2 -> nested/files/file2
	renamed:    files/file3 -> nested/files/file3
	renamed:    files/file4 -> nested/files/file4
	renamed:    files/file5 -> nested/files/file5

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

	both modified:   project

All renames except file3 are invalid and shouldn=E2=80=99t be here.
Here=E2=80=99s how the output looks like produced by an older Git =
version (git version 2.15.1):

rebase in progress; onto baf8d2a
You are currently rebasing branch 'branch' on 'baf8d2a'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	renamed:    files/file3 -> nested/files/file3

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

	both modified:   project

Here=E2=80=99s a ready-to-use repository: =
https://github.com/nikolaykasyanov/git-rebase-bug.

Regards,
Nikolay Kasyanov

