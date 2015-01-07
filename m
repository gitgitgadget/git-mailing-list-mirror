From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Wed, 7 Jan 2015 16:57:22 -0500
Message-ID: <CAPig+cRLMZMoW7Oe8ViB=3R9iSxp88haR7CZ1SHaW0sCnhJ=0Q@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
	<CAPig+cSrht0fovEWhEknxPPzwZhA7vzeLcM+omaM7PR752GfGw@mail.gmail.com>
	<CAD_8n+RBJHDjFCEY8GmbsqyyyxPEo71Lg03M7y9dMcu74y6m-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:58:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8ybY-0005i2-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 22:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbbAGV5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 16:57:23 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:45334 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbbAGV5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 16:57:23 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so1062949yho.5
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2dIVOjfjK9xHgFq/FFIGHIPYvUmKxuwP94YmJAbz+wg=;
        b=yDJMd1tKcp8HFYjNf7o6yKa1gd9wgtF6P9m0l7hDkIu84ftOOyhhtooHapWkxByccv
         bgM0ET7cfcW/+Ox/vuPE1CIJlyl2HP7dJQgxXDsK2vB0K7PV7QkVwUKBB96i/JbHL28A
         wo9b+fI80yYSYRo6ilci3yYn8/hXaJihlzqzI5xp5pE1p1EjOXcEMN20bC7yKyvns05H
         tVcDJDVyDAracwBAYIruRhHVt4efvp7K/PUPicJY78DrSAROBD6UeJ2wrH1fxIH9YT65
         TQeefv7FOGGwjJBlhvBCvr83Btk8QNU2xnxGZS3+P3Rtw+qnI9QChimIILA2wmmqE4nE
         B9/Q==
X-Received: by 10.170.119.7 with SMTP id l7mr4098387ykb.51.1420667842366; Wed,
 07 Jan 2015 13:57:22 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 13:57:22 -0800 (PST)
In-Reply-To: <CAD_8n+RBJHDjFCEY8GmbsqyyyxPEo71Lg03M7y9dMcu74y6m-w@mail.gmail.com>
X-Google-Sender-Auth: Zr_1jB9ipO9tARmE4B805jhvgzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262163>

On Wed, Jan 7, 2015 at 4:33 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> On Wed, Jan 7, 2015 at 1:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>>> +# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exist
>>
>> It would be slightly more accurate to drop the ".tv_nsec" bit from this comment.
>
> The AC_CHECK_MEMBER is checking for st_mtimespec.tv_nsec.  If I drop
> tv_nsec from the comment should I also drop it in the check?

No. My observation was just about the comment.

> I thought it was better to be very explicit because the code using the
> check is using that .tv_nsec field...I figured the check may as well
> do exactly what the code is doing...

Indeed, the check and code should agree. However, from the perspective
of the person reading comment, the ".tv_nsec" is just an
implementation detail of the check itself. The final outcome (the
setting of USE_ST_TIMESPEC) is independent of how that check was made:
it matters only that 'stat.st_mtimespec' was detected _somehow_.

Anyhow, it's just a minor observation, hence my qualification of it as
"_slightly_ more accurate". If you feel strongly that it should remain
as is, then that's fine.
