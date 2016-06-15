From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2 3/6] wrapper: move is_empty_file() from builtin/am.c
Date: Thu, 16 Jun 2016 00:10:03 +0530
Message-ID: <CAFZEwPOkojqvivXpP7vq6WuMWPAjE1uXruoxsxH76LGT+1Eu4A@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-4-pranit.bauva@gmail.com>
 <CAPig+cTu1msxkjBZgLfy9g3+_VF5OzKNDbR0E0zVvopTNe2Q=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:40:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFja-0005iV-7r
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbcFOSkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:40:08 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35043 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcFOSkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:40:05 -0400
Received: by mail-yw0-f193.google.com with SMTP id v137so2736386ywa.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D0JJTdPDTv24Kg4RABZ9e57T6tavbou3xr9o4whcOxU=;
        b=hM1sP70cLUnByicA803jxasCzzUzh2GCOpg2tS+KliYJCmifBAFLkt9Yoc3iebFHdu
         KA5VaMWOj8+RBM+axE/XSiapPY5UOQ8V0vVHsw+8sWWA+G6PvKXYmFK5AG+86sZyVX7F
         MaH9vAFAJSipfTtrbRHcvyLJw7CENn8NkZvuQLQgXzRHLgheHiLnAnxB/P44QN+ow+LS
         RPeCpuH7lj4cptqootGU71z7gXeKrtBcVu4HaksnR8el1JZkhooo8COsUcmE9PcTJD9/
         8R+1liQmcwMjWTGkZwZ3moXNus4fomlr0aPQX24P/jQw8E5OAY8UsfpLz41zas8MeEOf
         0lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D0JJTdPDTv24Kg4RABZ9e57T6tavbou3xr9o4whcOxU=;
        b=RCAiDiPA5YdUv3wLs2W4LVoc8A3IsU9iJOfl2zMHwg8sc9bB4MLpbDhl2idC3D/ND0
         MAlIkwQfZE5JPVBQZDCa012/s9e4u2eK514wuxTqrfHYlPf9ehLh1xPda1cLJJbObe4I
         iCHj9hXD5yje7ER33e9bK/kt2o1i9E9QoyWspszupyMpOpxTfknJm8SdhNkEDYexsdd3
         Atw7dtrUmabnEBqmohlpFW+2YF1nYdzskbuWraxClebIw+eAzya6662lC+UwETzsyR5F
         e13vPGFCyvEZ6Ql2eANbnM/WTyX3oUU9EQof4yxnzKcUjFAYDG0KptRac2vmWalNWDSx
         W6kg==
X-Gm-Message-State: ALyK8tKDUnzNwdKpIhCnvZwpRx3DOSf0MQBSek49+OFr9Ve602RxwRNfG/KE/NZv97SadxI+fV9J+1STq/Ai0Q==
X-Received: by 10.13.254.130 with SMTP id o124mr126737ywf.30.1466016004257;
 Wed, 15 Jun 2016 11:40:04 -0700 (PDT)
Received: by 10.129.116.193 with HTTP; Wed, 15 Jun 2016 11:40:03 -0700 (PDT)
In-Reply-To: <CAPig+cTu1msxkjBZgLfy9g3+_VF5OzKNDbR0E0zVvopTNe2Q=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297389>

Hey Eric,

On Wed, Jun 15, 2016 at 11:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> is_empty_file() can help to refactor a lot of code. Also it is quite
>> helpful while converting shell scripts which use `test -s`. Since
>
> As justification, "can help to refactor a lot of code" is very
> nebulous. It would be better to give a concrete reason for moving the
> function, such as explaining that the functionality will be needed by
> the "git bisect" port to C.

Sure I can include that.

>> is_empty_file() is now a "library" function, its inappropriate to die() so
>> instead error_errno() is used to convey the message to stderr while the
>> appropriate boolean value is returned.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/am.c b/builtin/am.c
>> @@ -30,22 +30,6 @@
>>  /**
>> - * Returns 1 if the file is empty or does not exist, 0 otherwise.
>> - */
>> -static int is_empty_file(const char *filename)
>> -{
>> -       struct stat st;
>> -
>> -       if (stat(filename, &st) < 0) {
>> -               if (errno == ENOENT)
>> -                       return 1;
>> -               die_errno(_("could not stat %s"), filename);
>> -       }
>> -
>> -       return !st.st_size;
>> -}
>
> So, the original function die()'d for unexpected errors, but the
> rewrite does not. This is a big behavior change. To account for such a
> change in behavior I'd expect to see git-am updated to die() on its
> own for such failures, but no such changes are present in this patch.
> More about this below...
>
>> diff --git a/wrapper.c b/wrapper.c
>> @@ -696,3 +696,16 @@ void sleep_millisec(int millisec)
>> +int is_empty_file(const char *filename)
>> +{
>> +       struct stat st;
>> +
>> +       if (stat(filename, &st) < 0) {
>> +               if (errno == ENOENT)
>> +                       return 1;
>> +               error_errno(_("could not stat %s"), filename);
>
> Mental note: There is no 'return' in front of error_errno(), so the
> function does not exit here...

This is purposely as I want to keep this function to return only
boolean values ( 0 or 1).

>> +       }
>> +
>> +       return !st.st_size;
>> +}
>
> If stat() returns some error other than ENOENT, then the value of 'st'
> will be undefined, yet this return statement accesses its 'st_size'
> field, which is clearly a bad thing to do.
>
> You either need to return a designated value (such as -1) upon errors
> other than ENOENT (and update the documentation to mention -1) so that
> the caller can decided what to do, or die() as the original did. While
> it's true that die()'ing is not necessarily friendly in library code,
> it may be acceptable until such time that you find a caller which
> needs different behavior.

I didn't realize the complexity the patch carried with itself before.
I probably shouldn't fidget with am code right now, its a work better
left to who are converting the code to library code. I think its the
best fit for this situation to leave it as die()'ing.

Regards,
Pranit Bauva
