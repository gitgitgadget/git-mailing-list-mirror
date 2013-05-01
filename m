From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Wed, 1 May 2013 14:28:27 -0500
Message-ID: <CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-5-git-send-email-artagnon@gmail.com>
	<CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
	<CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:28:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXchx-0007FE-2d
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab3EAT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:28:35 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33626 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab3EAT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:28:29 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so1600634lab.11
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XG+5CMifMKeqUm7vXflnyKdkHuOM4o2PLVE2bF1DJaI=;
        b=fYlM3JXhw01Rd/7rJDZe+MV8ARANJ1iXhwDo8YnNWfd98n7hSKeYyg/bNhOsrpdFJ5
         TT2Wr5MqIJppjRR03SnJ9tFNmrIfM0KgX6ENECEnRK18Kduo7kC/6lUgo7XJRNRQSkeS
         s8tM9eAQX0iCodApLdMjQ1ETGAxerlC42XwGcP5Xt6KTVhviD378t88Lsl+YVmQqQzkc
         kwDF1mU918x1xYKyUnHe+I8WMhLHjnVyTB8PxESC4alfD5f9eb6QT7BN8hYuhY4hrYp3
         zN73n6UfZfZQmkqIe1TUsVuHcmb8MwBhMJF7BtZLCW6KFy2pcz1YHTj+D9xaNCZULzSB
         /xdg==
X-Received: by 10.112.22.198 with SMTP id g6mr1561516lbf.135.1367436507956;
 Wed, 01 May 2013 12:28:27 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 12:28:27 -0700 (PDT)
In-Reply-To: <CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223128>

On Wed, May 1, 2013 at 1:44 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> But why? I'm not familiar with branch_get, but my intuition tells me
>> you are changing the behavior, and now branch_get() is doing something
>> it wasn't intended to do. And for what?
>
> Why is there a commit message?  I've explained what the behavior change is.

Not good enough.

>> Your rationale is that it fixes the test cases below, but that's not
>> reason enough, since there are other ways to fix them, as my patch
>> series shows.
>
> For what exactly.  To fix a real bug: H@{u} and @@{u} don't work where
> either H or @ are symbolic refs.  I want custom symbolic refs, because
> they are useful.  In other words, "HEAD" is not a sacred symbolic ref.

As I said, the @@{u} thing can be fixed through other ways.

Moreover, "HEAD" is still a special case in remote.c::branch_get()
that you just modified.

>> I think these are two patches should be introduced separately, and
>> with a reason for them to exist independent of each other.
>
> I cannot justify the remote.c patch without the "@{" change.

That's what I thought.

-- 
Felipe Contreras
