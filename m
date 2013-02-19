From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 11:39:17 +0100
Message-ID: <87vc9osi3u.fsf@pctrast.inf.ethz.ch>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
	<87ip5otybp.fsf@pctrast.inf.ethz.ch>
	<CALkWK0m--MbtNzGH9hNPCCLJWhv6rjF9Y=WQ4qnHUFnE61p6kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kbx-000833-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544Ab3BSKjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:39:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:43925 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab3BSKjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:39:21 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 11:39:15 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Feb 2013 11:39:17 +0100
In-Reply-To: <CALkWK0m--MbtNzGH9hNPCCLJWhv6rjF9Y=WQ4qnHUFnE61p6kw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 15:54:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216600>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thomas Rast wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> There are also other things in .git/config that would be nice to
>>> share, like whether to do a --word-diff (why isn't it a configuration
>>> variable yet?)
>>
>> Because that would break pretty much every script that uses git-diff?
>
> diff.c already makes a differentiation between git_diff_ui_config()
> and git_diff_basic_config(); there are  configuration options that
> should only be applied when the command is called interactively.

It still breaks every other use of diff unless you make the diff output
depend on whether the user runs directly at the terminal (possibly using
git's own paging).

For example, if you just say something like 'git diff >file' for
inclusion in an email, you expect that to be a git-apply compatible
diff.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
