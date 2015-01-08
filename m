From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] show-branch: Indentation for show-branch usage
Date: Fri, 9 Jan 2015 02:27:01 +0600
Message-ID: <CANCZXo6MvQ1EHXg18P1GZ9Vov3si780Jeh5oLdAdBju-XTnavw@mail.gmail.com>
References: <1420740516-20836-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqsifldone.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:28:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Jfj-0007Nq-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbAHU1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:27:03 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:50898 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbAHU1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:27:02 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so9084605oia.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3Sw1lE0/qM5Y8qq6Md49kF8bFwu7zQN8pQinCY+0DT4=;
        b=u/tC/cYewLrAAwBUj2zRYtELqBJPOpQ8Swa1nnPQ6BxRjX/yjoTpi9d//aChez3C+k
         fVYSfWr9iYmlzZoDdfRRduy7xnEzhOxGUfsQnJBKKuJ0DlcS2Qwa2BMgvnYYyXHjvAy9
         C+PhtkE9cjf1V4yf8CcjJY6f91rVBTVDAlxIwWipE7Iuj7+8q7ebrery3S8lSQzsGrCz
         0j0+ZEEY4MPd+g62FApVBD+0DWNoIHvsDXJDo57bwpd0XIYbMmiUd7yotIpgewDNncgq
         +0J55Vwd5lZjKUaIazf9X8g0xdz5EDoQGNO68bezcRF8WsXNaPYo0Le/k/FKszi6YObo
         f48Q==
X-Received: by 10.60.52.132 with SMTP id t4mr6892645oeo.11.1420748821617; Thu,
 08 Jan 2015 12:27:01 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 8 Jan 2015 12:27:01 -0800 (PST)
In-Reply-To: <xmqqsifldone.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262221>

No it doesn't breaks N_ macro. Will resend the patch.

2015-01-09 2:05 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>
> s/Indentation for/line-wrap/, perhaps?
>
> What the patch wants to do makes sense to me, but I haven't seen a
> long multi-line string, each lines in which is terminated with "\n\"
> in the source, fed to N_() macro anywhere else in the existing
> codebase, which makes me a bit nervous.
>
> Would writing it this way instead, i.e. making it more obvious where
> each line begins and how long the indentation of subsequent lines are,
> also work?
>
>         N_("git show-branch [-a|--all] ...\n"
>            "                [--current] [--color[=<when>]] ...\n"
>            ...
>            "                [--no-name ...");
>
> Or does it break N_() macro?
>
> Thanks.
>
>
>>  builtin/show-branch.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
>> index 270e39c..2e60107 100644
>> --- a/builtin/show-branch.c
>> +++ b/builtin/show-branch.c
>> @@ -6,7 +6,10 @@
>>  #include "parse-options.h"
>>
>>  static const char* show_branch_usage[] = {
>> -    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
>> +    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order]\n\
>> +                       [--current] [--color[=<when>] | --no-color] [--sparse]\n\
>> +                       [--more=<n> | --list | --independent | --merge-base]\n\
>> +                       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
>>      N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
>>      NULL
>>  };



-- 
_________________________
0xAX
