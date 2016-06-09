From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 63/94] builtin/apply: make apply_all_patches() return
 -1 on error
Date: Fri, 10 Jun 2016 00:01:06 +0200
Message-ID: <CAP8UFD0chzr9O9hpjQ00YruwfLof3gHj32292e3s=1SFmKdPzg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <20160511131745.2914-64-chriscool@tuxfamily.org> <CAPig+cQAM8i2sFY9UUYfN23PRGgFacG7KiTD6mZwnm=PgKBL7A@mail.gmail.com>
 <CAP8UFD2jA7ydsYTkQLbQJTW7NFRpkmJwgJQp=UZ0-8-7njSawA@mail.gmail.com> <CAPig+cQpk4Kknbudu1Ki3T9=rsO9+q4BCR6C2-1xjgUE0HSJYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:01:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB80t-0006HP-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 00:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbcFIWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 18:01:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32804 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbcFIWBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 18:01:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so13822156wmr.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GD6FNCxysSPLJenK5RM639IK6g9LfLvodOE6SQEYims=;
        b=UHTRhD3VlC/BY0heRjf8kteUuCkWejT/lJsdctBlyRWsLEsY37lKFfYywOCe0QDX02
         e2dxcnwuUVbS05Z782M7QgevhV40A7bDuv/YWnzS41/Nc3N5Fpk0tRtUBY6kA4FfBeKZ
         v+wEfxwKiP3udL+xLdmjufn5kXs4Nc5gzcv6iVbHwaKkB10UbTwe8vse+eGVX278x/4N
         ro/xWhsN/PeUxgE2AdDdt+ttozLSdp6OHzUAnHcYyXw4Yh9hrsyS9+bzCCD42SeQupSJ
         yo9BOHPITSz+u8I/u9fI69CJaeA9YJ9F5wD9QxHTqPRdON+Mu1zmGM+hlzrNYMOJQQcn
         9Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GD6FNCxysSPLJenK5RM639IK6g9LfLvodOE6SQEYims=;
        b=KqCZUqlwnmYlsORSEOlJYWxzHlTy3/iY8piw9ccPc7G2pZDCQoK0DOUwZSylyjJGBk
         w7AWea+cKXY4ODzwAEyffesqTbPYoV3judWeeyaIuzBloNPSkqrt/0zFIbsHxteHrBys
         /4+qgDchCPznIu6kpoZsjtkPAZM0W1IltHHwgg8SwLwQMNWAT/Cd91AiVt7VQzKUnLKA
         uiGjhk8u7u/IoXSpuYfe2DBf0GbriEtMvKDTFA5kgBh1Chxbi0tE7cetU26ccVWNnF96
         qr9jnzdbBHOXHro8wevbHFauIVx82QnQNjn/yFDERaTL3ub6QkQhoz7OEZMcgr1mERo1
         M19A==
X-Gm-Message-State: ALyK8tLJ943GhhUfQn0FDeHD6N2F5Lmde52WTtDR7wY4eVmP+5pe0CW4/MPuEz9i7Ez58/Vj30IXynh9V1oI1w==
X-Received: by 10.195.17.166 with SMTP id gf6mr11416220wjd.124.1465509666923;
 Thu, 09 Jun 2016 15:01:06 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Thu, 9 Jun 2016 15:01:06 -0700 (PDT)
In-Reply-To: <CAPig+cQpk4Kknbudu1Ki3T9=rsO9+q4BCR6C2-1xjgUE0HSJYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296935>

On Wed, Jun 8, 2016 at 7:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 12:37 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, May 16, 2016 at 5:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>>         if (state->update_index) {
>>>> -               if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
>>>> -                       die(_("Unable to write new index file"));
>>>> +               res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
>>>>                 state->newfd = -1;
>>>
>>> Does write_locked_index() unconditionally close the file descriptor
>>> even when an error occurs? If not, then isn't this potentially leaking
>>> 'newfd'?
>>>
>>> (My very cursory read of write_locked_index() seems to reveal that the
>>> file descriptor may indeed remain open upon index write failure.)
>>
>> You are right, it is leaking newfd if write_locked_index() fails.
>> The solution to that is to call `rollback_lock_file(state->lock_file)`
>> and the following patch was supposed to do that:
>>
>> [PATCH v2 82/94] apply: roll back index lock file in case of error
>>
>> but it would do that only if `state->newfd >= 0` so we should set
>> state->newfd to -1 only if write_locked_index() succeeds.
>>
>> I will fix this.
>>
>> I am also going to add a comment to this patch saying that this patch
>> needs a following patch to call rollback_lock_file(state->lock_file)
>> in case of errors.
>>
>> Or if you prefer, I can squash the patch that call
>> rollback_lock_file(state->lock_file) in case of errors into this
>> patch.
>
> Squashing may indeed be preferable over leaving it in a "broken" state
> until the next patch, though I haven't thought too hard about it.
> Alternately, can the two patches somehow be swapped?

I just squashed them for now as the result looks reasonable.
