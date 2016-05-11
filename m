From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Wed, 11 May 2016 07:33:12 +0700
Message-ID: <CACsJy8BE6U=yecxPew9GKr-M_eYYtuag440njK1R+n3OxuJ_UQ@mail.gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com> <1461330096-21783-6-git-send-email-pclouds@gmail.com>
 <CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
 <CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
 <20160510141416.GA22672@lanh> <xmqqzirxldn9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 02:33:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0I61-00054D-6k
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 02:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcEKAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 20:33:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34381 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcEKAdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 20:33:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id m101so3250971lfi.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7X5za4AFkGFTvblJ0QiohBkOGbgV/A2JAEzgv8Ur1/U=;
        b=Hjo1PZwKbqdjejsVVOKnX12ElU+MOf/+XXi0N5X9F6gEwaHsoPsMdji1HQDd1Xc51F
         IcIS09SQf8emm/wiW5wefu5xqY2bPxiZO9SrOxjoN/uM+y1/UMiraK9mmhtTc9BtUkcP
         bwTf+rK2a4mCWobsW9I9MPI9rP4pxJkmF1WTC+454u/5fCE1Wm4J1ceEFm0+Dmjf2ywD
         szq2dqsyj3OUgEQ/ohmGWkCkWk/RoxWjpCH0UcQqRSw0PH9kQ72RAH9iIfVW5zJlOG2V
         ncszi3WAlkopKhs7guZjSgtg+NfZ/JwhAsBZU6f6uli3enHeIyir4OOppnVsbdk2ZObY
         /Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7X5za4AFkGFTvblJ0QiohBkOGbgV/A2JAEzgv8Ur1/U=;
        b=P8D9vapdOdoSqjA6QJ9GIsr+rQ9OroBz4nDZLeKrIuNnuumuEW8ZpTfPzHiTJ6RIfU
         RfBa71VXflsvYJx1lQA4+9Sr0auTMzfLIWYXcMUUzI4aoGMrnKpgZLshdM9rSswGfV3f
         8u7r2xumsA8yyggNDPf7jz5Q9e7QJGyQliQa6XJ41wzmNA/m2ALjw28nL7NU4MwX1t0J
         Qc2ZuZW/cZ7KIgL4qo2XSr0F3pVJR3uNP4IhWa41Gmmenekqr4VQPreVGITW6D9a2Uzw
         bo7IeRTue15z/9a6Ygi2OkSsEbMOkDowsp3PMrHYzBmASbc31ZwgEz/sZ2zbc2Rvd1Nq
         nUag==
X-Gm-Message-State: AOPr4FXwW4QkDUnrpaUQ3kq93YmP8Oa6rmHKmeZryvVJDAD7xetl2dPY4rVKAgWwb9jcNWIbSVdyBObm/6Cbbg==
X-Received: by 10.112.181.72 with SMTP id du8mr149620lbc.137.1462926822410;
 Tue, 10 May 2016 17:33:42 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 17:33:12 -0700 (PDT)
In-Reply-To: <xmqqzirxldn9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294207>

On Wed, May 11, 2016 at 6:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On second thought, why hold patches back, lengthen the worktree-move
>> series and make it a pain to review? I moved a few patches from
>> worktree-move into this series and I took two other out to create
>> nd/error-errno. So I'm going to take more patches out of it, creating
>> two bite-sized series, to be sent shortly.
>>
>> The first one is purely cleanup (ok, 1/7 is not exactly cleanup)
>>
>>   [1/7] completion: support git-worktree
>>   [2/7] worktree.c: rewrite mark_current_worktree() to avoid
>>   [3/7] git-worktree.txt: keep subcommand listing in alphabetical
>>   [4/7] worktree.c: use is_dot_or_dotdot()
>>   [5/7] worktree.c: add clear_worktree()
>>   [6/7] worktree: avoid 0{40}, too many zeroes, hard to read
>>   [7/7] worktree: simplify prefixing paths
>
> Where are these patches designed to apply?
>
> It appears that this depends on something in 'next' (probably
> nd/worktree-various-heads topic?)

Yes. Sorry I forgot to mention that. Though if you move 2/7 to
nd/worktree-various-heads (and deal with some conflicts in worktree.c)
then it may become independent.
-- 
Duy
