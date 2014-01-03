From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Fri, 3 Jan 2014 13:06:27 +0530
Message-ID: <CALkWK0=tL4K7UHDBp_jGz5zUaHE9m=OESo2=2a0fUZwXB4auGg@mail.gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
 <1388415138-11011-4-git-send-email-artagnon@gmail.com> <xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 08:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzKB-0006Xm-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 08:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbaACHhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 02:37:11 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52574 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaACHhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 02:37:10 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so15629555ieb.39
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 23:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0utEz0Rx6Txgoahw7EQ5QK/nOqOHa1UVf7jhYnCka1o=;
        b=BZByeTSttB25ToikQZdb5RzLjmr9uQwVBLRCD/oSZlrvaeiEx5SvuxNE+6WRzaSFiz
         OTp1dRpotN4zBxZxO3rHDHCn8/awpZwKGZeUQORZ8/pum5K4RM4h0uAD6lD1k97nJVsB
         Hds58fhCP7IpINk/1zny9Xh6Yy+wh4Y43L8Lq+YUKLtRgiLeGfu1M1FSgkpQeI6tvJSk
         csPjuIbRp+DDPvX12j/MInLTnowaAftPFeg5IVLy4tH4o7rwqIz8v/veNrU5tGmOVASt
         UrXmKxm44fMLAhNUfdmXYGGBZ4T1HYEP9s+PUSW8LEpNsoXyxfODp2/mDP9MUngXjlGR
         1g0Q==
X-Received: by 10.50.36.67 with SMTP id o3mr1141951igj.47.1388734628017; Thu,
 02 Jan 2014 23:37:08 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Thu, 2 Jan 2014 23:36:27 -0800 (PST)
In-Reply-To: <xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239904>

Junio C Hamano wrote:
> If we are looking at "branch.autosetupmerge." followed by something,
> who typed that final dot?

I admit that it's a very unlikely case. The user did:

  $ branch.autosetupmer<TAB>

hit backspace to delete the trailing space, inserted a dot, and hit <TAB> again.

> If you are working on a topic about
> auto-setup-merge and named your branch "autosetupmerge", don't you
> want to be able to configure various aspect of that branch via
> branch.autosetupmerge.{remote,merge} etc., just like you can do so
> for your "topic" branch via branch.topic.{remote,merge} etc.,
> regardless of your use of "autosetupmerge" option across branches?

My reasoning was that being correct was more important that being
complete. So, if by some horrible chance, the user names her branch
"autosetupmerge", we don't aid her in completions.

> Besides, it smells fishy to me that you need to enumerate and
> special case these two here, and then you have to repeat them below
> in a separate case arm.

I'm not too irked about correctness in this odd case; seeing that you
aren't either, I'll resubmit the series without this hunk (+ the hunk
in remote.pushdefault).
