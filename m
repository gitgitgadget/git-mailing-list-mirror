From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 04/13] Use "git merge" instead of "git pull ."
Date: Sat, 24 Aug 2013 22:26:48 -0700
Message-ID: <CANiSa6iQKgwbc7bD5+V0XZdqOf=6OvyxO3zay3v87vB3UTLivQ@mail.gmail.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
	<20130825041912.GD2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	wking@tremily.us
To: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSqj-0000kO-Vu
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab3HYF0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:26:50 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:43375 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3HYF0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:26:49 -0400
Received: by mail-wi0-f180.google.com with SMTP id l12so1631463wiv.1
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8ZpVzFJmJCr3t8acmNUImSjEUM+Te7Q0t3XAXiBc/Oo=;
        b=sui6gCj9BEEyE4kjXIzFOSxpuJy8YRNDiaAjjmop1yzKRFVHKo1bUC9RGxoJx/PvY9
         nWdkvYBvYNXRkvir6QwqbHj2So2l3oxWjK1ED7Us2OmE4Z1TRdXKhzm3QWDbd8xle9MF
         CUr8nS0kd3u30u1nRcaiVixQhx+BKpn8bR16YMTWFHV4XWXyYLbDnrNl8tLoEZTeIDVy
         +cJ77cRhOelKkKmPYNGHQmM5zprPNvNr3tpW+/BD+HmN2n3bN8grYlh2Yyx+Sj3KBimW
         hYKVdIsydUkjk1hgOWuxEaaQOH/jcLDVukoFt1IIpWUp/OkZqNAa+AX+9YyYmCyrYIwB
         NHWg==
X-Received: by 10.194.240.129 with SMTP id wa1mr172301wjc.31.1377408408588;
 Sat, 24 Aug 2013 22:26:48 -0700 (PDT)
Received: by 10.180.79.8 with HTTP; Sat, 24 Aug 2013 22:26:48 -0700 (PDT)
In-Reply-To: <20130825041912.GD2882@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232922>

On Sat, Aug 24, 2013 at 9:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Thomas Ackermann wrote:
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -1784,17 +1784,6 @@ repository that you pulled from.
>>  <<fast-forwards,fast-forward>>; instead, your branch will just be
>>  updated to point to the latest commit from the upstream branch.)
>>
>> -The `git pull` command can also be given `.` as the "remote" repository,
>> -in which case it just merges in a branch from the current repository; so
>> -the commands
>> -
>> --------------------------------------------------
>> -$ git pull . branch
>> -$ git merge branch
>> --------------------------------------------------
>> -
>> -are roughly equivalent.  The former is actually very commonly used.
>> -
>
> I wonder if it would make sense to say they simply *are* equivalent.
> I.e., what differences are there between those two commands, and could
> "git pull" be tweaked to eliminate them?

One difference is that "git pull" can be configured to rebase.

> [...]
>> @@ -2259,7 +2248,7 @@ When you are happy with the state of this change, you can pull it into the
>>  "test" branch in preparation to make it public:

I realize that "pull" here is not necessarily about the command, but
perhaps it would still make sense to change it?
