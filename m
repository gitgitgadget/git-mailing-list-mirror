From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Removing unreachable objects in the presence of broken links?
Date: Sun, 11 Nov 2012 12:15:24 +0100
Message-ID: <CAMuHMdXPg-GCnkSCZmeA8HKA4hback7aUNpK5AigKKe2z+2uRA@mail.gmail.com>
References: <CAMuHMdUqUtDspOP2kE9wtGEr9aJHGGBG=HRomdY6NRa8gxar4A@mail.gmail.com>
	<m2r4oiffgy.fsf@igel.home>
	<CAMuHMdU5ZNFs-_TeUE4ntzCCOp85DSOyWMrjJ=yV76MSmjfxDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXVVr-0007Gq-3j
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 12:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab2KKLP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 06:15:26 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50682 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2KKLPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 06:15:25 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5332895vbb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=me5rO7DxM7iJrDbj8dqhUTEfK1qLIKfYJlTKTD1eB3g=;
        b=ZbbPZU+rDDSW03twHJYRK4lOn4Fm4Y6+0q6TVN6GbZ4hfE+7tzBHS1gUBJvmx9t19F
         KTtDY+xS9zobnxVkwCm/AkRS7UG3H35qpcL54FIe34ufOhp3vjQFj5Zc/3vdzkvCAA++
         LOSuYdZN9BYJLhXwjKeg+JAWymXym3Jk7V+F8Detn1ed7bsnCSqvhDcSV0qy78cF3hBd
         KU5VpjXs5YXxoinjyE6IZewLa+zz9OTPTUqs8DXKqqg4IAXcBDrbaC8//AITLwZ6PHIx
         kN0kfC2zsiBZu28DbMQRp4hNyYoZDqN5Lkow0v9TcElK1OY952Bqf0dAwVZ7CVs21guf
         W/mQ==
Received: by 10.58.239.138 with SMTP id vs10mr14641409vec.16.1352632524487;
 Sun, 11 Nov 2012 03:15:24 -0800 (PST)
Received: by 10.58.163.166 with HTTP; Sun, 11 Nov 2012 03:15:24 -0800 (PST)
In-Reply-To: <CAMuHMdU5ZNFs-_TeUE4ntzCCOp85DSOyWMrjJ=yV76MSmjfxDQ@mail.gmail.com>
X-Google-Sender-Auth: dhEPvv4fVkli5oMazaivPRRTO-I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209338>

On Mon, Oct 29, 2012 at 8:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Oct 28, 2012 at 10:34 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>>> Is there a way to force removing unreachable objects in the presence of broken
>>> links?
>>
>> Does it help to forcibly expire the reflogs?
>
> You mean "git reflog expire --all --expire=0"?
>
> After that the reflog is empty, but "git gc" still fails.

Although "git stash list" didn't show anything, .git/refs/stash still contained
one hash.

After running "git stash clear", "git gc" succeeded, and the object pointed to
by .git/refs/stash before was gone.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
