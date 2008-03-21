From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
Date: Fri, 21 Mar 2008 08:23:47 +0100
Message-ID: <200803210823.47899.chriscool@tuxfamily.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <200803200849.14664.chriscool@tuxfamily.org> <7vtzj1wd7u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcbWr-00047L-Be
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 08:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbYCUHSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2008 03:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYCUHSO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 03:18:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47482 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbYCUHSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 03:18:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 932A01AB2D0;
	Fri, 21 Mar 2008 08:18:12 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E35C51AB2EC;
	Fri, 21 Mar 2008 08:18:11 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vtzj1wd7u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77727>

Le jeudi 20 mars 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Yes, but if the user just wants to use a konq that is not in the pa=
th,
> > then the konq specified with "man.konqueror.path" should behave the
> > same as when using the konq in the path. That means that we should =
also
> > try to open a new tab on an existing konq, and this will not be the
> > case if we use "/path/konqueror URL" instead of "/path/kfmclient ne=
wTab
> > URL".
>
> If that inconsistency bothers you, you probably should rename the
> built-in konqueror support to "kfmclient", which is more honest appro=
ach,
> I would think.

It's perhaps more honest, but kfmclient is not as well known as konquer=
or.

Isn't a documentation patch like this enough:

------8<---------

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 4c6cb21..0ece412 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -87,7 +87,8 @@ is chosen. Only the following values are currently=20
supported:
 * "man": use the 'man' program as usual,
 * "woman": use 'emacsclient' to launch the "woman" mode in emacs
 (this only works starting with emacsclient versions 22),
-* "konqueror": use a man KIO slave in konqueror.
+* "konqueror": use kfmclient to open the man page in a new konqueror
+tab.

 Multiple values may be given to this configuration variable. Their
 corresponding programs will be tried in the order listed in the

------8<---------

I also wonder if you want some changes in "git-web--browse.sh" as there=
 is=20
the same logic ?

Thanks,
Christian.
