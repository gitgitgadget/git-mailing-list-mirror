From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git worktree fails to recreate existing branch even with -B
Date: Mon, 15 Feb 2016 16:41:54 +0700
Message-ID: <20160215094154.GA11698@lanh>
References: <344AE670-BF9A-4779-AFB0-50B870E1D488@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 10:41:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVFf6-0006X5-5d
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbcBOJlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:41:35 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34724 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcBOJld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:41:33 -0500
Received: by mail-pa0-f47.google.com with SMTP id fy10so43940956pac.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AaQx+YdyKiYSHZopF4E5CrTBm1lflhY+H3CmEgRMPtE=;
        b=IqZFCqGPbF0pNIDk7HZnijcJ2WhS5IEYXh0bHtCKI4Myk/h+4uKN4AtuWPW6diRRvT
         IrilYeeIoJyQZFFUX9/z6sh5X49C8P3ErAoptEZOC4KhKfoiEpaimn0KHTHmJNEfHUjx
         xexkqZ7q2zlDFuNRNAK2e9hzDu0f6mqjXz9GV1cNOa/uGQYLIrbT2S/wUpCONqSF9nVi
         EOA1VfULOzaB2Rgo6Yrboh4m3w3V9cuF45vgzWLqqbHMRjYbWaS1KbHjjv5/XrG7vj1v
         sa4IJ0UFJ7YDlxOSYdr2ArjFigBKOus4RxBFgPvBYWJ6Qi0TJUn25tvqgOMSzZXe2RUM
         V4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AaQx+YdyKiYSHZopF4E5CrTBm1lflhY+H3CmEgRMPtE=;
        b=Dfq8j4tT+fxQfh7kfrHjqmElC5glkn71NrAk6kx2Vg/R/5tZmJEplL6fzj2uIv8lyc
         py1OzYK5injxR5r7K+eHRwPlVxkzbpKVktFQxOPcqU1jUSE96ZTtn5fxqNPNXZutZvds
         pZP+wc7oy0/h8rWWwihKpv0jXPwJtKw+hb/oWgdex2mbni5/FB34gYv6/krKpfHOhdXw
         UVZsj00BMSeVFpj7gzbfqqOvAhIh/PSpPFh/DhXZB6EvZqGjrYCddjot3kIDUAlK/L2e
         A2QlKH2kjF6dfYdY95+Sa0BrMvUBSrceldREP9uoVGhdmDCRWdnF1u9LNs0LKHrm6Bwd
         XcQQ==
X-Gm-Message-State: AG10YOTvzBnSIgYMMz6IReeDuCCgFN/ZXi3OZUbVgy2+eqGWRkuXalDVN/cQfEUy6Vr/2g==
X-Received: by 10.66.234.104 with SMTP id ud8mr22052245pac.143.1455529292520;
        Mon, 15 Feb 2016 01:41:32 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id kw10sm37162586pab.0.2016.02.15.01.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:41:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:41:54 +0700
Content-Disposition: inline
In-Reply-To: <344AE670-BF9A-4779-AFB0-50B870E1D488@jetbrains.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286190>

On Tue, Feb 09, 2016 at 05:54:01PM +0300, Kirill Likhodedov wrote:
> Git doesn=E2=80=99t allow me to execute=20
>     git worktree add -B <branch> <path> <start-point>
> where <branch> already exists in the repository.
>=20
> The command prints the following:
>     Preparing <path> (identifier <branch>)
>     fatal: Refusing to point HEAD outside of refs/
>=20
> I=E2=80=99m trying to create a worktree on an existing branch <branch=
>,
> which should point to <start-point>. This obviously should fail with
> =E2=80=9C-b=E2=80=9D, but I use =E2=80=9C-B=E2=80=9D and expect it to=
 be reset to <start-point> as
> mentioned in the docs:
>=20
>     By default, -b refuses to create a new branch if it already exist=
s. =20
>     -B overrides this safeguard, resetting <new-branch> to <branch>.
>=20
> Do I miss something or there is a bug?

According to the man page, this looks like a bug.

> Steps to reproduce:
>=20
> git init wt
> cd wt
> echo 'asd' > a.txt ; git add a.txt ; git commit -m initial
> git branch br1
> git worktree add -B br1 ~/temp/br1 master
>=20
> Error message:
> Preparing /Users/loki/temp/br1 (identifier br1)
> fatal: Refusing to point HEAD outside of refs/

GIT_TRACE=3D2 gives me

trace: built-in: git 'symbolic-ref' 'HEAD' ''
fatal: Refusing to point HEAD outside of refs/

So we pass wrong argument to symbolic-ref. The '' should be
'refs/heads/br1'. This patch seems to fix it.

-- 8< --
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..d5b319f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -202,7 +202,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
=20
 	/* is 'refname' a branch or commit? */
 	if (opts->force_new_branch) /* definitely a branch */
-		;
+		strbuf_addf(&symref, "refs/heads/%s", refname);
 	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) =
&&
 		 ref_exists(symref.buf)) { /* it's a branch */
 		if (!opts->force)
-- 8< --
--
Duy
