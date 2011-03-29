From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 14:01:53 +0200
Message-ID: <4D91CA31.20908@drmicha.warpmail.net>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com> <7voc4uto9o.fsf@alter.siamese.dyndns.org> <7v8vvytldk.fsf@alter.siamese.dyndns.org> <AANLkTik33jiKipcv8d8tY_FXa2nE0BtBdi9vro0gkdQc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Daniel_Nystr=F6m?= <daniel.nystrom@timeterminal.se>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Xg0-0005UL-GU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1C2MFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 08:05:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42764 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837Ab1C2MFa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 08:05:30 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 81A5920C4B;
	Tue, 29 Mar 2011 08:05:30 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 29 Mar 2011 08:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vsQPpM8zsvw2K4E4c+KHEzBgoCs=; b=SEbDU1n4jSLeRk6Ykv6hnElO5yCaDSOD2AKCQfi3pPhi2Vnf/zVfUr/mXmXDHc5gc7+J48uOymr+Fn354t2FPFp8tB4GbYtALL3C8+7BJsVvf27SAAvX1t2FuqdOcoHrHuSYA5C7bSxij6n7J9mD60mkO2i7BIwvXsFv2EnfL2k=
X-Sasl-enc: 7hnukF34Oen3VMTMjMT6zbUXgrH7WWmdZi2eXhJ5EUQ3 1301400330
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DEE5F404B0B;
	Tue, 29 Mar 2011 08:05:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTik33jiKipcv8d8tY_FXa2nE0BtBdi9vro0gkdQc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170259>

Daniel Nystr=F6m venit, vidit, dixit 29.03.2011 11:18:
> Den 29 mars 2011 09:51 skrev Junio C Hamano <gitster@pobox.com>:
>>> Daniel Nystr=F6m <daniel.nystrom@timeterminal.se> writes:
>>>> How would you like a git feature like described above, marking fil=
es
>>>> for later inclusion?
>>>
>>> That does not sound like a feature but merely a source of confusion=
=2E
>>
>> If that is the case, then probably you shouldn't be even updating th=
e
>> "changelog" file constantly to begin with.  Instead, how about creat=
ing a
>> separate "changelog+" file that is not tracked, and keep its content=
s
>> maintained continuously so stuff won't be forgotten?  When the time =
to
>> release comes, you can "mv changelog changelog", and commit it.
>=20
> If we ignore this particular case, how would a "git hold <file>..." f=
eature do?
> --
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working di=
rectory)
> #
> #	modified:   package/qt/qt.mk
> #
> # Changed but on hold:
> #   (use "git add --holds <file>..." to update what will be committed=
)
> #
> #	modified:   CHANGES
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> --
> Would there be other use-cases?

As Junio pointed out, your "hold file" (ChangeLog+) is really not
versioned (tracked) at all, so it has no place in the worktree.
Otherwise you'll have constant nagging during the release cycle one way
or the other, if you want git to remind you of the files on hold. If yo=
u
don't need the reminder, git does not need to know about the file.
Simply store it somewhere else (such as in .git/description if you don'=
t
use that, or under .git/info/).

Michael
