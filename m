From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Mon, 23 May 2016 08:59:59 +0700
Message-ID: <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160522112019.26516-2-pclouds@gmail.com>
 <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 04:00:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4fAY-0003YD-Al
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 04:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcEWCAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 22:00:30 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37120 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcEWCA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 22:00:29 -0400
Received: by mail-ig0-f173.google.com with SMTP id l10so17157232igk.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=orp4oyZWUDQBAoYtAYKd4wEKP6OsK9a3YT1VZciMdco=;
        b=XeU7Jw3fU8gBgoSM3yKPiOYLY17po2QgTv+PT6nkDBQaQl4S+n/Qp+LeslZGBOZyPY
         JAcvJfsu5jKi7YwbaZ2aIvOs/iWyKXQ/DvrCHHoZKsRqlXE/tmYhoRXQc2hWQNZesy7p
         sZLJf+0tG3e0rIoqr++gAfVzvajYvl8C5TPvYvZsNw30Gv0IVmXUwb3aG5YAYOQN0nqp
         eErIuPTwHPCdGiK0YoSrYFA/6Dmrco7tdDzmOvLvQXN3OoIzFBteVkK6YV47iGzsbDpF
         c+9sXQKuHcXwmKmFMCrGyjyj85gqz7G7MLV2bjavPnXdD+QVaMj66M/L5PIb/8Hdplkw
         s0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=orp4oyZWUDQBAoYtAYKd4wEKP6OsK9a3YT1VZciMdco=;
        b=RAWMrIZIOr7aIIHvQPUtp+Tc/RYTczCSFrpd07E7BMNT9v48jQkwjitrklDnKUizNG
         gW2VCeQFd9VDPeXE+hel0IFhuNk2a+IKQsfxkbSesGVZ7cIeVE4zSjKzMm9LM6NcPxY7
         YW8QAVMT0otDMMdeqA7QWDC5re8LE1Yg9Bk6kblFAg02ld/4P16q2DpzcRcxc1ITrpef
         Qg9CVsexEwr9zHpPtPvaKwKxUUa7tbBJZoFjUvqOX0RKHzvb/B8f7mh5uqPpVZOBQULD
         bYMBUsZo0QKjlY4f5VqHSRMCdiE759jyXInxT/sqE1B92v67/Tmjm9zpn7FJs0h1oIvG
         0PAg==
X-Gm-Message-State: AOPr4FUO8u1HbMoWNBmgUK0dNskhznBbv1ruW4dtgSBVBNtiCAYQpDitPMiyELZd1IATOXT63zgeSarF+TP37w==
X-Received: by 10.50.108.45 with SMTP id hh13mr10534320igb.27.1463968828470;
 Sun, 22 May 2016 19:00:28 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 22 May 2016 18:59:59 -0700 (PDT)
In-Reply-To: <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295301>

On Mon, May 23, 2016 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> That is, I wonder if the above can become something like:
>
>> From github.com:pclouds/git
>>  * [new branch]      { -> pclouds/}2nd-index
>>  * [new branch]      { -> pclouds/}3nd-index
>>  * [new branch]      { -> pclouds/}file-watcher
>>  ...
>
> The above example borrows the idea used in diffstat label for
> renaming patch and I think you can design a better notataion, but a
> big point is that you can shorten the whole thing by not repeating
> the common part twice.  The arrow aligns merely as a side effect of
> the shortening, taking advantage of the fact that most people fetch
> with "$their_prefix/*:$our_prefix/*" renaming refspec.

I did think of that. My only concern is, with the new output I can't
simply copy the ref name (e.g. pclouds/2nd-index) and use it to, say,
examine with git-log. But I'm more of a "tab tab tab" person than
"copy and paste", so I don't know how often people need to do that.
-- 
Duy
