From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: TopGit: ensure worktree (was: [TopGit PATCH] Check for help invocation before setup)
Date: Fri, 21 Nov 2008 13:15:19 +0100
Message-ID: <36ca99e90811210415g7b50c5c1m3185bf19cab104aa@mail.gmail.com>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
	 <1227110623-4474-2-git-send-email-madduck@debian.org>
	 <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com>
	 <20081121120609.GA10326@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "petr baudis" <pasky@suse.cz>,
	501982@bugs.debian.org
To: "martin f krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:16:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Uw9-0000RK-42
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYKUMPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYKUMPV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:15:21 -0500
Received: from rn-out-0910.google.com ([64.233.170.184]:60709 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYKUMPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:15:20 -0500
Received: by rn-out-0910.google.com with SMTP id k40so764631rnd.17
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tuv56NoY2xzlygLUWKGq1hhoxrSziHTFuVC4OXd6Pzs=;
        b=VrfrCVS9ES09SHDy4AgHNS0SNkwW4P0TMuk3pjGQd7W/WGmb2+M/oOdploHLLxoJjs
         NSg2S6wEfjIyfTgME5JH1iXJMgjfzbTNoK3z0pgd3KOiT/QH2bGrXtSKB0dyX8Y2t/gu
         xNkzI9sShZ6ApAsFwzjI99un2TiNRUuCydceE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jlakIdyjV+O5o7Sgj7ZMEw0zRy87DFUt86SzzNwj0yqMMyl/BS9CDxGKJOmWwXO6xd
         20iTd+QlgWrMn3ibZQGPm64wJWY5FAnY63uB5vSZ5kr/QPjs9JWOnMdbOZ8eh8HZTkif
         3iRsIz7JM5jwIBjVQA8HgCpkpkzoLc7GWgTvo=
Received: by 10.65.73.16 with SMTP id a16mr346212qbl.89.1227269719306;
        Fri, 21 Nov 2008 04:15:19 -0800 (PST)
Received: by 10.65.148.5 with HTTP; Fri, 21 Nov 2008 04:15:19 -0800 (PST)
In-Reply-To: <20081121120609.GA10326@piper.oerlikon.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101517>

On Fri, Nov 21, 2008 at 13:06, martin f krafft <madduck@debian.org> wrote:
> I think you wanted to CC Petr, not Junio. It's also useful to CC
> Debian bugs if you know of them. :)
I CC'ed Junio, because I think this git rev-parse --git-dir is a bug.
For example you can try starting git gui inside a .git dir.

>
> also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.11.21.1019 +0100]:
>> I really second this. Plus, I think its crucial to check that we are
>> not inside the .git directory before setting up topgit. Because git
>> rev-parse --git-dir only works in the top .git dir, not deeper (i.e.
>> inside .git/refs) and will always return ".".
>>
>>       $(git rev-parse --is-inside-work-tree) ||
>>               die "Not in a git working directory"
>
> Thanks, noted. I am still working on this patch, since
> evaluating $argv/checking for --help at this early stage basically
> requires a rewrite of the CLI parsing, ideally using POSIX getopt or
> something similar, which takes much of the load away.
>
> Anyway, Patch for your proposal forthcoming.
A patch would depent on your --help patch, Because help should work everywhere.
So either I wait for you or do do it.

Bert
>
> --
>  .''`.   martin f. krafft <madduck@debian.org>
> : :'  :  proud Debian developer, author, administrator, and user
> `. `'`   http://people.debian.org/~madduck - http://debiansystem.info
>  `-  Debian - when you have better things to do than fixing systems
>
> (a)bort, (r)etry, (p)retend this never happened
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkkmpDAACgkQIgvIgzMMSnUSKgCghXE+J9KegZ03tetnM3TIcyeM
> zn0AoJmYVzh/Kjxk7NFEpQw7USR0daXy
> =xl31
> -----END PGP SIGNATURE-----
>
>
