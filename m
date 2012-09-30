From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Sun, 30 Sep 2012 10:45:30 +0700
Message-ID: <CACsJy8DC=rpuFQbKG9MUh3Aknf6zxJJpww+XoCYki5tu3SDF4w@mail.gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org> <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com> <20120929053013.GB3330@sigill.intra.peff.net>
 <7vpq55idbe.fsf@alter.siamese.dyndns.org> <CACsJy8A1UroqCezJFjqOqBQg+puX=jc1Q-CMSB4f=CHULY=OyA@mail.gmail.com>
 <7vbogoiqzs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 05:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIAUd-0001WB-W4
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 05:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab2I3DqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 23:46:04 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55976 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab2I3DqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 23:46:02 -0400
Received: by ieak13 with SMTP id k13so10046150iea.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Nwp6qvaFYvG4wB24XhKKSKakOlPWX8RMk/HZROf45io=;
        b=jD6aizQzHZmAgv886s67AQjAtdvZUJvtlRVo7Nw9fP53zxsOEi9yxpqPY4kZtFDjdi
         vx1PQL4nYSZpVd/H4Z/5CPlGdMdSXX6Lx1iqYA/CvR6+wTpU+IOOO9OLXhdPVX+yK1MH
         s2THtQBBhCaa7T52OYMVrwuQxJiCshzBeRefOTXYJtqNN8j+t436ezs048BVXIl0KjSS
         Ls0IM1o7bpNz54A+OWrDd6zJRyLhKnJC6I2RTAEf+NO4Xm3AdOLh0V0VP1rMAvRtbx4T
         sAWuQ7wrVaB5Wc+SzMIosQz/5RvuR3uoJpVLCX/iTJy9zJBxdo5zjoYR2FljQ90W9KnM
         rFVA==
Received: by 10.50.207.33 with SMTP id lt1mr2504124igc.40.1348976762254; Sat,
 29 Sep 2012 20:46:02 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sat, 29 Sep 2012 20:45:30 -0700 (PDT)
In-Reply-To: <7vbogoiqzs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206663>

On Sun, Sep 30, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> How about squashing this in?  I've future-proofed commit_match() a
> bit while at it; it would be cleaner to add new fake headers if the
> function is done this way.

Sure. It looks good to me.

> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -56,8 +56,8 @@ endif::git-rev-list[]
>         Limit the commits output to ones with reflog entries that
>         match the specified pattern (regular expression). With
>         more than one `--grep-reflog`, commits whose reflog message
> -       matches any of the given patterns are chosen. Ignored unless
> -       `--walk-reflogs` is given.
> +       matches any of the given patterns are chosen.  It is an
> +       error to use this option unless `--walk-reflogs` is in use.

We could even drop the part about --walk-reflogs. Users will soon
figure it out when they try it.
-- 
Duy
