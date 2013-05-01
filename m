From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] refs.c: make @ a pseudo-ref alias to HEAD
Date: Thu, 2 May 2013 00:30:05 +0530
Message-ID: <CALkWK0=WjctcYv30V9b3NMb5motYz=57OqmLU7pdW_fbOP40MA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-6-git-send-email-artagnon@gmail.com> <CAMP44s3nzuecoM+h+pNknV4A68R1gZ6DZpehp3uKcJhppXo+1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXcGu-0007Va-CV
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab3EATAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:00:51 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33261 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab3EATAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:00:46 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so2245225iee.20
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=67aH/FXUm1ehh3QB/UdOfqLJq/Rao5Ugf2Hpbgmmlzk=;
        b=SkjuT3S24An13urmpup9pW2Nzv/AkynDLV4XfS4T1aU+m44Ih+PbVZWvr7QlnA7jfm
         aFeYykEzEdhgPHHuR0MgS+FMNn0rzIoQi+OTZYa8YeG/UPtoa+DujulD7MjpQ6ktgMLL
         qJ/Pv9/SUP+lIzIJ8wfNRDu2JXPziLZFUwgpG1xnLvQ3rbBGXUIRrH9vSD4346STMpQW
         JBHCzXduaSjbzAyA2sG881FR4fN/84EmYn7ltB6SR1ZKqopIYnG0pNHPtFI8RhCV+wJr
         89GCF5OdLAI61iRqWsLOykyL4BEclbgVQzKX2gDGhflKe8r2BW5Wm9FCXTr6HUYmqrLj
         pdIA==
X-Received: by 10.50.73.65 with SMTP id j1mr2395479igv.49.1367434845710; Wed,
 01 May 2013 12:00:45 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 12:00:05 -0700 (PDT)
In-Reply-To: <CAMP44s3nzuecoM+h+pNknV4A68R1gZ6DZpehp3uKcJhppXo+1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223126>

Felipe Contreras wrote:
> Does the user really cares if it's a pseudo-ref or not? Also, what
> does it mean that "refers" to HEAD?

It's not about whether the user cares or not; it's about saying it in
a way that doesn't make it less precise.  I'm saying "@ is like a
symbolic-ref .git/@ ref referring to HEAD, except it doesn't sit on
the filesystem".

It's not important that end users understand it fully.  It's only
really useful in two cases: @~ and @^, and I've provided examples
there.

>> An '@' followed
>> +    by '\{' has no relationship to this and means something entirely
>> +    different (see below).
>
> If the user cares about that, the user can see that below, otherwise
> there's no point in mentioning that.

A user seeing @{} might vaguely recall @ and scroll-back here.  In
which case, this is useful.

> Just like there's no point in
> mentioning that @{-N} means something totally different from @{N},
> because the user can see that. If it didn't mean something different,
> this bullet point wouldn't exist.

Those two are right next to each other.
