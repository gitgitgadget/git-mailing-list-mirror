From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Tue, 30 Oct 2012 14:11:42 -0500
Message-ID: <CAEUsAPZE8O0rbMwbc+XxaFC+eB00HAK_d1fBSFnhxzZtGS+WVQ@mail.gmail.com>
References: <508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
	<CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
	<508E532F.2010109@alum.mit.edu>
	<20121029103837.GA14614@sigill.intra.peff.net>
	<CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
	<20121029113500.GA15597@sigill.intra.peff.net>
	<20121029172330.GC8359@camk.edu.pl>
	<20121029213508.GB20513@sigill.intra.peff.net>
	<CAEUsAPZhXpZx+d3+2XUyyYQnM5NFB691FLcasnK5k6fS9efQFQ@mail.gmail.com>
	<CAB9Jk9CC9wjeyggejkVjKgY2HGAFw70hJo-S0S-W-p4gnd2zug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:11:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTHED-0000jO-51
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934221Ab2J3TLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:11:44 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61208 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab2J3TLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:11:43 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so482362lag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aKtzQ5aP4Sow/htNlR9QeK5g7XgO0pWGmUsE4BLmX/U=;
        b=doyFPIOTb3YHLhCzTwTqXdb/eFBvxgvKPfvGzUQMDX7RMhLLo9YH/ixaUeoqZxaKc0
         xVXVgMo7oBNc38aUkcYivObNWiAWD5pRuS6uLuMmx2TBi1UU2nAmXnWFHfctHCTrFKnl
         H7HZl1uAc4HFdQGZIoSw82Fv26ZR4dgVF4I0tHSEp3pI8KwFGf59qe5xMBqfk3zakMZB
         R9rW3MBJc8D4z74k8POxwRu8ggkCwngZvGQ2j9fXqxbviCUISAl3LUYc2QQUHmFSMqeZ
         FY7Mb2A974kViQX8ofZ7hQVlq16y7L/0hoj0VwgDh/hWOaVJ1QX41a/2CCmozl5VLPp3
         mc4w==
Received: by 10.112.14.107 with SMTP id o11mr13609456lbc.98.1351624302192;
 Tue, 30 Oct 2012 12:11:42 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Tue, 30 Oct 2012 12:11:42 -0700 (PDT)
In-Reply-To: <CAB9Jk9CC9wjeyggejkVjKgY2HGAFw70hJo-S0S-W-p4gnd2zug@mail.gmail.com>
X-Google-Sender-Auth: zgG-toPW58HJoIih0rn71PvWGNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208731>

On Tue, Oct 30, 2012 at 1:34 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Cris,
>
> I think a key in the config file of the remote repo is better than an
> option on git-push for what concerns security: it allows the owner of
> the remote repo to enforce the policy not to overwrite tags, which
> would not be possible if any user that has push access can --force
> tags.
>
> -Angelo

Hi Angelo,

Security is orthogonal to what this patch is attempting to resolve.
As Kacper pointed out, you can never be sure you're not going to
clobber an existing tag in the remote repo.  This patch attempts to
give git-push better (i.e., less surprising) semantics for tags.  In
other words, it's should will prevent mistakes, not provide any sort
of security.

So I don't think a config option is better or worse, it's just trying
to solve a different problem.

Thanks,

Chris
