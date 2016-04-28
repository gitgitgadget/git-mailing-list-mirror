From: Stefan Beller <sbeller@google.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 09:35:26 -0700
Message-ID: <CAGZ79ka9v0v4gwtbiojR5o89JWLDZYkDM2CmhySeXXKYaiLQig@mail.gmail.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<CAH6n4TfvybZyAYLkzyjfaP=2ZkirpacTgVQApF3bZT-j8=_Qng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew J <andj2223@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avouZ-0008UR-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcD1Qf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:35:28 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36091 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbcD1Qf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:35:27 -0400
Received: by mail-io0-f174.google.com with SMTP id u185so95164168iod.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RqiSmtm0Jc7TFZ3+Nizfx1tfao5YnXmPYeLumbLWww8=;
        b=GKgjalNXYrp/Csi13YGUY0rzJAAkmZ/eDmNAmFS5TLHAGsABnYj9oXES76XIEyWG1n
         H0Y4bMId+XxKmophERJY0bpXEGYw2qusAp1cQd9r8wvok/vobbeFlRdvwvsSryuHKU1e
         w9iO4vhO+5oomWb6TI1ehE3AYh1S+pez1p+nOC6s/rRx9SZaS3IVH2lz7v0hou42PLMV
         aDR50IPgMPqy5z7feMMQy2/LuzTh9cENAAn2+4az1sFhPtktOMejMPlPXCMmqvWWU7+4
         rUmiwx5v2Kxqd8VMyr91BfngrQPawb0wtwttW6s/DBzDis+40W5Vvb4HSL8wribRwSCz
         4xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RqiSmtm0Jc7TFZ3+Nizfx1tfao5YnXmPYeLumbLWww8=;
        b=AsUHxLxitwrCxCVC5hYo4jy4HIOsSClHtQ5rgyk3BchpiWkaAY49xM3ymGzv80/cgD
         CRz/V/3Q0D82VdgT6fniNp4n4Doq1m+UrTABUOkVREzNXP6trt6r5zBMzhCdlk4GCNv9
         blB1TiNqt1w/vXr59OuAgh2enh0NfihhBcTqCP+Yh5LJZigDSINS6WAHlX/AmpKE9QWW
         PN/YXP7ZVOFTKBTXhU14qcRMVmItdECQcXaZvs7TbdMCtcwlYrTfBjir2U/wcnQv9lbI
         LHauqgYW31/5gp2ZNTy0y1rjZuk+XOk6niaVlsUB0am3XFuzcWGyJbjfgt5DyhoKhin0
         5aFQ==
X-Gm-Message-State: AOPr4FUyBbfgZX02KfBEXHc61qx4d/WJ69ArWi9AzIXQ+AyOliqr8A60i9iUM0ItLHn/7XdFo58cika0pOY37DTq
X-Received: by 10.107.53.200 with SMTP id k69mr18429873ioo.174.1461861326191;
 Thu, 28 Apr 2016 09:35:26 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 09:35:26 -0700 (PDT)
In-Reply-To: <CAH6n4TfvybZyAYLkzyjfaP=2ZkirpacTgVQApF3bZT-j8=_Qng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292916>

On Wed, Apr 27, 2016 at 11:10 PM, Andrew J <andj2223@gmail.com> wrote:
> Hi Stefan,
>
> On Wed, Apr 27, 2016 at 9:08 AM, Stefan Beller <sbeller@google.com> wrote:
>> I think (pure speculation), that it the error is in the context
>> (repository) switching logic.
>> What happens if you alter the order, i.e. give testfile first and then
>> the files in the nested
>> repos?
>
> Interestingly, reversing the order produces the same result (the
> testfile is added, the nested files are not).
>
> I've also noticed that running something like 'git status testfile
> nestedfiles' results in the nested files being omitted from the git
> status output; I'd expect them to be printed by git-status as
> untracked files. So it appears the problem is not isolated to git-add.

Looking at the code, git-add uses parse_pathspec, which is used my
most commands[https://github.com/git/git/blob/master/builtin/add.c#L364]
and I think that function needs to learn to cover paths for different
repositories.
Maybe we can pass in a flag, which allows parse_pathspec to get files from
the different repos and then it's up to each command how to deal with that
list of files.



>
> To give some context, my use case is that I have a parent project that
> links to numerous chromium libraries, thus my parent project needs
> access to many of chromium's headers at build time. I wanted to make
> these headers available to other developers without them needing to
> check out all of chromium.
> So I add all the chromium headers to the parent project with something like:
> find deps/chromium/src -name "*.h" | xargs git add --
> I was weirded out to find that many of the header files weren't being
> added, as I've already described.
>
> I ultimately worked around this by doing:
> find chromium/src -name "*.h" | xargs -n 1 git add
> Since each file gets added separately, this is quite slow. So it'd be
> nice if this little bug was fixed someday :)
>
> As you probably know, Chromium is comprised of many hundreds of nested
> repos, so that aided in manifesting this issue.
>
> Thanks,
> Andrew
