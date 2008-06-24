From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 13:21:57 +0200
Message-ID: <1214306517.6441.10.camel@localhost>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB6by-0000YQ-7U
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYFXLWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 07:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYFXLWB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:22:01 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:47624 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYFXLWA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:22:00 -0400
Received: by hu-out-0506.google.com with SMTP id 28so13117061hub.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 04:21:59 -0700 (PDT)
Received: by 10.86.98.14 with SMTP id v14mr8816840fgb.74.1214306518677;
        Tue, 24 Jun 2008 04:21:58 -0700 (PDT)
Received: from ?192.168.11.104? ( [129.132.78.250])
        by mx.google.com with ESMTPS id e20sm11917189fga.1.2008.06.24.04.21.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 04:21:58 -0700 (PDT)
In-Reply-To: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86035>

On Tue, 2008-06-24 at 14:15 +0300, Erez Zilber wrote:
> Hi,
>=20
> I'm able to git-clone a tree using ssh:
>=20
> [root@kd001 t]# git-clone
> ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_t=
est/.git/
> erez.zilber@kites's password:
> remote: Counting objects: 9, done.
> remote: Compressing objects: 100% (5/5), done.
> remote: Total 9 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (9/9), done.
>=20
> However, it doesn't work with http/https/git:
>=20
> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.gi=
t
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_t=
est/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
>=20

Maybe you should run git-update-server-info in the repository on the
server?

> [root@kd001 t]# git-clone https://kites/pub/git/erez.zilber/my_test.g=
it
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_t=
est/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?


=EF=BB=BFMaybe you should run git-update-server-info in the repository =
on the
server?

By the way, try enabling the post-update hook -- it runs
update-server-info for you automatically after pushing to your server
(make the script $GIT_DIR/hooks/post-update executable)

> [root@kd001 t]# git-clone git://kites/pub/git/erez.zilber/my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_t=
est/.git/
> kites[0: 172.16.1.11]: errno=3DConnection refused
> fatal: unable to connect a socket (Connection refused)
> fetch-pack from 'git://kites/pub/git/erez.zilber/my_test.git' failed.
>=20

Is the git daemon running on your server? You need to configure inetd o=
r
git-daemon yourself, that is not done automatically for you.


--=20
http://spinlock.ch/blog/
