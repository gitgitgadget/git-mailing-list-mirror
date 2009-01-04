From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] git-web--browse: don't add start as candidate on Ubuntu
Date: Sun, 4 Jan 2009 08:33:25 +0100
Message-ID: <200901040833.25849.chriscool@tuxfamily.org>
References: <495D3964.6040006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jan 04 08:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJNUj-0002fE-Ng
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 08:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbZADHch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 02:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbZADHch
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 02:32:37 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:43569 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbZADHcg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 02:32:36 -0500
X-Greylist: delayed 93173 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jan 2009 02:32:34 EST
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 18C0B940053;
	Sun,  4 Jan 2009 08:32:26 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DAE76940069;
	Sun,  4 Jan 2009 08:32:23 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <495D3964.6040006@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104496>

Le jeudi 1 janvier 2009, Ramsay Jones a =E9crit :
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi *,
>
> When upgrading to v1.6.1, I noticed that the html help had stopped
> working on Linux (Ububtu), viz:
>
>     $ git help -w tag
>     start: Need to be root
>
> So, after squinting at git-web--browse.sh, I tried a few things:
>
>     $ ls /bin/start
>     ls: /bin/start: No such file or directory
>     $ test -n /bin/start; echo $?
>     0
>     $ which start
>     /sbin/start
>     $ start fred
>     start: Need to be root
>     $ ls -l /sbin/start
>     lrwxrwxrwx 1 root root 7 2007-06-24 19:45 /sbin/start -> initctl*
>
> So, it would seem that /sbin/start is part of upstart, which would
> explain the "Need to be root" ;-)
>
>     $ test -x /bin/start; echo $?
>     1
>     $
>
> So, the patch below fixes the issue for me, but as I don't have MinGW
> installed, I can't test this fix works there.
>
> Does anybody else see this issue and can someone test the patch?

Petr, as you added support for using /bin/start on MinGW, could you tes=
t?

Thanks,
Christian.
