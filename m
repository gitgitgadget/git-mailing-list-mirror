Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E02420960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdDJXXz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:23:55 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36106 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdDJXXy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:23:54 -0400
Received: by mail-io0-f177.google.com with SMTP id l7so114465508ioe.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TnDcEnHLgOT7jtfla96kNUB//ao1VBXennvk527+OTg=;
        b=QOJ0zxtunXvq+9k1/raAdWKuoKhtar4P00OnhDLEg/lIhS5SkBGNHzbumKQwXcAjGo
         M3dOZYK19rEdTEldFi8k/t45N392d39zUGguzBnuw4B6VU/voDtFgTDSORGczGFYNiAt
         vvka9MHLdO7z6PfQSjZADvMHus9EeqUDB7wnjCxZGI3/3PMWAotJaAJy13//Pm3R7lDC
         wQOrnjP3ahB85OyhgK3f0y0I+y5sChmtMRhrzKFlLRlapmjNmDD0yWElPDXqJ4yKzxgI
         IKd8xY9Um9Ak8OsGxiH+NRG837bOQy0XvImBEnB+T1WsrZ6fm2sQTK4qZ3wqD3eQzCrO
         Yrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TnDcEnHLgOT7jtfla96kNUB//ao1VBXennvk527+OTg=;
        b=ecSlLqyYm2hy1PXdwyT3c+qUKr26oa+vktQeUhTMGP1CDSKDHhVghA7K1Rnth7W9ex
         W8llfey6OSip9mx5MgNuBsCmCrca2MAjS88B/d1l/z1c/8OEumcllcwyRbj/6MVZO4B2
         Ea7eAuN1cXvaUmdM+iLjhyOwcQG4w34BSapLC8qC0QruGUvFP/fg6Y/MosFsDKxhh8cR
         RvpVOJUR3H791e9nfIq7DUlC2xr4pYlF3gx+o/jWcuFkwa9hY529Cz99TRDlSwz73PwB
         ZJOfjpWuk+5w/Gwty6FaDSMbJLgiAob/mArX4bJtNJuiZzm27lXZOgYSVR+UVtRG1sJk
         teMg==
X-Gm-Message-State: AN3rC/6jz/JnkYW4y3r129LShS/t1SqoQtF+8zjBm10HolSZV82Ra2FI
        WZosl06cmeQOTVFRLwDW4PU4dgAHzA==
X-Received: by 10.36.76.16 with SMTP id a16mr14159368itb.91.1491866633372;
 Mon, 10 Apr 2017 16:23:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 10 Apr 2017 16:23:32 -0700 (PDT)
In-Reply-To: <20170409191117.25175-3-avarab@gmail.com>
References: <20170409191117.25175-1-avarab@gmail.com> <20170409191117.25175-3-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 01:23:32 +0200
Message-ID: <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 9:11 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change the test library to insert non-alphanumeric ASCII characters
> into the TRASH_DIRECTORY name, that's the directory the test library
> creates, chdirs to and runs each individual test from.

I did a bit more work on getting more granularity on why things were
failing. I wrote a script[1] that runs each of the failing tests once
with each individual character in the non-alphanumeric ASCII range to
narrow down issues.

I skipped the svn tests, and something went wrong in the middle of my
run to make the http tests fail on everything, but the gist of it is:

* Most of the tests fail because git clone can't deal with cloning a
repo with a \r in the path. The error we produce when we try is quite
bad and doesn't indicate what went wrong:

$ rm -rf /tmp/git.*; mkdir /tmp/git.$(perl -e 'print chr 13') && cd
/tmp/git.* && git init --bare b && file b && git clone b c
/b/tialized empty Git repository in /tmp/git.
b: directory
Cloning into 'c'...
fatal: '/tmp/git. /b' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

So file(1) shows it exists, a strace shows that git knows it exists at
some point, but something gets lost along the way.

* Much of it fails due to GIT_CEILING_DIRECTORIES not working with
dirs with ":" in the name.

* That leaves the rest at:

$ grep FAIL results | grep -v -e svn -e svk  | awk '{print $1 " "
$2}'|perl -nE 'chomp;my ($f, $c) =3D split / /, $_; push @{$f{$f}} =3D>
$c; END { for my $k (sort keys %f) { say "$k =3D " . join ", ", map { $_
< 32 ? $_ : "$_(" . chr($_) . ")" } @{$f{$k}} } }'|grep -E -v
'^.{150,}$'|grep -E -v -e '=3D 13$' -e '=3D 58\(:\)$' -e '=3D 13, 58\(:\)$'
t0021-conversion.sh =3D 37(%), 58(:)
t0060-path-utils.sh =3D 39(')
t0302-credential-store.sh =3D 9, 32( ), 34("), 40((), 39('), 38(&),
41()), 59(;), 60(<), 62(>), 96(`), 124(|)
t1305-config-include.sh =3D 9, 13, 34("), 35(#), 59(;), 92(\), 91([)
t1500-rev-parse.sh =3D 9, 13
t1510-repo-setup.sh =3D 13, 92(\)
t3900-i18n-commit.sh =3D 9, 32( ), 40((), 41()), 38(&), 59(;), 60(<),
62(>), 124(|)
t4030-diff-textconv.sh =3D 13, 34("), 96(`)
t4031-diff-rewrite-binary.sh =3D 13, 34("), 96(`)
t5150-request-pull.sh =3D 13, 92(\)
t5310-pack-bitmaps.sh =3D 9, 13
t5407-post-rewrite-hook.sh =3D 34("), 96(`)
t5505-remote.sh =3D 13, 35(#)
t5516-fetch-push.sh =3D 13, 39(')
t5601-clone.sh =3D 13, 34("), 39('), 96(`)
t7003-filter-branch.sh =3D 34("), 96(`)
t7008-grep-binary.sh =3D 13, 34("), 96(`)
t7402-submodule-rebase.sh =3D 13, 34("), 96(`)
t7405-submodule-merge.sh =3D 34("), 92(\)
t7406-submodule-update.sh =3D 13, 9, 34("), 35(#), 38(&), 59(;), 92(\)
t7407-submodule-foreach.sh =3D 13, 9, 42(*)
t7504-commit-msg-hook.sh =3D 34("), 96(`)
t7700-repack.sh =3D 9, 42(*)
t9001-send-email.sh =3D 13, 34("), 96(`)
t9200-git-cvsexportcommit.sh =3D 42(*), 63(?)
t9300-fast-import.sh =3D 34("), 92(\)
t9400-git-cvsserver-server.sh =3D 13, 59(;)
t9401-git-cvsserver-crlf.sh =3D 13, 59(;)
t9402-git-cvsserver-refs.sh =3D 13, 59(;)
t9600-cvsimport.sh =3D 42(*), 58(:), 63(?)
t9601-cvsimport-vendor-branch.sh =3D 42(*), 58(:), 63(?)
t9602-cvsimport-branches-tags.sh =3D 42(*), 63(?), 58(:)
t9604-cvsimport-timestamps.sh =3D 42(*), 58(:), 63(?)
t9700-perl-git.sh =3D 13, 92(\)

I've fixed a few in https://github.com/avar/git/commit/55395613fe

There's one segfault in there:

$ ./t5601-clone.sh --root=3D"xtmp.$(perl -e 'print chr 39')" -v -i -d
[...]
Cloning into 'ssh-bracket-clone-plink-4'...
Segmentation fault
not ok 45 - single quoted plink.exe in GIT_SSH_COMMAND

1. https://github.com/avar/git/commit/edc439c462
