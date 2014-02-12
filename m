From: Stefan Zager <szager@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 11:02:37 -0800
Message-ID: <CAHOQ7J_pg6Nqc5TdU9OA81=d+ZG_JpLFQ5-eFLY3uW8CuAQrUQ@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	<87y51g88sc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDf51-0005d5-D6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbaBLTCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:02:39 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:43189 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaBLTCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:02:38 -0500
Received: by mail-vc0-f176.google.com with SMTP id la4so7375824vcb.35
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RmXfg5XCZ4mQGVxoAn/AGxVT5HmYqm9x/z9QScQ9XVg=;
        b=OJJh8sN789gv+nFHMIi4SAQd07HEagUFLzKbrqK3kosJnnuP4XVfdF+G79RgUhT4Kx
         fkkk1B8HVwIyrZbus6So0HW2uMGNBUwsGJTqeE57fBDE6ktJ2JcgyqKISbFhgryYsJhu
         gX+0k8xWcpzVWB77GRnMaG3mx0I/Awy1woGzEQ4hCSLMoEQCbqOY1IBW+EwC7hOWXenh
         gZpr+T6VsY6CrZFaq8LtWPsA7g2I1vPOHIQb7+sbHNgZua+gS+mILk2nfWHKOSexA99o
         Z7ITYQ9De/yIyy2wNjOKcZPIbBMddwBcpZQP5ZSzL18aC545Xj8pCOENLRAghVkJy8UC
         Z6cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RmXfg5XCZ4mQGVxoAn/AGxVT5HmYqm9x/z9QScQ9XVg=;
        b=UvWTj3wN9QyE+jerocJsPq0gbX9GSwQC+z1WwjjU0P/NkgdZtWcfCcVjvgg12lwnuo
         ogHdNoTA40Ru4wtme7BI/yqnc9JJRkObv/Jk5/sM3vPF460GY/e6pdN9KMPedYqQF8nm
         X22zLv8xhTDXhtkUpIvA3XN9Ku4benmxqCWfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RmXfg5XCZ4mQGVxoAn/AGxVT5HmYqm9x/z9QScQ9XVg=;
        b=isF82NnSobObUCrE2OoRouMs8EYWwxNuEzyg/mgcOxruyQjO/Saz5R3qUyOuyAEr9G
         Ufw2fEIjEcJplnyaKiXoRxmpXbeqIseCktsPhk9sA91lTMJ2ZsxFMBkdbZ5tUUiBJ0Um
         yt45ujlx4F2pcNPuHPZlmiRsJjst4i7D3eHEegO0hPqWn/YIJG0iFbihTXB1aHDMTQrC
         7vtXWncyaqJxREGVJMQSi/Op1auWks5WkoB+drj7GOxUzefc20guWFGEuaamrVdkO3wk
         CEMOu/uBcPZ5Q6f9afOkwT+qfsnLXr298AxgadAobinSF214eIB7uY/SigR0Cp5kTb2+
         /Dcg==
X-Gm-Message-State: ALoCoQnvVKmlAXOfIjEL++tt1faMp7iOgoTwMzH6TLIX+MlIYldsfMgVRdAFprV5J6syVStGPsR5HhHd5uf1fnsM4wBSCUwrFvJBTdoYnrdCYoDnJBbqqiz9vuD8V5zNbuTIZhpT/91IzfMWJmBrDlglW5TEM0r+3d6nompwdq9xyjbcm7/aYqrK0eCd1GE8bm7G4HiPBjqC
X-Received: by 10.52.247.231 with SMTP id yh7mr1717938vdc.34.1392231757562;
 Wed, 12 Feb 2014 11:02:37 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 11:02:37 -0800 (PST)
In-Reply-To: <87y51g88sc.fsf@fencepost.gnu.org>
X-Google-Sender-Auth: GHCzdrSAiK0WGRtd6F03bRUgqHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242012>

On Wed, Feb 12, 2014 at 10:50 AM, David Kastrup <dak@gnu.org> wrote:
> Stefan Zager <szager@chromium.org> writes:
>
>> Anything on Windows that touches a lot of files is miserable due to
>> the usual file system slowness on Windows, and luafv.sys (the UAC file
>> virtualization driver) seems to make it much worse.
>
> There is an obvious solution here...  Dedicated hardware is not that
> expensive.  Virtualization will always have a price.

Not sure I follow you.  We need to support people developing,
building, and testing on natively Windows machines.  And we need to
support users with reasonable hardware, including spinning disks.  If
we were only interested in optimizing for Google employees, each of
whom has one or more small nuclear reactors under their desk, this
would be easy.

>> Blame is something that chromium and blink developers use heavily, and
>> it is not unusual for a blame invocation on the blink repository to
>> run for 30 seconds.  It seems like it should be possible to
>> parallelize blame, but it requires pack file operations to be
>> thread-safe.
>
> Really, give the above patch a try.  I am taking longer to finish it
> than anticipated (with a lot due to procrastination but that is,
> unfortunately, a large part of my workflow), and it's cutting into my
> "paychecks" (voluntary donations which to a good degree depend on timely
> and nontrivial progress reports for my freely available work on GNU
> LilyPond).

I will give that a try.  How much of a performance improvement have you clocked?

> Note that it looks like the majority of the remaining time on GNU/Linux
> tends to be spent in system time: I/O time, memory management.  And I
> have an SSD drive.  When using packed repositories of considerable size,
> decompression comes into play as well.  I don't think that you can hope
> to get noticeably higher I/O throughput by multithreading, so really,
> really, really consider dedicated hardware running on a native Linux
> file system.

I have a background in hardware, and I have much more faith in modern
disk schedulers :)

Stefan
