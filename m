From: John Tapsell <johnflux@gmail.com>
Subject: Re: remotely deleting a branch
Date: Mon, 1 Jun 2009 12:02:23 +0100
Message-ID: <43d8ce650906010402t792df314v1ed632e79f42bca7@mail.gmail.com>
References: <1de9d39c0906010316v657f2624i3f16b8b5bea73122@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB5Hm-0001AB-K4
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 13:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbZFALCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbZFALCW
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 07:02:22 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:57111 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZFALCV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2009 07:02:21 -0400
Received: by gxk10 with SMTP id 10so12837005gxk.13
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0dxgpT0h40rKW38ftbWyQDvgZTXk7kMIo7TnwONw9WE=;
        b=IerjebG9rTYIrDQMvZ2+J7Hj4mCYjVD3HWWT+IpZMPLBRqvm2Fri2X5+1sggkeX2Od
         f7BDmQfcyDlw8B4XvDePy2IONYrjMBi5SFsykLQ5KkQVLptiHLOO7Ac3Luq7zfGliv3+
         +V0ku5O+DoyjYIA25+xbgur5OdsNNLjgfDJy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vasM07Ygp24cf3AKWMY4nNbmWaWkwefzlCzbkMAIYKK+dY+ZVNp/Z5Bf9hh4od26tr
         R9Z/TX6P7PZcJ/mI+vO66dRExouTj+cj4RIik+ntp9KqgV4QlGdaxOaza/f0rIy55/O7
         zHq0dHj5lYp6efkgEbFbfTn5Ca5E297MU1b1s=
Received: by 10.151.139.4 with SMTP id r4mr11485014ybn.109.1243854143613; Mon, 
	01 Jun 2009 04:02:23 -0700 (PDT)
In-Reply-To: <1de9d39c0906010316v657f2624i3f16b8b5bea73122@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120460>

2009/6/1 jean-luc malet <jeanluc.malet@gmail.com>:
> hi!
> I created a remote branch by doing
> $ git push origin mynewbranch
> I done some work on mynewbranch, commited, pushed changes to origin,
> merged it to master and pushed to origin and deleted the mynewbranch
> localy because I don't need it anymore
> now I want to "undo" the git push origin mynewbranch ie remotely
> delete the branch from the repository
> I tried git push --mirror but it deleted all remote branches that I
> didn't worked on... I don't want to have it be a mirror... but
> something like
> $ git branch -r -d origin/mynewbranch
> $ git push
> =C2=A0 ---> deleting origin/mynewbranch
>
> how shall I do that?

Yeah, it's pretty confusing on how to delete a remote branch.  The
magic command is:

git push origin -f :mynewbranch

Hopefully someone will figure out a way to make git a bit more
intuitive in this respect.  Maybe a remote option for git branch -d or
something.
John
