From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Mon, 1 Nov 2010 18:38:44 +0100
Message-ID: <AANLkTimdJgobR_C2cCA7oLHc2Yr9YsSobqsMMueN=XAE@mail.gmail.com>
References: <loom.20101101T182113-378@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Drews <paul.drews@intel.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 18:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCyLh-0001q4-1N
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 18:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab0KARjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 13:39:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40714 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab0KARjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 13:39:06 -0400
Received: by gyg4 with SMTP id 4so3348297gyg.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5ApWmIL23JH65sbANXufoEW4jfz5OblAwszLOoFMDoU=;
        b=uSuygK8dO/CalwcIolq3LS8IlCYpyGqwtwFnqAOY/nY+Wi+qenb63FfnaRYLavHqnE
         xHHvlRh2hC0t5tCbj1wsyQ3jCuzx4aQ394kbbDGnIQgCEVayCae0GaQilzjuN0mqBYrT
         3fVgj+mlZyANi0Fb17SZQ62ARS0jo+02W2HHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vr0vTHDDq2R2ts0lamxhaCvENiTFgn7li4q3uZZ/4rUIPqPf/HuwFVSGBiJviW1LDn
         A10D2N+UWwYr5mISGo4Qk70O1IT9xsFDF9U4bHE63nfQr+XPW8HX3MV0n8KQqAk7Jfe6
         1qt/BJrgHQSJataY2XjFthYSr8B6IDc90b/54=
Received: by 10.151.105.19 with SMTP id h19mr27932663ybm.369.1288633144567;
 Mon, 01 Nov 2010 10:39:04 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Mon, 1 Nov 2010 10:38:44 -0700 (PDT)
In-Reply-To: <loom.20101101T182113-378@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160490>

[+Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, who is currently working o=
n improving/fixing
how git handles worktree detection]

On Mon, Nov 1, 2010 at 18:22, Paul Drews <paul.drews@intel.com> wrote:
> I'm observing an unexpected error from "git rebase" run from the dire=
ctory
> containing the ".git" directory:
>
> $ git --version
>
> git version 1.7.3.GIT
> (includes up to commit ca2090 from git repository at
> http://www.kernel.org/pub/scm/git/git.git)
>
> $ mkdir wherefilesare
> $ mkdir wheregitis
> $ cd wherefilesare
> $ echo "Here is a line from the original" > myfile.txt
> $ cd ../wheregitis
> $ git init
> $ git config core.worktree /absolute/path/to/wherefilesare/
> $ git add .
> $ git commit
> $ git branch mybranch
> $ git checkout mybranch
> $ vim ../wherefilesare/myfile.txt
> $ git add .
> $ git commit
> $ git checkout master
> $ vim ../wherefilesare/myfile.txt
> $ git add .
> $ git commit
> $ git checkout mybranch
> $ git rebase master
>
> fatal: /usr/libexec/git-core/git-rebase cannot be used without a work=
ing tree.
>
> Since I'm in the directory containing ".git" at this point, the ".git=
" directory
> and the worktree can be unambiguously found. =C2=A0Other commands bes=
ides "git
> rebase" work. =C2=A0I would expect "git rebase" to work as well. =C2=A0=
Is this a bug or an
> unreasonable expectation on my part?

Sounds like a bug.

--=20
Cheers,

Sverre Rabbelier
