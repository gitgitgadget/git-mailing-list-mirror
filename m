From: tsuna <tsunanet@gmail.com>
Subject: Re: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 00:56:40 -0700
Message-ID: <CAFKYj4fdYHKukM7kaxxTKYNqTfOXadmZynTxXO9824G6H6HiZA@mail.gmail.com>
References: <1374306567-16640-1-git-send-email-tsunanet@gmail.com> <CALkWK0m46SR3C6R_pjYouu7LkHjL_gPGb1A3S94d0nx8227-UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 09:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0S2M-0000sR-Qx
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 09:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab3GTH5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 03:57:02 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60886 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3GTH5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 03:57:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so6282846obb.8
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OX0VmDjTKcEfvt0kFGYn7eAm9nXHg39Zu9KIuvSnmuE=;
        b=FfKM+hCFm3MG1Az93/sqLVft1eZOLnRaXjZF8BYMhKvHoYPAk4xfRdsSmaqWPAr2i3
         YXa73GGItiq0Rd1Y2ikSkanTAz2FQtjRLrQ7xt6Jhrx0UMxGnwOUFEOPWjXUB93/GMI6
         UEVc8/ldfuBtEzBYqtclfHQMPRal1uy7R7+ih+RxYUZ38SpthaYAHGqBDbXRXWSdkkmD
         kz1sbIq+L+kg50n11jIF8QeqbnrjQxGBAzObJt4yg3fkz5NE+1AYsvddRYBs65JN6Sv9
         JAQJPlWJ5/y7X4+nteHdLeKakZNqC8H22Lr1rCJ+lf8HKICmAxFXCyPAmG0ko7xH/BFF
         iXOQ==
X-Received: by 10.182.47.137 with SMTP id d9mr15203116obn.26.1374307020794;
 Sat, 20 Jul 2013 00:57:00 -0700 (PDT)
Received: by 10.182.241.170 with HTTP; Sat, 20 Jul 2013 00:56:40 -0700 (PDT)
In-Reply-To: <CALkWK0m46SR3C6R_pjYouu7LkHjL_gPGb1A3S94d0nx8227-UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230877>

On Sat, Jul 20, 2013 at 12:55 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Benoit Sigoure wrote:
>> diff --git a/compat/unsetenv.c b/compat/unsetenv.c
>> index 4ea1856..addf3dc 100644
>> --- a/compat/unsetenv.c
>> +++ b/compat/unsetenv.c
>> @@ -1,5 +1,10 @@
>>  #include "../git-compat-util.h"
>>
>> +#ifdef __APPLE__
>> +// On OS X libc headers don't define this symbol.
>> +extern char **environ;
>> +#endif
>> +
>
> Shouldn't this go into git-compat-util.h, since there may be other
> files depending on this variable?

I thought about that but there are no other files that use `environ'
so I opted for putting it here instead.

-- 
Benoit "tsuna" Sigoure
