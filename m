From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Tue, 6 Sep 2011 21:28:41 +0200
Message-ID: <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
	<7v1uvta97o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11KB-0008MX-8D
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab1IFT2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:28:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38171 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab1IFT2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:28:42 -0400
Received: by vws1 with SMTP id 1so5028285vws.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ECemiHEUUaM/3YSOxzJ743OpZLyJqTz7HO9EZTjAcKg=;
        b=mKdj/6GJyOIwcsX/t1EsX4M2PyeBTHKaGVtK+gt5waOROilhxe/GQbMyHT/xoiC0kK
         ouW/qt7l/cnKXwxn58Zhdg6pmBaFV2FCcYUDtNisCCCsV0HzhOEF15JgaD9IIPs+fzpx
         WU9SVln9rjnuXLqBKBs9JpVhPeOY/yzKAKrZE=
Received: by 10.52.174.169 with SMTP id bt9mr5592597vdc.129.1315337321252;
 Tue, 06 Sep 2011 12:28:41 -0700 (PDT)
Received: by 10.52.110.2 with HTTP; Tue, 6 Sep 2011 12:28:41 -0700 (PDT)
In-Reply-To: <7v1uvta97o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180823>

Hello Junio,

On Tue, Sep 6, 2011 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Our assumption has always been that it is a notable event that a patch
> that does not get filtered with internal "git cherry" (which culls patches
> that are textually identical to those that are already merged to the
> history you are rebasing onto) becomes totally unneeded and is safe to ask
> for human confirmation in the form of "rebase --skip" than to ignore it
> and give potentially incorrect result silently.

Ok then I think this "git cherry" filtering is not working in my case
since it seems to me that commit that I cherry-picked are not
filtered, please see below.

>
> Obviously you do not find it a notable event for some reason. We would
> need to understand why, and if the reason is sensible, it _might_ make
> sense to allow a user to say "git rebase --ignore-merged" or something
> when starting the rebase.

My use case is the following: I'm maintaining a branch from an
upstream project (the kernel one). While the upstream project follows
its development cycle (including some fixes), my branch is stuck. I
sometime want to includes (or rather backport) some commits that
happened later in the development cycle. To do that I use "git
cherry-pick".

After some period, I'm allowed to rebase to a more recent commit from
the upstream project and  this rebase 'cancel' the previous 'git
cherry-pick' I did. But for some reasons, git telling me "nothing
added to commit ...", which is expected in my case, well I think,
hence my question.

Thanks.
-- 
Francis
