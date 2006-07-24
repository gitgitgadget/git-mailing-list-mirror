From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't clone Linus tree
Date: Mon, 24 Jul 2006 12:36:03 +0200
Message-ID: <44C4A293.8090207@lsrfire.ath.cx>
References: <20060724080752.GA8716@irc.pl> <44C4992E.3070706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 24 12:36:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4xnJ-0001ol-83
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 12:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGXKgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 24 Jul 2006 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWGXKgI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 06:36:08 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:18564
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932110AbWGXKgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 06:36:07 -0400
Received: from [10.0.1.3] (p508E7BBB.dip.t-dialin.net [80.142.123.187])
	by neapel230.server4you.de (Postfix) with ESMTP id DF9692F016;
	Mon, 24 Jul 2006 12:36:05 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Tomasz Torcz <zdzichu@irc.pl>
In-Reply-To: <44C4992E.3070706@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24138>

> Tomasz Torcz schrieb:
>> %  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux-2.6.git linux-git
>> fatal: packfile '/home/zdzichu/linux-git/.git/objects/pack/tmp-1jI4A=
H' SHA1 mismatch
>> error: git-fetch-pack: unable to read from git-index-pack
>> error: git-index-pack died with error code 128
>> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux-2.6.git' failed.

Ah, I just saw this is a known problem and there's a patch by
Matthias Lederhofer, which Junio just accepted, I think (the
mail with subject "[PATCH] upload-pack: fix timeout in
create_pack_file)" on the git mailing list.

The problem is apparently that the server expects you (wrongly)
to finish your download session within ten minutes.  Until the
server is fixed you can use rsync:// for the initial clone and
git:// for smaller updates.

Ren=E9
