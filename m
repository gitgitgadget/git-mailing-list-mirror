From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-svn taking a long time
Date: Wed, 10 Feb 2010 18:29:59 +0100
Message-ID: <87bpfxov6w.fsf@krank.kagedal.org>
References: <87hbppp8k7.fsf@krank.kagedal.org>
	<6D721095-7A04-4097-8D86-1A2B915182DF@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGOS-0003Tv-Ly
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab0BJRaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 12:30:14 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:55754 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab0BJRaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:30:09 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 855374000A;
	Wed, 10 Feb 2010 18:28:22 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 7606D40016; Wed, 10 Feb 2010 18:28:22 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 436AF4000A;
	Wed, 10 Feb 2010 18:28:20 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 23A6D61154; Wed, 10 Feb 2010 18:30:00 +0100 (CET)
In-Reply-To: <6D721095-7A04-4097-8D86-1A2B915182DF@apple.com> (Andrew Myrick's
	message of "Wed, 10 Feb 2010 08:59:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139524>

Andrew Myrick <amyrick@apple.com> writes:

> Give 1.7.0-rc2 a try.  It includes commit 8bff7c5383ed833bd1df9c8d85c=
00a27af3e5b02, which attempts to persistently cache a lot of the proces=
sing that git-svn has to do on subversion's merge tickets, which has im=
proved my fetch times significantly. =20

By "merge tickets", are you talking about the merge functionality that
appeared in subversion 1.5? We don't use that.

But I had another idea. I pecularity of our subversion repo is that we
no longer use the foo/trunk branch, but only foo/branches/*. But we did
once upon a time have a foo/trunk. And since I didn't include a "fetch =
=3D
foo/trunk:refs/remotes/svn/trunk" in my config, it might need to refetc=
h
that information every time. For instance, the first revision is on
trunk.

I'm rerunning the fetch now with the trunk added, so see if it helps.

And another note is that "git svn fetch --parent" was always quick.

--=20
David K=C3=A5gedal
