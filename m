From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 19:58:39 +0200
Message-ID: <CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:58:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqmXt-0003XK-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbbEHR6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:58:41 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36394 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbbEHR6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:58:40 -0400
Received: by wgiu9 with SMTP id u9so79302751wgi.3
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QIy5iFWL3uCYrllKTj52FdGohliaJ2w35CoBWvJkzmc=;
        b=Wce54KQBE3sTIZZnpadzt+7x00D7BreoLuxanrAUBbv7ltO1ZLIWQcaBe8ht0VkVJu
         kcZYSxd1T9/Z+JotuY/QtE88dm4ULIyfXr6Pfdot/2lT4z+gPyzyQ8TP2+VkSKWX+CSa
         dUBybinGvvHQffUMw9Sw1myAJX1ULy6l3ueBQZ5WSp0z4ZV6rcMOXLlJrT5HJHGibszz
         uxhabrZBG47YpybdQIsnFKujNikiWMPZj2K/VjW+4vuAnh8y7iyWVg5sDZ75IjuBIxDs
         BfpXlxBASTr2+VS5qPg6U/UO0oIKY0/0V8rv1WJMVqDbxHVZdJQOB9xO8oZMYUAc+aew
         x2qg==
X-Received: by 10.194.97.196 with SMTP id ec4mr9669532wjb.3.1431107919936;
 Fri, 08 May 2015 10:58:39 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Fri, 8 May 2015 10:58:39 -0700 (PDT)
In-Reply-To: <xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268635>

Junio C Hamano <gitster@pobox.com> wrote:
> But I doubt the value of pointing out exact commit in the first
> place, which leads me to say that "no -m option was given but
> history has a merge" might be a viable alternative.
>
> If identifying the exact commit has value, on the other hand, we can
> rephrase it like this:
>

It has value since you see the hash and can check if you have
passed a wrong commit accidently.

I don't see why you suggest to rephrase the messages over an
abbreviation of the hash. Is it because I wrote "in the middle of"?
I think it's a good change anyway.

>         error(_("no -m option was given to pick a merge '%s'", ...));
>
> to place it not in the middle.  We can do similar rephrasing for
> other messages as well.
>
>>> -                       return error(_("Commit %s does not have parent %d"),
>>> -                               sha1_to_hex(commit->object.sha1), opts->mainline);
>
>         error(_("No parent %d for commit '%s'", opts->mainline, ...);
>
>>> -               return error(_("Mainline was specified but commit %s is not a merge."),
>>> -                       sha1_to_hex(commit->object.sha1));
>
>         error(_("-m option was given for non-merge commit '%s'", ...);
