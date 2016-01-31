From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 09:05:39 -0600
Message-ID: <CAEtYS8Qt1ewf3nAAiP_2ey5mV=9e3_To1fcaeV6f3+05uwHxgg@mail.gmail.com>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
	<56AE1F40.8060509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Aaron Gray <aaronngray.lists@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 16:06:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPtZt-0004Ta-Q8
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 16:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbcAaPFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 10:05:41 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34265 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218AbcAaPFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 10:05:40 -0500
Received: by mail-qg0-f52.google.com with SMTP id 6so100217464qgy.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pPEsN8JCDxys626CG3EPOh07Z4P9zDFGXRRnUgPpZws=;
        b=c/AkCXujtQP/EEyUn2SvMtLK3qJ4doN58lBG//b5M68EGMMCF1NOWjXH6JhuISkjGY
         bxHSWYYXKlec3lFZEDGKgrSCYb0qv+mbMfAEwqqlPtiP8I7MhHLr4q90WONA/yzZ+s7O
         BYkUBkK/6W2mnRnTUJR4fVh8aJjKqrhDKuWMWP/I7YiaDqsw+w0WMiZw7SMH+X2IuMjD
         UX8SVPjzLIAspDZLSIy/1CB/qw0ois/aO2TTprK1KnbONET2RJZzCu1Q8jM89WqEiRCz
         LBh8N+il73qR9IkDt1tbLsJU0hDYHkxIyxgM7rOqqH+iOREE8F4zjt8DLMLliqZI7XFy
         dTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pPEsN8JCDxys626CG3EPOh07Z4P9zDFGXRRnUgPpZws=;
        b=GxU27IjY3HLLWEaV0K5yyct6USo4yhzB5GD+B8B2YvtPh97C8XCxuSouUeYWju/TMW
         efPhVEuQ5kNrtmnz3MvrkCQS+tFmRBQ9R9cdT/Pczj0Tss14jjoSWWrlzIEI0D8gNpVd
         AIeXTL67Qouv4Be0Z5+jkJO9X3fnqWWCWjEXB/Mw5rFRZr8AzWMQ0pdLwYEoubRKIfxP
         GvCvsSH2Z7TmDtGG0a4A9AaGP4jK7r0U3iKiKNtf79zgdCPCi5yOYr/b8EySMW0Daflh
         cnaGmgpmCxHb33zperfseRpzXge7+oBgGUE0wGnY5HhgTmYZkjxxdDM+HNUfvvT5ELwx
         TZ+w==
X-Gm-Message-State: AG10YOSFRP3jA4jUvn3PcLgbLxNz+r5z4H3T61552gS1t6XzLG62C6Gc9ANFRmdlMKP/9Z/hz+92wc4HwfjoFg==
X-Received: by 10.140.31.197 with SMTP id f63mr22953013qgf.12.1454252739875;
 Sun, 31 Jan 2016 07:05:39 -0800 (PST)
Received: by 10.55.15.161 with HTTP; Sun, 31 Jan 2016 07:05:39 -0800 (PST)
In-Reply-To: <56AE1F40.8060509@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285150>

On Sun, Jan 31, 2016 at 8:50 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 31.01.2016 um 15:03 schrieb Aaron Gray:
>>
>> Hi,
>>
>> I think I have found a possible difference in behaviour between
>> Windows git commandline distro and Linux git
>>
>> basically If I do a :-
>>
>>      git mv logger.h Logger.h
>>
>> I get the following :-
>>
>>      fatal: destination exists, source=lib/logger.h,
>> destination=lib/Logger.h
>>
>> It looks and smells like a bug to me !
>
>
> Not really. When you attempt to overwrite an existing file with 'git mv',
> you get this error message on both Windows and Linux.
>
> The difference is that logger.h and Logger.h are the same file on Windows,
> but they are not on Linux. Hence, when you attempt to overwrite Logger.h on
> Windows, you see the error because it exists already (as logger.h).
>
> As a work-around, you can use -f.
>
> -- Hannes

Indeed.  And just to clarify, you'll get the same issue on OS X, where
the filesystem is also case-preserving, not case-sensitive (by
default, at least).  I've never tried using -f for this, but I'll
usually use git mv twice to achieve the same result.  Annoying, but
that way my local directory looks correct, too.
