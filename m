From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 12/17] rebase-todo: introduce rebase_todo_item
Date: Wed, 16 Mar 2016 20:54:55 +0800
Message-ID: <CACRoPnRH1D=8k5uuUahh1MJOAXsWkhY0fWev2AQhJm5+WWk5rQ@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-13-git-send-email-pyokagan@gmail.com>
	<CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:55:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAyb-00084M-AB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbcCPMy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:54:57 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36498 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbcCPMy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:54:56 -0400
Received: by mail-lf0-f50.google.com with SMTP id l83so18494944lfd.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cyNh3+5unUasMcgf9Y4G17dVsVx02G4kJzS4LDOm+pY=;
        b=YwN1iyOK6WC2JWZWb/m1d92n1V61Z8soQXv3Feqf/W++1APXMiJ9O7pyGoVANGc8HZ
         ShM9PHODee6A6/forpmMiOFQ+Q0gfy0E/ZL/fslcUgk0RoA2kTrLEOwls+I6fRH3ip4M
         BSx9ZxEvBjmXRIqgpupciGMUlc7s9xBuVBMhZzGzDmGdlHV1A2J+Tw5lYfS/EE7zNy6q
         S//IGa7AEwO8cvU8VPAOvMwgo562ve31Edqz1A2QBnmGs3u+q4rY/h4X55fbREo4C1Sh
         RB/zDQSlNrL2k1B/KtyRUkxymWMRGAz31+v54meZaZftMmrhvedTCE9I0FskC9Answ2E
         G6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cyNh3+5unUasMcgf9Y4G17dVsVx02G4kJzS4LDOm+pY=;
        b=KiL8819hSLWIb9TWXIaAdD3GkDaDXTdWcNyZwzziuayK279UJS0eoIlk5o8ADELl6H
         qNrHooZxGgHeFCzyQ7jKU04bCGh1aaWkvVsuLTUAzf8AayQlT+sErMofWTKfVL7GSHeP
         8+/gHkk/YaULZ+n3L1LFBb9QGdNFno8yWWgFHKSaUzFUm1Y+/tElBIcNkBwB38JeD0Z3
         CSQDhRtB1auZ0cvotUKd8eevOKOA4Nb17I5h1Ny+uQU8xScTsrIafBO9bBSU5fHsJZts
         G26kchYUXN5XEQWxX8ol6gd1UE7u99R0JmyIq+o3Twq+YDHmNUBFzStKQHiYuGxKO5hK
         F3+g==
X-Gm-Message-State: AD7BkJKr4jxvtAo+6AYWPqTgowpXKB82Rw4xJRTRrO2vGb0xhHzPAc7JSmkFONYmpEITzu994JL0oxYXzVte/A==
X-Received: by 10.25.156.133 with SMTP id f127mr1387328lfe.102.1458132895073;
 Wed, 16 Mar 2016 05:54:55 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 05:54:55 -0700 (PDT)
In-Reply-To: <CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288967>

Hi Christian,

On Mon, Mar 14, 2016 at 9:43 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Mar 12, 2016 at 11:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> In an interactive rebase, commands are read and executed from a todo
>> list (.git/rebase-merge/git-rebase-todo) to perform the rebase.
>>
>> In the upcoming re-implementation of git-rebase -i in C, it is useful to
>> be able to parse each command into a data structure which can then be
>> operated on. Implement rebase_todo_item for this.
>
> sequencer.{c,h} already has some code to parse and create todo lists
> for cherry-picking or reverting multiple commits, so I am wondering if
> it would be possible to share some code?

AFAIK, sequencer.c as it is in master parses the todo list
destructively and does not keep the associated action for each commit
and the "rest" string. interactive rebase does keep those, so I needed
a different data structure rather than the one currently being used in
sequencer.c.

As I said in another thread, originally I wanted to keep the scope
simple, and just do the rewrite of rebase from C to shell, and let any
further libifications and optimizations come after, so I didn't want
to touch sequencer for now. However, it turns out that Dscho has grand
plans for the unification of sequencer and interactive rebase, so I'll
go with that :-)

Regards,
Paul
