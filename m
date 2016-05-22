From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] worktree: add "lock" command
Date: Sun, 22 May 2016 17:31:08 +0700
Message-ID: <CACsJy8CpsW+Jp=A8swDzR0+udGq8H-ampztyZwyXiK2mbcjqPA@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160510141729.23063-1-pclouds@gmail.com>
 <20160510141729.23063-4-pclouds@gmail.com> <CAPig+cRMxYGx_gR9vei=6bcoXkhm2ntQSdqA3Vq9rtTzDd1RSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 22 12:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Qff-0004XF-F9
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbcEVKbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 06:31:40 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33168 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbcEVKbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:31:39 -0400
Received: by mail-io0-f181.google.com with SMTP id t40so84316842ioi.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VFaGfvG/14RjcVUlPqOBcqk3YBUaXb5+0bn9r5P8RSc=;
        b=rub9i2jQnbdYn4lsMCAXHGkxo1afRQk8Uocadnrj8Y4YVgA5O+K70dAorCDOZYS1eC
         VYopGyb4OMix75pCBAFi687DZTfxQQeOrSlF+0DJs8hcdm1SWglW+2QS/JaVx2Tq8tsC
         YGqwGzDMBOSTcH1sT89h3cvJjWqfBadTozkRcoQSJ62yR2l8mfnQxVzl2Zul87wGLgFX
         RKRYMiUF/5YMifAbcfcOOME17xHsJitUY+zaS8jrc39QlutrSV4lnf/BwqLWTEFaDR2H
         voAkUH7eE305bE5AGX7nGUj2JJQWKXyNYfR8qSXm+bAYIAOZzN/TTwY5WITebSciExfp
         C1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VFaGfvG/14RjcVUlPqOBcqk3YBUaXb5+0bn9r5P8RSc=;
        b=DOy+BDACVGjvtgbrtnlY8wZNg0Kg8byTUpD9T3E3azzDt6Yz5hP0WD1/Bg4UjbpjbQ
         RpohwVPl66avtLtiO3ELQrb/r9cGrSMog80yXKgA/W3eD4MOKYrvQt9ilnSKWEmWz/Mo
         eu/2rxSm/NUaH9R5p8QqW7TKhf8BRqoZQsZHiF2Czn9IjY6YQGEbPGd/pfhfAnBZfx6h
         OpkwpVOP6w6cWQH7hlHmTWfFOZlPx5aW6nOEb9koqaIOKW+ph5jK6D/ATACGLoWa/S++
         KOA/PggUljQO5+Yrl/vawCGUw+1q3woYiMBk4PInRBtVfAljYQnMng/KcJWRK9UxTmFo
         xFow==
X-Gm-Message-State: AOPr4FW8MEoCEYug+kVGraL+JIeZ4jfEz/CFYi6o6/G/7xAM5Hl338nbGG4GOkxE+mZjNkHuRj6Ue7H7GtamzA==
X-Received: by 10.107.159.84 with SMTP id i81mr8193725ioe.29.1463913097869;
 Sun, 22 May 2016 03:31:37 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 22 May 2016 03:31:08 -0700 (PDT)
In-Reply-To: <CAPig+cRMxYGx_gR9vei=6bcoXkhm2ntQSdqA3Vq9rtTzDd1RSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295269>

(the answer to rest of your questions is "yes you're right, will fix"
or something along that line so I will not quote them here)

On Mon, May 16, 2016 at 7:09 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +       old_reason = is_worktree_locked(wt);
>> +       if (old_reason) {
>> +               if (*old_reason)
>> +                       die(_("already locked, reason: %s"), old_reason);
>> +               die(_("already locked, no reason"));
>> +       }
>
> As a convenience, would it make sense to allow a worktree to be
> re-locked with a different reason rather than erroring out?

For now I think the user can just unlock then relock, after examining
the previous reason and maybe incorporating it to the new reason. Yes
there is a race but for these operations I don't think it really
matters. If it's done often enough, we can lift this restriction.

>> +       write_file(git_common_path("worktrees/%s/locked", wt->id),
>> +                  "%s", reason);
>> +       return 0;
>> +}
>
> This is a tangent, but it would be nice for the "git worktree list"
> command to show whether a worktree is locked, and the reason (if
> available), both in pretty and porcelain formats. (That was another
> reason why I suggested to Mike, back when he was adding the "list"
> command, that 'struct worktree' should have a 'locked' field and
> get_worktrees() should populate it automatically.)

Yes. And a good reason for get_worktrees() to read lock status
automatically too. I will not do it right away though or at least
until after I'm done with move/remove and the shared config file
problem.
-- 
Duy
