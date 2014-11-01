From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Sat, 1 Nov 2014 16:03:06 +0100
Message-ID: <CAP8UFD17DOajgFWTTDC12qz3m4wKJTn2XLn+MWUE8Fc_XyTBTQ@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
	<CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
	<CA+POfmvXEjDV9Vap6NDX7HvOMjEVG4mVe1uWFSTQy5g_c+vJnw@mail.gmail.com>
	<CAP8UFD0ZN1Dq3kAs=nQE3fY8RydqUhSDvYksy7J2igTpt9p5WQ@mail.gmail.com>
	<CA+POfmt9cQcKshc3LgGpBqHdbsgjoN7Ou7eN3sGqJcDeXwgPyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dmitry Oksenchuk <oksenchuk89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 16:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkaCz-0000uV-5N
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 16:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758767AbaKAPDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2014 11:03:10 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:42071 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758449AbaKAPDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2014 11:03:07 -0400
Received: by mail-ig0-f178.google.com with SMTP id a13so2474795igq.17
        for <git@vger.kernel.org>; Sat, 01 Nov 2014 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k+/G96tPAznAx9CPQfsB/9WokHfYaVwqVjDa2THU3/E=;
        b=RsmHRe8MxDdiEbDvV8mh7JIskNCAPIEBmMJSRxoh5yOjEwx/hGnLXb/Bym8PMwICsd
         sEY1jtJCKuQ4/dyvMFqzC1wsu22qO5aEmCHzRprlGUvgI056dsTZMWIOeRFNTFMIBzZx
         mda2gcEh6DOTLGRo6pnMp5/DES+2f3HtmxJsAkzawsvhMnedw2yZH1eRjUblgsikOGXC
         K70uZ3vlv8n3Hoa0oI2zbj9pF1gazwT7dLbh1qJnoOg3QYGiJsAVS3CnYINjcOnscNyq
         /3F25KfsjYxOYCvH2BvI1qgq69ZkyvBc43ZgGGvFLQXLw4ThwBV//ckEARwVH0I0w2kG
         PwxA==
X-Received: by 10.42.80.143 with SMTP id v15mr2730497ick.54.1414854186962;
 Sat, 01 Nov 2014 08:03:06 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Sat, 1 Nov 2014 08:03:06 -0700 (PDT)
In-Reply-To: <CA+POfmt9cQcKshc3LgGpBqHdbsgjoN7Ou7eN3sGqJcDeXwgPyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dmitry,

On Fri, Oct 31, 2014 at 4:47 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
> Hi Christian,
>
>> On Thu, Oct 30, 2014 at 6:41 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
>>>
>>> Yes, because of such amount of refs, push in "historical" repository
>>> takes 12 sec, push in "working" repository takes 0.4 sec, push in
>>> "joined" repository takes 2 sec. Local operations with history like
>>> log and blame work with the same speed in "joined" repository as in
>>> "historical" repository.
>>
>> What does "joined" mean? Does it mean joined using grafts? Or joined
>> using replace refs? Or just the unsplit full repository?
>
> It's joined using grafts or replace. In both cases performance is the same.
>
>> Also what is interesting is if local operations work with the same
>> speed in the small "working" repository as in the unsplit full
>> repository.
>
> Speed of operations like git diff, git add, git commit is exactly the
> same in both repositories.
> Operations like git log and git blame work much faster in repository
> without history (not surprisingly :)
> For example, git log in small repository takes 0.2 sec, in full
> repository - 0.8 sec. git blame in full repository can take up to 9
> sec for large files with long history.

Ok, thanks for the information. I think it shows that indeed it makes
sense to split your repo.

Best,
Christian.
