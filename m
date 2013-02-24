From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Load testing of git
Date: Sun, 24 Feb 2013 12:31:14 -0800
Message-ID: <CAJo=hJvX5rmsuB4Jsbp7ZoqeyPtB_fwiZc=8VMWmF=HN0XKGLw@mail.gmail.com>
References: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
 <201302241758.18316.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yuri Mikhailov <yuri.mikhaylov@gmail.com>,
	git <git@vger.kernel.org>
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Sun Feb 24 21:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9iEq-0006Ee-KI
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 21:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757801Ab3BXUbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 15:31:36 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39887 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab3BXUbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 15:31:35 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so2417650ieb.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oNGM2QZiMuglr/P3vWzZBm7yUh7WBFRJH2DXeFgCxhs=;
        b=B4+AEMvOlQnhLHIPJsuafPrBCmAl6KeoklVQ37R1OPjaui4hFo9Kg9Tki7saAArFcw
         83ABmc+aJG54b7F7GEMepoZSDA5Dq6n6vL1QxJrBKP7VbC3KHpAnSzTlyZXZXrWLwkpT
         0NK0YciDM3f/htSZOQn8iZ8UIBDhhN6OPjAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=oNGM2QZiMuglr/P3vWzZBm7yUh7WBFRJH2DXeFgCxhs=;
        b=CBmTxVjnc+9T8WRTJTVCEuSTNz0WutbXU0tBuRDe4n9sv2US0Gl/fL5ITaXYCi5gxr
         vezGxXy92zHMzrMvhOcTEsxJZo6H7s8oMUqrdhWeZFrQOA2gZFQwM7NnsBrCL0u9Npd2
         PgUg7EzNIFardvLglu+uINGINkdvyjUAXKkIYfelRf/Awf4XNmowX48KcxFhuMnc+Dy3
         2EU4RkKihVntIvxnSEkwljscvTdEHfZgWvQrWQ5AoV8mTiU8fgZqoxL7Ei9oLvh9ra45
         q3LieZPWFJCKa+kcxWxEHytIJdaMQ4Tj0DFx118Q5BhnmvDh+TIOZ0ffh1nDZKVNZy67
         r8uw==
X-Received: by 10.50.195.134 with SMTP id ie6mr2412655igc.6.1361737895113;
 Sun, 24 Feb 2013 12:31:35 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Sun, 24 Feb 2013 12:31:14 -0800 (PST)
In-Reply-To: <201302241758.18316.thomas@koch.ro>
X-Gm-Message-State: ALoCoQlHqgnUGqHpg1NZn1QkwO7tVHqbbGhENMOmgmv/1Zw7gNTqNQZIXxCESC1n+tl7dIwluqQ1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217001>

On Sun, Feb 24, 2013 at 8:58 AM, Thomas Koch <thomas@koch.ro> wrote:
> Yuri Mikhailov:
>> Dear Git community,
>>
>> I am a Software Developer and I have been using git for a while.
>> Currently my company is looking for a version control system to use
>> and we find Git a good candidate for us. But what is important for us
>> to know is scalability of this VCS. Does anyone performed load testing
>> of Git? What is the practical maximum number of files and revisions
>> this system can handle?
>>
>> Best regards,
>> Iurii Mykhailov
>
> Have a look at the projects using Git[1]. There are for sure projects that
> exceeds the scalability you're thinking about. The linux Kernel might be the
> biggest project.

I highly doubt the Linux kernel is the biggest project.

IIRC WebKit has more objects, more files, etc. Its repository's
compressed form is >4G.

I know of at least some proprietary repositories with 96G in them. Not
much history, but a lot of binary blobs around 128M each doesn't
compress well. And bup wasn't used so we didn't get very good
compression over the files.
