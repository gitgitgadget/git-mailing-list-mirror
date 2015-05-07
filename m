From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 09/12] t7406: use "git pull" instead of "git pull --rebase"
Date: Fri, 8 May 2015 02:17:48 +0800
Message-ID: <CACRoPnQ3zYsv63pNUtasS6y2HnWMYqwssF=yFA3OHVvF2Yb5Sw@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-10-git-send-email-pyokagan@gmail.com>
	<xmqqfv78qp13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:17:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQMs-0000mz-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbbEGSRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:17:50 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36186 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbEGSRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:17:49 -0400
Received: by lbbqq2 with SMTP id qq2so37140315lbb.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GEUmDltcc3fyVDE6we3ss4wC+nqoxFJjwxBqpXErFhA=;
        b=CGhErrEoTRxgdHPvlRug5/gBB010/+9uO/rmKfjIxuxfyEVugvK1dyscgEqCxb9Jzt
         OkjZctFyYC2Z+RPyKNnBoVpPKiw9Lszoyoxg6Bhb73xa9BBbEDMLRCoMhUIY5Yx2dP0K
         Ji7f9KIsdse+j5qF+UMdIvKhezogeNptbikf95v7wztJM4NMDxQtW9397sGLrWgfyOB4
         1LxuofyPCUwrzMxT/fa6aWZ086Bu3BCGK1TYlK24I/hMaKn+7ObQRr17IjauoP3iX/AA
         kkBKET3HuKg+8tllrjFhJh6JUDhXx3TAFIAsIrmOxX1ACOsSEdwXmx4CH3L8YSAgLRqh
         lbGw==
X-Received: by 10.152.6.105 with SMTP id z9mr3969212laz.98.1431022668253; Thu,
 07 May 2015 11:17:48 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 11:17:48 -0700 (PDT)
In-Reply-To: <xmqqfv78qp13.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268567>

Hi,

On Fri, May 8, 2015 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
> If 'git pull' gets broken, it will break this test _anyway_.

You have a point, perhaps this should be changed to git-fetch + git-merge?

Well my reasoning is that it's because git-pull --rebase requires more
code to be implemented than git-pull. So I'm thinking that git-pull
--rebase is more likely to break than git-pull.

> Unless
> the operating assumption is "it is OK to break 'git pull --rebase',
> as long as we do not break 'git pull', while rewriting it", I am not
> sure the value of the change in this patch.  We'd need to keep both
> form working, no?

Yes, ultimately the git-pull rewrite must re-implement everything, but
if this test suite is affected by any git-pull (--rebase) breakage,
then there will be lots of patch noise as this test suite's tests get
disabled/re-enabled in the git-pull rewrite patches.

But if the patch noise is okay, then I'm fine with dropping this patch
and 07/12.

Thanks,
Paul
