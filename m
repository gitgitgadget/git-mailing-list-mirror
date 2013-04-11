From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 16:21:15 -0500
Message-ID: <CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<7vfvywj4au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOvt-0003pF-LR
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935205Ab3DKVVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:21:20 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:56183 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934790Ab3DKVVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:21:17 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so1930718lab.18
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JpHCXpgDeGjk88OnUEs569Gt06TXjpUAg+jWY2Wh604=;
        b=OeVnLR4aOz2LzzSHPqnR4m3fw9EoQvgSHrh8Vprl9VsxW4cyxlmLW0x8FwYVIV+xbU
         YO4jnfN3dkfIhkdK0SH+F7CShGu5vycV67EqOgk0GSA6sCqoK2VysWQuyAYuGhEORQs4
         b5zk07f1dJql+ZZ+8MHcmAi37N4ZoCiAob7FyWZWcio7RKiqObLesovZhiUJCgpocbN/
         9kc/cLML1B9MW6A6E//yIw9ydqaL+f0hdTLLTDxc/7ob08YJ91moZ0NqLVdjV38QQJht
         dtYkN5W/IH/7nE5dnDgdvyrUnXdhq1teUkE9LjRMOGX9H5YG+Cdlvqd9wzkWexfeoA3K
         6Lfg==
X-Received: by 10.152.132.36 with SMTP id or4mr4098590lab.8.1365715275788;
 Thu, 11 Apr 2013 14:21:15 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 11 Apr 2013 14:21:15 -0700 (PDT)
In-Reply-To: <7vfvywj4au.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220930>

On Thu, Apr 11, 2013 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> In the long run, it may make more sense to propagate the
>>> error back up to push, so that it can present the usual
>>> status table and give a nicer message. But this is a much
>>> simpler fix that can help immediately.
>>
>> Yes it might, and it might make sense to rewrite much of this code,
>> but that's not relevant.
>
> It is a good reminder for people who later inspect this part of the
> code and wonder if it was a conscious design choice not to propagate
> the error or just being "simple and sufficient for now", I think.
> It would help them by making it clear that it is the latter, no?

No. Design choices is what code comments are for, of which Git only
has too few, according to ohloh[1]. No wonder they are so few, people
are spending time writing novels on commit messages and forgetting
there's also code where you should clarify things.

>> ... I think it might
>> be possible enforce remote-helpers to implement the "done" feature,
>> and we might want to do that later.
>
> Yes, all these are possible and I think writing it down explicitly
> will serve as a reminder for our future selves, I think.

Yes, but not writing them here. By spending so much time in commit
messages you neglect the code, and the wiki (which is actually the
place to write these things on.

And if all you want is to write them down, we already did, right here.
There's no need to punish the readers of the commit messages in the
future only so we can flex our memory, because we already did.

And if you must, you might was well label them with "REMINDER", no,
wait, that's what "TODO" comments are for, where people can see them,
and not *forget* them.

Cheers.

[1] https://www.ohloh.net/p/git/factoids#FactoidCommentsLow

--
Felipe Contreras
