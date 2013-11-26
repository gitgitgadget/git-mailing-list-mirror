From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Tue, 26 Nov 2013 09:40:42 +0100
Message-ID: <87li0b1rp1.fsf@thomasrast.ch>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
	<5290BEE7.2070901@kdbg.org>
	<CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	szeder@ira.uka.de
To: Heikki Hokkanen <hoxu@users.sf.net>
X-From: git-owner@vger.kernel.org Tue Nov 26 09:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlECa-0004k4-SC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 09:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab3KZIk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 03:40:56 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:57707 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab3KZIk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 03:40:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id AB49B4D6578;
	Tue, 26 Nov 2013 09:40:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HpeYqtVGD1ay; Tue, 26 Nov 2013 09:40:44 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id F1F2A4D64DE;
	Tue, 26 Nov 2013 09:40:43 +0100 (CET)
In-Reply-To: <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
	(Heikki Hokkanen's message of "Sat, 23 Nov 2013 18:31:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238374>

Heikki Hokkanen <hoxu@users.sf.net> writes:

> On Sat, Nov 23, 2013 at 4:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Gah! This adds a fork+exec each time the prompt is shown. Not good,
>> particularly on Windows.
>>
>> Since your intent is to disable the prompt in the home directory,
>> wouldn't that mean that most of the time you *don't* want the prompt?
>> Wouldn't you be better served with a method that *turns on* the prompt?
>> For example, a shell function that sets PS1 and another one that unsets
>> it? Or a wrapper that inspects a shell variable and calls __git_ps1 only
>> when you want a prompt.
>
> Actually, I do want the prompt for all other git repositories. The
> problem with $HOME is that it's the default directory after logging in
> or opening a terminal, so if you have git prompt sourced and your
> $HOME under git, you get an unbearable delay every time you open a
> terminal, or type a command, anywhere, except for a separate git
> repository.

Umm... is __git_ps1 by itself so slow that you find it unbearable, or is
it the worktree status discovery?  Because the latter can already be
controlled per repository via bash.showUntrackedFiles and
bash.showUpstream.

-- 
Thomas Rast
tr@thomasrast.ch
