From: John Keeping <john@keeping.me.uk>
Subject: Re: Bug: git push crashing
Date: Fri, 12 Apr 2013 20:06:31 +0100
Message-ID: <20130412190630.GM2222@serenity.lan>
References: <201304122050.26471@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjJ5-0005bB-ML
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3DLTGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 15:06:39 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37539 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab3DLTGi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:06:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 137116064EA;
	Fri, 12 Apr 2013 20:06:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0df23qBh52pz; Fri, 12 Apr 2013 20:06:37 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 7098A6064D3;
	Fri, 12 Apr 2013 20:06:37 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6885D161E07A;
	Fri, 12 Apr 2013 20:06:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQIl-CLiAt6C; Fri, 12 Apr 2013 20:06:36 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5C2CA161E3CC;
	Fri, 12 Apr 2013 20:06:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <201304122050.26471@pali>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221015>

On Fri, Apr 12, 2013 at 08:50:25PM +0200, Pali Roh=E1r wrote:
> when I'm trying to push one specific branch from my git repository
> to server, git push crashing. Pushing branch is rejected by server
> (because non fast forward), but local git app should not crash.
>=20
> I'm using git from ubuntu apt repository (compiled myself for debug
> symbols), version git_1.7.10.4-1ubuntu1 on amd64 ubuntu system:
> http://packages.ubuntu.com/source/quantal/git
>=20
> Here are gdb backtrace and valgrind outputs. I changed server, repo
> and branch strings from output. It looks like that git crashing in
> strcmp function because one of arguments is NULL.
>=20
> If you need more info, I can send it. This crash occur always. I can
> reproduce it again and again...

This looks like the same issue that was fixed by commit 1d2c14d (push:
fix segfault when HEAD points nowhere - 2013-01-31).

Can you try again with Git 1.8.2 and see if the crash still happens?
