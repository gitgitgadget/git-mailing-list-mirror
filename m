From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git .lock file error
Date: Sun, 19 Sep 2010 22:42:11 -0400
Message-ID: <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 04:42:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxWKz-0006fa-TD
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 04:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab0ITCmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 22:42:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36763 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab0ITCmb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 22:42:31 -0400
Received: by iwn5 with SMTP id 5so3870042iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=c+QocQpAyfeGVtIaCfH0l3sBNYQYxnIMmnnPQbFWnPI=;
        b=T9mZpUU1jexNzeSe73Kjuye1Him3Dm4Y9orkWcXwOWht9w6c5Obt8qKOqD4kr8xytj
         ZdmPbQ2yjCHNaIn+ZmBpvffLXz3SKN4snIkqQZfp3/MNyGX+u1DDVNSX6k/uDDYNlpGM
         5jJJSWfZtGVMfcjXL+1APgIRfnk6Z59GN+nxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=iLXhuzj37emVRtaoSzDYZbvxJasdr8nQixhaubvkWXK48uGHP/GINWEsPIoKoZPKYT
         ZxS2wBr0qoo0+Kxf/VuKOZjT7JYuRYgxwbFsHR6Tc42NYE64CxZz7MfNxSFIeWtILLKd
         aIp7MAsH20wPV8+YHnYOkS6d5Sj9iia25Hsi8=
Received: by 10.231.183.67 with SMTP id cf3mr9353700ibb.187.1284950551299;
 Sun, 19 Sep 2010 19:42:31 -0700 (PDT)
Received: by 10.231.113.141 with HTTP; Sun, 19 Sep 2010 19:42:11 -0700 (PDT)
In-Reply-To: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156548>

Hello again,

I realized I have=A0git-cheetah running as well, so I killed
explorer.exe (the only process using git_shell_ext.exe), and tried
again. That's when I noticed that running 'git=A0svn=A0fetch' spawned t=
wo
git=A0processes and a perl process (which later spawned another perl).
Is this something that should be happening?

Thanks,
-Nate

On Mon, Sep 13, 2010 at 11:19 AM, Nate Parsons <parsons.nate@gmail.com>=
 wrote:
>
> Hi everyone,
>
> I'm trying to switch to git, so I apologize in advance for my
> ignorance. For this, I'm using cygwin git, version 1.7.1 to talk to a
> svn server running 1.4.2.
>
> When I 'git svn clone' or 'git svn clone; git svn fetch', I sometimes
> run into the following error.
> > Couldn't open .git/svn/refs/remotes/0.0.0/.rev_map.b8cad480-e46b-48=
b4-8317-a683ee46c2bd.lock: Device or resource busy
> > =A0at /usr/lib/git-core/git-svn line 5210
>
> And when I 'git svn rebase'
> >=A0Couldn't open .git/svn/refs/remotes/git-svn/.rev_map.cc05479a-e8e=
a-436f-8d71-e07493b7796c.lock: Device or resource busy
> > at /usr/lib/git-core/git-svn line 1528
>
> Sometimes the line number is different (578, I think?), but when I
> retry the fetch command, it rebuilds the file corresponding to the
> lockfile, and then continues a little farther before dying again.
>
> When I watch the directory in question, I see the lock file appear,
> and then disappearing a short time after the script gives up.
>
> I don't have a series of steps to reproduce the problem, sometimes it
> goes for an hour, and sometimes for just a few minutes/seconds.
>
> I do have TortoiseGit running my machine, but this issue happens even
> when TGitCache.exe is not running. If some other instance of git is
> accessing the repository, I don't know which or how.
>
> Thanks,
> -Nate
