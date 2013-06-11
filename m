From: John Keeping <john@keeping.me.uk>
Subject: Re: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 13:55:21 +0100
Message-ID: <20130611125521.GL22905@serenity.lan>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mathieu.Lienard--Mayor@ensimag.imag.fr,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu.Moy@grenoble-inp.fr
To: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 14:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmO9d-0006ne-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 14:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab3FKM6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 08:58:10 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:33927 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab3FKMzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 08:55:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 946C52339C;
	Tue, 11 Jun 2013 13:55:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taKlUTqun5+o; Tue, 11 Jun 2013 13:55:31 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 117792328C;
	Tue, 11 Jun 2013 13:55:23 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227435>

On Tue, Jun 11, 2013 at 02:35:29PM +0200, Mathieu Li=E9nard--Mayor wrot=
e:
> (Got the idea from:
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_rebase_-=
-status)
>=20
> When in the middle of a rebase, users can be easily confused about
> what to do, or where they are in the rebase process.
>=20
> All the information is available in .git/rebase-merge/, but I believe
> it would be helpful to have a command (for example 'git rebase
> --status') which would explicitely indicate the state of the process.
>=20
> For instance, the output could look like:
>=20
> $ git rebase --status
> Rebasing my_last_commit onto base_commit
> Already applied 2 patches:
> 	b170635... my_commit_message
> 	b170635... my_commit_message
> Currently applying b170635... my_commit_message
> 2 patches left to apply:
> 	b170635... my_commit_message
> 	b170635... my_commit_message

The one piece of information that I often want is the SHA1 of the commi=
t
that is currently being applied.  Currently I have to look through my
scrollback for the "stopping" message or poke around in .git/.

Having that in the output of "git status" would be really nice, but the
output format you've posted is a big improvement over what we have at
the moment for this case.

Actually, the same applies for cherry-pick and revert when they have
been given a range - showing the commit that is currently being applied
in "git status" would be nice there as well.
