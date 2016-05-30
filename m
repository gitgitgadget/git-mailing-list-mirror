From: Yotam Gingold <yotam@yotamgingold.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 30 May 2016 01:07:49 -0400
Message-ID: <4067AC3B-D369-4E86-9EB9-ED19FD362E2D@yotamgingold.com>
References: <loom.20160523T023140-975@post.gmane.org> <CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com> <xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com> <CAP8UFD0yB8XjUi0f2OTUrW9W1UPC_ekY3+8--CC5rk_5RciYAA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 07:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7FQj-0001wY-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 07:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbcE3FHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 01:07:53 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34580 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcE3FHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 01:07:52 -0400
Received: by mail-qg0-f53.google.com with SMTP id p34so3925961qgp.1
        for <git@vger.kernel.org>; Sun, 29 May 2016 22:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wkYumLn6cI3pUjdw56a/Kk4EutvCpDGXhXgwu/IUUvs=;
        b=G57LzY2JadsefJ7ExLvPSZ8pQpL3E2p0rNadiiyjYT38hUHygxC/VQwE5eJX1feEFB
         HOmqGXgXl2rp+NfSa/fyqYNF+OABegSFa5FNRaNYapMTSQ9lvnW+vc9nnFaxOcxdrGTe
         5cv2S6nDu2UaLgayGUQREECnGt/3AvwRFjp7TA/FB6JAzdqT44BsZ/lWU1UG0YiBeVUd
         ey9r036Yla5NWDnmEd0fG5qQktQsGH1O8pU2/bQArAjIioCil9HS+KnybQgjXYKmPb+n
         thhGqC6i7/UNE+FCNWX8dyrIN2L2YHl720x36I1soNzLCATbFKJGNqJOqX/UtS11Fx+U
         jWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:mime-version:subject:from:in-reply-to
         :date:cc:content-transfer-encoding:message-id:references:to;
        bh=wkYumLn6cI3pUjdw56a/Kk4EutvCpDGXhXgwu/IUUvs=;
        b=LhPOn53YYTZ3RJrSZoEp5v5OGXmwrSUw+xmz1AY38d7t3+t3ieqFkeg3/HkGZXJpd5
         CrMD7CvvENqJnEHWLFTQZ2fg6KNovOi6/IbXzCtFqVLpj5+JmYzp5fxZPhsw712wTz3L
         tRdo4i9pHqrvnKavgVB06DQFc4voWvZIinal1FYz0wABrte1gav7FHhhL9if2fNJxiJM
         xiQO5BMwSw/pHrzJZH86QuoPsH5LPuwDOUWctTnWasGQUjArtd6WJZfS7KJHOLjLiHBB
         UGfK7NErS4e5w+pU5FpIE9mxPOcnLDBqmixQ4laU8W0Q5rib/qF6p50MjF/jgVHnAaSd
         B5Qw==
X-Gm-Message-State: ALyK8tLnK7PCAKm1beqRpQOeXJdl9rx2rQKgWr7gUSEZrIsDUXoAsT+StREPuja+K/c3kw==
X-Received: by 10.140.142.136 with SMTP id 130mr25417254qho.64.1464584871621;
        Sun, 29 May 2016 22:07:51 -0700 (PDT)
Received: from yotronagon.hsd1.dc.comcast.net (c-73-200-28-96.hsd1.dc.comcast.net. [73.200.28.96])
        by smtp.gmail.com with ESMTPSA id 17sm2529755qhp.28.2016.05.29.22.07.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2016 22:07:50 -0700 (PDT)
In-Reply-To: <CAP8UFD0yB8XjUi0f2OTUrW9W1UPC_ekY3+8--CC5rk_5RciYAA@mail.gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295852>

> On May 24, 2016, at 2:20 AM, Christian Couder <christian.couder@gmail.com> wrote:
> 
> On Mon, May 23, 2016 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> 
>> I am not sure if that is a good addition, though.
> 
> I am not sure either, but at least if something like that is added,
> people may complain less.

The present documentation is at best wrong and at worst misleading.
I read Junio's enumerations of the situations, and I appreciate that the
current behavior of git reset --hard cannot be changed because of the
many tools that rely on the current behavior. After reading it, I have
modified my proposed amendment to the git reset --hard documentation:

    A file is considered tracked if it exists in a prior commit or in the
    staging area. Note that a newly added file not in any prior commit will be
    removed. This is useful for aborting a failed merge.

Shall I submit a patch?


>>>> I would also like to propose that the staging area's tree object be saved,
>>>> ..
>>> Yeah, it might be a good idea.
>> 
>> Two issues with that "proposal" is that
>> 
>> 1. the index may not be writable as a tree (think: during a
>>    conflict resolution); and

So why not do it only when possible? But in this case (and every case),
wouldn't a solution be to create a tree that is not the index just for the reflog?


>> 2. the sole point of "reset --hard" is to "discard the changes".
>>    If you want to instead save them away, there is another command
>>    that was designed to do just that.

git stash isn't relevant here. git reset --hard deletes data from disk that has
only ever been in the staging area. Many commands in git can be "undone"
due to the fact that it is a version control system and there is a reflog.
This is not one of those. git reset --hard can cause a catastrophic loss of
data, with no way to undo it.


>> It wasn't all that surprising that those on stackoverflow would
>> think such a proposal is a good idea, but I somehow was hoping you
>> have been around here long enough to know "git stash" ;-)
> 
> Yeah, we can try to teach people about git stash and git reset --keep
> instead, but I doubt that it will be very effective.

git stash doesn't make sense in this context. The documentation for
git reset --hard is misleading. The error is unrecoverable. How could anyone
but a git developer know this?

Yotam
