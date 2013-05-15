From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 05/10] remote-hg: fix new branch creation
Date: Wed, 15 May 2013 14:45:30 -0500
Message-ID: <CAMP44s3hfQD7JLgDebH4RM4tJspMQvw2ojeFTpa6hXJmTjJVHA@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-6-git-send-email-felipe.contreras@gmail.com>
	<51929c576d949_13a8f89e18183b@nysa.mail>
	<7v8v3gav6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 21:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uchdp-0006HG-3A
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab3EOTpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:45:32 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33363 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3EOTpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:45:32 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so2283108lbi.21
        for <git@vger.kernel.org>; Wed, 15 May 2013 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Z4muwTjrVZ3m4hAmY/I6fvitWogvYh+d8Nr7Wpb02rY=;
        b=KO2cykruh20puKA4l5d+kZPACqQJncHKi5igUcKOlaHV2UFhs8/82BsOfh8Fgr9dtr
         dtAe921mbnA8b7oAsSTyN1byOsr5vKzlsnlYRCo9abBRYMv6ckYW2S3a76OBV2EX8MnU
         wwv8Z2vbFbWYjZAC6CYG/ftmVhhAiTJ4SyWSZvFVY2g2E6ZqEWNr+tmRzcuimOo0NHqT
         3RkSNkwu0w6GYYhgrpuRR2cygtD48hTXcuFWIG/9NgHUC3J6Zlq7sYNN+wpHLArBKA0Q
         a8n28KZ/7lFd019sg9LGImT68pqDFD7lAm7RbGGQDcVomUE6rQd1gjQeecJgUmqoixMO
         PRpg==
X-Received: by 10.112.135.70 with SMTP id pq6mr18500522lbb.82.1368647130658;
 Wed, 15 May 2013 12:45:30 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 12:45:30 -0700 (PDT)
In-Reply-To: <7v8v3gav6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224444>

On Wed, May 15, 2013 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Felipe Contreras wrote:
>>> When force_push is disabled, we need to turn the argument to True.
>
> With your follow-up clarification, here is what ended up in the log
> message:
>
>     remote-hg: fix new branch creation
>
>     When a user creates a new branch with git:
>
>       $ git checkout -b branches/devel
>
>     and then pushes this branch
>
>       $ git push origin branches/devel
>
>     which is the way to push new mercurial branches,

I don't like this part. This is not documentation, this is a commit
message. You don't explain how git works in every commit message. It's
not relevant how to create Mercurial branches, it could be done
through a totally different way and it wouldn't affect this patch. The
only thing that is relevant is that a new Mercurial branch is created
somehow.

But since you never, *ever*, agree that a piece of information in the
commit message is not useful, I realize this is wasted breath.

>     we do want to
>     create a branch, but the command would fail without newbranch=True.
>
>     This only matters when force_push=False, but setting newbranch=True
>     unconditionally does not hurt.
>
> The only part that I came up with on my own is "but ... does not
> hurt" at the end.  If that is incorrect, please supply an update.

It's correct.

-- 
Felipe Contreras
