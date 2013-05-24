From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 19:32:59 -0500
Message-ID: <CAMP44s3Ba7L5fvEQPo0VADzNn9pJeyr2=f+OyW+_V5kkuKqEEw@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7vppwhb52f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0NmKO7qkxVDMqR7Lxutm19MdOQ+6u5_3MY6f18C_V3PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 02:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uffwh-0003wH-PO
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126Ab3EXAdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:33:03 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:42234 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810Ab3EXAdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:33:01 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so3820799lab.25
        for <git@vger.kernel.org>; Thu, 23 May 2013 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Efg7bN7BQ4bPOeRWn1dK/utTD2JLtnC5WDCjPjz+G90=;
        b=nGy3SNTOsTDVzrC8ye841ZCxoetMne3xy0g93OQQ8hNI66VZtnr3kadbAYNdu4SMRk
         6uumSaaS1lv9KRjL24WSTJXRbQTQrr1unQl2u3IulndLN5A9oq7Fim/09UPqRkjzFdtA
         2Dg1GjWu78cPV58eX7Cz9eX14Z5RO8QhdMWjnuK3HWQxrDLbhj8ZhPKKoJ9XpZjA5Fen
         RqA8UL6/GCMHneG+lZwcKhN94vbLP4ZBzMi5k58htEedyiHR13P2BBuhcffFQwCt+0ui
         19LISqApJjUrbPM8emSsf9Xc/dmXoMYQGitPWV6Tzc5wkfWDTutJitSrCBWLcf9YAMw6
         zV7A==
X-Received: by 10.112.218.102 with SMTP id pf6mr7638319lbc.77.1369355579482;
 Thu, 23 May 2013 17:32:59 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 17:32:59 -0700 (PDT)
In-Reply-To: <CAMP44s0NmKO7qkxVDMqR7Lxutm19MdOQ+6u5_3MY6f18C_V3PA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225328>

On Thu, May 23, 2013 at 7:25 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 23, 2013 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> It would be a *horrible* mistake to make "rebase" the default, because
>>> it's so much easier to screw things up that way.
>>>
>>> That said, making "no-ff" the default, and then if that fails, saying
>>>
>>>    The pull was not a fast-forward pull, please say if you want to
>>> merge or rebase.
>>>    Use either
>>>
>>>         git pull --rebase
>>>         git pull --merge
>>>
>>>    You can also use "git config pull.merge true" or "git config
>>> pull.rebase true"
>>>    to set this once for this project and forget about it.
>>>
>>> That way, people who want the existing behavior could just do that
>>>
>>>     git config pull.merge true
>>>
>>> once, and they'd not even notice.
>>>
>>> Hmm? Better yet, make it per-branch.
>>
>> I would assume that "no-ff" above was meant to be "--ff-only" from
>> the first part of the message.
>>
>> I also would assume that I can rephrase that setting pull.merge
>> (which does not exist) as setting pull.rebase explicitly to false
>> instead (i.e. missing pull.rebase and pull.rebase that is explicitly
>> set to false would mean two different things).
>>
>> I have to think about this a bit to convince myself that the message
>> is clear enough and useful for those this updated behaviour is
>> trying to help.  After reading the above message three times, I
>> still cannot shake the impression that we are just covering our
>> backside to be able to say "we told you already and you chose
>> poorly", in case things go wrong for them later.
>
> FWIW this is the message Mercurial users get (and they often say
> Mercurial's UI makes more sense):
>
> pushing to /tmp/foo
> searching for changes
> abort: push creates new remote head 77eafc4313d5!
> (you should pull and merge or use push -f to force)

Er, that's for push, but I don't see why something small like that
wouldn't make sense:

The pull was not fast-forward, please either merge or rebase.

-- 
Felipe Contreras
