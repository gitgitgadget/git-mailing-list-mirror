From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 8 Nov 2011 19:59:54 +0200
Message-ID: <CAMP44s0bm+bydNnMWPHpz8B8wMf6XN9LTiiCD-nrYSHGAV5c5Q@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
	<7vvcquy05c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 19:00:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNpxp-00041T-39
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 19:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab1KHR74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 12:59:56 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55885 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1KHR7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 12:59:55 -0500
Received: by qyk27 with SMTP id 27so3954592qyk.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xOav8bi3B+07eImu6dUs67aPwIrZMLgVBu+n3yrlXiI=;
        b=hyFr00naAXJrx5MHokDnPfikDv9GcsLfUu7J8jxx52yn2EpGt6rro3PxMFTAQCEpq6
         xcm4L2UzYy6tmo7TMW+BlhpmmyZs5l12biVYZ8GZqwX6nKh+KIZoaaUQ5hEP0IXztuRI
         WDasyIX2koeIu7nklDnT1E6g+6xM7ZAeQBdk0=
Received: by 10.68.0.103 with SMTP id 7mr2434941pbd.76.1320775194113; Tue, 08
 Nov 2011 09:59:54 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Tue, 8 Nov 2011 09:59:54 -0800 (PST)
In-Reply-To: <7vvcquy05c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185101>

On Tue, Nov 8, 2011 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Nov 7, 2011 at 11:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> That makes sense. But I think it fits in with git's current UI to do
>>>> this via a combination of push options and refspecs. Even if we want to
>>>> wrap it in some "git remote" command for convenience, I think what
>>>> you're asking should be implemented as part of "git push".
>>>
>>> Yeah, I think it makes sense to give --prune to "push" just like "fetch"
>>> already has. These two are the primary (and in the ideal world, only)
>>> operations that talk to the outside world. "remote add -f" might have been
>>> a tempting "convenience" feature, but I personally think it probably was a
>>> mistake for the exact reason that letting anything but "push" and "fetch"
>>> talk to the outside world just invites more confusion. There does not have
>>> to be 47 different ways to do the same thing.
>>
>> What about 'git remote update'?
>
> If you asked, I would have to say that is probably a worse mistake in the
> hindsight. I am guessing that back them "remote" command might have been a
> tool meant only for the read-only customers and the verb "update" may have
> made sense as "update me from the upstream", but these days "remote" also
> helps the aspect of pushing things out (e.g. "set-url --push"), so "update"
> that does not specify the direction is totally an inappropriate verb.
>
> You _could_ argue that adding subcommands and options related to pushing
> to "git remote" was a mistake. I don't care too much which side you would
> choose to blame, but taken as the whole, in the current set of options,
> subcommands and what "git remote" command does, "update" is a complete
> misnomer.

Perhaps these 'git remote' commands should be removed in 1.8 then.

-- 
Felipe Contreras
