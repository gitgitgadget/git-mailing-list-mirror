From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 23:04:52 -0500
Message-ID: <CAMP44s03iXPVnunBdFT8etvZ-ew-D15A7mCV3wAAFXMNCpRAgA@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 06:05:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmFpL-0000PJ-9j
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 06:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab3FKEEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 00:04:54 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48433 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab3FKEEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 00:04:53 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so2582860lbc.31
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 21:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2/XX8TxsyH/7JZOVhEajw61UiA/4RM7jDhTEOeylOrQ=;
        b=ZW2gN3xOc4IhJp+KUsYzQoZw6sPOHqwPLTTqaw8vGyxez8SLpMRLju9Ye2OIu3AYoB
         0e+7WM55UlTMU0SvysMbsPCjREmMQtITQJ/vBLcb3s8dQmjjJN0/MhXNKW4fTFnUDx1r
         fvys2CIbWSpGCXT9f+ZaDQ1pQYxnV2sL/5XcfTA+P9SQmbp17G/aN5exXfk/bteK6Ekk
         8hHveSYeLH9OAX3xGzcgio5U36vut/IIFxzzErEQl2qCKQTXhHf516QP9bg2d7h7fNO3
         ghyFPTmc7NrA5a4HUtQl4xZgXs2cpF8ckwzMYp2oCY0pcLiReQmAHWNlffsCufRhHMHY
         wHag==
X-Received: by 10.152.28.162 with SMTP id c2mr1922157lah.45.1370923492103;
 Mon, 10 Jun 2013 21:04:52 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 21:04:52 -0700 (PDT)
In-Reply-To: <7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227412>

On Mon, Jun 10, 2013 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> *1* ... which is a very reasonable thing to do.  But moving
>>>     sequencer.o to builtin/sequencer.o is *not* the way to do this.
>>
>> By now we all know what is the *CURRENT* way to do this; in other
>> words, the status quo, which is BTW all messed up, because builtin/*.o
>> objects depend on each other already.
>
> builtin/*.o are allowed to depend on each other.  They are by
> definition builtins, meant to be linked into a single binary.

That's not what John Keeping said[1]. I'm going to assume he was
wrong, but I don't think that's relevant for my point.

Either way, the meaning of builtin/ should probably be explained somewhere.

>> We are discussing the way it *SHOULD* be. Why aren't you leaning on that?
>
> And I do not see the reason why builtin/*.o should not depend on
> each other.  It is not messed up at all.  They are meant to be
> linked into a single binary---that is what being "built-in" is.
>
> A good way forward, the way it *SHOULD* be, is to slim the builtin/*.o
> by moving parts that do not have to be in the single "git" binary
> but are also usable in standalone binaries out of them.
>
> And that is what I just suggested.

But init_copy_notes_for_rewrite() can *not* be used by anything other
than git builtins. Standalone binaries will never use such a function,
therefore it doesn't belong in libgit.a. Another example is
alias_lookup(). They belong in builtin/lib.a.

[1] http://article.gmane.org/gmane.comp.version-control.git/227017

-- 
Felipe Contreras
