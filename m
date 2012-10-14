From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why git shows staging area to users?
Date: Sun, 14 Oct 2012 19:16:58 +0200
Message-ID: <vpqr4p1as8l.fsf@grenoble-inp.fr>
References: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
	<CAJDDKr7tUJ59jYDM-jhFnGMEB18taT7FsTJ24Hr=iBUgXXeYdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: semtlenori@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNRoX-0001Oh-U1
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 19:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab2JNRRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 13:17:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58038 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab2JNRRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 13:17:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9EHA3vW026476
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 14 Oct 2012 19:10:05 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TNRoB-0006c7-5D; Sun, 14 Oct 2012 19:16:59 +0200
In-Reply-To: <CAJDDKr7tUJ59jYDM-jhFnGMEB18taT7FsTJ24Hr=iBUgXXeYdg@mail.gmail.com>
	(David Aguilar's message of "Sat, 13 Oct 2012 17:56:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 14 Oct 2012 19:10:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9EHA3vW026476
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350839410.57815@mxnbaA1v1QPOGnojEWU+sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207677>

David Aguilar <davvid@gmail.com> writes:

> On Sat, Oct 13, 2012 at 2:08 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
>> Hi, all.
>>
>> Why git shows staging area to users, compared with the other scms hide
>> it? What benefits users get?
>
> http://thkoch2001.github.com/whygitisbetter/#the-staging-area
> http://tomayko.com/writings/the-thing-about-git
> http://gitready.com/beginner/2009/01/18/the-staging-area.html
>
> Other scms do not "hide"; other scms lack this feature altogether.

More precisely: there are several things in what git calls "the index"
or "the staging area" (i.e. .git/index):

1) a list of files tracked by Git

2) a record of the last known meta-data of the file, used to avoid
   re-reading unmodified files content each time one runs "diff",
   "commit" or so.

3) a record of the file's staged *content* (possible several records in
   case a merge is going on)

Any decent revision control has the equivalent of 1) and 2), but AFAIK,
3) is a unique feature of Git. There is a frequent confusion between 2)
and 3) that leads to people (often other revision-control
users/developers) wonder why this is visible to the user. 2) is a
performance optimization that can be hidden to the user (it is with
Git's porcelain commands), but 3) is user-visible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
