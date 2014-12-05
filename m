From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 07:55:33 +0100
Message-ID: <548156E5.2080006@kdbg.org>
References: <1417732931.20814.16.camel@segulix> <1417759955.10992.2.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?U8OpcmdpbyBCYXN0bw==?= <sergio@serjux.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 07:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwmnm-00045x-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 07:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaLEGzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 01:55:38 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:56771 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751283AbaLEGzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 01:55:37 -0500
Received: from [192.168.0.204] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jv4S60Y68z5tlb;
	Fri,  5 Dec 2014 07:55:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1417759955.10992.2.camel@segulix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260859>

Am 05.12.2014 07:12, schrieb S=C3=A9rgio Basto:
> Hi,
>
> I add 2 files that I want ignore on commits
> git update-index --assume-unchanged configurations/local.defs
> git update-index --assume-unchanged processor/default.defs
>
> git diff -a
> is clean
> git diff .
> is clean
> git commit -a
>
> nothing added to commit
>
> but
>
> git commit .
> # Changes to be committed:
> #       modified:   configurations/local.defs
> #       modified:   processor/default.defs
>
> this is a bug .

Actually, it's a user error. When you set --assume-unchanged, then you=20
give a promise to git that you do not change the files, and git does no=
t=20
have to check itself whether there is a change.

But since you did not keep your promise, you get what you deserve. ;-)

So, to follow-up on your nearby post: --assume-unchanged is *not* a too=
l=20
to avoid accidentally committing changes to files that are tracked.

-- Hannes
