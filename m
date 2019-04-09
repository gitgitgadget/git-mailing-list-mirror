Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4272F20248
	for <e@80x24.org>; Tue,  9 Apr 2019 14:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDIOco (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 10:32:44 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34579 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDIOcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 10:32:43 -0400
Received: by mail-lf1-f50.google.com with SMTP id o199so5395320lfo.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=xC50bBTesa3YVZDZe57Qs91BW0suGhdvJ1b2az1edTc=;
        b=vYaccLdfNwU+ieq0/bDB84kvxr/3En7vvrpi60Kc0zr2mfSRhWyiz/+gyxVjG7efj8
         1qafZzh4K3FCLMR3++Xlb/X0E8HO2U9Rf3o4ylHSRsqUkrALZJmrHjIbpuAldgd0QIco
         2P/fuogW3hdU8xXtzOWKWO8RHPlyyuT0TMCHmNQB6EyKD5OaXTBx4fYn2fw1Qryq8VBc
         TOtWzpe/okcxfpT43+ggXV+AP2PqqiydF3vE3WAYmKoXmCcvH0ZYc3buRZLaG/qpsMM4
         fV608xRVXIjm4YOy7BddBadH7gEAELK71OhUh+XCLSsnhMe68yvyYicjlBDlvL473mYu
         1prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=xC50bBTesa3YVZDZe57Qs91BW0suGhdvJ1b2az1edTc=;
        b=VFj7AHuOq0iNg7bNMzyZFSYtkWtVhgfJIcmE27QRF4mj0HoV6z3Im98U65UrXrXcRo
         kGspcI0MTeOzb057H6tJJ9E9ePBT4Ev7oVlnReFcqIml/Pbaki67vzQNHgIb0aQRh0Xx
         xaY6yn0VIduAUpAahKYVT2SjqgUv6YqsJ4NhGrL+Cg3ISxbvMBOrHJ2MjuJLzMzNEJeW
         DBsxalXe1JZbCGNO+XUqRzWQ3ZjoUgwyUHb+E6LMx22hi0f9Hg1tW1TbWrSaCYl7uXWm
         llEfGrgTu6XjS7qmsPhLhT3oKF6K/CeDrQNqL9r35oFebBHghgzNr4hrcgPg23ywAml8
         yLsg==
X-Gm-Message-State: APjAAAUEPbDdebx2ZXZwMXknmfyWnyfj6BSlNucZkAA647d+P3UPqjPB
        eCaB2rFDClU2J1WKCK1cEZ6SvSo/H+bTRz4KIefAMBou
X-Google-Smtp-Source: APXvYqwOeXpKSCcIqbmg1ox5OEoi5COdc7NUAJ2n3kpOX0zQpT5AY5of9Y+qah+FsJ0+++eaoMgwphA0L7xdNbcGfC4=
X-Received: by 2002:a19:740e:: with SMTP id v14mr20539996lfe.94.1554820361398;
 Tue, 09 Apr 2019 07:32:41 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 9 Apr 2019 09:32:29 -0500
X-Google-Sender-Auth: IijNECskvwXTE7Bh_U6Q59clMAQ
Message-ID: <CAHd499C1x+S7vwGzqV4=DFBoKVuY+jO6Jts94tb_g4FW3sD20A@mail.gmail.com>
Subject: Advice setting for git rebase
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I perform a rebase and it stops at a commit due to a conflict,
the messages printed are very verbose. Example:

```
Applying: Delete run configuration for zPayServiceStandalone
Using index info to reconstruct a base tree...
A       .idea/runConfigurations/zPayServiceStandalone.xml
Falling back to patching base and 3-way merge...
CONFLICT (rename/delete):
.idea/runConfigurations/zPayServiceStandalone.xml deleted in Delete
run configuration for zPayServiceStandalone and renamed to
.idea/runConfigurations/MSRServiceStandalone.xml in HEAD. Version HEAD
of .idea/runConfigurations/MSRServiceStandalone.xml left in tree.
error: Failed to merge in the changes.
Patch failed at 0005 Delete run configuration for zPayServiceStandalone
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git
rebase --abort".
```

Basically everything after the "error: Failed to merge in the changes"
line should be hidden by an advice setting of some sort. However,
reviewing the config documentation shows that there is no such option,
or at least, none that I see. I pulled up the code base for Git and
saw that some of these strings come from rebase.c, and it is added as
a `--resolvemsg` option. But I don't see anything that tries to read a
config setting before pushing that argument.

Also if you attempt to `rebase --continue`, for example, instead of
`rebase --skip`, you get similar help messages from the `am.c` file:

```
Applying: Delete run configuration for zPayServiceStandalone
No changes - did you forget to use 'git add'?
If there is nothing left to stage, chances are that something else
already introduced the same changes; you might want to skip this patch.
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git
rebase --abort".
```

Again, I didn't see an option to disable this advice.

Can anyone confirm if there is a setting to disable this advice or
not? A lot of the underlying machinery is shared between commands it
seems, so there might be a setting that isn't straightforward. Adding
a setting for this seems relatively easy, so with some advice I might
be willing to contribute a patch. Let me know, and thank you.
