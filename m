From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Fri, 31 Oct 2014 09:45:43 +0100
Message-ID: <CAP8UFD0ZN1Dq3kAs=nQE3fY8RydqUhSDvYksy7J2igTpt9p5WQ@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
	<CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
	<CA+POfmvXEjDV9Vap6NDX7HvOMjEVG4mVe1uWFSTQy5g_c+vJnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dmitry Oksenchuk <oksenchuk89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk7qI-0001Y6-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 09:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbaJaIps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 04:45:48 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58503 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149AbaJaIpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 04:45:44 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so795600iec.40
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4v0dAXC3dAev5LheVB/4v7bj+oy97bxAufUjylWzlxk=;
        b=QEy347Rtzof7VjSQH9mr7vgTxxUA2X46dpAA5WsQw0oCD3j17tkNQ4gUWv5TUD/L40
         Wq/8JTS/S41xtBPQyWJKm+1J30U0r2n0CJt6Cb1rNn+g1PJ7WW431mMEzka5KUuGMnrF
         oG07QeSaV578S7+BFRuMUO0J12Ja3vl/OIBr+5ntIsWXcnO2dJyPEiCB9clcFqanTtgK
         B6bnF9flEoLcIKDcv7ReaY8bPuqoxvrSiq9dP85zBIchUmYAsKYF8QFGiWPNk0IoVBiS
         EIXAP3RkPqZZMfYotZ/x0CvpRwnx0ONTM+mbmg1WtMgMrdefQBOamW0HTsJ0NuNtz0ZD
         u2Rw==
X-Received: by 10.42.194.16 with SMTP id dw16mr2630318icb.28.1414745143712;
 Fri, 31 Oct 2014 01:45:43 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Fri, 31 Oct 2014 01:45:43 -0700 (PDT)
In-Reply-To: <CA+POfmvXEjDV9Vap6NDX7HvOMjEVG4mVe1uWFSTQy5g_c+vJnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dmitry,

On Thu, Oct 30, 2014 at 6:41 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
> 2014-10-30 19:54 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>>
>> This might be a good idea. Did you already test that the small
>> repository is really faster than the full repository?
>
> Yes, because of such amount of refs, push in "historical" repository
> takes 12 sec, push in "working" repository takes 0.4 sec, push in
> "joined" repository takes 2 sec. Local operations with history like
> log and blame work with the same speed in "joined" repository as in
> "historical" repository.

What does "joined" mean? Does it mean joined using grafts? Or joined
using replace refs? Or just the unsplit full repository?

Also what is interesting is if local operations work with the same
speed in the small "working" repository as in the unsplit full
repository.

>>> Are there any disadvantages of using grafts and replace? Will both of
>>> them be supported in future versions of Git?
>>
>> My opinion is that grafts have no advantage compared to replace refs.
>>
>> Once you have created your replace refs, they can be managed like
>> other git refs, so they are easier to distribute.
>>
>> Basically if you want to get the full history on a computer you just need to do:
>>
>> git fetch 'refs/replace/*:refs/replace/*'

By the way the above should be:

git fetch origin 'refs/replace/*:refs/replace/*'

> That's true but you still need to have another remote with full
> history because it has lots of tags and branches that will be cloned
> by initial clone.

Yeah, you might want to have another remote for that reason, but this
is true with both grafts and replace refs.

Best,
Christian.
