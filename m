From: Stefan Beller <sbeller@google.com>
Subject: Re: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 10:10:12 -0800
Message-ID: <CAGZ79kaBhO4Qg28VP39inaVsaEbVU_Dy-_6Dy29WCgCJpVq1fw@mail.gmail.com>
References: <20151204150546.GA17210@inner.h.apk.li>
	<CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
	<20151204172851.GQ18913@serenity.lan>
	<CANgJU+W2NWX4eK8M7GXu7+kmKsyEriau=_WXO8EEQZinCFTtRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4uoJ-0006xg-0G
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 19:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbbLDSKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 13:10:16 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35009 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbLDSKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 13:10:13 -0500
Received: by ykba77 with SMTP id a77so133052169ykb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 10:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5aqJHmhPzF97FFF0ZtdH/pq25PJ3jeU9HDxp+eEvY00=;
        b=Ns1wkTGoFWRKh0qFylGCX5eB8ddxU/RyrGY1XqHk+2G6QUYot1f4b7SE/49Z3Z8Ld7
         E+SYHFHgZMPwCDfFJVp883NVCBUv19b+fauL2/hMFtBjgVUxCCGMpRQiKzClk9QHN4Oz
         4qdbTs+4GdV0c2vln5wYXZBDTBpyL7dCf87vKwhUSyPskNdLlWuAbyHg1UQ87o9FuRKY
         WvETW6k4WqgCR0i5cxvM+eJfqjJACikqF7IlVtp8Y/VRBaBe/kUSMp3lWq3kvhWsdz2U
         x+XZKdIdgZ30f652LX6HMRLhiaHumDsVyvzuU+26VvkmmCwOwxcAsIS8UmW5LC8hjVNc
         DIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5aqJHmhPzF97FFF0ZtdH/pq25PJ3jeU9HDxp+eEvY00=;
        b=B8lBJutpCWGvJDdira73yQOjUpSQGpzyJJTdngkCqNkogWFp5uMlk0ISkUNGknuzE6
         y+8g+lADW/CgShLwJn4kU6xwu0zNGMVYQtznp5NyI741yWdsSCH6BNj+DesEEHXLzgAk
         TzZMCEQMjTNRDtoGHnh5KPbkFi+u+oKexlFf2n78fUSjgaej3wuNx4fqq5aItfIse/6L
         b38tGCKE00Qo23woC3Gg5kT7gABpsClHDjVJacpL4NdrldUAS8t852d0TP07rjlIHWsf
         /1dhs9y0jfCXQWHGymDQUXsSDGSBuQSOTY+uLlvMBI+X99QsW+BDuM/qvDGh7j0awtMb
         xP0Q==
X-Gm-Message-State: ALoCoQlUfZOvFywecoA1t/qwe2tLvvEwdbHEOYUTvhRFmazIWM6wUOzxTsegoPXtAugOVtHTO/ci
X-Received: by 10.13.214.19 with SMTP id y19mr12403200ywd.63.1449252612967;
 Fri, 04 Dec 2015 10:10:12 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Fri, 4 Dec 2015 10:10:12 -0800 (PST)
In-Reply-To: <CANgJU+W2NWX4eK8M7GXu7+kmKsyEriau=_WXO8EEQZinCFTtRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281992>

On Fri, Dec 4, 2015 at 9:33 AM, demerphq <demerphq@gmail.com> wrote:
> In all fairness however, I do believe that some of the recent changes
> to git helped, but I dont how much or which. What I do know is we
> still have the cron sweeper process cleaning refs. (It broke one of my
> repos that I set up with --reference just the other day).
>
> Yves

git-am was rewritten in C, which is used to apply patches.
This also speeds up rebase.
