From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/log: clarify what --raw means
Date: Fri, 15 May 2015 10:44:46 -0700
Message-ID: <xmqqpp61hh0x.fsf@gitster.dls.corp.google.com>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
	<1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
	<loom.20150515T174530-547@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri May 15 19:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJfK-0001sf-SK
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 19:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbbEORou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 13:44:50 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34104 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbbEORot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 13:44:49 -0400
Received: by igblo3 with SMTP id lo3so44501795igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NXv0iX8YeT9IUc7RUy0guSC/hawatKSj8wsve+QWkcU=;
        b=cIRqw6AfGMMFKMCMupB//sYcCjgsGThFYK1flllWgdZJ8R300Hh4A/KGxpichT5HvA
         1yzFegTwicje4nT7hijBeV7MS2stJxHH0PrrvPQ3jRWWd/okOUvcHBHPAAvydBQfgmYV
         RE/SbBx2iVhAq5htTFXTG7Asmn6xRCWBZIXdiLgImr6wEFk9SC3mBulvAzL2i9m1KWK3
         l02ZsYox4DRIp+gdAA9DdqEiNE07kcugUzt0aYKXlAJIBGKsqmUGGcSwZs5XXJM48LaG
         PJCcCx5dcS250OSJTZU7FlYMShWXE+702oHQZ0d2BgdzHNKKJGGkE8ezR4gja+WDbKN+
         q3wg==
X-Received: by 10.107.8.87 with SMTP id 84mr10894311ioi.87.1431711889365;
        Fri, 15 May 2015 10:44:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id p196sm1570284iop.15.2015.05.15.10.44.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 10:44:47 -0700 (PDT)
In-Reply-To: <loom.20150515T174530-547@post.gmane.org> (Ed Avis's message of
	"Fri, 15 May 2015 15:47:24 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269161>

Ed Avis <eda@waniasset.com> writes:

> Thanks, I think that is a bit clearer.
>
> You might also need to clarify the part about --format=raw where it says
> 'SHA-1s are displayed in full, regardless of whether --abbrev or --no-abbrev'.

This part of the description being "--format" option, the "SHA-1s"
the description refers to are the ones that appear in the commit
object itself, something like:

    tree 2b5bfdf7798569e0b59b16eb9602d5fa572d6038
    author Linus Torvalds <torvalds@ppc970.osdl.org> 1112911993 -0700
    committer Linus Torvalds <torvalds@ppc970.osdl.org> 1112911993 -0700

    Initial revision of "git", the information manager from hell

And the commit object itself does not have any "diff", as you are
not comparing anything with any other thing.  It is about recording
one single state in time.

I think that is what the reader needs to be made aware of, and the
current documentation is not doing a good job at it.
