From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Fri, 24 Dec 2010 08:33:34 +0700
Message-ID: <AANLkTik7oG+7D60YJE3+RvkRhYsj0hNUHr=LuPcP6UpF@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
 <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 02:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVwXu-00024k-KU
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 02:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab0LXBeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 20:34:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39520 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0LXBeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 20:34:07 -0500
Received: by wyb28 with SMTP id 28so6607785wyb.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 17:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RlbF/NopTMkrDQuk6zWVE3Nz0OJHCdapgyqMHKVqKFE=;
        b=jzarLH+90SfZjBA7+SbMMqbYTi3SUboWb56vvYBlunE2wk56u2wPzvRwOrL5BmqccY
         T8GSfV9LxdM0LtrdxfhbmJJ8sZa0Bq9CMEmo5o5mFtQBQ20oNbvX+Ij7X6NDc/LXnYa/
         LdigImMvDFVwwsCFJvg+A9SUpPcar5hBwG9SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P0iVqOBbgUCT8xX/TNENzH0xDmLPUSrzOJ191pVrOmaHagwcshUDm05D29parYtWSV
         fWN6JaFwSIVSsax5uZVxQYuUeAatupgePHDJmYOuhvIAMGdD/tMt8kyY/QsRQmn76oo8
         BV+mZwcEunNw3BGqD0RT6QVEq7Qjz70C6FoHM=
Received: by 10.216.52.206 with SMTP id e56mr9923907wec.19.1293154444890; Thu,
 23 Dec 2010 17:34:04 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 23 Dec 2010 17:33:34 -0800 (PST)
In-Reply-To: <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164144>

On Fri, Dec 24, 2010 at 12:17 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Dec 22, 2010 at 8:59 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> * nd/struct-pathspec (2010-12-15) 21 commits
>>> =C2=A0...
>>> =C2=A0(this branch is used by en/object-list-with-pathspec.)
>>>
>>> Rerolled again. =C2=A0Getting nicer by the round ;-)
>>
>> With jj/icase-directory merged to master, match_pathspec() and
>> match_pathspec_depth() now diverse again.
>>
>> When I wrote match_pathspec_depth(), I assumed that match_pathspec()
>> would not change much and I would have more time for converting the
>> rest of git to use match_*_depth(). Looks like I need to add case
>> insensitive matching to struct pathspec and friends then remove
>> match_pathspec() in this series too. At least if somebody changes
>> match_pathspec() again, it would cause a conflict so I can catch it.
>
> While this topic is something I have long wanted to see, I have start=
ed
> feeling that this needs to cook a bit longer than be in the next rele=
ase.
> So perhaps the best course of action might be to rebase the series on=
ce
> after the 1.7.4 feature freeze, cook it in 'next' for a while and mak=
e it
> part of the release after that. =C2=A0I think at that point we may pr=
obably
> want to have other changes that are not strictly backward compatible =
but
> their incompatibilities do not matter in practice (e.g. cquoting path=
specs
> in the attributes file comes to mind, but I am sure there will be oth=
er
> changes that people wanted to have but we held them off due to worrie=
s on
> compatibility).
>
> What do you think?
>

No problem.
--=20
Duy
