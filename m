From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Tue, 21 Apr 2015 10:31:51 -0700
Message-ID: <CAGZ79kbev7OS_-xZAizSr0SSwdAZfn4U-3QRy7GprexJt=CzZw@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	<xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
	<xmqqa8y1iekw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:31:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykc1d-0004MK-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbbDURbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:31:53 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36553 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbDURbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:31:52 -0400
Received: by igblo3 with SMTP id lo3so92666880igb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ehJr2C5KYgpFUwLc9Z1qQ/wxKiWSFwEStd5VkqgmzU8=;
        b=HgJ4Ba1Evy+AeWMtm3GXFZtdchVVnO6hJRvNbaoJ/b6srMENL3sdZEGTXu7pySGg2y
         CQ0dj/koADkEG8ySboAJ2ORUD8bJCyNmCxy5+DhWguypehTuJPLkQAKbynQgFLAUQ3TD
         W824n/lxAjyzNuEWwEc7rGIyRezr0jz0y7xCp0/Fj/AjkpD4zV7pRged2f/9D6eUBes0
         FDyXCet5iCKLzppf2+n4rojvFcXbJxEMVjdRty8qaqa89km60vprBPAXGk5zNpnn6wn4
         UxKrlYZWT2552xiTz2HCdDfcmq1Wcv2zwkQ2BOhXwXXKZVNPwI8kRwcWdxHcmJCfReKZ
         dYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ehJr2C5KYgpFUwLc9Z1qQ/wxKiWSFwEStd5VkqgmzU8=;
        b=NE5za+JOOTkyRli3tA4Zp8okCjT3cptQ+zAg+tocl3wWKQDNsV4fTiCnnYI5FwJJ3s
         Q0Nv9f2XBXS/9FxMCGzSYV9Un4NjUXH2LTspXYIGjAMwoaniaLVYYaVVyZLetOaiDYaP
         YbdPivDbquZa7upspG8zxU9Xw/RvbkUPwg1Sh6+WuMPLCMnsax5RdSN4KJhc98VnWIME
         ++iDLCoCskWL/kKdaz7rEY8YzPN8S0gzGqg5rS4aD8kfNjtUtNqqAkbpbcvnHpqT3K9m
         KtRt/3ZGTVh/IR7E2hxMFey1z4DjPGs6uuRQCCqUq8VQgFeuGaRlQHpICXqRO36D6W6P
         Y9Zg==
X-Gm-Message-State: ALoCoQmtomeEt7DqIRGjzAVqrGJ4v0K+4NbAA+aUr8Bp1x0igjEyjSbs2YdL9KMiLPSnx7jo7miy
X-Received: by 10.107.170.135 with SMTP id g7mr31088046ioj.2.1429637511760;
 Tue, 21 Apr 2015 10:31:51 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 21 Apr 2015 10:31:51 -0700 (PDT)
In-Reply-To: <xmqqa8y1iekw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267539>

On Tue, Apr 21, 2015 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Apr 20, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> On the core management side, xmalloc() and friends retry upon
>>> failure, after attempting to free the resource.  I wonder if your
>>> codepath can do something similar to that, perhaps?
>>
>> But then we'd need to think about which fds can be 'garbage collected'.
>> The lock files certainly can be closed and reopened.
>
> ... and that is the natural thing to garbage collect, no?  After
> all, this approach allows lock-file subsystem to keep fds open even
> when they do not absolutely have to, so they are the best candidates
> to be shot down first when things gets tight.
>
> A good thing is that you have a list of all them already for use by
> the atexit handler ;-)

Yes, but when such a garbage collection is in place, it is part of the API,
which means you need to check all places, where lock files are used,
so that you have the pattern

   open lock file
   ...
   if lock_file->lk == -1
       lock_file_reopen(...)
   use(lock_file->lk)

I think that could be easily integrated into the lock_file API when the API
users don't directly read the values of the lock file struct, but rather call
a method
    int lock_file_get_fd(lock);

which guarantees to return a valid fd, but that is not long term stable. You
can use the fd for the next action, but it may become garbage collected again.

So then you don't know how long the fd is valid as the garbage collection
may be either triggered from the lock file code or by yourself?

There is some uncertainty on when which data is valid, which is why I dislike
this approach and rather prefer to make it explicit. If we run into such
a problem in another place, we can still think about a general solution in the
lock file API.
