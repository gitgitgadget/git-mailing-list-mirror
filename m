From: John Szakmeister <john@szakmeister.net>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 05:38:08 -0400
Message-ID: <CAEBDL5VWuvuJCptY=J5ZyjpLkkP-+V+xY+Eugtkb7M0NL=Px4A@mail.gmail.com>
References: <7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
	<7v8v35cnp0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
	<7vzjvlb7mu.fsf@alter.siamese.dyndns.org>
	<CAMP44s1D06ggmTjXBEL0puFLqYDShhy6HV0S+oj0AwDGz-sUqA@mail.gmail.com>
	<20130524082900.GZ27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 24 11:38:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfoS2-0002wc-O9
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 11:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760201Ab3EXJiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 05:38:13 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37763 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760000Ab3EXJiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 05:38:09 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so5075984wib.8
        for <git@vger.kernel.org>; Fri, 24 May 2013 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=S9jo74iR2LzY62yy2+RaKwZta/FJXkH8VxmiyZbtIfc=;
        b=gZTd6xDi9w5A8JJn7+xyuQG+Ejt9P3nMZYcQFDruVLggprcb7x0wAQVU56TxKvtBrl
         k+tzoIhr55T1h6ZEQw2EeQn5g8c0Yp5RPFJPnbOMh3DGk4i9Rrmlr+jcHYg16zQQ9FMD
         9iniJD3hjrr0HFgsE1o3K9ozi3fMDMBbeixr5oNZyYIgKYNmrLwXuTc4+R4+sJDmybg8
         kgkXIcYTT8Kc7xgnnfEu6YzPFDfqRj9ifMP9OwLb/YEq2fL5+HQMCzwYFGCYPxOZ+JIt
         UHjibJ5auMHuwe4aI5V4ztGEjVRrW2GQf5q0Eid4GXsVKCchaFDhXnwH3nkLFhQrxWlv
         fQOg==
X-Received: by 10.181.13.42 with SMTP id ev10mr50404909wid.1.1369388288547;
 Fri, 24 May 2013 02:38:08 -0700 (PDT)
Received: by 10.180.5.33 with HTTP; Fri, 24 May 2013 02:38:08 -0700 (PDT)
In-Reply-To: <20130524082900.GZ27005@serenity.lan>
X-Google-Sender-Auth: hHS_4WEV-TEYwI9Sq4EH_d7jSR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225337>

On Fri, May 24, 2013 at 4:29 AM, John Keeping <john@keeping.me.uk> wrote:
[snip]
> Note that in my email that started this, I tried to be clear that I was
> talking about "git pull" *without a branch name*.  If this user
> explicitly says "git pull remote branch" then I consider that a clear
> indication that they really do mean to perform a merge; I would not
> recommend changing the current behaviour in that case.
>
> If the user just says "git pull" then it is more likely that they are
> just trying to synchronise with the upstream branch, in which case they
> probably don't actually want a merge.

This makes a lot of sense to me.  I was going to write earlier that I
almost wish there was a separate command for getting your local branch
"in sync" with the remote one.

BTW, it also doesn't help that `git pull` is suggested as the answer
anytime a push cannot succeed.  I've warned my users about using `git
pull`, and--unfortunately--they sometimes forget because the advice is
right there in front of them.

I agree with John here: it's a bare `git pull` that is often the
culprit.  Of course, the asymmetry between `git pull` and `git pull
remote branch` is a little bothersome too, but the team does that
*far* less often.

-John
