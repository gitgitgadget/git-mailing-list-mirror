From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD state while preserving its staged state
Date: Sat, 4 May 2013 10:58:39 +0200
Message-ID: <87obcryvcw.fsf@hexa.v.cablecom.net>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Dimitar Bonev <dsbonev@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 10:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYYIs-0003SR-0O
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 10:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394Ab3EDI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 04:58:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:11629 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3EDI6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 04:58:44 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 4 May
 2013 10:58:38 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 4 May
 2013 10:58:41 +0200
In-Reply-To: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	(Dimitar Bonev's message of "Sat, 4 May 2013 10:34:55 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223363>

Dimitar Bonev <dsbonev@gmail.com> writes:

> I have been looking for such a command/option and no one gave me
> sufficient answer. So this message should be considered as a feature
> request. I had a situation where I had staged a file with a problem
> solution in it, then I wanted to experiment with a different solution
> so I had to revert the file to its HEAD state and I couldn't find a
> way that preserves the staged state of that file. More discussions:
>
> https://groups.google.com/forum/?fromgroups=#!topic/git-users/nYiN-rE_3i0
>
> http://stackoverflow.com/questions/16335799/git-porcelain-command-to-revert-a-single-file-to-its-head-state-but-keep-its-sta

Is that a common enough issue to warrant a better solution than

  git show HEAD:targetfile > targetfile

which is how we would do it?

Or more likely,

  git commit -m WIP
  git revert -n HEAD

which is safer anyway, since it doesn't lose the formerly-staged state
so easily (you have the reflog in case of any mistakes).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
