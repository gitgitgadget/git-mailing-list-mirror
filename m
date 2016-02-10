From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 16:33:11 +0100
Message-ID: <CAHGBnuMMN_xEVDJ_dqWgL6QCGK08hy=ggg=6PzkSCinHr=QeFg@mail.gmail.com>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
	<20160210125429.GA8078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 16:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTWlb-0003lf-BK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 16:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbcBJPdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 10:33:13 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32904 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcBJPdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 10:33:12 -0500
Received: by mail-vk0-f65.google.com with SMTP id c3so1230026vkb.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Exwc7cFYfutpwIsHzzkLxKUKfGBovvsgJSTKwrqwEog=;
        b=duFoHfEGOneSs+IBZJshf5U9ipsEldys4rMG3/pGJvYuyLOZEHRrll1nOUhsk7YJmR
         9YFDrRdFz9aWHP9Juz9FJZnPGXHXIEhsyUxFMzAVQubuWq3J5zdzdMjfk25Iciy+cwWM
         knnhXnCnnkgcb9+rzlXWrh23hs9cJ2w7pQnPwlPSnRJ47HAq9yTkE1fecoTj9mUq98es
         7IdskxB5KQOeVe8Uv20nm/MZE0LuDQwjD6ESACjD09jQacskEu5srfXJXhPRwVh44O/p
         abK0aTjLH1kVW9RRlv8HXqoEKLeY9DvyoJAfpZHeeObA7R6AzZ5yMTlhT3DGw/E9KxXs
         bC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Exwc7cFYfutpwIsHzzkLxKUKfGBovvsgJSTKwrqwEog=;
        b=gQqvUPwuLkfV6BB5JRh/r99YpaZuN8Q8BKR/805wGTfa2JCjgtI/+hVpWEmRKy2EKe
         U35yhZ8yY0DTZHS6dCxdrGqegNsZZzwfWqSOV/nCFXlhxFroToWj6AEWwbLvh1u2WAjs
         9PSXZfUxEFaVS3+3ALrJrWzJEzxcN0lrQnUPKfdN9pafwQSdM9Xp3QOJh0RvzP1RcMEO
         bk34w9misitJerx8lPBwtNWuXm+Rhve2hvF91cnzmgJa1Oemu7utwzmq+2B8OlWAmgDC
         N4FuzFIcdjvZDi+oOhI5SBjMX29sr2a0UG54y4+MZUyVy0NCAWK2/MGvqW4W8nbbeTmh
         9o8w==
X-Gm-Message-State: AG10YOSYi5vzvGcqB6T9uNdVxwaoteEz+aOoBqHNwHwR99ymS0IMiWe/MT3BPSuOWnW+QLV4b5yE17MrFtXBsg==
X-Received: by 10.31.56.13 with SMTP id f13mr28506949vka.20.1455118391983;
 Wed, 10 Feb 2016 07:33:11 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Wed, 10 Feb 2016 07:33:11 -0800 (PST)
In-Reply-To: <20160210125429.GA8078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285903>

On Wed, Feb 10, 2016 at 1:54 PM, Jeff King <peff@peff.net> wrote:

>> +--sources::
>> +     Augment the output of all queried config options with the
>> +     source type (file, stdin, blob, cmd) and the actual source
>> +     (config file path, ref, or blob id if applicable).
>
> I think something like "cmdline" might be more descriptive than "cmd".

I agree "cmdline" is better than "cmd".

> So the format here is like:
>
>   file\t<filename>\t<value...>
>   blob\t<blob>\t<value...>
>   stdin\t\t<value...>
>   cmd\t\t<value...>
>
> where two of the prefixes have nothing in the second slot. I expected
> something more like:
>
>   file:<filename>\t</value...>
>   blob:<blob>\t<value...>
>   stdin\t<value...>
>   cmd\t<value...>
>
> with a single delimited slot for the source, which can then be broken
> down further if desired.  I can't think of any reason to prefer one over
> the other rather than personal preference, though. They can both be
> parsed unambiguously.

I also would have expected sopme like the latter, except that I'd also
expect a colon after "stdin" and "cmd" (or "cmdline", as said above).
I.e. the colon should be part of the prefix to mark it as such.

-- 
Sebastian Schuberth
