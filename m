From: John Szakmeister <john@szakmeister.net>
Subject: Re: consistency problem on ZFS
Date: Sun, 28 Apr 2013 16:12:23 -0400
Message-ID: <CAEBDL5W8E_i3V1ePWkf0Ep2iTjY59abqU7Q2w4o0iA8=P_4Onw@mail.gmail.com>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Yann Hodique <yann.hodique@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 22:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXxW-0005Eo-Ey
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 22:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab3D1UMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 16:12:25 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:56444 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab3D1UMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 16:12:24 -0400
Received: by mail-we0-f170.google.com with SMTP id z53so745783wey.15
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RdD7TIr1bMPy8WfFAS+FpJ+WHnyVokfuXJ7FNwe+G/4=;
        b=ca7Nbr4sEYWvRKvQyqItPjdNUTJP8GLfB+CtFCtWDFry5GxtwloYLnvlk4PRt/5kpT
         v8Z2NvnSGOeveNRwd5lq88qMtTZaMAOmTLzBzXEqMKeTAery0hKUALGVQoccOYkCtFXv
         7nCZSbcoAX3LzVq/dZI/QHg+wF1+WWo0eO94Q3GSNPXscfDL6PsycpezepWPGaEHtPc/
         blFlwuuHJ/ByRmmZIagdqljehAnY6fg1qz+8oG4D2YM2hx03dkpyvWl83iJHcq/yQYFi
         vtTm1MxUUTZOW/W5Mm0quqf4t5Fc1UShrbbko/+ffuv7+vXcGKHQMygwdrfb/na8bFT8
         a8bg==
X-Received: by 10.194.222.100 with SMTP id ql4mr48341034wjc.59.1367179943556;
 Sun, 28 Apr 2013 13:12:23 -0700 (PDT)
Received: by 10.180.187.240 with HTTP; Sun, 28 Apr 2013 13:12:23 -0700 (PDT)
In-Reply-To: <m2bo8yxyg2.fsf@jarvis.hodique.info>
X-Google-Sender-Auth: nZE6oEnpc1yEG-82JRbnVGOi3KQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222751>

On Sun, Apr 28, 2013 at 3:11 PM, Yann Hodique <yann.hodique@gmail.com> wrote:
> Hi,
>
> I have a weird problem that seems to manifest itself only on ZFS
> (actually the Zevo distribution, on OSX). With git 1.8.2.1 by the way.
> I just switched to ZFS, so I can't blame that particular version of git.
>
> "Sometimes" (I'd say something like 10-15% of the time, fairly
> reproducible anyway), "git diff-files" will see changes that don't exist
> for some time, then will catch up with the actual state of the file:
>
> $ git checkout next; git diff-files; git checkout next; git diff-files
> Already on 'next'
> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M      magit.el
> Already on 'next'
> $

Since you're running with Mac OS X, can I ask what version?  Have you
seen this with the regular file system (HFS) at all?  It might be that
you need to disable core.trustctime.

-John

PS  Sorry for the repeat Yann... I forgot to CC the list.
