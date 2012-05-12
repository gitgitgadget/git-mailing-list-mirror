From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 21:28:48 +0900
Message-ID: <CAFT+Tg81f-fa-hf0jJ-y0TP99WbUGxVRAoxDyALd33cgaPrboQ@mail.gmail.com>
References: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
	<1336824434.3002.17.camel@centaur.lab.cmartin.tk>
	<CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat May 12 14:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBRO-0002ii-Bl
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab2ELM2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 08:28:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42409 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2ELM2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 08:28:48 -0400
Received: by obbtb18 with SMTP id tb18so4614049obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=DTc4BhC8uUKH8snVjItSDapgcCZ9MD3HpxpeVPOtmLE=;
        b=nMey+KB4hX/cmBV3mjaUzDu+fNZ4y7NCMx5nqoenZOrEvehxb9l6SsGP2M9xW1h1TL
         yKqQJn1oLruftEEQbnx5iMCE3JezCMr8+FJyEItiN2MlZhIheKpGVY8GvZxEYDPFmFOr
         +qciAH2dJnZCPzsRbheJxElRQZCuVhBTY8N9i9PuzS26WqE9Jqg+DFfFEyUyXcvsryhf
         EPGJBp3+FI2KMHNE8WhokWs/2flfXrZ7UMH1itwUvQ2IUagch8nF6BwcBNBzyQBMhjFQ
         CGlpWMOldxECOrWmzNRnWYiqLcJXQW9QJxV6w1/utpjziJdt5KsbYTwhYdj4bmrhFJ7g
         jOMQ==
Received: by 10.182.111.39 with SMTP id if7mr2024969obb.55.1336825728379; Sat,
 12 May 2012 05:28:48 -0700 (PDT)
Received: by 10.182.53.39 with HTTP; Sat, 12 May 2012 05:28:48 -0700 (PDT)
In-Reply-To: <CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197731>

Oops, it's just my mistake. git-remote also does not have '--all' optio=
n.

2012/5/12 Yi, EungJun <semtlenori@gmail.com>:
> Wow, I should do like this:
>
> $ git branch -a --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
> * master
> =A0remotes/origin/HEAD -> origin/master
> =A0remotes/origin/master
> =A0remotes/origin/next
> =A0remotes/origin/pu
>
> git-branch has '-a' but not '-all', and git-remote has '--all' but no=
t '-a'.
>
> This is a bit confusing for me. Why don't the two commands have the
> option under the same name?
>
>
> 2012/5/12 Carlos Mart=EDn Nieto <cmn@elego.de>:
>> On Sat, 2012-05-12 at 20:42 +0900, Yi, EungJun wrote:
>>> Is there any way to find remote and local branches include given co=
mmit?
>>>
>>> e.g.
>>>
>>> $ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73=
d6f
>>> * master
>>> =A0 remotes/origin/next
>>>
>>> As you know, it does not work and "git branch --contains" finds onl=
y
>>> local branches.
>>
>> Works For Me. What version are you trying it with? Are you sure that
>> remote-tracking branches do contain that commit?
>>
>> From a quick look through the log and release notes, it was never
>> mentioned as a fix. The log contains 3f7701a4 from 2007 which fixes =
'git
>> describe --all --contains' which, though unlikely, might be related.
>> This commit was however part of release 1.5.4, which makes it unlike=
ly
>> you'd be using something older.
>>
>> =A0 cmn
>>
