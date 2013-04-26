From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Fri, 26 Apr 2013 17:40:17 -0500
Message-ID: <CAMP44s2u1iLXKQ5zuif4xKvYREVQm3B+301J=F5CpqPW6E5wWw@mail.gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrpuedv.fsf@alter.siamese.dyndns.org>
	<7vsj2due28.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrJY-0008B4-8z
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab3DZWkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:40:19 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:39393 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3DZWkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:40:18 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so1354528lab.33
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=bnMp+mFpuli1AHJi2HQ15XKkbcnqOlVnC9pbQobobkk=;
        b=gwVtgVimhUO4uJJ9JWHQJ9vppCtWaLVyhn0chXTE18n8GnB7ySUnqtqY9ogwm1Kofw
         QWVRARfVisBm84TMIsMVtBGrumibt1YkXWSMf2f+8qDWqqoNfSCuYGyIqmwlwB0isxd8
         rR/pNNpbMkln6Rt+05YI+J1tNbqsoDTmPbQsCqGz5S1OEW+lvJLNqgY8byLLEUQ4hTNo
         FXzzCdt2xhqZ0lBHbk4HxByTup6EuJheCRrAvWUie7PlU2vgYioDnTdBZLOLzkVPvm5E
         dcE608u17SsRTd7mroXsGg2Xpc4giVLO6qjT768lEKee/vC0SWQWbhfFNBr33EY97Tsh
         WjjQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr22715275lbb.88.1367016017315;
 Fri, 26 Apr 2013 15:40:17 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 15:40:17 -0700 (PDT)
In-Reply-To: <7vsj2due28.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222600>

On Fri, Apr 26, 2013 at 5:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.
>>>
>>> Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.
>>
>> Thanks.  Will queue on 'pu' without looking.
>
> Actually, I was going to merge fc/remote-hg and fc/remote-bzr down
> to master anyway, so I'll just apply them directly on 'master'.
>
> By the way, I personally do not think the quality of the changes to
> remote-bzr matters all that much at this point in its history.  It's
> not like millions of people use it heavily from the v1.8.2 release.
> A huge patch series from its original author and nobody else, either
> reviewed or unreviwed, would not hurt them more than the one in the
> v1.8.2 version anyway. And it is also not like bzr-to-git population
> will grow significantly in the future to require us to pile a lot of
> features on remote-bzr that makes the maintenance burden of it
> becomes an issue.
>
> Am I underestimating the pain of potentially breaking existing
> remote-bzr userbase?

No, I think it's reasonable. 1.8.2 was better because 1.8.1 didn't ave
any support whatsoever, and 1.8.3 will be better, because 1.8.2 was
barely usable for any real-world project. Will there be any
regressions? I doubt it, and if there are, it's unlikely that they
would be found in the review process, in 'pu', or in 'next', specially
since very few people actually use remote-bzr, in part because it
wasn't very useful, and in part because few people use bzr in the
first place.

Of course, I would prefer if people reviewed the patches for the
massive changes, the _important_ patches, and I would gladly explain
the reasoning and update the commit messages if needed. But nobody is
volunteering to review that. The only exception was for a few
irrelevant patches that could be easily dropped.

remote-hg is a different story, and so I'm being more careful with the
changes there, and I actually think the current patches are more than
enough for 1.8.3, they should be tested in an actual release, and the
rest would have to wait. For the rest, I'm still juggling in which
order I should send them, and I want to send first the ones that
should maximize the benefits for the users, with minimum possibility
of breakage, but even then I wouldn't be confident with those landing
in 1.8.3, so 1.8.4 it is.

Cheers.

-- 
Felipe Contreras
