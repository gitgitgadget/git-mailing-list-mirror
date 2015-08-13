From: Kosenko Roman <madkite@gmail.com>
Subject: Re: [bug] git-svn segmentation fault
Date: Thu, 13 Aug 2015 18:28:31 +0100
Message-ID: <CAB4xWX4Z+1jKTj2d7_UPVxudsu8V6y7h2nk5StLzRdwRkSk05g@mail.gmail.com>
References: <CAB4xWX7R_FrFATqnwebRqAWsUrZd-ATU3rTGxjq6c-44XbRUgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 19:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPwJF-0004cj-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 19:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbbHMR2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 13:28:53 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35594 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbbHMR2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 13:28:52 -0400
Received: by wicne3 with SMTP id ne3so148221293wic.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=d/+ggBS2Ym0uZVzhl8mQHSIj0hdsqFq+Fh6dWJQRHF8=;
        b=CSjG341AyP1QSnuXn4fHLpI6Hi1DACg3yRq3XHTS/yZR5iXIgqIb5rcNJ8I7wOeTsv
         UPvsob4eK9kOK14NjyFKNCgIsRj4PLpf4k6eB82kKdzNr3itiKQNzWNca3UVJitZNyiI
         qdnZbG89sjdU9OM8AWxM4hcKkkGDIKBU7LvRH/Sfwy3DDj3i1ifvh1zD3sdpkrZizK+8
         zd9Ttay5YEIljmtxCt1w385FOgGyoohI/aKkMiymKpPlUKw1eX+1O98xXHfVT1cDfDJa
         5xFhpnP7QEw0dvLgSpD4wBSYKwh/hrHHqRwtjCJU3/8eUwz+44mCNPQDNAXD8P9/mqVw
         u0Nw==
X-Received: by 10.180.104.68 with SMTP id gc4mr8695009wib.78.1439486931200;
 Thu, 13 Aug 2015 10:28:51 -0700 (PDT)
Received: by 10.28.103.68 with HTTP; Thu, 13 Aug 2015 10:28:31 -0700 (PDT)
In-Reply-To: <CAB4xWX7R_FrFATqnwebRqAWsUrZd-ATU3rTGxjq6c-44XbRUgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275865>

Sorry for bothering, it seems like this is not related to git, this is
because of broken subversion package in this buggy archlinux.

On 11 August 2015 at 12:56, Kosenko Roman <madkite@gmail.com> wrote:
> Hello,
> I use git-svn. I have used it without any problem for two month. Now
> git starts crashing after "svn rebase" (maybe also after other
> operations with a remote svn server, I'll check when will do "svn
> dcommit" next time). It successfully done the operation and only then
> it crashes:
>
> $ git svn rebase
> Current branch master is up to date.
> error: git-svn died of signal 11
>
> $ dmesg | tail -n5
> [518105.393218] git-svn[25148]: segfault at 7f81c0775c50 ip
> 00007f81c0775c50 sp 00007ffca025adc8 error 14 in
> Glob.so[7f81c0979000+6000]
> [518113.627053] git-svn[25487]: segfault at 7f0547a76c50 ip
> 00007f0547a76c50 sp 00007ffe31c39958 error 14 in
> Glob.so[7f0547c7a000+6000]
> [518137.038469] git-svn[25677]: segfault at 7fe124d4fc50 ip
> 00007fe124d4fc50 sp 00007ffc821fc848 error 14 in
> Glob.so[7fe124f53000+6000]
> [518173.339068] git-svn[25864]: segfault at 7f0919006c50 ip
> 00007f0919006c50 sp 00007ffe78e51b58 error 14 in
> Glob.so[7f091920a000+6000]
> [519070.924619] git-svn[26467]: segfault at 7f119202ec50 ip
> 00007f119202ec50 sp 00007fff2af3a948 error 14 in
> Glob.so[7f1192232000+6000]
>
> This behaviour is persistent and I can reproduce it any time.
>
> Versions info:
>
> $ uname -a
> Linux hs-arch 4.1.4-1-ARCH #1 SMP PREEMPT Mon Aug 3 21:30:37 UTC 2015
> x86_64 GNU/Linux
>
> $ git --version
> git version 2.5.0
>
> $ svn --version
> svn, version 1.8.13 (r1667537)
>    compiled Jun  3 2015, 05:30:35 on x86_64-unknown-linux-gnu
>
> Copyright (C) 2014 The Apache Software Foundation.
> This software consists of contributions made by many people;
> see the NOTICE file for more information.
> Subversion is open source software, see http://subversion.apache.org/
>
> The following repository access (RA) modules are available:
>
> * ra_svn : Module for accessing a repository using the svn network protocol.
>   - with Cyrus SASL authentication
>   - handles 'svn' scheme
> * ra_local : Module for accessing a repository on local disk.
>   - handles 'file' scheme
> * ra_serf : Module for accessing a repository via WebDAV protocol using serf.
>   - using serf 1.3.8
>   - handles 'http' scheme
>   - handles 'https' scheme
>
> $ perl --version
>
> This is perl 5, version 22, subversion 0 (v5.22.0) built for
> x86_64-linux-thread-multi
>
> Copyright 1987-2015, Larry Wall
>
> Perl may be copied only under the terms of either the Artistic License or the
> GNU General Public License, which may be found in the Perl 5 source kit.
>
> Complete documentation for Perl, including FAQ lists, should be found on
> this system using "man perl" or "perldoc perl".  If you have access to the
> Internet, point your browser at http://www.perl.org/, the Perl Home Page.
>
> I don't know exact version of Subversion on the remote server (web ui
> doesn't show it).
> Core dump: http://madkite.cc/git/core.git-svn.1000.e28aeb54778749879c9313b05ea040e8.26467.1439282047000000.lz4
>
> I have tried on another environment (cygwin x64, git 2.4.5, svn
> 1.8.13, perl 5.14.4) - it works fine with the same repo.
> Also my environment works fine with other repos.
>
> Is there anything else you need from me?
>
> Best regards, Roman.
