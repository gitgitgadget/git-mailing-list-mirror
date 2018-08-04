Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7FA1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 14:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeHDQXt (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 12:23:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39484 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQXt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 12:23:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so8046460wre.6
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xvZMp2I51ddOJZgVmJZ4A1C4z4QaeIo7/Tl2XrMvFM8=;
        b=mwAI4k9XBsaFOM2kJ0hHFAipJKV2FWGN6UpZrHNI4horFGcHN0lwl7oWS/JbABJFHW
         bhQUMCp2pX21t7LqBp7Dc4RcfIWOvqcr6uGpsyO/I315A/OjocZO4S3RTXPQrTp4xcTw
         AvJvF2zu8YiiVF/diM0iUSEj2+iysg9q4GrSbwCbRRdAjXmx/JHInHZ7aFOLalj9oK25
         rPBdt5EWpFCw4cbIWexqFRnhoelpptKzLH7uDA/8Yn75oepfCJetnTq8fW8cgraDyTXJ
         3evaq7UjjNQcnLvx31BK6PngmOS7jGpESzDgJV7bJ+17WA8GMXqrleB/PY4hFuvy3OMw
         VZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xvZMp2I51ddOJZgVmJZ4A1C4z4QaeIo7/Tl2XrMvFM8=;
        b=X7ayP5G8scE62Z1GWMyA5o4XVN7HgV5s0Dy6OgXqZaBMxFBv7rhvs6Jos2+Vya7LUH
         2aL2zfzk8d1aymMvR0m0tMgLdFXaf2bU2utHaOksLmqGr2zqwwtAQL2IG53Cept369NV
         eVhuPubeWWwhGuNBF/pLRFPsWT4HC6uMvbJBeKL8q3YF3Rytydvd7izveOBw6FxE12Nl
         SFnvTKjaQrS6xiE8NwVE7Q6fu1zRYzp5or8gOFXfpunwrXqOV6S3VBh+tUf/j4Rb7yfy
         JlxVzyA/Wd7Ay4C3X1bxrE8Gfq7hpJWq6ClKrOOWWCMdL8nOI2uO54A8yI55BNjg1FQY
         kMKw==
X-Gm-Message-State: AOUpUlF582hBth1hxwwStxvlqWPO3NwPnE/kXaWJ8MLo0UWqV+GOYc2u
        n/BKF0/0hgEUrKCa8RfSBgjDKnx62wNLGg==
X-Google-Smtp-Source: AAOMgpd1pS9jjuzDhaad+0w2MB5WRlEAT3+gWBtkq/G2t0yB68M/qrejuJTaNH0qPOPGJp9uyr7eSw==
X-Received: by 2002:adf:ec41:: with SMTP id w1-v6mr5127220wrn.128.1533392576034;
        Sat, 04 Aug 2018 07:22:56 -0700 (PDT)
Received: from e3c0ce5ceb57 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id o14-v6sm3130932wmd.35.2018.08.04.07.22.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 07:22:55 -0700 (PDT)
Date:   Sat, 4 Aug 2018 14:22:47 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/1] Introduce git-recover
Message-ID: <20180804142247.GA7@e3c0ce5ceb57>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello-

I created a simple shell script a while back to help people recover
files that they deleted from their working directory (but had been added
to the repository), which looks for unreachable blobs in the object
database and places them in the working directory (either en masse,
interactively, or via command-line arguments).

This has been available at https://github.com/ethomson/git-recover for
about a year, and in that time, someone has suggested that I propose
this as part of git itself.  So I thought I'd see if there's any
interest in this.

If there is, I'd like to get a sense of the amount of work required to
make this suitable for inclusion.  There are some larger pieces of work
required -- at a minimum, I think this requires:

- Tests -- there are none, which is fine with me but probably less fine
  for inclusion here.
- Documentation -- the current README is below but it will need proper
  documentation that can be rendered into manpages, etc, by the tools.
- Remove bashisms -- there are many.

Again, this may not be particularly interesting, but I thought I'd send
it along in case it is.

Cheers-
-ed

-----------------------------------------------------------------------

git-recover allows you to recover some files that you've accidentally
deleted from your working directory.  It helps you find files that exist
in the repository's object database - because you ran git add - but were
never committed.

Getting Started
---------------
The simplest way to use git-recover is in interactive mode - simply run
`git-recover -i` and it will show you all the files that you can recover
and prompt you to act.

Using git-recover
-----------------
Running git-recover without any arguments will list all the files (git
"blobs") that were recently orphaned, by their ID.  (Their filename is not 
known.)

You can examine these blobs by running `git show <objectid>`.  If you
find one that you want to recover, you can provide the ID as the argument
to git-recover.  You can specify the `--filename` option to write the
file out and apply any filters that are set up in the repository.  For
example:

    git-recover 38762cf7f55934b34d179ae6a4c80cadccbb7f0a \
        --filename shattered.pdf

You can also specify multiple files to recover, each with an optional
output filename:

    git-recover 38762c --filename one.txt cafebae --filename bae.txt

If you want to recover _all_ the orphaned blobs in your repository, run
`git-recover --all`.  This will write all the orphaned files to the
current working directory, so it's best to run this inside a temporary
directory beneath your working directory.  For example:

    mkdir _tmp && cd _tmp && git-recover --all

By default, git-recover limits itself to recently created orphaned blobs.
If you want to see _all_ orphaned files that have been created in your
repository (but haven't yet been garbage collected), you can run:

    git-recover --full

Options
-------
    git-recover [-a] [-i] [--full] [<id> [-f <filename>] ...]

-a, --all
Write all orphaned blobs to the current working directory.  Each file will
be named using its 40 character object ID.

-i, --interactive
Display information about each orphaned blob and prompt to recover it.

--full
List or recover all orphaned blobs, even those that are in packfiles.  By 
default, `git-recover` will only look at loose object files, which limits
it to the most recently created files.  Examining packfiles may be slow,
especially in large repositories.

<id>
The object ID (or its abbreviation) to recover.  The file will be written to
the current working directory and named using its 40 character object ID,
unless the `-f` option is specified.

-f <filename>, --filename <filename>
When specified after an object ID, the file written will use this filename.
In addition, any filters (for example: CRLF conversion or Git-LFS) will be
run according to the `gitattributes` configuration.


Edward Thomson (1):
  recover: restoration of deleted worktree files

 git-recover.sh | 311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 311 insertions(+)
 create mode 100755 git-recover.sh

-- 
2.0.0 (libgit2)

