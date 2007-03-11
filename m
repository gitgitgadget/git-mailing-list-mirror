From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 21:18:49 +0700
Message-ID: <fcaeb9bf0703110718i70742b8frca4d0df78bff214d@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
	 <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
	 <20070311133350.GA12553@moooo.ath.cx>
	 <fcaeb9bf0703110646p5417048bx27f119679c01e988@mail.gmail.com>
	 <20070311140553.GA18947@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Matthias Lederhofer" <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 15:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQOsw-0006gp-OK
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 15:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933659AbXCKOSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 10:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933663AbXCKOSv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 10:18:51 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:14525 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933659AbXCKOSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 10:18:50 -0400
Received: by an-out-0708.google.com with SMTP id b33so1198703ana
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 07:18:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3U8ihwLg96Btg0qwy97QVkALa8meSzZd6jQ39ED3bzgstBPMMOEB26qo6doMGnuexGHGr8vb8RlHhwahUIvGt8m2LojVTVfs45Sh6ydauAjNqKvOUrQECYpwZJNiMATCHyAFtZ8mCUB7GIcM3iu7MbFRy7fF5nKg0k1FaXK8uE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NEkb6Lc7AAfKecb3D1Ap5d0IBwMZUpo85kqSxzvkZYIowWyxwjLXtLIpWa2QpBvw3PuwHEMWos4bl6FTBdDNr8Vgwm9uesrXEjsCcdQTHbjLfEHsVOyjxWnxPHyXQTv1ungf21uCC8fOtH0R3XXZ7nWsMRj+00E3ciiqBMkRfzA=
Received: by 10.114.13.1 with SMTP id 1mr835510wam.1173622729867;
        Sun, 11 Mar 2007 07:18:49 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Sun, 11 Mar 2007 07:18:49 -0700 (PDT)
In-Reply-To: <20070311140553.GA18947@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41927>

On 3/11/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > Yes I expected it to move the specified working directory as described
> > in the previous mail (copied/pasted below). However the patch requires
> > me to be in workdir somewhere already (which is fine if that is your
> > expectation). If that's the case, maybe you should tell users
> > something about GIT_WORK_DIR not applicable.
>
> Let's say we have GIT_DIR=/tmp/git GIT_WORK_DIR=/tmp/foo and are in
> /tmp.  You want `git add bar` to chdir to /tmp/foo and add the file
> bar from /tmp/foo?

Yes. I wanted it for easy scripting but it's not very intuitive from
command line. I'd take it back.

>
> > >Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > >> By the way, is it plausible to add --git-workdir option to specify
> > >> working directory? With that option, I won't need to _chdir_ to the
> > >> working directory, run git commands and _chdir back_.
> I thought you meant the chdir to the toplevel directory when you're in
> a subdirectory.  For this case I'd rather suggest
> mygit() {
>     old=$(pwd)
>     cd "$MYTOPDIR"
>     git "$@"
>     ret=$?
>     cd "$old"
>     return $ret
> }
>
Thanks, will try

-- 
Duy
