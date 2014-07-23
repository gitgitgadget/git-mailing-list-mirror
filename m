From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Wed, 23 Jul 2014 16:17:56 +0200
Message-ID: <53CFC414.1010601@gmail.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:18:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9xMo-0006Hq-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 16:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaGWOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 10:17:58 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49249 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaGWOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 10:17:57 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so2338462wiv.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5fUwvmCp4ceXQjP8Mz4g2Dogghv9uZ6GBG3Y1StbrxY=;
        b=Kn25Lgrh1hqJs7xw4Te8LuiQtlH+F6BzpXUqaW/+RfKjbqjVLuUJlWNCK8t3jd73uf
         JByQJgtKcZHOnLaS+PEN0dfqAj43zmeuNejz8/5W9SZXTtm81GcC495JMAeAUGb8Q5ZJ
         h5iTVb8KIxWKawht2f5mUs7NGHukapl6njjp2xo0IBDtjAcqA1tA1lAU6rQGBYhICFjY
         I0IwamQjq8V+2N0W87drjdFmhLaDBrbx8a6zIqLk/eAm+1FIy/0143w2sCopdpWT18Xf
         P9apeDpZq//PFmc2pIJQ+wEg3VUEqudq+DK+kzya6bCe15ilsNj/jhZ2YQNSRFS116qV
         +WBQ==
X-Received: by 10.180.36.18 with SMTP id m18mr3574872wij.74.1406125074925;
        Wed, 23 Jul 2014 07:17:54 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jv9sm6610336wjc.28.2014.07.23.07.17.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 07:17:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254078>

Am 22.07.2014 23:44, schrieb Junio C Hamano:
> 
> * sk/mingw-uni-fix-more (2014-07-21) 14 commits
>  - Win32: enable color output in Windows cmd.exe
>  - Win32: patch Windows environment on startup
>  - Win32: keep the environment sorted
>  - Win32: use low-level memory allocation during initialization
>  - Win32: reduce environment array reallocations
>  - Win32: don't copy the environment twice when spawning child processes
>  - Win32: factor out environment block creation
>  - Win32: unify environment function names
>  - Win32: unify environment case-sensitivity
>  - Win32: fix environment memory leaks
>  - Win32: Unicode environment (incoming)
>  - Win32: Unicode environment (outgoing)
>  - Revert "Windows: teach getenv to do a case-sensitive search"
>  - tests: do not pass iso8859-1 encoded parameter
> 
>  Most of these are battle-tested in msysgit and are needed to
>  complete what has been merged to 'master' already.
> 
>  A fix has been squashed into "Unicode environ (outgoing)"; is this
>  now ready to go?
> 
> 
> * sk/mingw-tests-workaround (2014-07-21) 6 commits
>  - t800[12]: work around MSys limitation
>  - t9902: mingw-specific fix for gitfile link files
>  - t4210: skip command-line encoding tests on mingw
>  - MinGW: disable legacy encoding tests
>  - t0110/MinGW: skip tests that pass arbitrary bytes on the command line
>  - MinGW: Skip test redirecting to fd 4
>  (this branch is used by jc/not-mingw-cygwin.)
> 
>  Make tests pass on msysgit by mostly disabling ones that are
>  infeasible on that platform.
> 
>  The t0110 one has been replaced; is this now ready to go?
> 

Yes, I think both series are ready.

Compiles with msysgit and MSVC (with NO_CURL=1).

With the version in pu, three tests fail. t7001 is fixed with a newer 'cp'.
The other two are unrelated (introduced by nd/multiple-work-trees topic).

* t1501-worktree: failed 1
  As of 5bbcb072 "setup.c: support multi-checkout repo setup"
  Using $TRASH_DIRECTORY doesn't work on Windows.
  
* t2026-prune-linked-checkouts: failed 1
  As of 404a45f1 "prune: strategies for linked checkouts"
  Dito.

* t7001-mv: failed 6
  'cp -P' doesn't work due to outdated cp.exe.
