From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sat, 17 Apr 2010 21:29:00 -0500
Message-ID: <20100418022900.GA1669@progeny.tock>
References: <1271551934-sup-1118@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 04:29:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3KGF-0001nI-HI
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 04:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab0DRC3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 22:29:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49830 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab0DRC3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 22:29:07 -0400
Received: by gyg13 with SMTP id 13so2041149gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PhbiBPkQXvBZQFCnLfuFavISZ8wOgs9H/38JJfibHnE=;
        b=qr/yUcaCAkU21KHAF3YUGIEX3CUyZ+KJyd3/RxvPbUzOiP2ulxtZNmJoVwcupqpSct
         C+TeBS4a38BClPu07TtEcOiuDIJqytqR99e9X5dCUL8vWYGyd9rMQwv+a2xFEGp/qDXK
         0UzXmlUKl3mPj7MOuUxB86gEktKSWmrjuBk3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=k0w5EoedLz9ApKx3q5V+5HDhMyl5XPkASpCcumWIqYmxFnZHPiWPAyzs8p+jUhePo3
         V67GPCP3nk0MOW8cfaAL1TqUnmxWNMmrjYmUO3wKyZVtYn/0tTusmq+T0yxGFh6z55SU
         Opq+XZ5ANszFSyv9CuYEGqeCXj7S601zMNpzY=
Received: by 10.150.194.20 with SMTP id r20mr4060644ybf.7.1271557746014;
        Sat, 17 Apr 2010 19:29:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3413087iwn.6.2010.04.17.19.29.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 19:29:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271551934-sup-1118@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145204>

I=E2=80=99m not a remote helper expert, but I=E2=80=99ll review it to g=
et the ball
rolling.  I assume you=E2=80=99ve already gone through this a lot.  Mos=
t of
what=E2=80=99s left is nitpicks.

Ramkumar Ramachandra wrote:

> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
[...]
> -These programs are normally not used directly by end users, but are
> -invoked by various git programs that interact with remote repositori=
es
> -when the repository they would operate on will be accessed using
> -transport code not linked into the main git binary. Various particul=
ar
> -helper programs will behave as documented here.
> +Remote helper programs are normally not used directly by end users,
> +but are invoked by git when it needs to interact with remote
> +repositories.

nitpick: comma usage.  Probably the simplest fix would to add a
subject after ", but".

  Remote helper programs are normally not used directly by end-users,
  but they are invoked by git when it needs to interact with remote
  repositories over transports git does not support natively.

> +They implement a subset of the capabilities documented
> +here, and conform to the "remote helper protocol". When git needs
> +needs to interact with a repository served by a remote helper, it
> +spawns the helper as an independent process and interacts with it ov=
er
> +the specified protocol.

Pedantic usage nitpick: I think by =E2=80=9Cinteracts with it over the
specified protocol=E2=80=9D here, you mean =E2=80=9Cinteracts with it a=
ccording to the
aforementioned protocol=E2=80=9D.  It would probably be simpler to skip
mention of the protocol altogether, like this:

  A given helper will implement a subset of the commands documented
  here.  When git needs to interact with a repository using a remote
  helper, it spawns the helper as an independent process, sends
  commands to the helper=E2=80=99s standard input, and expects results =
from
  the helper=E2=80=99s standard output.  Because a remote helper runs a=
s an
  independent process from git, there is no need to re-link git to add
  a new helper, nor any need to link the helper with the
  implementation of git.

[cutting everything up to]
> +
> +All the capabilities of remote helpers have to do with discovering a=
nd
> +updating remote refs, transporting objects between local and remote,
> +and updating the local object store.

Odd phrasing: this does not actually explain what capabilities are.

  Every helper must support the "capabilities" command, which git will
  use to determine what other commands the helper will accept [*].  Oth=
er
  commands generally concern facilities like discovering and updating
  remote refs, transporting objects between the object database and
  the remote repository, and updating the local object store.

[*] and to read in refspecs for remote-tracking branches.  This seems
silly (and would not scale well too many refspecs) --- why doesn=E2=80=99=
t git
take responsibility for reading the refspecs from .git/config itself?

> +Using the 'fetch' capability,
> +they can discover refs on the remote, transfer objects from the remo=
te
> +reachable via those refs to local, and update the local object
> +store.

Does =E2=80=9Cthey=E2=80=9D refer to the helpers or their capabilities?=
  Best to avoid
the question:

  Helpers supporting the 'fetch' capability can discover refs from the
  remote repository and transfer objects reachable from those refs to
  the local object store.

The original phrasing separated transfer from inclusion in the object
db, but it is not clear to me why.

> +Using the 'push' capability, they can transfer objects from
> +local to remote, and update the corresponding refs as necessary.

It seems confusing to talk about corresponding refs here: if two
branch heads point to the same commit, which is the corresponding
ref?

  Helpers supporting the 'push' capability can transfer local objects
  to the remote repository and update remote refs.

> +
> +Git comes with a "curl" family of remote helpers, that handle variou=
s
> +transport protocols, such as 'git-remote-http', 'git-remote-https',
> +'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilit=
ies
> +'fetch', 'option', and 'push'.

With the above changes (or whatever subset you think is suitable),

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-r=
emote-helpers.txt
index 15214ae..9d86c26 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -13,25 +13,26 @@ DESCRIPTION
 -----------
=20
 Remote helper programs are normally not used directly by end users,
-but are invoked by git when it needs to interact with remote
-repositories. They implement a subset of the capabilities documented
-here, and conform to the "remote helper protocol". When git needs
-needs to interact with a repository served by a remote helper, it
-spawns the helper as an independent process and interacts with it over
-the specified protocol. git sends commands to the helper
-over standard input, and receives the result written to standard
-output by the helper over a pipe. Because a remote helper runs as
-an independent process to interact with remote repositories, there
-is no need to re-link git when adding a new helper nor need to link
-the helper with the implementation of git.
+but they are invoked by git when it needs to interact with remote
+repositories git does not support natively.  A given helper will
+implement a subset of the capabilities documented here. When git
+needs to interact with a repository using a remote helper, it spawns
+the helper as an independent process, sends commands to the helper's
+standard input, and expects results from the helper's standard
+output. Because a remote helper runs as an independent process from
+git, there is no need to re-link git to add a new helper, nor any
+need to link the helper with the implementation of git.
=20
-All the capabilities of remote helpers have to do with discovering and
-updating remote refs, transporting objects between local and remote,
-and updating the local object store. Using the 'fetch' capability,
-they can discover refs on the remote, transfer objects from the remote
-reachable via those refs to local, and update the local object
-store. Using the 'push' capability, they can transfer objects from
-local to remote, and update the corresponding refs as necessary.
+Every helper must support the "capabilities" command, which git will
+use to determine what other commands the helper will accept.  Other
+commands generally concern facilities like discovering and updating
+remote refs, transporting objects between the object database and
+the remote repository, and updating the local object store.
+
+Helpers supporting the 'fetch' capability can discover refs from the
+remote repository and transfer objects reachable from those refs to
+the local object store. Helpers supporting the 'push' capability can
+transfer local objects to the remote repository and update remote refs=
=2E
=20
 Git comes with a "curl" family of remote helpers, that handle various
 transport protocols, such as 'git-remote-http', 'git-remote-https',
