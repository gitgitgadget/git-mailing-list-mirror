From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: symlinks
Date: Sun, 7 May 2006 22:28:32 +0300
Message-ID: <f36b08ee0605071228s40832980k3fd045e8fa0ba84@mail.gmail.com>
References: <f36b08ee0605071047h32ccef4bk76ac360ada1331a@mail.gmail.com>
	 <Pine.LNX.4.64.0605071104230.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 21:28:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcovn-0004Bm-Lv
	for gcvg-git@gmane.org; Sun, 07 May 2006 21:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWEGT2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 15:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWEGT2e
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 15:28:34 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:24140 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932214AbWEGT2d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 15:28:33 -0400
Received: by py-out-1112.google.com with SMTP id x31so1285622pye
        for <git@vger.kernel.org>; Sun, 07 May 2006 12:28:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeCo9zSO/mkq+g2OnVna9ZRbZirRPweyCmnrrEamUTPr0nJCOdekf20ArVqp0GA8s+WgGUHUOy0BCLcwiYnPXmz+cIAed2Hye44LBajXetGzaYLNP+y9pR1/2JnGkGrTB7IgQOkJis8hLmQ+ozHXjHMRdUhAM3SSUcJlBdhKd7w=
Received: by 10.35.9.2 with SMTP id m2mr1363691pyi;
        Sun, 07 May 2006 12:28:32 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Sun, 7 May 2006 12:28:32 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605071104230.3718@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19715>

On 5/7/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sun, 7 May 2006, Yakov Lerner wrote:
> >
> > I have a project that makes heavy use of symlinks in the source tree.
> > I added it to git, then cloned the repository, and all symlinks were
> > converted to plain files. What am I missing to preserve symlinks ?
>
> You're not missing anything, it sounds like a bug. What did you use to
> clone, and what version? It definitely doesn't happen for me:
>
>        mkdir symlink
>        cd symlink/
>        git-init-db
>        ln -s unknown new-link
>        ls -l
>        git add new-link
>        git commit
>
>        cd
>        git clone symlink symlink2
>        cd symlink2/
>        ls -l
>
> shows that the symlink was preserved.

Yes, I see now it's not git problem. I suspect
I just incorrectly copied the files into git-init-db directory,
something like 'cp -r' instead of 'cp -a' or tar/cpio. Sorry I'm
new to git.

Thanks
Yakov
