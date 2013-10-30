From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: collapsing old git history to reduce repo size, while preserving
 commit #s and tags
Date: Wed, 30 Oct 2013 16:55:30 +0100
Message-ID: <52712BF2.2080409@gmail.com>
References: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com> <CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com> <CAH5451=DGp0aRaA6c-ThO0Aj0VCAUFX17p8gOKPpURwEnjcpdA@mail.gmail.com> <CAJSXqrr7rHxyXX=_+xgJ4FW2UHSts2jRt7zwrkkw1L3uKHnCtw@mail.gmail.com> <CAJSXqrrMCWmRBoRNCLuD6DvU=CSk+MVGrSOCeOROROEaKouVKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stas Cherkassky <scherkas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbY7O-00021r-N5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab3J3Pzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 11:55:35 -0400
Received: from dovecot.mat.uni.torun.pl ([158.75.2.81]:35557 "EHLO
	dovecot.mat.uni.torun.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3J3Pze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:55:34 -0400
Received: from dovecot.mat.uni.torun.pl (localhost.localdomain [127.0.0.1])
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTP id AC58BB7179E;
	Wed, 30 Oct 2013 16:55:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mat.uni.torun.pl
Received: from dovecot.mat.uni.torun.pl ([127.0.0.1])
	by dovecot.mat.uni.torun.pl (dovecot2.mat.uni.torun.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UxnunCA4nD-5; Wed, 30 Oct 2013 16:55:31 +0100 (CET)
Received: from [158.75.2.83] (unknown [158.75.2.83])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jnareb)
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTPSA id AE775B71789;
	Wed, 30 Oct 2013 16:55:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAJSXqrrMCWmRBoRNCLuD6DvU=CSk+MVGrSOCeOROROEaKouVKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237027>

On 2013-10-30 08:52, Stas Cherkassky wrote:
>
> Shallow clone (if that's what you meant) is not suitable because it
> doesn't allow to push/pull to/from this shallow repository.

Still?  I think there were some work on making shallow clone to
allowing push/pull to/from it.

> I understand that generally git is designed to preserve the history.
> But the problem is real,  and probably is not unique to our project.
> The fact that there ARE some ways to modify history (collapse commits=
,
> rebase, filter-branch) made me hopeful that what I need is also
> possible..

By the very nature of git, namely that the 'parent' link to previous
(as in: this is based on it) commit or commits, is SHA-1 of said commit=
,
and SHA-1 identifier of commit is based on contents including 'parent'
field.

Both rebase and filter-branch _rewrite_ history (i.e. make modified
copy of history, and let you replace old history by new).

You could try to use father or shallow clone, namely *grafts*, to
'cauterize' history, but there remains same problems as with shallow
clone, perhaps with exception that git won't check things for you.

--=20
Jakub Nar=C4=99bski
