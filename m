From: Thierry Suzanne <thierry@yellownemo.com>
Subject: Found possible branch point, then "Use of uninitialized value $u in substitution/concatenation"
Date: Thu, 5 May 2016 11:43:01 +0100
Message-ID: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 12:43:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayGkO-00079b-4C
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 12:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbcEEKnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 06:43:04 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37498 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbcEEKnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 06:43:03 -0400
Received: by mail-ig0-f175.google.com with SMTP id s8so10227586ign.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yellownemo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=ciMva4e56QmOOlfMjgYMTFQUpaoPkkT8XEHOsJhiAzk=;
        b=wMAQnKhnBhycg9khNH2NN4FDo88ciAucLj/5OZk502Y74RE7330OG9VoYAXQHulLZk
         D/juadntvMclJvtztlz4+9Te3pozeipK47afw0nVGbMa/F3Ngg0Fg0suDivt9AC7K5eW
         whTosDT825O12aZ7SJGX419D5FD1D/UxaGkkIuieXGUHXfu43nFxEmJWA3om8wCcetCx
         GrNtc+YflDxxxv/1vNFdcFV+xno9C7U8UlDeGceWaQ7T9tIPGXa+jc6Ll64Kepse8IvA
         R5/G2swIL5XL0IRzWd6wAX9JJPwG+pavfd2PSHMiOhaa10jBvem/CSRM4pd1w4ykCyUt
         2xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ciMva4e56QmOOlfMjgYMTFQUpaoPkkT8XEHOsJhiAzk=;
        b=E3MNdqsOIR+W0WJ/fr8Rxy9853S+DyEEKxOI1PaEW3JVY+OHGqLcYx9CG73QSvulNY
         jIhJ7Cspe4BbpK5J2NfaOUdbEGVrhS/aadoIwHSVAih7kU+irNyXAYVdusR0yvus1jyG
         pBHZrT2dLF9pFmn6Y1tQHqJtuKGLUrIB302zYJUM3h6JMcSVGgaLnObxYdhBmwbdND12
         HhHfLjSHywbfDVZAxqiNvwJToNLCWaNyFAEp3qsTHMuHjFQnuLINCR73YF4kb1+JJizg
         hYZe3EHkpv8ZPmrB2BPbEit5Pr7VTvDEvQR9yyFTP0FXv16VRIzgaRoSH7yqPUztiTQW
         KHEA==
X-Gm-Message-State: AOPr4FUYM+ZEJaRoMgHUwum3dRvz6PD3bH4Uj2y7QzxTj3da7hhHzKuNkbmB+usY0Ag5ZvcjCG9EV0RndKcrtA==
X-Received: by 10.50.10.165 with SMTP id j5mr2788552igb.29.1462444981410; Thu,
 05 May 2016 03:43:01 -0700 (PDT)
Received: by 10.36.8.5 with HTTP; Thu, 5 May 2016 03:43:01 -0700 (PDT)
X-Originating-IP: [86.28.149.6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293645>

Hi,

I am converting my SVN repository to Git.
git version 2.8.2.windows.1
Windows 8.1 Pro 64bits, running Git For Windows 32bits.

I have found this error mentioned here:
http://stackoverflow.com/questions/15387812/git-svn-found-possible-branch-point
and here:
http://stackoverflow.com/questions/3009738/what-does-this-svn2git-error-mean


v1 causes 2 errors, trunk address is wrong, I set it by mistake to
same as repository root:

C:\Windows\system32>git svn clone
https://mycompany.svn.beanstalkapp.com/myproject --no-metadata -A
c:\temp\svn_to_git_users.txt
--trunk=https://mycompany.svn.beanstalkapp.com/myproject
--tags=https://mycompany.svn.beanstalkapp.com/myproject/tags
--branches=https://mycompany.svn.beanstalkapp.com/myproject/branches
c:\code\Git_myproject

[...]
W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/MS WCSF
Contrib/src/Services
W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/RealWorldControls/References
r530 = c276e3b039d8e38759c6fb17443349732552d7a2 (refs/remotes/origin/trunk)
Found possible branch point:
https://mycompany.svn.beanstalkapp.com/myproject/trunk =>
https://mycompany.svn.beanstalkapp.com/myproject/branches/20080918_DBDEPLOY,
529
Use of uninitialized value $u in substitution (s///) at
/mingw32/share/perl5/site_perl/Git/SVN.pm line 101.
Use of uninitialized value $u in concatenation (.) or string at
/mingw32/share/perl5/site_perl/Git/SVN.pm line 101.
refs/remotes/origin/trunk:
'https://mycompany.svn.beanstalkapp.com/myproject' not found in ''
C:\Windows\system32>


v2 works: corrected the paths (and using relative instead of absolute
to make line shorter)

C:\Windows\system32>git svn clone
https://mycompany.svn.beanstalkapp.com/myproject --no-metadata -A
c:\temp\svn_to_git_users.txt --trunk=trunk --tags=tags
--branches=branches c:\code\Git_myproject

[...]
r529 = 40442d32486f4ca6f713e659b3785a446bd19de6 (refs/remotes/origin/trunk)
Found possible branch point:
https://mycompany.svn.beanstalkapp.com/myproject/trunk =>
https://mycompany.svn.beanstalkapp.com/myproject/branches/20080918_DBDEPLOY,
529
Found branch parent: (refs/remotes/origin/20080918_DBDEPLOY)
40442d32486f4ca6f713e659b3785a446bd19de6
Following parent with do_switch
Successfully followed parent
r530 = 9fefc1b3a892555e315d55c2024cdf3d3a05010f
(refs/remotes/origin/20080918_DBDEPLOY)
        A       src/database/sds.dbd
[...]


As suggested on stackoverfloow posts, I opened the config file
(C:\code\Git_myproject\.git\config) and the first version (broken) was
as follow. The fetch is probably the wrong thing comparing with v2
(branches and tags are duplicated too, some stackoverflow people say
it might also cause problems).

[svn-remote "svn"]
noMetadata = 1
url = https://mycompany.svn.beanstalkapp.com/myproject
fetch = :refs/remotes/origin/trunk
branches = branches/*:refs/remotes/origin/*
tags = tags/*:refs/remotes/origin/tags/*
branches = branches/*:refs/remotes/origin/*
tags = tags/*:refs/remotes/origin/tags/*

and the 2nd version (working) was:

[svn-remote "svn"]
noMetadata = 1
url = https://mycompany.svn.beanstalkapp.com/myproject
fetch = trunk:refs/remotes/origin/trunk
branches = branches/*:refs/remotes/origin/*
tags = tags/*:refs/remotes/origin/tags/*

Looking at svn.pm, I can see we're in find_parent_branch() which
outputs the message "Found possible branch point". It then calls
other_gs($new_url, $url, $branch_from, $r, $self->{ref_id});

which itself calls:
Git::SVN->find_by_url($new_url, $url, $branch_from);

which calls:
resolve_local_globs($u, $fetch, $globspec);

and resolve_local_globs is where the error is thrown on line 100/101:
my $u = (::cmt_metadata("$refname"))[0];
$u =~ s!^\Q$url\E(/|$)!! or die

I made a mistake in my command line for sure, so this might not be a
bug, I'm just emailing all this if someone think it could be handled
differently or a better error shown.

Thanks,
T
