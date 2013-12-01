From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: git stash doesn't honor --work-tree or GIT_WORK_TREE
Date: Sun, 01 Dec 2013 12:12:48 +0100
Message-ID: <874n6sddu7.fsf@thomasrast.ch>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
	<loom.20131130T221443-682@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 12:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn4xt-00035P-4J
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 12:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab3LALNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 06:13:07 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38555 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab3LALNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 06:13:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 4FBE14D64FC;
	Sun,  1 Dec 2013 12:12:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rchWA53k3IUA; Sun,  1 Dec 2013 12:12:49 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (pD9EB3CC1.dip0.t-ipconnect.de [217.235.60.193])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0DE304D64C4;
	Sun,  1 Dec 2013 12:12:49 +0100 (CET)
In-Reply-To: <loom.20131130T221443-682@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Sat, 30 Nov 2013 21:22:01 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238586>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Aaron Brooks <aaron <at> brooks1.net> writes:
>
>> Unlike other commands, git stash doesn't work outside of the worktre=
e,
>> even when --work-tree is specified:
[...]
> The environment variables are properly exported. I verified this by
> adding 'echo $GIT_WORK_TREE; echo $GIT_DIR' at the top of git-stash.s=
h.
> So these should propagate to "child gits" just fine, and so it should=
n't
> be necessary to test them explicitly.
>
> The problem seems to be that git rev-parse --is-inside-work-tree does
> not honor these. In fact it doesn't even honor --git-dir or --work-tr=
ee.
> Judging by the name this may be intentional.

Thanks for investigating this.

Duy, you are the expert on the worktree detection logic.  Do you know i=
f
there is a reason for --is-inside-work-tree to not honor the
GIT_WORK_TREE / GIT_DIR overrides?

--=20
Thomas Rast
tr@thomasrast.ch
