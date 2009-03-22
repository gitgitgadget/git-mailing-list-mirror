From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sun, 22 Mar 2009 16:57:20 +0100
Message-ID: <150271EF-9B2B-4B48-9A17-F9E423830E60@wincent.com>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org> <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com> <20090321185817.GA22540@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 16:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlQ4x-0004Ay-Sj
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbZCVP52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 11:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZCVP52
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:57:28 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:40088 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbZCVP51 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 11:57:27 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2MFvK4R018015
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 22 Mar 2009 11:57:22 -0400
In-Reply-To: <20090321185817.GA22540@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114150>

El 21/3/2009, a las 19:58, David Aguilar escribi=F3:

> On  0, Wincent Colaiuta <win@wincent.com> wrote:
>> El 21/3/2009, a las 8:58, Junio C Hamano escribi=F3:
>>
>>> * da/difftool (Thu Mar 19 01:25:25 2009 -0700) 1 commit
>>> - difftool: move 'git-difftool' out of contrib
>>
>> Before this one goes any further, I noticed that nobody replied to m=
y
>> email on this thread a few days ago:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/113609
>>
>> My concern was:
>>
>>> Given that git-difftool shares basically all the same options as =20
>>> "git
>>> diff", I think a good long-term plan would be looking at adding the
>>> "--tool" option to "git diff" itself so that users wouldn't have to
>>> learn a new subcommand, just a new option.
>>
>>
>> What do people think?
>>
>> Cheers,
>> Wincent
>
> That could be interesting.  git-difftool is just a
> frontend to git-diff so there isn't really any maintenance
> worries about keeping the options in sync.  I do agree that
> keeping things easy for users is a noble goal and that that
> was your only concern.
>
> git-difftool is pure porcelain, so I'm interested in how we
> could implement this.  Right now the call stack is:
>
> $ git difftool
> ... GIT_EXT_DIFF=3Dgit-difftool-helper
> ... git diff
> ... ... git-difftool-helper
> ... ... ... xxdiff
>
>
> What should it look like instead?
>
> Are you envisioning this (1):
>
> $ git diff --tool
> ... --tool was passed, so set GIT_EXT_DIFF?
> ... git-difftool-helper
> ... ... xxdiff ...

Yeah, something like that. I wasn't actually imagining that the logic =20
of git-difftool-helper would itself be rolled into "git diff". I was =20
just wondering if we could keep the command-count down.

Cheers,
Wincent
