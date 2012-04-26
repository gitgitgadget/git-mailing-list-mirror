From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: Git.pm
Date: Thu, 26 Apr 2012 14:58:37 -0400
Message-ID: <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 20:59:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTuB-0007sO-UW
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523Ab2DZS6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:58:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52674 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304Ab2DZS6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 14:58:37 -0400
Received: by iadi9 with SMTP id i9so1918752iad.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9LPQK7BH5mHgGawwCZ/zR2oo7aZWDwmFy6Hs3ZvkudE=;
        b=APzkhHkV83rJc3HSTKVZA5BKLCnDZOS8sujcH9u05rRkiX6gr6UNjN9er5tEjEWYY1
         3A1hwGdpvj91fD1e1b03l3V2k0qOZ0yIQZcv61eor0DWweRGHce4h1ngm3ZRpKUjXwkT
         NXhF1KpMmD50D6ioVmZ1Yo+zddM/QUY6BfnuEll/PjmHSTxxrwLh0QE9JhYRDEUzSweG
         ohzFNf4usPiYftzrBSg2tPtPUc/fgad4bKnHPMwaWpoUzxhqD7LctEJKabU+VHLDKbHT
         v74rpmbIslx/XaY7K0KrpO4uvDuc2JkSCeVKtkVKVlqagnq2Rs1LCw7e0vgMFMSXEIJ9
         96Dg==
Received: by 10.50.94.200 with SMTP id de8mr4140495igb.21.1335466717300; Thu,
 26 Apr 2012 11:58:37 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Thu, 26 Apr 2012 11:58:37 -0700 (PDT)
In-Reply-To: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196392>

On Thu, Apr 26, 2012 at 12:15 AM, Subho Banerjee <subs.zero@gmail.com> wrote:
>
> ---> I see in the code that it says that the API is experimental. Is
> there any absolute need for backward compatibility, or can I try to
> redesign the API somewhat extensively?

A quick grep of the code in 'master' shows Git.pm used in the following:

    - contrib/examples/git-remote.perl
    - git-add--interactive.perl
    - git-cvsexportcommit.perl
    - git-send-email.perl
    - git-svn.perl
    - t/perf/aggregate.perl

There is also work in progress on 'pu' that relies on Git.pm.

Breaking any of these scripts would be bad.  You may be able to
refactor them at the same time Git.pm is modified, but it would be
wise to contact the authors before making any major changes.
