From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] remote-helpers: test fixes
Date: Mon, 20 May 2013 18:22:31 -0500
Message-ID: <CAMP44s13hjYzqHuBHKjGXRbf6PTyOiX=_EeuwAdLdZ9wSo-oQQ@mail.gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2sltgj4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0gK5EgD-pJb1NVrpJvYeyXmN_nS6MT7renFHhne1cZJg@mail.gmail.com>
	<7v7gits0r9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 01:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeZPZ-0008Bt-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 01:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233Ab3ETXWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 19:22:33 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:64313 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab3ETXWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 19:22:33 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so2581lab.4
        for <git@vger.kernel.org>; Mon, 20 May 2013 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/QB+J3kDkqgPlor4bAIhiI97RkOnvvf80ruCfY4X3JI=;
        b=pooVL3D4jHcP3BRniQ8ZL3xGNeujQpDLeSeknX9YTQY0FPCxg/I0m3Pa0MKyQgRsdK
         n5QQqFtb6f9wy1K3Q19+hjKn5vWrVHUiTAXgHWT212YX4EFXfALQmm3iWBYuqWCiDSIY
         ottYpThBI/cJBXzjjU4DR6uTD81fU0JvE51E0nZKY/jwjpEhLwRMzgjuZ+JSqKqt5zSz
         Iq2Fx5G6AAUjfqb9KlYWNBX3u4S0xbaI+ligacUsJwuLyAkDVJlWAykikr9GpkNwvArO
         AZSuU5kDUMO5O7HX9XIGr1WOfCCcRZBg2RsCMVxyOQ9D8tdKdE7onwVFu4EOWFWCYC6b
         ORqQ==
X-Received: by 10.112.125.130 with SMTP id mq2mr126350lbb.103.1369092151443;
 Mon, 20 May 2013 16:22:31 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 16:22:31 -0700 (PDT)
In-Reply-To: <7v7gits0r9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225002>

On Mon, May 20, 2013 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, May 20, 2013 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Hi,
>>>>
>>>> I've setup a project in Travis CI for continuous integration with very good
>>>> results, however, I had to apply a couple of fixes.
>>>>
>>>> I'm not sure if this is v1.8.3 material, but here they are.
>>>
>>> Thanks; I'll queue them at the tip of fc/remote-hg to graduate soon
>>> after 1.8.3, then.
>>
>> No, they should be graduated first. The tip of fc/remote-hg is in pu,
>> no? I have rebased that branch and squashed some fixes so every commit
>> works on all versions of Mercurial. I will resend all the patches, the
>> only reason I haven't done so is that I didn't want to create more
>> noise before v1.8.3, and you said I was the one taking the decision
>> when to merge remote-helper stuff to master.
>
> Then is this v1.8.3 material?  Please do not stay "I'm not sure" for
> very long.  I do not think we want -rc4 only for a contrib/ stuff.

I think this could very well fit into v1.8.3, but there's no rush, it
can wait until after.

> For today's integration run I didn't want to wait so tentatively
> they are queued at the tip of fc/remote-hg, and it is too late to
> redo everything I did today, but I can requeue them for 'master' in
> the tomorrow's cycle if you want.

I think 'next' is fine, they could go into 'master' to improve the
testing of what's already there, but it probably won't matter much.
Moreover, it's not fixing test regressions; the issues have been there
pretty much since day one, and if nobody has found them by now it
probably won't change anything for v1.8.3.

My main motivation is that with these patches I could test a pristine
'master' branch directly into travis-ci.

-- 
Felipe Contreras
