From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for vim/gvim
Date: Fri, 24 Sep 2010 14:01:01 -0500
Message-ID: <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
	<1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
	<20100918073428.GA9850@gmail.com>
	<AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:01:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDWA-0004pU-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab0IXTBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 15:01:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61620 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757455Ab0IXTBD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 15:01:03 -0400
Received: by fxm3 with SMTP id 3so921682fxm.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PZCt5N9Z4OSfGSbDZ6SBECAxkQ1Yv/EtrpG+1KWv/9U=;
        b=M+HHw7oT/P9gP8VLMhNDSJA+0zdiBGvkD3yvTz1c5TbmSDIZ8QgoxnGddIbdH/QuvX
         Aoq2qPNm3aUcMoNSqlbwWAiKyLAzqLrZ7xA56Wazi7JyZo+rh4SNfccTz1jsWmrT/EVM
         SNMFc8zUxekKUBzeASrWJtXXI+1VkU34YtZXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UCdhK/wq6pdFD3ed23UUeS0+vDNXHHGtj1gbRKERGArs0CDNVJp5FSODTvcXzhnsfl
         xXV2j0w03qfRepPm24z6ooFCkbDPotakalvrNsAKqvW507Iy6rN0fVoEP7c57A8Cy3hL
         gWPHQfqNXiAdl1HICsZxkptIuU47TdYTLBHIw=
Received: by 10.239.157.14 with SMTP id o14mr235030hbc.74.1285354861940; Fri,
 24 Sep 2010 12:01:01 -0700 (PDT)
Received: by 10.239.149.209 with HTTP; Fri, 24 Sep 2010 12:01:01 -0700 (PDT)
In-Reply-To: <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157036>

On Sun, Sep 19, 2010 at 4:48 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Sep 18, 2010 at 10:34 AM, David Aguilar <davvid@gmail.com> wr=
ote:
>> On Tue, Sep 14, 2010 at 09:21:43PM -0500, Dan McGee wrote:
>>> When the base version is available, use a three-way, four panel vie=
w by
>>> default. This shows the (local, base, remote) revisions up top and =
the
>>> merged result by itself in the lower pane. All revisions will still=
 scroll
>>> together by default, and the cursor still defaults to the merged re=
sult edit
>>> pane.
>>>
>>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>>> ---
>>>
>>> Vim was one of the few diff commands to not support a three-way mer=
ge showing
>>> the base revision, so this is a stab at resolving that shortfall. T=
he biggest
>>> objection I can see to this is making the interface a bit more cumb=
ersome and
>>> bloated.
>>>
>>> An example screenshot of what this produces:
>>> http://www.toofishes.net/media/extra/vim_three_way.png
>>>
>>> -Dan
>>
>>
>> Patch 1/2 of this series looks good to me.
>>
>> Is it worth keeping the old behavior and calling this new
>> mode "vimdiff3" or something along those lines?
>>
>> I'm not a vimdiff user so I'm not be the best person to
>> judge the merits of this change. =C2=A0I like what it's trying
>> to accomplish, though. =C2=A0Are there any vimdiff users
>> with strong feelings either way?
>
> I think this is a definite improvement; the old mode wasn't really
> useful for me.

Not as much feedback as I had hoped, but thanks to those that did
speak up. I was thinking of adding a separate mode, but I think it
would then get under-used and as I said, every other merge tool was
already doing this anyway.

So are these patches good to go forward with? No major objections in a
over a week's time.

-Dan
