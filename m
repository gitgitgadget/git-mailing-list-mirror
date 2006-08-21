From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Recover from a bad push in StGit
Date: Mon, 21 Aug 2006 16:55:28 +0100
Message-ID: <b0943d9e0608210855m71c29a21y3d4941ec721e0737@mail.gmail.com>
References: <200608190030.47257.robin.rosenberg.lists@dewire.com>
	 <tnxk652torl.fsf@arm.com>
	 <200608211703.59873.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 17:58:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFC7j-0003lP-Qt
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWHUPza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWHUPza
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:55:30 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2176 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932084AbWHUPz3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 11:55:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so2535205pyg
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 08:55:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IiJy19AY5zo08MZOb+PN+YAGda7MXcqbWUZ8WDhNkva36v9w9UxOPbBZMjpLwE5AVIDakjh9NgYKwlu4NfSil2Q+dIQjeRUGuViyi2z99JXgG0yLLbmouUNpT7hhjBND7mIZVyLYzSadOMqyWI2lAitx/3v+1425tg5ZuYW6cuU=
Received: by 10.35.117.5 with SMTP id u5mr13535450pym;
        Mon, 21 Aug 2006 08:55:28 -0700 (PDT)
Received: by 10.35.37.16 with HTTP; Mon, 21 Aug 2006 08:55:28 -0700 (PDT)
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200608211703.59873.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25801>

On 21/08/06, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> m=E5ndag 21 augusti 2006 11:35 skrev Catalin Marinas:
> > "stg push --undo" (the same option for "refresh"; maybe I should ad=
d a
> > separate "undo" command) resets the local changes and it restores t=
he
> Not necessarily, but a hint about --undo when push/pop fail would hav=
e
> helped me.

It is in the "stg help push" output but I could just display it when
the conflict happened.

> > original boundaries of the patch (no information is lost). You coul=
d
> > use the latest snapshot as it has some bug-fixes from release 0.10.
>
> Does refresh --undo make me see the state of the patch like it was be=
fore last
> refresh, ie. stgit remembers the history of my patces? I thought it d=
ropped
> the references as obsolete.

The references before the last command are stored and they can be
obtained by "stg id <patch>//(bottom|top).old". As long as you haven't
run a git prune on your repository, you should be able to undo the
refresh.

I'm (slowly) working on patch history support using reflogs and (when
ready) you should be able to retrieve a previous state of the patch as
long as you haven't pruned your GIT repository.

--=20
Catalin
