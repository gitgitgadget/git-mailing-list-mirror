From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 19 Mar 2016 22:14:08 -0400
Message-ID: <CAPig+cQvpGgWzT9rXSx_9TR8fg0TrUf+dSs91iRinbbdwo39cg@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
	<CAPig+cQg2gYbr26X6PPQ6bobkxbufSSNtA1T94kdyEKQwHZXBw@mail.gmail.com>
	<CA+DCAeTnvEZjcGaS=Ed95bGYHRqV-svtTY-hX8gEbXstbkYe5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 03:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahSsh-0005qj-L1
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 03:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbcCTCOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 22:14:11 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35213 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955AbcCTCOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 22:14:10 -0400
Received: by mail-vk0-f68.google.com with SMTP id e185so13182004vkb.2
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=A9sXL7DPfRhv10SvjUQwyLXrbjU9GzA3lnI6ohVDGC8=;
        b=a6Fjt7CY2AyLVhrpZPoJrpNORVX1c3KCA4l7iv1YyG84M/25uwvXOa+PKzU/CEjKU+
         4Pvdv8+Nhwj9x9qCfUqOjmOO/xhCjmtZP70gQhRPur5JWKPgjFfLGcyS/75dnGp6OGgB
         8uA7NxM7G28Co3SHtQCKTJnGoaD5QdDfTyBnQqoI86qbwAQoUcKwdcc/QM9FpeLQOUUf
         lOdHZQ7HoMU3Pq2mj2xF7hJm/nX1dWyxIc9BJ87v5WfUzmdp6+cBpYWQj68KgqSOdzt5
         qnRmU7ZoFp1J2jUyiSZkB/wjRIexlfA3Nzv0jQJ01VYt4qziuKKd3FrwbL/QDeRzIVDk
         XzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=A9sXL7DPfRhv10SvjUQwyLXrbjU9GzA3lnI6ohVDGC8=;
        b=cFoUxOe2WB3YViFtCtTCuklon4L5eZC9Aa6HBHQwnBWqdBUPEAqagxSk43vEZcsI7I
         x6fxiWzHF0qMhbuFL1R/O4BVieRu8Qu6QMIckyDJtcRgVF1fYkEaoGjihg/F0hJjCndO
         /5AtfdsmSjh1sKXUHp0bHYLAghCNAnVlBqkjkzzD+adxmahDKAyBUCts/Yph6Ykkjcuk
         hqGxu907qaQTWaxg5tYn2n9ERMTd9w6xp9iGdOMP+Aex4whAsQNqTrnzxot4KQo4TGi8
         ko/jISBJu3CeNlzHVibsRgVR2E304kJJNZQi0K6cByAKP28Yll1UZK5AQsecg8CbnY/9
         Lr3w==
X-Gm-Message-State: AD7BkJIIsX901NMiGQSr5FIFEweo1k+/tAt9jTUGWOZ6t8dwrN7/NjsFZoGuQni5DdPJ1abeoDETc44FgTidCA==
X-Received: by 10.31.150.76 with SMTP id y73mr25365273vkd.84.1458440048864;
 Sat, 19 Mar 2016 19:14:08 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 19 Mar 2016 19:14:08 -0700 (PDT)
In-Reply-To: <CA+DCAeTnvEZjcGaS=Ed95bGYHRqV-svtTY-hX8gEbXstbkYe5A@mail.gmail.com>
X-Google-Sender-Auth: ayR2br_Q7dI2Aaheh-S-86NonyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289328>

On Fri, Mar 18, 2016 at 11:17 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Fri, Mar 18, 2016 at 10:09 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Actually, this is going to pass --autostash or --no-autostash to
>> git-rebase unconditionally won't it? This seems kind of undesirable
>> due to the unnecessarily tight coupling it creates between the two
>> commands. I wasn't paying close attention to the earlier discussion,
>> but wasn't the idea that you should pass one of these two options
>> along to git-rebase only if the user explicitly asked to do by saying
>> so on the command line?
>
> This is interesting. I checked out git-rebase.sh and found that it reads
> rebase.autoStash if nothing is specified by user. So if user is not
> specifying anything about stashing then it is the job of git-rebase
> to decide whether or not to do stashing by reading rebase.autoStash.
>
> Similarly if user doesn't specify the --[no-]autostash option to git-pull
> then neither of --autostash and --no-autstash should be passed to the
> git-rebase as it will decide on his own about what needs to be done.
> Agreed. I made a unnecessary tight coupling between git-pull and
> git-rebase. Instead of that the following changes can be done to
> remove it.
>
> This way there's no need to remove "autostash" from the current code
> base and instead use it to write a much cleaner patch.  Something like
> this (this is w.r.t. current code base)
> [...]
>
> What are your views on this?

I think this makes the patches cleaner and the final code nicer, and
it eliminates the too-tight coupling between the two commands, so it
seems to be a win overall.
