From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Tue, 16 Sep 2008 19:21:12 +0700
Message-ID: <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
	 <200809151240.54495.jnareb@gmail.com>
	 <fcaeb9bf0809150701j1161f87gcedef0013a244610@mail.gmail.com>
	 <200809152205.15388.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 14:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfZZo-00012t-Js
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 14:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYIPMVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYIPMVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 08:21:16 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:32535 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYIPMVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 08:21:15 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1276363gvc.37
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5MAXxPhnsVotAQbbHPe6A8bkEBmtVLg3cFly+0YWutw=;
        b=IDH/hZwgf8b5zCe6XyTDIv394PPMqPst1ydgW/jA6i2bPvTF0vlgoxsCGMM++PZ85g
         UFx4WoIDqGRYx7hA/P9KSpnYyATyDTAB0bVOD56HC+B0q7fZvjovKoUM+vBzUquyEzku
         LD7l9EDwNyEq/SQsqdTvMrkg9GPi5sZcHjr2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dlfpS/cixDeclQMpfjW2sXvRj965RcQAdnGF8HXvisHJLpEQdfJ0tCOODdhDHKehdL
         TsSv3Nry9JlTNwiN0dYJA7m9E8aI4IYh+SmAixzMEkNchXrm3JqwG6u/MjM2yLwf65bp
         jtg1DQJHY4T3R8zfEwXkv0xMozKa8BTWJ/HhM=
Received: by 10.86.28.2 with SMTP id b2mr700748fgb.31.1221567672858;
        Tue, 16 Sep 2008 05:21:12 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Tue, 16 Sep 2008 05:21:12 -0700 (PDT)
In-Reply-To: <200809152205.15388.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95996>

On 9/16/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  >> Couldn't you simply escape ':', i.e. write for example Git\:\:Tag.3pm,
>  >> or Eichten_PRD21\:313,1980_erratum.tex, or \:0.log, or perhaps
>  >> kmail/jnareb@gmail.com\:@pop.gmail.com\:995, or even something like
>  >> Mail/inbox/cur/1194202360.32296.mprnq\:2,S, in the same way like you
>  >> can escape other special characters, for example wildcard characters
>  >> like '\*' for '*' and '\?' for '?', and of course '\\' for '\'?
>  >
>  > Sure. Somehow I forgot that.
>
>
> Well, if it is possible, it should be stated in documentation.
>  Even if it is obvious.

I mean it should be possible, but not yet implemented. Next time
document will be updated when '\' escape is implemented.

>  > --<--
>  > Narrow checkout
>  > ---------------
>  >
>  > Normally when you do checkout a branch, your working directory
>  > will be fully populated. In some situations, you just need to
>  > work on certain files, no full checkout is needed. Narrow
>  > checkout is a mode that limits checkout area according to your
>  > needs.
>
>
> You have decided then on the term 'narrow checkout', and not
>  'partial checkout' or 'sparse checkout', then?

Not yet. I tend to prefer partial/sparse checkout. Probably should
have a look at how other SCMs do and what term they use. If Git's
functionality is so different, a different term might notice people
about that.

>  > Because narrow checkout uses new index format, it will be
>  > incompatible with git prior to 1.6.0 regarding worktree operations.
>  > Repository-only operations such as clone, push, pull... should not be
>
>
> s/pull/fetch/. pull affects working repository, and it can affect
>  narrow checkout unexpectedly by conflicts during merge part of pull.

Bad writing. I mean pull/fetch from a narrow-checkout-ed repository to
another fully populated one. Will fix.

>
>  > affected by narrow checkout. In order to make your working directory
>  > work again with those versions, you can use `git checkout --full` to
>  > return to normal mode (and compatible index format).
>
>
> By the way, you have made "git checkout <file>" get file and mark
>  it "wanted", i.e. clear/zero "no-checkout" bit.  Wouldn't then
>  "git checkout ." be shorter equivalent to "git checkout --full"?
>  I'm not saying that '--full' option should be abandoned...

It is not equivalent. "git checkout ." will happily overwrite any
modified files in your working directory.

>
>  >
>  > In narrow checkout mode, checkout status of every files in your
>  > working directory will be recorded in index. If a file is marked
>  > "no-checkout", it means that file is not needed to be present in
>  > working directory by user or any git command. When a new file is added
>  > to index, it will be marked "checkout" unless narrow spec is applied.
>  > Unmerged files are always "checkout". linkgit:git-update-index[1] can
>  > be used to update "checkout/no-checkout" status in index. When you
>  > checkout new files using "git checkout <file>" they will be
>  > automatically marked "checkout". Other commands such as "git apply"
>  > can also checkout new files if they are needed.
>  >
>  > "No-checkout" status is very similar to "assume-unchanged bit"
>  > (see linkgit:git-update-index[1]). The main difference between them
>  > is "assume unchanged" bit just ignores corresponding files in working
>  > directory while narrow checkout goes a bit farther, remove those files
>  > when it is safe to do so.
>
>
> Good description (although probably could be improved even further).

Contributions are welcome   ;)

>
>  >
>  > When you apply new narrow spec to your working directory using either
>  > --path, --add-path or --remove-path, it will update "checkout" status
>  > in index accordingly. Moreover, if a file is marked "no-checkout" and
>  > is present in working directory, it will be removed. If a file is
>  > turned from "no-checkout" to "checkout", then it will be added again
>  > to working directory. Modified and unmerged entries can't bear
>  > "no-checkout" status, if narrow spec applies to them, "git checkout"
>  > will refuse to update working directory.
>
>
> Do I understand correctly, that if one uses --path=<colon separated list>
>  _only_ filenames matching one of patterns specified would be checked out,
>  --add-path=<path> would additionally checkout given path and mark "wanted",
>  and  --remove-path=<path> would additionally mark "no-checkout" and remove
>  path?

--add-path/--remove-path also use narrow spec, which could be more
than one pattern.

>  What --add-path starts from, i.e. does
>
>   $ git checkout --add-path=.gitignore
>
>  starts from empty set if --add-path is first, or from full set as without
>  --add-path?

I'm not sure I understand this.

>  And is <pathspec> matched against full pathname, or like .gitignore
>  rules, i.e. as full pathname if it has at least one '/' in it?

like shell wildcard, full pathname must match. On my way back home, I
thought I should have removed mention of "pathspec", which behaves a
little bit different.

Also those specs are relative to working directory though, so if you
are in b/c and want to match d, you only need to type --add-path=d
instead of --add-path=b/c/d. Will add this to doc.

>
>  >
>  > Narrow spec is not saved by "git checkout". You can form your checkout
>  > area on one go with --path option, or do it incrementally
>  > with --add-path and --remove-path.
>  > --<--
>
>
> I would probably say that specification used to select which paths to
>  check out is not saved anywhere, and used only to mark paths in index
>  as "no-checkout" or not.  Or somehing like that.
>

Thanks (as for other parts of your comments stripped by me)

-- 
Duy
