Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB9020899
	for <e@80x24.org>; Tue, 15 Aug 2017 02:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbdHOCkD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 22:40:03 -0400
Received: from mail-ext-sout1.uwa.edu.au ([130.95.128.72]:55742 "EHLO
        mail-ext-sout1.uwa.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbdHOCkC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 22:40:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AlAwCEXpJZ/8+AX4JdGgEBAQECAQEBA?=
 =?us-ascii?q?QgBAQEBhVKPBI9WAQEBAQEBBoEIIneXMwGFRgKFPBQBAgEBAQEBAQFrKIUYAQE?=
 =?us-ascii?q?BAQIBIx0BATcBBAsLGCoCAiwrBhMbigcFCKxNa4ImgwgBAQWFAAdDgxIBAQEBA?=
 =?us-ascii?q?QUBAQEBAQEaCIMogTKBVYIqNoI9NIgGgmGREIEOjhinEZYVNiGBCjIhCBgZhVG?=
 =?us-ascii?q?CH2kBihcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2AlAwCEXpJZ/8+AX4JdGgEBAQECAQEBAQgBAQEBhVKPBI9?=
 =?us-ascii?q?WAQEBAQEBBoEIIneXMwGFRgKFPBQBAgEBAQEBAQFrKIUYAQEBAQIBIx0BATcBB?=
 =?us-ascii?q?AsLGCoCAiwrBhMbigcFCKxNa4ImgwgBAQWFAAdDgxIBAQEBAQUBAQEBAQEaCIM?=
 =?us-ascii?q?ogTKBVYIqNoI9NIgGgmGREIEOjhinEZYVNiGBCjIhCBgZhVGCH2kBihcBAQE?=
X-IronPort-AV: E=Sophos;i="5.41,376,1498492800"; 
   d="scan'208";a="295612324"
Received: from f5-new.net.uwa.edu.au (HELO mooneye.ucc.gu.uwa.edu.au) ([130.95.128.207])
  by mail-ext-out1.uwa.edu.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2017 10:39:29 +0800
Received: by mooneye.ucc.gu.uwa.edu.au (Postfix, from userid 801)
        id 86C2D66002; Tue, 15 Aug 2017 10:39:29 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ucc.gu.uwa.edu.au;
        s=ucc-2016-3; t=1502764769;
        bh=KmtIFPaft2alcsY68aCUGmHPebPYBbuZUogXp3bOtXA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=G8T4ib18e++6LgdlLDENQFGgUD6mDu6SajfBcdqQJvs0p2yes+9T1VZkzWX2ZdhHp
         OnEtU3ywCLBn6oh7ew8K8qEux09pVgwtz0/R7HbH9Bi/BqfQ5/FeZnyMt3YRxxUVvp
         866LmQQEqKi0QTePWKOrCBCaV/Glzb0xK/17qf2M=
Received: from motsugo.ucc.gu.uwa.edu.au (motsugo.ucc.gu.uwa.edu.au [130.95.13.7])
        by mooneye.ucc.gu.uwa.edu.au (Postfix) with ESMTP id 2AC6966001;
        Tue, 15 Aug 2017 10:39:29 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ucc.gu.uwa.edu.au;
        s=ucc-2016-3; t=1502764769;
        bh=KmtIFPaft2alcsY68aCUGmHPebPYBbuZUogXp3bOtXA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=G8T4ib18e++6LgdlLDENQFGgUD6mDu6SajfBcdqQJvs0p2yes+9T1VZkzWX2ZdhHp
         OnEtU3ywCLBn6oh7ew8K8qEux09pVgwtz0/R7HbH9Bi/BqfQ5/FeZnyMt3YRxxUVvp
         866LmQQEqKi0QTePWKOrCBCaV/Glzb0xK/17qf2M=
Received: by motsugo.ucc.gu.uwa.edu.au (Postfix, from userid 11251)
        id 23F1824F94; Tue, 15 Aug 2017 10:39:29 +0800 (AWST)
Received: from localhost (localhost [127.0.0.1])
        by motsugo.ucc.gu.uwa.edu.au (Postfix) with ESMTP id 1F28B24F92;
        Tue, 15 Aug 2017 10:39:29 +0800 (AWST)
Date:   Tue, 15 Aug 2017 10:39:29 +0800 (AWST)
From:   David Adam <zanchey@ucc.gu.uwa.edu.au>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug?: git archive exclude pathspec and gitattributes
 export-ignore
In-Reply-To: <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
Message-ID: <alpine.DEB.2.11.1708151027350.9062@motsugo.ucc.gu.uwa.edu.au>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au> <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1602357005-2038249645-1502764769=:9062"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1602357005-2038249645-1502764769=:9062
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 14 Aug 2017, René Scharfe wrote:
> Am 13.08.2017 um 06:53 schrieb David Adam:
> > I think I have a bug in git (tested 2.11.0 on Debian 8, 2.14.1 on OS X and
> > 2.14.1.145.gb3622a4 on OS X).
> > 
> > Given a repository with an export-ignore directive for a subdirectory in
> > .gitattributes, `git archive` with a pathspec that excludes a different
> > subdirectory produces no output file and git exits with -1 as the return
> > status.
> 
> Thanks for the thoughtful bug report!
> 
> The problem seems to be that archive.c::write_archive_entry() returns 0
> instead of READ_TREE_RECURSIVE for directories with the attribute
> "export-ignore", and archive.c::write_directory() gets caught by
> surprise by that and returns -1, which ends up causing git archive to
> exit with return code 255 without actually writing anything.
> 
> This should only happen if you use wildcards like "*", i.e. git archive
> should behave as expected if you spell out the full name of the
> directory.  Can you confirm that?

Yes - that's definitely the case.

The reason I am trying to use the wildcard is that using an ":(exclude)b" 
pathspec excludes the contents of, but not the actual b directory 
itself:

    > git archive HEAD ':(top)' ':(exclude)b' | tar t
    .gitattributes
    b/

Whereas I would like to export the archive without the b directory 
entirely.

> The real solution is probably to teach tree-walk.c::do_match() how to
> handle attributes and then inject ":(attr:-export-ignore)" as a default
> internal pathspec in archive.c::parse_pathspec_arg() instead of handling
> it in archive.c::write_archive_entry().

Many thanks

David Adam
zanchey@ucc.gu.uwa.edu.au
--1602357005-2038249645-1502764769=:9062--
