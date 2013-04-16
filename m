From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 15:25:30 +0530
Message-ID: <CALkWK0m+NQ_ZdDkD31VxEpFHGm006mGiAy6GHi31+MrPmzB1mQ@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org> <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
 <vpqli8je8w0.fsf@grenoble-inp.fr> <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
 <vpqvc7mdd3x.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US2ca-00045X-FR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934111Ab3DPJ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:56:12 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:50278 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933889Ab3DPJ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 05:56:11 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so232458iad.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mG1KPdcsQY71yUcbZSl9/V4D8Fzkmr2smEJ8Er8Wbn4=;
        b=vN9UMHlJgfKLFV+Bp/HoHm9pvnslr1CDzFSuPFjkV7LjnlyFHwRMfOrq3bVQOrJErM
         yDtwCJpOMwlaztix9lml8bRvE6t9rYYi6306ZuSqi+8Gg89xvkLfuCDCZqq3zNUOU1SH
         28B6GMMcb0sQGLAShmFlFhfZNFYwRjaVZsu1X6rDeRP/KxDs/MyQPMnC1YXU3l1sK4+3
         qRVXPIK2uFz6DJ92Os00p6wUILnbYiE4ChBZywuLWEBju8o109hD+yf7nZ9kWfCYZkzJ
         55vNsCIkHvYndhHcdoimogxL4GoDnljnCyrsVOBCZR01P2Lb5y4QuGu/zbYPPVE5zF2F
         6w6A==
X-Received: by 10.50.17.166 with SMTP id p6mr7356173igd.12.1366106171084; Tue,
 16 Apr 2013 02:56:11 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 02:55:30 -0700 (PDT)
In-Reply-To: <vpqvc7mdd3x.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221403>

Matthieu Moy wrote:
> And you're going to pop the stash even if no stash were triggered when
> starting the rebase.
>
> Really, think about it again: you're not going to guess whether you have
> to unstash without storing this information somewhere. You may argue
> about storing it outside the todolist, you can't unstash
> unconditionally.

Yes, touching a simple "autostash" file at stash-time, and removing it
at pop-time will do.  I don't see why it should be part of a
(potentially user-editable) todo-list, which serves an entirely
different purpose.
