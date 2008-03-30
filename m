From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: why multiple password prompts?
Date: Sun, 30 Mar 2008 16:34:57 -0400
Message-ID: <3e8340490803301334g2127451cu6e9dc71eefa6241c@mail.gmail.com>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
	 <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 22:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg4Ft-0005Ji-Dj
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbYC3UfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYC3Ue7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 16:34:59 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:13047 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbYC3Ue6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 16:34:58 -0400
Received: by py-out-1112.google.com with SMTP id u52so1826644pyb.10
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qdi9J9KXb0+PgB6nTHVBHPXsdw9rmDzG8Azn+w9dBGg=;
        b=n1ydg5mW89THvDyiHIlzxAdme8exkv3tvd/jFmpS8s5X9r6grBCvKiIW06pxttUbYIknA5yyXXQ7NF8LgCAMdLGmMNfzc+t5OTVe/Udj8Kt2w5O1gNgr78uhWKymCfUrBdwboCHQAI81O2P44YpggDra83DGpETmEAvLivlZG6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jTVFYY7fmZovwj5PQyaftdh1MXTC9gzQh6VTJVEMIG0PoQRwmH474z1+86cDw/9wCR/Z4DwelWlliPq9B0uo6NZ3nsEng/vuCe4t4pT+melCdWVb+oZdYEACT5Hw1VywD1rL9mxFJl179AFFR5r3bPF85k8JW97D/f3tBqTYPWc=
Received: by 10.64.199.2 with SMTP id w2mr11830317qbf.51.1206909297277;
        Sun, 30 Mar 2008 13:34:57 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Sun, 30 Mar 2008 13:34:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78512>

On Sat, Mar 29, 2008 at 12:48 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sat, 29 Mar 2008, Paul wrote:
>
>  > When I do a simple git-pull over SSH, why does it typically prompt me for my
>  > SSH password two or three times? And no, I am not inputting it wrong.
>
>  In some versions of git, it makes separate connections to find out what
>  the remote's state is and to fetch the actual data. A third connection
>  should only be needed if there are new tags to fetch, and that would be
>  after some of the messages.
>
>  One of the changes in the upcoming release is to reduce this to one,
>  except for an occasional second one.

git.git's master branch seems to be hitting ssh twice fairly reliably...
[bd@shion git-test] SSH_AUTH_SOCK= ~/src/git/git-pull
bd@130.111.246.25's password:
bd@130.111.246.25's password:
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2)remote: , done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From ssh+git://bd@130.111.246.25/home/bd/git-test
   b0b8450..57a92a7  master     -> origin/master
Updating b0b8450..57a92a7
Fast forward
 fob |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
[bd@shion git-test] ~/src/git/git --version
git version 1.5.5.rc2

The remote's still on 1.5.4.4 if it matters...
