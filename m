From: Stefan Beller <sbeller@google.com>
Subject: Re: git status during interactive rebase
Date: Thu, 21 Jan 2016 14:16:40 -0800
Message-ID: <CAGZ79ka7MVuHyTrjuR7BhBAxxJ-PuMCSDnRVWCbeeRSq9rGdWQ@mail.gmail.com>
References: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
	<vpqpowvz6g0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:16:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNX4-0004sO-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbcAUWQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:16:43 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33641 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcAUWQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:16:41 -0500
Received: by mail-io0-f176.google.com with SMTP id q21so69815935iod.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 14:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uTpm3esZ3D0HxmFXEhGtR2DxHecdnXLPfzOW/1OQj/E=;
        b=ZF4k+3MnVSW5M3KPHzuYKITxjFC3QvYzXO1brQMqL8ICU+oUFw8P1LJ4zFu8T+zZY9
         vZCwkTMDocjYCjO7CwvklF+fdSrkrI1tjSkVLmhcmK26fbRSc/BpZr2vDix08vo/VFtw
         2rYgIYY9nQUQ2TZFHLNszvsbbD+pLjWLnAUxQix+RK+P3IBhmGYRDM3cGs0IWohtjw2H
         4zN/tWETz2rBpkeZhqR48TOi5fbFyNvoISG+2M+RR9upxWKm+irJsqlI8hNb6ZjlUc9k
         7xGbV9UriO4MmwOBl59s5ma3vP0xkHreAnpZIA1wWA05fLh0q3lFWYK7uyEMjBRWN03H
         3atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uTpm3esZ3D0HxmFXEhGtR2DxHecdnXLPfzOW/1OQj/E=;
        b=gssxTl+oc7GGufXP5/eLd5z27JRKsSbYagfAJ/tSUae9ryNCQGxSHo0yaFkJlco11Q
         MDb/TYtSE6X8Up5sWFcFJdiwuCeKGpBJYbn7kXm5OkRoiLbgrJ0H3BEeYI96LGCxFgXQ
         jSrxnLBDaU/kBIX5Pj3bYE4RZAZT6jn+wuXW0Qf1PrkdNrbWLxxzVmGMhaRT+EDAZ504
         9Ut6zvvw7yxjaBWd2RIveZW7i9pNbSxknnTd9dc1TPRUel79IgJH0sDQObhtGjdA+mb4
         UR2tvYmVu4ZfP5dyQ/q1OWq1R4V4m9AYK0Yok8M7id3Bl15t9h91ppQm1N7Vh5G564W3
         9Z1g==
X-Gm-Message-State: AG10YOSkQUfN6s8bNCIdW8TqLyjRm8nlHD8kvYmTN4c5gPZyNZgnQ8gKt1/mgJ6OLs3vQjk+eh2jX9psfBUq8KnA
X-Received: by 10.107.137.68 with SMTP id l65mr321850iod.110.1453414600506;
 Thu, 21 Jan 2016 14:16:40 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 21 Jan 2016 14:16:40 -0800 (PST)
In-Reply-To: <vpqpowvz6g0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284534>

On Thu, Jan 21, 2016 at 12:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So I ran an interactive rebase, and while editing
>> .git/rebase-merge/git-rebase-todo I tried to run
>> `git status` in another terminal to inquire about a
>> filename of an untracked file.
>>
>> However, I got:
>>
>> $ git status
>> On branch submodule-groups-v3
>> fatal: Could not open file .git/rebase-merge/done for reading: No such
>> file or directory
>>
>> Was this behavior always the case? (IIRC it worked a long time ago?)
>
> From the list of recipients, I guess you already found that the issue
> probably comes from 84e6fb9 (status: give more information during rebase
> -i, 2015-07-06), which introduced
> read_rebase_todolist("rebase-merge/done", &have_done); in wt-status.c.

I just remembered you working on git-status specially during rebase,
so I figured you may have a clue here.

> No time to work on a patch for now :-(.

:-(

> The cop-out would be to write an empty 'done' file before editing the
> todo, but it would give the wrong impression that it is safe to run `git
> rebase --continue` now... Interactive rebase is *definitely* not
> thread-safe ;-)

ok. As I did not start the rebase yet, I figured I may still ask a thing. :P

> So the proper fix might be to test for the presence of the "done" file and
> otherwise tell the user that this rebase has not even started yet.

So what Matthieu said?

Thanks,
Stefan
