From: Christian Couder <christian.couder@gmail.com>
Subject: Re: flatten-merge history
Date: Sun, 26 Oct 2014 20:02:15 +0100
Message-ID: <CAP8UFD2yjXC6ffCQyTvYNZZ00Ou=YmNgyWxGhbO29nbTHXRD5w@mail.gmail.com>
References: <544B9839.7000302@gmx.de>
	<CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
	<544D0702.1050907@gmx.de>
	<8761f65060.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:02:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiT52-00039h-Gj
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 20:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbaJZTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 15:02:17 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:40918 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaJZTCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 15:02:16 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn18so4286585igb.15
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HPqbdiHzBiEtBzkaSznwwpKeJ5nuF5zWLjnMCHXXoQg=;
        b=YVPwK6YCxhRouVAEQz7xnsnTdJz5wky1kkxPffx3Wqej8VKvJFwlt8ZPV+qIDp5MkM
         i6ZHvYvOSwkilAQRwKM5/xzekjpvN6NgH4+0wrhJiR9UFo5RxCHpMztbLxkDBQcoD15Y
         vuoR8FshAF88sfkMnEJZF3NAZwDATiCGStgLzhbYM3ffaQ96VA1lDRgi1Ql/6ln3TbQA
         iNtK5k0jyNADf8RQUQ/Ps6I+I1StJZGiKTXbiWHGNsj82grda6OlhuKpctYtU+i5N8iG
         I7+nx01a7ZcTmj+AE1tHnZs++5seGmtYWTSYMzUWn8ITlvU5ZiNz2vzxWzxxG0hWczT4
         mCCA==
X-Received: by 10.43.119.131 with SMTP id fu3mr2582288icc.56.1414350135610;
 Sun, 26 Oct 2014 12:02:15 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Sun, 26 Oct 2014 12:02:15 -0700 (PDT)
In-Reply-To: <8761f65060.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 4:19 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Henning Moll <newsScott@gmx.de> writes:
>
>> 1. For P, A is the nearest prior commit on 'master'
>> 2. on master: git rebase -i A^
>> 3. change A from pick to edit. save. quit
>> 4. git merge P
>> 5. git rebase --continue
>>
>> From the perspective of 'master' this worked. But as all of the commits
>> have been rewritten, the branches b1 and b2 no longer refer to
>> 'master'. Branch b2, for example, still branches off at B and not B'.
>
> You only rebased master, so b1 and b2 were unchanged.  If you want to
> change b1 and b2 you have to rebase them as well.

Yeah. Henning, when interactively rebasing, in our editor, you should
have something like:

pick A
pick P
pick B
pick Q
pick C
pick D
pick R
pick E

which should work without any conflict.
And then you can rebase the b1 and b2 branches on the resulting branch.

Best,
Christian.
